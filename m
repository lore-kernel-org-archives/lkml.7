Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E96C31E49
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 08:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A477721473
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 08:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfFPI6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 04:58:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39923 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfFPI6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 04:58:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so6675540wrt.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 01:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BH7q4sQxtlW7GBy0Ndsur0wfVLJQqa1DwxMiAYKl/M8=;
        b=aAjaburQSWC+9Dn9WNbPZvncTX//ni6q6saNVCajfpRhwJ+mqmMtex8zBnivIYFZIt
         +JPJwYN5gzFrUsembuU2eNvTUuIgy1L+tdUkqQ5XiABzLOeKDJzNo1nq6p7cy2RXu2/X
         A6e7DMKmdlj5ykZ9ZKdFAUlKMLuW6WnNiBRdNFjuI8XQ0s/hVZdiB58r0rftimggjSPW
         3Qph4M5pwvIwAOtqlBNDEf65FzyuJBp0S4taIZ3YyKkX3YaDJaAis/WS41SJkNw8OLJt
         jXgWOr59I2JCr3rtKIfLEWpBFFqArG7lO3QNC30yqVRhcpTDvIn3ksFoI5T530FBBDtw
         3cyg==
X-Gm-Message-State: APjAAAX0CdOmJUjijQVRzzijTy4yEdsNkMxvlTU/w768us+QTO7+6hUh
        AFa2ZPTZazDuxCwKXx8Vm1Ju5w==
X-Google-Smtp-Source: APXvYqz8xNHGO6SpiHfeRXmpPOlMaBmRTs2Z+ZnB2utwNn6Sw4tv3GLfcp5kGY1tE4/gW0/NkQufFQ==
X-Received: by 2002:a5d:5702:: with SMTP id a2mr28113288wrv.89.1560675523661;
        Sun, 16 Jun 2019 01:58:43 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e7sm6195627wmd.0.2019.06.16.01.58.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 01:58:43 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: [PATCH NOTFORMERGE 4/5] mm/madvise: employ mmget_still_valid for write lock
Date:   Sun, 16 Jun 2019 10:58:34 +0200
Message-Id: <20190616085835.953-5-oleksandr@redhat.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190616085835.953-1-oleksandr@redhat.com>
References: <20190616085835.953-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do the very same trick as we already do since 04f5866e41fb. KSM hints
will require locking mmap_sem for write since they modify vm_flags, so
for remote KSM hinting this additional check is needed.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 mm/madvise.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 9755340da157..84f899b1b6da 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1049,6 +1049,8 @@ static int madvise_common(struct task_struct *task, struct mm_struct *mm,
 	if (write) {
 		if (down_write_killable(&mm->mmap_sem))
 			return -EINTR;
+		if (current->mm != mm && !mmget_still_valid(mm))
+			goto skip_mm;
 	} else {
 		down_read(&mm->mmap_sem);
 	}
@@ -1099,6 +1101,7 @@ static int madvise_common(struct task_struct *task, struct mm_struct *mm,
 	}
 out:
 	blk_finish_plug(&plug);
+skip_mm:
 	if (write)
 		up_write(&mm->mmap_sem);
 	else
-- 
2.22.0


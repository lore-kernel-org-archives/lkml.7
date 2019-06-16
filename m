Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63FEC31E53
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 08:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F10621473
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 08:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfFPI6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 04:58:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33968 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfFPI6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 04:58:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so6699871wrl.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 01:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ITCIjtRiKXBETAqnfXapAAbycKyMBn7c3dUFh4aTVw=;
        b=BJ3VqwLhfcgBEJMs7Nx92tfXf8T92OEqP6LJNqcau2RcnRdGyPvg+7BuSHzAFXU1JE
         b0//LF/vh4g5/jzh7O88Dr2x0cLDv+ng9yavSfpVjh8mvZQqwWuCFJdW5QxKeLn4ArjD
         JOJXZ9+EHvlIP64xUaJqueJ+6qAR/TPBYpKj+p0gcpYuLjvN+wPDVf6sGhmI5QLALwWS
         1GLb5UVA4EaG03bHxjbkfld4pXjrzeSMAqIoXuWRNUGF2TUldvrTNCnaDgToui/BJm+G
         lcZUvLNCSNHDyeopmRLQNUWKQKe4EEDmRTNlePnuaPvefGxy/7xmHXVCq7e+4dIjzqFO
         JO9A==
X-Gm-Message-State: APjAAAWGPBRB1rUsdJcXoxzBPCDxa/N38liE5RKYGzXaVR+6mSx+bIuY
        7MtTXpJHs9q4v/kuKSEV1daqOCuVih8=
X-Google-Smtp-Source: APXvYqzQMjvzDFYnOgTdFM99hcnJUp0/uTV59QLuRVfafS23C/DUgS5gTgJZNRO0B4DaEtyvurzykA==
X-Received: by 2002:a5d:6a42:: with SMTP id t2mr6432594wrw.352.1560675520784;
        Sun, 16 Jun 2019 01:58:40 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t1sm7728752wra.74.2019.06.16.01.58.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 01:58:40 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: [PATCH NOTFORMERGE 2/5] mm: revert madvise_inject_error line split
Date:   Sun, 16 Jun 2019 10:58:32 +0200
Message-Id: <20190616085835.953-3-oleksandr@redhat.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190616085835.953-1-oleksandr@redhat.com>
References: <20190616085835.953-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just to highlight it after our conversation.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 mm/madvise.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index edb7184f665c..70aeb54f3e1c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1041,8 +1041,7 @@ static int madvise_common(struct task_struct *task, struct mm_struct *mm,
 
 #ifdef CONFIG_MEMORY_FAILURE
 	if (behavior == MADV_HWPOISON || behavior == MADV_SOFT_OFFLINE)
-		return madvise_inject_error(behavior,
-					start, start + len_in);
+		return madvise_inject_error(behavior, start, start + len_in);
 #endif
 
 	write = madvise_need_mmap_write(behavior);
-- 
2.22.0


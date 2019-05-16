Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF7CC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4CB20881
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJDQ2mox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfEPIAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:00:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39410 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbfEPIAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:00:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id z26so1418616pfg.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 01:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YpW+vAT0Cpr2059Ga4zxgIqRrIamk2gVKxB/HsOolR8=;
        b=eJDQ2mox2qWgfQsPVTzBBwj7Pi7aonm1gHmIm4IwMOOFgOkYBPs9vNML+FMumchfoJ
         2CcA4AxqgCXV+YQHsFCyoiI1QnBWG1XK1Vkyapk8V+UNWVW6bwy8wonvZKuSvknkPhOd
         U2JmLrIHVm9Yz7Wl+BDR0as7LR60++Ie17ag/rk3HjXd2HIwvkDCXU+ljfH1Mi5yY0K6
         fgsLBLYE3AdyIyidTMUU2KbcmrmXC5edlPIs+pIPzyXXIsE5cjNaWabmKcLjghbVUldU
         RGU6BypmhLuok98tWjfrs1BwYfKA3ZgyNb9fRjDFsICAi6I0Mg8/klpxMpGOrUQwwymj
         yt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YpW+vAT0Cpr2059Ga4zxgIqRrIamk2gVKxB/HsOolR8=;
        b=RBBIT+JsSUQSOHha65U1jkrOP+thMANXjkAeTmnlunQ4Qiu8FZ1rU3sgbLa3SB0qbC
         GU0eYhX+SllQGppCWzMNjGD+7E0GaPePnq0vb+3ivA9dL2Grwmx9IPahqfplHpEHTcgF
         Rp8F3K1sR6VYYJ5oIZGRjDMhcNxA1hclxpMquGgLk16ctWTyLJUxhry66jHeM1sj7teQ
         VQq6LkvePKR1wS0AXkVvp75dF0jo2CBI45AJiuKtFDVg/gIkS7Bo7snbpn7RLaZ67dsh
         nYohIXbirNYA26nbcYKkE17p+XWAi90BhOT91TPhAiamSr9v3rB5gQg1i/QNCAzZgrtf
         hLew==
X-Gm-Message-State: APjAAAW9TMHpk3AVfNIri7fPtbw5Zszdt1PkktGFBJj8hShCI/pre4Pc
        XxOiP3u+r4aMnFgn1nyUKVs=
X-Google-Smtp-Source: APXvYqwUaPwD+hOt28GBCvBn6NMK07zcMZEB8dVTrrXsI/JP1oME2s7Tr4/wBVIz5S0lAv3x58rQsg==
X-Received: by 2002:a63:2bc8:: with SMTP id r191mr48213164pgr.72.1557993649175;
        Thu, 16 May 2019 01:00:49 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id p7sm2051471pgb.92.2019.05.16.01.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 01:00:48 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com, paulmck@linux.ibm.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 07/17] locking/lockdep: Introduce mark_lock_unaccessed()
Date:   Thu, 16 May 2019 16:00:05 +0800
Message-Id: <20190516080015.16033-8-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190516080015.16033-1-duyuyang@gmail.com>
References: <20190516080015.16033-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since in graph search, multiple matches may be needed, a matched lock
needs to rejoin the search for another match, thereby introduce
mark_lock_unaccessed().

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 54ddf85..617c0f4 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1338,6 +1338,15 @@ static inline void mark_lock_accessed(struct lock_list *lock,
 	lock->class->dep_gen_id = lockdep_dependency_gen_id;
 }
 
+static inline void mark_lock_unaccessed(struct lock_list *lock)
+{
+	unsigned long nr;
+
+	nr = lock - list_entries;
+	WARN_ON(nr >= ARRAY_SIZE(list_entries)); /* Out-of-bounds, input fail */
+	lock->class->dep_gen_id--;
+}
+
 static inline unsigned long lock_accessed(struct lock_list *lock)
 {
 	unsigned long nr;
-- 
1.8.3.1


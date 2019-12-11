Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368CEC2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099D82077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqUDzVMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfLKU2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:28:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36105 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfLKU2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:28:52 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so123467wru.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 12:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=naWMx9N0uWainyxJFoMeYjPsvH+QX5wLBu2xsPR3Oj8=;
        b=FqUDzVMvTHUsGNZOVZVnsyxn/WOFcpMcj3M5pwBSH4+aQ7ABk2HwNI3ogvU6INPNnL
         CvSTOm6b6IHdsxalKesh9e1aelv8cXLhecfAg7g5Riwh6xs6WSSv1o6iAWXseMHDwOHK
         Yjy+jrKWGo/zbo7FqHC3+qOAfgHT4/xZAo+BoX2IbqEd6E/2sh61SBlK0cXL5MBsZnRu
         pTSnur4SRuKdIayya15rUXKmtNzHE50TGK6mUdFytdBqxkoS+xe0N6Uj3RE+Skwa+q51
         PCuidQGsLH9otreTg2UmheLX2k20vUx1PGp5dJxfzQUU/01kU1+L/z+YUsIjsiJRn8sM
         0rGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=naWMx9N0uWainyxJFoMeYjPsvH+QX5wLBu2xsPR3Oj8=;
        b=JLrfgNGXoM11barPju0AGPwU51VB7HJcn2luLW2xMn07rpqsIqcExnzKdE/mpeqK30
         XrHdvAUCrf3lrhSKBFZCUzu8TlFG13eTnkYiC2koj8SdvQZi1LR/jlzUwHnjHMza+aM8
         DpV8taQ0Rd0KhiW4Mqmu+WIDx8aeVlleNUSadi7rRaORZjrlBVzvYg9U/SjOeAmb/9bH
         pYRdcwRMl+gt18dzNjNwaeUKEySpvViBAZJDoE2Zul52ChO6EDdp5wAguRmVYyX69dOJ
         RKdM6F5SgPQGFEMz626bd5FRVG+INhcX55n8B+LIym+HidvA7MT4kEuw8UikDZ3ckex8
         XTHA==
X-Gm-Message-State: APjAAAUBMT4AFIo3vhV4J7knHoqSIsgtvwF3YCn0175VNJkRR43Qu0I4
        +64BCagepj5t076TC6CVksE=
X-Google-Smtp-Source: APXvYqwvLAJ3BVDmU9pXGr4hJ10Q800cW203xBsv+TNZ4pRMpMwlZajjkG7AFDb5rkcicWdjyDnGLg==
X-Received: by 2002:adf:d0c1:: with SMTP id z1mr1832688wrh.371.1576096130389;
        Wed, 11 Dec 2019 12:28:50 -0800 (PST)
Received: from kwango.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x1sm3441768wru.50.2019.12.11.12.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 12:28:49 -0800 (PST)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Edward Chron <echron@arista.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] mm/oom: fix pgtables units mismatch in Killed process message
Date:   Wed, 11 Dec 2019 21:28:30 +0100
Message-Id: <20191211202830.1600-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pr_err() expects kB, but mm_pgtables_bytes() returns the number of
bytes.  As everything else is printed in kB, I chose to fix the value
rather than the string.

Before:

[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
...
[   1878]  1000  1878   217253   151144  1269760        0             0 python
...
Out of memory: Killed process 1878 (python) total-vm:869012kB, anon-rss:604572kB, file-rss:4kB, shmem-rss:0kB, UID:1000 pgtables:1269760kB oom_score_adj:0

After:

[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
...
[   1436]  1000  1436   217253   151890  1294336        0             0 python
...
Out of memory: Killed process 1436 (python) total-vm:869012kB, anon-rss:607516kB, file-rss:44kB, shmem-rss:0kB, UID:1000 pgtables:1264kB oom_score_adj:0

Fixes: 70cb6d267790 ("mm/oom: add oom_score_adj and pgtables to Killed process message")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 mm/oom_kill.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 71e3acea7817..d58c481b3df8 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -890,7 +890,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 		K(get_mm_counter(mm, MM_FILEPAGES)),
 		K(get_mm_counter(mm, MM_SHMEMPAGES)),
 		from_kuid(&init_user_ns, task_uid(victim)),
-		mm_pgtables_bytes(mm), victim->signal->oom_score_adj);
+		mm_pgtables_bytes(mm) >> 10, victim->signal->oom_score_adj);
 	task_unlock(victim);
 
 	/*
-- 
2.19.2


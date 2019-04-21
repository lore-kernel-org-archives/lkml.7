Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F282C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 11:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4842087F
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 11:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQaBDRhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfDULrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 07:47:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38315 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfDULrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 07:47:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so4445452pfo.5;
        Sun, 21 Apr 2019 04:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=l1XMfRfwz3PYG87O4Xru/p0h0VgC3g5uSZkBJ4fCYy0=;
        b=GQaBDRhGo3GA9dXYbej6iuWKt4/L6Nbh1CB2Fhr313moYpRWPPlELcW9sImdOppe3l
         Y/1cFyyZ0SWz80ikORm6Byf7f88iHF9uE1AB2Dk2zyMjoHiBifSRNuTK4QDsyq35M7S/
         uFOdfIyZjK3fwd/ncPT2mIDKuEOXZgs2WhNvX5Rr/cooSIbjwszQZCrwueRHjRBo94/g
         kOW3JV9EX/GnfmsArfxKgeK3KUGLKPKR8hd0B8iNjvcQPhyNqRkoM1JrRUp/O8FfkKAf
         XynF2/RbBAoqeSg7aASUbW/3eYtSPnzUTPdKcK9lNplT+okwCVjlPH5Q6XI68oUeF0qJ
         AseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l1XMfRfwz3PYG87O4Xru/p0h0VgC3g5uSZkBJ4fCYy0=;
        b=J8nLnOC1+MHqodZMchJXbOmF6h4GAyyEXB/0nOg8u8XFhYNUYtAVdwt5EIjpCqCVUK
         tBQxWZjPwyQvc9b3ztwPh4cofTBsevN7HHl7IXW9dnz7KjWhN/hgc2HwpKwz/uy6LNkV
         73AzlkU2jfXMjhJvLRzObewH1yVsvcwzy1VfEL2yZXCHEaGZkhtNNCzJYUVWI4Jjz1jp
         ZEgT02ltqCM/NnmgfX9DaLvw4O29jIK/64x3h93E7P7hrnBkGTmBII5Iy/nsYoS//em2
         euG3t5nX9LHJxWkAAmWlKmNoP0Q2j0ZfMgIhlCfaUcp9DgMHiM4wS1xe2QRxagvHKghe
         2kDg==
X-Gm-Message-State: APjAAAWNz8z6a2NGZfOWr02akH/fmSDUVKx6cmkwZMrvi2h6tmzTblU/
        YR3aVARQoBZGwoYXqfpy1mk=
X-Google-Smtp-Source: APXvYqxb06nrenI/Bhom5lrSgikF5cdtvwBdIJ4AJGHqTcB3FXSbdPU4H3cBMX+AVyhTBPIbQILxDQ==
X-Received: by 2002:a65:4481:: with SMTP id l1mr13574357pgq.66.1555847262004;
        Sun, 21 Apr 2019 04:47:42 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id x24sm13195697pfn.128.2019.04.21.04.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 04:47:41 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/06] kernel: cgroup: fix misuse of %x
Date:   Sun, 21 Apr 2019 19:47:27 +0800
Message-Id: <20190421114727.20325-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointers should be printed with %p or %px rather than
cast to unsigned long type and printed with %lx.
Change %lx to %p to print the pointers.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 kernel/cgroup/debug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/debug.c b/kernel/cgroup/debug.c
index 5f1b873..80aa3f0 100644
--- a/kernel/cgroup/debug.c
+++ b/kernel/cgroup/debug.c
@@ -64,8 +64,8 @@ static int current_css_set_read(struct seq_file *seq, void *v)
 		css = cset->subsys[ss->id];
 		if (!css)
 			continue;
-		seq_printf(seq, "%2d: %-4s\t- %lx[%d]\n", ss->id, ss->name,
-			  (unsigned long)css, css->id);
+		seq_printf(seq, "%2d: %-4s\t- %p[%d]\n", ss->id, ss->name,
+			  css, css->id);
 	}
 	rcu_read_unlock();
 	spin_unlock_irq(&css_set_lock);
@@ -224,8 +224,8 @@ static int cgroup_subsys_states_read(struct seq_file *seq, void *v)
 		if (css->parent)
 			snprintf(pbuf, sizeof(pbuf) - 1, " P=%d",
 				 css->parent->id);
-		seq_printf(seq, "%2d: %-4s\t- %lx[%d] %d%s\n", ss->id, ss->name,
-			  (unsigned long)css, css->id,
+		seq_printf(seq, "%2d: %-4s\t- %p[%d] %d%s\n", ss->id, ss->name,
+			  css, css->id,
 			  atomic_read(&css->online_cnt), pbuf);
 	}
 
-- 
2.11.0


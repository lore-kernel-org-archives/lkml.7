Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F8DC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 21:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC1D20733
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 21:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573940569;
	bh=Nq6ldT5ZozlU8NTFdQ8aEl9RgRcuXKsay1WSaBlrops=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=BBOKCcl38wGpCK2TevbV1lNO6yN7R5ClhO18et1qIPWN1ZN1tTKtTCU1wYAw00tUr
	 SxuZh5RMmY2byGQpNQqJesqFglaCltTnS0XZhJ/J3bGLxb++45QuPJq5KTmg/UoHs/
	 JXC/13hR21GZ91s4XrW7yCGK0yroVSauPEQcT9Mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfKPVms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 16:42:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40334 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfKPVmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 16:42:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id f3so14603889wmc.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 13:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mVe62UrRp28X5Wt7iRnP9lnwTQM7y7iLYPBYJc71QAw=;
        b=rAZEEyl1Yhj5UxedIGE876B3ufKvasKZ67qNAtEs/lnthJBmDhbWaxSI+YoMCceS+X
         JGuJxamFfqnleaVJ3BNKO6zdYDRXNqu57OFHGLCNooarb0Ic7cyAz8CvkHssZa9ZmIDs
         2zcO1MnDo7KFNa1ioxAHIfmjJsu823xs9Kj69fXvvLMlINdJVl26qszV++gipMhzlsQ6
         cBWDviadXtPWq/ahdaUFEN2T+DcWnbuG3lsFgDZUiD3Fn2SPq6AsKHXpNoE038yB2u/C
         kuMi4pc3QX6RVmOcA8F8EddGCqBIGgaTXqOb4UCRyR17tfjnyAnGJL8Y1AEd7M60rd4G
         xdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=mVe62UrRp28X5Wt7iRnP9lnwTQM7y7iLYPBYJc71QAw=;
        b=EQbdJIxBE4FI1f1RnPFNUj+/jsa8qXTCHSaPsd+dJk64m9pPYCvvwZ3ncb4MjKhEtB
         5F3mqzYNUEpVgcoAOdZbB8/VvhxuEheS5MnnjfuUU2mF1mqDzRKvfSgiyThAec7Bzrj8
         JVeJMR50poKRZjNOStGEDnOi0JwC55vuPS+LYhL0XIx60P9DpE6HjvodOXTZGLP0Cquu
         oAKwlRYYx4ji/2dFnD2aAiFVoV8QtTcpM+3he4GsyhWcDlDS9saB54P4lf9L1yCZgMsg
         KrFpGMDj2w/6CxwNSYsRX1reybQ4FIVFAWpQbSn9joeP5EnpCXyb038/y90kE3y438Kt
         F3rQ==
X-Gm-Message-State: APjAAAW9pN1rvMgfRxuUU4D8D4UzJ81GzrBHBYVdc8XRLiSgl68RUCXV
        Lm0k5k5I6+/EFlc6wpsx7rM=
X-Google-Smtp-Source: APXvYqwUSrIw6LJBALU5WD57XnbvZKgX20BWknN6CSi+oSk0zBCTIxXvnRS72wYp41aovsKAh4vaRg==
X-Received: by 2002:a7b:c743:: with SMTP id w3mr22649539wmk.165.1573940565826;
        Sat, 16 Nov 2019 13:42:45 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id x205sm16727666wmb.5.2019.11.16.13.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 13:42:45 -0800 (PST)
Date:   Sat, 16 Nov 2019 22:42:43 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20191116214243.GA81282@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: c8eafe1495303bfd0eedaa8156b1ee9082ee9642 x86/resctrl: Fix potential lockdep warning

Two fixes: disable unreliable HPET on Intel Coffe Lake platforms, and fix 
a lockdep splat in the resctrl code.

 Thanks,

	Ingo

------------------>
Kai-Heng Feng (1):
      x86/quirks: Disable HPET on Intel Coffe Lake platforms

Xiaochen Shen (1):
      x86/resctrl: Fix potential lockdep warning


 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 4 ----
 arch/x86/kernel/early-quirks.c         | 2 ++
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index a46dee8e78db..2e3b06d6bbc6 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -461,10 +461,8 @@ static ssize_t rdtgroup_cpus_write(struct kernfs_open_file *of,
 	}
 
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
-	rdt_last_cmd_clear();
 	if (!rdtgrp) {
 		ret = -ENOENT;
-		rdt_last_cmd_puts("Directory was removed\n");
 		goto unlock;
 	}
 
@@ -2648,10 +2646,8 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 	int ret;
 
 	prdtgrp = rdtgroup_kn_lock_live(prgrp_kn);
-	rdt_last_cmd_clear();
 	if (!prdtgrp) {
 		ret = -ENODEV;
-		rdt_last_cmd_puts("Directory was removed\n");
 		goto out_unlock;
 	}
 
diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 6f6b1d04dadf..4cba91ec8049 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -710,6 +710,8 @@ static struct chipset early_qrk[] __initdata = {
 	 */
 	{ PCI_VENDOR_ID_INTEL, 0x0f00,
 		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
+	{ PCI_VENDOR_ID_INTEL, 0x3ec4,
+		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
 	{ PCI_VENDOR_ID_BROADCOM, 0x4331,
 	  PCI_CLASS_NETWORK_OTHER, PCI_ANY_ID, 0, apple_airport_reset},
 	{}

Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79DFC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992582187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573111712;
	bh=cgw1pHZhRZUq5Cx0CP+hnn9eJH/ypUdYQrZnrqza1zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1knXwPv3m9hyHnD0l5JPgkRPKWtiKkdgNV84rcUesZ4fBcUIY3GKaVCZOGSV3aizn
	 xQzuSGhDB+22DHQlTPnlJLjjIvrB3oqS/FJox1t7ik6KUqlJ0IqRF8ca74EBVgq33d
	 9HHy/ziGI2vV5gfodatzpIl6Y6wSnfucYzyrMQq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfKGH2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 02:28:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42154 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfKGH2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 02:28:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id a15so1746500wrf.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 23:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=72ZGaeKO8p6F8DLc8DiLa90CqFm7osDdCPrGV3hluik=;
        b=EiAfRXneI1ykYdJL17W+mlgYI6uCt6dUSvkWjITXeN0sn3FBP6hOAj+bkaue3UbXDb
         v7huqqLxlwTUgZgVQB3mjGGk2Pz88Mb/1YUwKSI12PJ3HvC0+wsIqX+kb3hlbubalfyl
         1YwM4s0sT6SiAST5/MOUiggC0eYf/hWDheb47w4UD8U0hI5yZ06l04H+uVZxixQkoG1S
         jHTQwiohV1vmnL/OAuKUtvwFTZWp2NFXqFVI7SZIf08nvxZ/WQcXOvy6HFmRKa3c0myN
         MHaFx5cTuqKCOBwuS7v5Y+2r9jD0DLvMH3KNmpR/4+UEyNXdCQ5ll4/rK6wP3QxG1L+H
         kBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=72ZGaeKO8p6F8DLc8DiLa90CqFm7osDdCPrGV3hluik=;
        b=kV52zkWR1MY0Tl9C8n4dnqnplUswmyn5SZLrdD6LvGZRe0nXNHJO5oGztaaC8x9kQS
         30BKapI606WdFmpZd8rs7Dqpnyfg4QhlstOFuBInCHs+d2wdUyZkaGAZ/22EOowqx1nK
         ygPFB2CgKxeDsDsgCC0fiKPQLMGFRjPmog1NYYzh97+b8Uc62LVU6HJq4utZsAufHrlf
         smknRu2ux4KAIw8J2gTfJCRAzLvhprz2A5Iz83/JePbWOM1ZYF/rtrdAzEmGlt2f3X5n
         Nh3kIiyg+aejniAoc/KtB9Piv3S68w19TxRmPrn09iTqcfwjTAlaEhSLQQ0DoeGzxZd0
         xsRg==
X-Gm-Message-State: APjAAAUAkHUthy4ZwNoMDDz2jKwRz2iAQmr/q4N+2Re6AHzQtsdlawo7
        4daDIjYbPw3RecOVvY5+9Ek=
X-Google-Smtp-Source: APXvYqx8tpmdYJyKSTskDKhc4k8w7+JKQ9uIeKQ0GnbZrBcOc6TFNZ7QQKReT6ymHNQt8H7jNzl0OA==
X-Received: by 2002:a5d:6947:: with SMTP id r7mr1449910wrw.129.1573111708664;
        Wed, 06 Nov 2019 23:28:28 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id w19sm1056735wmk.36.2019.11.06.23.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 23:28:28 -0800 (PST)
Date:   Thu, 7 Nov 2019 08:28:26 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch] x86/iopl: Remove unused local variable, update comments in
 ksys_ioperm()
Message-ID: <20191107072826.GB30739@gmail.com>
References: <20191106193459.581614484@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191106193459.581614484@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> The series is also available from git:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/iopl

Very nice series - I fully agree with this simplification of ioperm 
legacies.


On x86-64 defconfig new warning in ioport.c:

    arch/x86/kernel/ioport.c:184:18: warning: unused variable ‘regs’ [-Wunused-variable]

This local variable can simply be removed, now that we don't rely on 
regs->flags anymore. See the patch below.

I also removed the now stale comment about the Xen PV 
quirk/incompatibility.

Thanks,

	Ingo

---
 arch/x86/kernel/ioport.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index aad296a23170..78127087b1ed 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -181,15 +181,10 @@ SYSCALL_DEFINE3(ioperm, unsigned long, from, unsigned long, num, int, turn_on)
 SYSCALL_DEFINE1(iopl, unsigned int, level)
 {
 	struct thread_struct *t = &current->thread;
-	struct pt_regs *regs = current_pt_regs();
 	struct tss_struct *tss;
 	unsigned int tss_base;
 	unsigned int old;
 
-	/*
-	 * Careful: the IOPL bits in regs->flags are undefined under Xen PV
-	 * and changing them has no effect.
-	 */
 	if (IS_ENABLED(CONFIG_X86_IOPL_NONE))
 		return -ENOSYS;
 

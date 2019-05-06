Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967E9C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626692082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557137944;
	bh=lSjYVdD/vYljtjF9U3KVLzQiaMncPkwNBz5xLq5QNWA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=hSUEHEzQ/RkkyCktW6Ae1JUlZWI07P3ag3cr+eZwHQ6a59JDqM4GgbBJ4VODioKfY
	 n8sY0LMNb8MqQgHxW+PCn42ek74R5IM1rFPgrKxV/0dew/G/C9l/iKK15v70fWawQg
	 R46TSvUXDwkNojR/A4dIHA3Pj5kK+d9bKZbwjAUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfEFKTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 06:19:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56131 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfEFKTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 06:19:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id y2so14730974wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 03:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4qxjZV2udtdqo1zlc8W/nmJSKqGux+F2jmsNyAq3Ueo=;
        b=O2g0HEr99/vssRVlzQ/YcQO4s0kS5MnoyrPzv2Bzd4WvKn90/EXTEvQbIWRAT+TD+m
         ciI0xp6//YW6LpFo8iYApQZf9uGA2XQ5cxCMyirEkhXeARl/QipkG3ZLBXXVQFX1I6qs
         bpDgZXBAsW40iR0N5VDi4rqLVBGYX06EQTtt2L6I2JDyvFsoHJkw+1UE7NabP5YXGhFF
         chJc7MrkJ4G6wrZBO04Mk0X5jHpo3dk0PcQeLbdCrgROHLhYXqrizLAX7HBWZu8Kj1wv
         0QO87KGr+DCDt0kvP2J21DGC4XS4j4ln4FmTdDe2L5sqIiz6Bs9izLyXF888q/3cCxR6
         H8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=4qxjZV2udtdqo1zlc8W/nmJSKqGux+F2jmsNyAq3Ueo=;
        b=TKxa58qO/kmVqfQzYxUERHDpVxgykG1UgzMnow/IS5X4HD/Mqo0S8SxxoFPd3rws1Z
         eHw4cNDDF76K40olgkv9S9J1QxodsG/tWAXh8wvE/s7WIy5Ff0GqiGr4fLEiVS48V+nU
         sm2kU7RKwB/Th6PffklTcmYTKzG7LLKX5+C2RGEXDZc6TqbhPri8KJGlUhjVMFg5VM3M
         B92qPdN67T9me1axjzHuqTjMBV23wcJgMLRZ0C/kWovzdjJ13E354Q1Wjiatriftq+W+
         TiKubuUU22V7pm/p94bbY+BKPv74Kj7RgGpmOLc3q0DvLfxx7QFMoWP1wCS6SmdEGYyO
         kH/Q==
X-Gm-Message-State: APjAAAVEtR6aqiL/8BR0/1ZEsHMjw3U7lvSQ5qN1mZhf7jbGG3//Hgg1
        3ZI6Wsuduyoa/oSh8YKUubc=
X-Google-Smtp-Source: APXvYqxK7yZsuK64tzAZnQ5o6nnNuGF7kQqL02FHFZjhd+VEiCLpcrG6Fa+aIDybB+lGVn4+b37i7A==
X-Received: by 2002:a1c:2d91:: with SMTP id t139mr16827921wmt.102.1557137940554;
        Mon, 06 May 2019 03:19:00 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c131sm8013154wma.31.2019.05.06.03.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 03:18:59 -0700 (PDT)
Date:   Mon, 6 May 2019 12:18:57 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/entry change for v5.2
Message-ID: <20190506101857.GA39509@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-entry-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-for-linus

   # HEAD: b5b447b6b4e899e0978b95cb42d272978f8c7b4d x86/entry: Remove unneeded need_resched() loop

This tree includes a single commit that removes a redundant complication 
from preempt-schedule handling in the x86 entry code.

 Thanks,

	Ingo

------------------>
Valentin Schneider (1):
      x86/entry: Remove unneeded need_resched() loop


 arch/x86/entry/entry_32.S | 3 +--
 arch/x86/entry/entry_64.S | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index d309f30cf7af..b1856fe9decf 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -766,13 +766,12 @@ END(ret_from_exception)
 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
 	DISABLE_INTERRUPTS(CLBR_ANY)
-.Lneed_resched:
 	cmpl	$0, PER_CPU_VAR(__preempt_count)
 	jnz	restore_all_kernel
 	testl	$X86_EFLAGS_IF, PT_EFLAGS(%esp)	# interrupts off (exception path) ?
 	jz	restore_all_kernel
 	call	preempt_schedule_irq
-	jmp	.Lneed_resched
+	jmp	restore_all_kernel
 END(resume_kernel)
 #endif
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1f0efdb7b629..e7e270603fe7 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -645,10 +645,9 @@ retint_kernel:
 	/* Check if we need preemption */
 	btl	$9, EFLAGS(%rsp)		/* were interrupts off? */
 	jnc	1f
-0:	cmpl	$0, PER_CPU_VAR(__preempt_count)
+	cmpl	$0, PER_CPU_VAR(__preempt_count)
 	jnz	1f
 	call	preempt_schedule_irq
-	jmp	0b
 1:
 #endif
 	/*

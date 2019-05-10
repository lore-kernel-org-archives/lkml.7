Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3CEC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECE3217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfEJSry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 14:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727638AbfEJSry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 14:47:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEE4C21479;
        Fri, 10 May 2019 18:47:51 +0000 (UTC)
Date:   Fri, 10 May 2019 14:47:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        paulmck@linux.ibm.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, srinivas.eeda@oracle.com
Subject: Re: [PATCH 2/2] doc: kernel-parameters.txt: fix documentation of
 nmi_watchdog parameter
Message-ID: <20190510144749.592f4249@gandalf.local.home>
In-Reply-To: <1555211464-28652-2-git-send-email-zhenzhong.duan@oracle.com>
References: <1555211464-28652-1-git-send-email-zhenzhong.duan@oracle.com>
        <1555211464-28652-2-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


As nobody else commented, I will ;)

Hi Zhenzhong!

On Sun, 14 Apr 2019 11:11:04 +0800
Zhenzhong Duan <zhenzhong.duan@oracle.com> wrote:

> As stated in "Documentation/lockup-watchdogs.txt:line 22", the default
> behaivor after 'hardlockup' is to stay locked up rather than panic.

That actually says:

 A 'hardlockup' is defined as a bug that causes the CPU to loop in
 kernel mode for more than 10 seconds (see "Implementation" below for 
 details), without letting other interrupts have a chance to run.
 Similarly to the softlockup case, the current stack trace is displayed
 upon detection and the system will stay locked up unless the default
 behavior is changed, which can be done through a sysctl,
 'hardlockup_panic', a compile time knob, "BOOTPARAM_HARDLOCKUP_PANIC",
 and a kernel parameter, "nmi_watchdog"

If your config has:

 CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y

The kernel will panic on hard lockup by default unless you add nopanic.

If your config has:

 # CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set

Then the default will be not to panic unless you add "panic" to the
kernel command line.

> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2b8ee90..fcc9579 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2769,7 +2769,7 @@
>  			0 - turn hardlockup detector in nmi_watchdog off
>  			1 - turn hardlockup detector in nmi_watchdog on
>  			When panic is specified, panic when an NMI watchdog
> -			timeout occurs (or 'nopanic' to override the opposite
> +			timeout occurs (or 'nopanic' which is the opposite
>  			default). To disable both hard and soft lockup detectors,

Honestly, I think the original text states what it does better than
your update. Because the nopanic is added to override the "opposite
default" which is if the config was set to do so.

That said, this all still can be explained better. What about:

        nmi_watchdog=   [KNL,BUGS=X86] Debugging features for SMP kernels
                        Format: [panic,][nopanic,][num]
                        Valid num: 0 or 1
                        0 - turn hardlockup detector in nmi_watchdog off
                        1 - turn hardlockup detector in nmi_watchdog on
                        When panic is specified, panic when an NMI watchdog
                        timeout occurs (or 'nopanic' to not panic on an NMI
			watchdog, if CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is set)
                        To disable both hard and soft lockup detectors,
                        please see 'nowatchdog'.
                        This is useful when you use a panic=... timeout and
                        need the box quickly up again.

-- Steve


>  			please see 'nowatchdog'.
>  			This is useful when you use a panic=... timeout and


Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1480FC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54752133D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbfFMUpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 16:45:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36517 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfFMUpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 16:45:32 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hbWb3-00044F-Il; Thu, 13 Jun 2019 22:45:21 +0200
Date:   Thu, 13 Jun 2019 22:45:20 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Octavio Alvarez <octallk1@alvarezp.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiang Biao <jiang.biao2@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Nicolai Stange <nstange@suse.de>
Subject: Re: PROBLEM: Marvell 88E8040 (sky2) fails after hibernation
In-Reply-To: <2cf2f745-0e29-13a7-6364-0a981dae758c@alvarezp.org>
Message-ID: <alpine.DEB.2.21.1906132229540.1791@nanos.tec.linutronix.de>
References: <aba1c363-92de-66d7-4aac-b555f398e70a@alvarezp.org> <2cf2f745-0e29-13a7-6364-0a981dae758c@alvarezp.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Octavio,

On Thu, 13 Jun 2019, Octavio Alvarez wrote:

> I reported this to different people but I have not received a response [1]
> [2]. I am following the reporting procedure described in the kernel admin
> guide [3] so now I am escalating to you. What am I missing?
> 
> I noticed that Thomas' mailbox is filtering my mail because of some RBL and
> have not figured out why that is yet so maybe he has not gotten any e-mails
> from me. However, I already tried conacting using a different mail provider.

I got your mail from June 1st via LKML and this one directly and via
LKML. It's in the pile of the other ~1000 mails in my backlog as I was out
on vacation and travel. Just because people do not reply immediately does
not mean they ignore you. 

> Hibernating the machine and bringing it back does not properly bring back the
> Marvell NIC. Most of the time a module reload does not help.
> 
> Problem starts on the following commit, which if I revert over a recent
> master, the problem goes away:
> 
> $ PAGER= git show bc976233a872c0f20f018fb1e89264a541584e25
> commit bc976233a872c0f20f018fb1e89264a541584e25
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Fri Dec 29 10:47:22 2017 +0100
> 
>     genirq/msi, x86/vector: Prevent reservation mode for non maskable MSI

That does not make sense. This brings the MSI code back to the state which
it had _BEFORE_ I reworked the vector allocation and MSI code. It rather
looks like this patch unearths some other weird issue in that Marvell NIC
(or the driver) which was not visible before. And looking at the code the
hardware has known problems with MSI interrupts and uses a magic probe
function to verify whether they work at all.

Can you please provide the content of /proc/interrupts with the driver
loaded and working after boot (don't hibernate) for the following kernels:

  Linus upstream

  Linus upstream + revert

  4.14 stable (that's before the big overhaul of the vector/msi code)

Thanks,

	tglx


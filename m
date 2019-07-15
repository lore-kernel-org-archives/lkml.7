Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8F2C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDAC2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbfGOTJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:09:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48567 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbfGOTJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:09:58 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hn6M5-0004VD-RP; Mon, 15 Jul 2019 21:09:45 +0200
Date:   Mon, 15 Jul 2019 21:09:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Octavio Alvarez <octallk1@alvarezp.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiang Biao <jiang.biao2@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Nicolai Stange <nstange@suse.de>,
        Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: PROBLEM: Marvell 88E8040 (sky2) fails after hibernation
In-Reply-To: <82fa0f47-ccb9-18fc-e35d-af02df37e3fb@alvarezp.org>
Message-ID: <alpine.DEB.2.21.1907152055430.1767@nanos.tec.linutronix.de>
References: <aba1c363-92de-66d7-4aac-b555f398e70a@alvarezp.org> <2cf2f745-0e29-13a7-6364-0a981dae758c@alvarezp.org> <alpine.DEB.2.21.1906132229540.1791@nanos.tec.linutronix.de> <95539fd9-ffdb-b91c-935f-7fd54d048fdf@alvarezp.org>
 <alpine.DEB.2.21.1906221523340.5503@nanos.tec.linutronix.de> <alpine.DEB.2.21.1906231448540.32342@nanos.tec.linutronix.de> <098de4c3-5f71-f84d-8b49-d2f43e18ed91@alvarezp.org> <alpine.DEB.2.21.1906271632300.32342@nanos.tec.linutronix.de>
 <82fa0f47-ccb9-18fc-e35d-af02df37e3fb@alvarezp.org>
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

On Mon, 15 Jul 2019, Octavio Alvarez wrote:
> If I reboot with sky2.disable_msi=1, then I get IO-APIC and the bug does not
> occur:
> 
>  19:          0          0          0          0   IO-APIC  19-fasteoi eth0
> 
> However, if I reboot without sky2.disable_msi=1 it properly starts as PCI-MSI
> and then, after re-modprobing it it goes to IO-APIC, but the bug occurs
> anyway:
> 
> $ cat /proc/interrupts | grep eth
>  27:          0          1          0          0   PCI-MSI 3145728-edge
> eth0
> 
> $ sudo modprobe -r sky2
> [sudo] password for alvarezp:
> 
> $ sudo modprobe sky2 disable_msi=1
> 
> $ # hibernating and coming back hibernation
> 
> $ cat /proc/interrupts | grep eth
>  19:          0          0          0          0   IO-APIC  19-fasteoi  eth0
> 
> 
> > Also please check Linus suspicion about the module being reloaded after
> > hibernation through some distro magic.
> 
> This is not happening. Each time the driver is loaded the message "sky2:
> driver version 1.30" is shown.
> 
> I confirm only 1 line for the sky2.disable_msi=1 from kernel boot and only 2
> lines for re-modprobing.

Odd. I still fail to make a connection to that commit you identified
which merily restores the behaviour before the big changes.

As we cannot revert that commit by any means and as the hardware is known
to have issues with MSI, the only option we have is to avoid MSI on that
particular machine. I suspect that the fact that it is 'working' on some
older kernel version does not necessarily mean that it works by design. It
might as well be a works by chance thing.

Thanks for all the detective work you put into that and sorry that I can't
come up with the magic cure for this.

Thanks,

	tglx



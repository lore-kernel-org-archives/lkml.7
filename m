Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D36C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92DCE20656
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfFWMy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 08:54:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33361 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfFWMy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 08:54:26 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf20c-0001D8-NF; Sun, 23 Jun 2019 14:54:14 +0200
Date:   Sun, 23 Jun 2019 14:54:13 +0200 (CEST)
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
In-Reply-To: <alpine.DEB.2.21.1906221523340.5503@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1906231448540.32342@nanos.tec.linutronix.de>
References: <aba1c363-92de-66d7-4aac-b555f398e70a@alvarezp.org> <2cf2f745-0e29-13a7-6364-0a981dae758c@alvarezp.org> <alpine.DEB.2.21.1906132229540.1791@nanos.tec.linutronix.de> <95539fd9-ffdb-b91c-935f-7fd54d048fdf@alvarezp.org>
 <alpine.DEB.2.21.1906221523340.5503@nanos.tec.linutronix.de>
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

On Sat, 22 Jun 2019, Thomas Gleixner wrote:
> On Wed, 19 Jun 2019, Octavio Alvarez wrote:
> > On 6/13/19 3:45 PM, Thomas Gleixner wrote:
> > > Can you please provide the content of /proc/interrupts with the driver
> > > loaded and working after boot (don't hibernate) for the following kernels:
> > > 
> > 
> > $ cat linux-master-after-boot.txt
> >            CPU0       CPU1       CPU2       CPU3
> 
> >  27:          1          0          0          0   PCI-MSI 3145728-edge eth0
> 
> > >    Linus upstream + revert
> > 
> > $ cat linux-master-reverted-after-boot.txt
> >            CPU0       CPU1       CPU2       CPU3
> 
> >  27:          1          0          0          0   PCI-MSI 3145728-edge eth0
>  
> > Meanwhile, here it is for 4.9, which is the latest Debian-provided kernel and
> > worked:
> > 
> > $ cat linux-4.9-after-boot.txt
> >            CPU0       CPU1       CPU2       CPU3
> 
> >  24:          1          0          0          0   PCI-MSI 3145728-edge eth0
>  
> > I will keep trying 4.14, unless you say otherwise.
> 
> It would be interesting though I don't expect too much data.
> 
> So all of the above use PCI/MSI. That's at least a data point. I need to
> stare into that driver again to figure out why this might make a
> difference, but right now I'm lost.

One other data point you could provide please:

 Load the driver on Linus master with the following module parameter:

   disable_msi=1

That switches to INTx usage. Does the machine resume proper with that?

Thanks,

	tglx

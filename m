Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0BAC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31FF2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbfFXPkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:40:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39154 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFXPkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:40:12 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfR4Z-0000HP-Q2; Mon, 24 Jun 2019 17:39:59 +0200
Date:   Mon, 24 Jun 2019 17:39:58 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Stephen Hemminger <stephen@networkplumber.org>
cc:     Octavio Alvarez <octallk1@alvarezp.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Mirko Lindner <mlindner@marvell.com>
Subject: Re: PROBLEM: Marvell 88E8040 (sky2) fails after hibernation
In-Reply-To: <20190624083618.28cfd30a@hermes.lan>
Message-ID: <alpine.DEB.2.21.1906241736570.32342@nanos.tec.linutronix.de>
References: <aba1c363-92de-66d7-4aac-b555f398e70a@alvarezp.org>        <2cf2f745-0e29-13a7-6364-0a981dae758c@alvarezp.org>        <alpine.DEB.2.21.1906132229540.1791@nanos.tec.linutronix.de>        <95539fd9-ffdb-b91c-935f-7fd54d048fdf@alvarezp.org>       
 <alpine.DEB.2.21.1906221523340.5503@nanos.tec.linutronix.de>        <alpine.DEB.2.21.1906231448540.32342@nanos.tec.linutronix.de> <20190624083618.28cfd30a@hermes.lan>
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

On Mon, 24 Jun 2019, Stephen Hemminger wrote:
> On Sun, 23 Jun 2019 14:54:13 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > I will keep trying 4.14, unless you say otherwise.  
> > > 
> > > It would be interesting though I don't expect too much data.
> > > 
> > > So all of the above use PCI/MSI. That's at least a data point. I need to
> > > stare into that driver again to figure out why this might make a
> > > difference, but right now I'm lost.  
> > 
> > One other data point you could provide please:
> > 
> >  Load the driver on Linus master with the following module parameter:
> > 
> >    disable_msi=1
> > 
> > That switches to INTx usage. Does the machine resume proper with that?
> > 
> > Thanks,
> > 
> > 	tglx
> 
> 
> Suspend/resume and hibernation issues are often related to BIOS issues.

Right. The puzzle is that it worked and stopped working at some point and
the cure is to revert a change in the irq core. That change fixed a
regression in MSI and basically restores previous behaviour which should be
very similar to the behaviour in the working old (4.9) kernel.

Still trying to wrap my head around that, but of course everything is a
moving part since then (interrupts, network, ....)

Thanks,

	tglx


Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15560C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 06:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54D4206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 06:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404293AbfIQGho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 02:37:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40723 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729094AbfIQGhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 02:37:43 -0400
Received: from pd9ef19d4.dip0.t-ipconnect.de ([217.239.25.212] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iA770-00044V-0x; Tue, 17 Sep 2019 08:37:18 +0200
Date:   Tue, 17 Sep 2019 08:37:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Raj, Ashok" <ashok.raj@intel.com>
cc:     Johannes Erdfelt <johannes@erdfelt.com>,
        Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: Add an option to reload microcode even
 if revision is unchanged
In-Reply-To: <20190917003122.GA3005@otc-nc-03>
Message-ID: <alpine.DEB.2.21.1909170824220.2066@nanos.tec.linutronix.de>
References: <20190905072029.GB19246@zn.tnic> <20190905194044.GA3663@otc-nc-03> <alpine.DEB.2.21.1909052316130.1902@nanos.tec.linutronix.de> <20190905222706.GA4422@otc-nc-03> <alpine.DEB.2.21.1909061431330.1902@nanos.tec.linutronix.de> <20190906144039.GA29569@sventech.com>
 <alpine.DEB.2.21.1909062237580.1902@nanos.tec.linutronix.de> <20190907003338.GA14807@araj-mobl1.jf.intel.com> <alpine.DEB.2.21.1909071236120.1902@nanos.tec.linutronix.de> <alpine.DEB.2.21.1909161227060.10731@nanos.tec.linutronix.de>
 <20190917003122.GA3005@otc-nc-03>
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

Raj,

On Mon, 16 Sep 2019, Raj, Ashok wrote:
> On Mon, Sep 16, 2019 at 12:36:11PM +0200, Thomas Gleixner wrote:
> > That said, there is also a distinct lack of information about micro code
> > loading in a safe way in general. We absolutely do not know whether a micro
> > code update affects any instruction which might be in use during the update
> > on a sibling. Right now it's all load and pray and the SDM is not really
> > helpful with that either.
> > 
> 
> Guilty as charged :-). In general we do not expect microcode updates to 
> remove any cpuid bits (Not that it hasn't happened, but it slipped through
> the cracks). 
> 
> microode updates should be of 3 types.
> 
> - Only loadable from BIOS (Only via FIT tables)
> - Suitable for early load (things that take cpuid bits for e.g.)
> - Suitable for late-load. (Where no cpuid bits should change etc).
> 
> Today the way we load after a stop_machine() all threads in the system are
> held hostage until all the cores have done the update. The thread sibling
> is also in the rendezvous loop. 

I know. See below.
 
> Do you think we still have that risk with a sibling thread? 
> (Assuming future ucodes don't do weird things like what happened in 
> that case where a cpuid was removed via an update)

Well, yes. The sibling executes a limited set of instructions in a loop,
but it might be hit by an NMI or MCE which executes even more instructions.

So what happens if the ucode update "fixes" one of the executed
instructions on the fly? Is that guaranteed to be safe? There is nothing
which says so.

A decade ago I experimented with putting the spinning CPUs into MWAIT,
which caused havoc. Did neither have time nor the stomach to dig into that
further, but the ucode update _did_ fix an issue with MWAIT according to
the version history.

That's why I'm worried about instructions being "fixed" which are executed
in parallel on the sibling.

An authorative statement vs. that would be appreciated. Preferrably in form
of an extension of the SDM, but an upfront statement in this thread would
be a good start.

Thanks,

	tglx





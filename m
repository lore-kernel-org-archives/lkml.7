Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21198C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 10:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005D821835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 10:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388812AbfIGKhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 06:37:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49183 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfIGKhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 06:37:36 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i6Y5g-00053B-Ps; Sat, 07 Sep 2019 12:37:12 +0200
Date:   Sat, 7 Sep 2019 12:37:11 +0200 (CEST)
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
In-Reply-To: <20190907003338.GA14807@araj-mobl1.jf.intel.com>
Message-ID: <alpine.DEB.2.21.1909071236120.1902@nanos.tec.linutronix.de>
References: <41cee473-321c-2758-032a-ccf0f01359dc@oracle.com> <D8A3D2BD-1FD4-4183-8663-3EF02A6099F3@alien8.de> <20190905002132.GA26568@otc-nc-03> <20190905072029.GB19246@zn.tnic> <20190905194044.GA3663@otc-nc-03> <alpine.DEB.2.21.1909052316130.1902@nanos.tec.linutronix.de>
 <20190905222706.GA4422@otc-nc-03> <alpine.DEB.2.21.1909061431330.1902@nanos.tec.linutronix.de> <20190906144039.GA29569@sventech.com> <alpine.DEB.2.21.1909062237580.1902@nanos.tec.linutronix.de> <20190907003338.GA14807@araj-mobl1.jf.intel.com>
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

On Fri, 6 Sep 2019, Raj, Ashok wrote:
> On Fri, Sep 06, 2019 at 11:16:00PM +0200, Thomas Gleixner wrote:
> > Now #1 is actually a sensible and feasible solution which can be pulled off
> > in a reasonably short time frame, avoids all the bound to be ugly and
> > failure laden attempts of fixing late loading completely and provides a
> > usable and safe solution for joe user, jack admin and the super experts at
> > big-cloud corporate.
> > 
> > That is not requiring any new format of microcode payload, as this can be
> > nicely done as a metadata package which comes with the microcode
> > payload. So you get the following backwards compatible states:
> > 
> >   Kernel  metadata	  result
> > 
> >   old	  don't care	  refuse late load
> > 
> >   new	  No   		  refuse late load
> > 
> >   new	  Yes		  decide based on metadata
> > 
> > Thoughts?
> 
> This is 100% in line with what we proposed... 

So what it hindering you to implement that? ucode teams whining about the
little bit of extra work?

Thanks,

	tglx

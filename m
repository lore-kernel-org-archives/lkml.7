Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04598C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D829A2082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404771AbfIFMvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:51:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47309 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404762AbfIFMve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:51:34 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i6Dhu-0001Sg-QS; Fri, 06 Sep 2019 14:51:18 +0200
Date:   Fri, 6 Sep 2019 14:51:17 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Raj, Ashok" <ashok.raj@intel.com>
cc:     Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: Add an option to reload microcode even
 if revision is unchanged
In-Reply-To: <20190905222706.GA4422@otc-nc-03>
Message-ID: <alpine.DEB.2.21.1909061431330.1902@nanos.tec.linutronix.de>
References: <1567056803-6640-1-git-send-email-ashok.raj@intel.com> <20190829060942.GA1312@zn.tnic> <20190829130213.GA23510@araj-mobl1.jf.intel.com> <20190903164630.GF11641@zn.tnic> <41cee473-321c-2758-032a-ccf0f01359dc@oracle.com> <D8A3D2BD-1FD4-4183-8663-3EF02A6099F3@alien8.de>
 <20190905002132.GA26568@otc-nc-03> <20190905072029.GB19246@zn.tnic> <20190905194044.GA3663@otc-nc-03> <alpine.DEB.2.21.1909052316130.1902@nanos.tec.linutronix.de> <20190905222706.GA4422@otc-nc-03>
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

On Thu, 5 Sep 2019, Raj, Ashok wrote:
> On Thu, Sep 05, 2019 at 11:22:31PM +0200, Thomas Gleixner wrote:
> > That's all nice, but what it the general use case for this outside of Intel's
> > microcode development and testing?
> > 
> > We all know that late microcode loading has severe limitations and we
> > really don't want to proliferate that further if not absolutely required
> 
> Several customers have asked this to check the safety of late loads. They want
> to validate in production setup prior to rolling late-load to all production systems.

Groan. Late loading _IS_ broken by definition and it was so forever.

What your customers are asking for is a receipe for disaster. They can
check the safety of late loading forever, it will not magically become safe
because they do so.

If you want late loading, then the whole approach needs to be reworked from
ground up. You need to make sure that all CPUs are in a safe state,
i.e. where switching of CPU feature bits of all sorts can be done with the
guarantee that no CPU will return to the wrong code path after coming out
of safe state and that any kernel internal state which depends on the
previous set of CPU feature bits has been mopped up and switched over
before CPUs are released.

That does not exist and unless it does, late loading is just going to cause
trouble nothing else.

So, no. We are not merging something which is known to be broken and then
we have to deal with the subtle fallout and the bug reports forever. Not to
talk about having to fend of half baken duct tape patches which try to glue
things together.

The only sensible patch for that is to remove any trace of late loading
crappola once and forever.

Sorry, -ENOPONIES

Thanks,

	tglx

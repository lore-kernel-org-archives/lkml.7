Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4372C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 21:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4322070C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 21:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390220AbfIFVQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 17:16:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48660 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387588AbfIFVQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 17:16:22 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i6LaM-0002rr-VX; Fri, 06 Sep 2019 23:16:03 +0200
Date:   Fri, 6 Sep 2019 23:16:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Johannes Erdfelt <johannes@erdfelt.com>
cc:     "Raj, Ashok" <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: Add an option to reload microcode even
 if revision is unchanged
In-Reply-To: <20190906144039.GA29569@sventech.com>
Message-ID: <alpine.DEB.2.21.1909062237580.1902@nanos.tec.linutronix.de>
References: <20190829130213.GA23510@araj-mobl1.jf.intel.com> <20190903164630.GF11641@zn.tnic> <41cee473-321c-2758-032a-ccf0f01359dc@oracle.com> <D8A3D2BD-1FD4-4183-8663-3EF02A6099F3@alien8.de> <20190905002132.GA26568@otc-nc-03> <20190905072029.GB19246@zn.tnic>
 <20190905194044.GA3663@otc-nc-03> <alpine.DEB.2.21.1909052316130.1902@nanos.tec.linutronix.de> <20190905222706.GA4422@otc-nc-03> <alpine.DEB.2.21.1909061431330.1902@nanos.tec.linutronix.de> <20190906144039.GA29569@sventech.com>
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

On Fri, 6 Sep 2019, Johannes Erdfelt wrote:
> On Fri, Sep 06, 2019, Thomas Gleixner <tglx@linutronix.de> wrote:
> > What your customers are asking for is a receipe for disaster. They can
> > check the safety of late loading forever, it will not magically become safe
> > because they do so.
> > 
> > If you want late loading, then the whole approach needs to be reworked from
> > ground up. You need to make sure that all CPUs are in a safe state,
> > i.e. where switching of CPU feature bits of all sorts can be done with the
> > guarantee that no CPU will return to the wrong code path after coming out
> > of safe state and that any kernel internal state which depends on the
> > previous set of CPU feature bits has been mopped up and switched over
> > before CPUs are released.
> 
> You say that switching of CPU feature bits is problematic, but adding
> new features should result only in a warning ("x86/CPU: CPU features
> have changed after loading microcode, but might not take effect.").
> 
> Removing a CPU feature bit could be problematic. Other than HLE being
> removed on Haswell (which the kernel shouldn't use anyway), have there
> been any other cases?
> 
> I ask because we have successfully used late microcode loading on tens
> of thousands of hosts. I'm a bit worried to see that there is a push to
> remove a feature that we currently rely on.

The point is that you know what's on stake so you can evaluate precisely
upfront whether that works or not and you have experienced kernel engineers
on staff who can tell you which kind of ucode change is going to explode in
your face and which on does not.

So it's the special case of a large cloud company with experts on staff.

Now map that to the average user/sysadmin. If we proliferate this, then the
inevitable consequence will be that those people read about how great that
is and how it made your customers happy yadayadayada. Now they go and do
the same thing and guess what happens? It explodes in their face, they send
bug reports and someone else will send lousy patches to paper over the
problem. None of this ends on your desk.

Yes you can surely argue that if you give people a gun then they can shoot
themself into their foot. But in that case it's a irresponsible argument
which just put's your interest above the general rule of not offering
things which are bound to break in all flavours of wreckage especially in
the hard to diagnose way.

So if we want to do late microcode loading in a sane way then there are
only a few options and none of them exist today:

 1) Micro-code contains a description of CPUID bits which are going to be
    exposed after the load. Then the kernel can sanity check whether this
    changes anything relevant or not. If there is a relevant change it can
    reject the load and tell the admin that a reboot is required.

 2) Rework CPUID feature handling so that it can reevaluate and reconfigure
    the running system safely. There are a lot of things you need for that:

    A) Introduce a safe state for CPUs to reach which guarantees that none
       of the CPUs will return from that state via a code path which
       depends on previous state and might now go the other route with data
       on the stack which only fits the previous configuration.

    B) Make all the cpufeature thingies run time switchable. That means
       that you need to keep quite some code around which is currently init
       only. That also means that you have to provide backout code for
       things which set up data corresponding to cpu feature bits and so
       forth.

So #2 might be finished in about 20 years from now with the result that
some of the code pathes might simply still have a

     if (cpufeature_changed())
     	   panic();

because there are things which you cannot back out. So the only sane
solution is to panic. Which is not a solution as it would be much more sane
to prevent late loading upfront and force people to reboot proper.

Now #1 is actually a sensible and feasible solution which can be pulled off
in a reasonably short time frame, avoids all the bound to be ugly and
failure laden attempts of fixing late loading completely and provides a
usable and safe solution for joe user, jack admin and the super experts at
big-cloud corporate.

That is not requiring any new format of microcode payload, as this can be
nicely done as a metadata package which comes with the microcode
payload. So you get the following backwards compatible states:

  Kernel  metadata	  result

  old	  don't care	  refuse late load

  new	  No   		  refuse late load

  new	  Yes		  decide based on metadata

Thoughts?

Thanks,

	tglx


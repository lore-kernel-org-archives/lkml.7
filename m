Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B768C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8B82071F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfKNSsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:48:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41497 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfKNSsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:48:45 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iVKAa-000180-Oa; Thu, 14 Nov 2019 19:48:40 +0100
Date:   Thu, 14 Nov 2019 19:48:39 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Waiman Long <longman@redhat.com>
cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] x86/speculation: Fix incorrect MDS/TAA mitigation
 status
In-Reply-To: <8f7e0f4b-5100-67b5-fcb5-f7a968b96110@redhat.com>
Message-ID: <alpine.DEB.2.21.1911141943150.29616@nanos.tec.linutronix.de>
References: <20191113193350.24511-1-longman@redhat.com> <20191114174553.GC7222@zn.tnic> <8f7e0f4b-5100-67b5-fcb5-f7a968b96110@redhat.com>
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

On Thu, 14 Nov 2019, Waiman Long wrote:
> On 11/14/19 12:45 PM, Borislav Petkov wrote:
> >> -	/* TAA mitigation is turned off on the cmdline (tsx_async_abort=off) */
> >> -	if (taa_mitigation == TAA_MITIGATION_OFF)
> >> +	/*
> >> +	 * TAA mitigation via VERW is turned off if both
> >> +	 * tsx_async_abort=off and mds=off are specified.
> >> +	 */
> > So this changes the dependency of switches so if anything, it should be
> > properly documented first in all three:
> >
> > Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
> > Documentation/x86/tsx_async_abort.rst
> > Documentation/admin-guide/kernel-parameters.txt
> >
> > However, before we do that, we need to agree on functionality:
> I agree that the documentation needs to be updated. I am going to do
> that once we have a consensus of what is the right thing to do.
> > Will the mitigations be disabled only with *both* =off supplied on the
> > command line or should the mitigations be disabled when *any* of the two
> > =off is supplied?
> 
> The mitigation is disabled only with BOTH =off supplied or
> "mitigations=off". This is the current behavior. This patch is just to
> make sure that vulnerabilities files reflect the actual behavior. Of
> course, we can change it to disable mitigation with either =off if this
> is what the consensus turn out to be.

I think the current behaviour is correct. It's just a coincidence that both
issues happen to use the same mitigation technology in the exactly same
places. So if you leave one on then the other gets mitigated as a side
effect and the sysfs file should reflect that.

Thanks,

	tglx

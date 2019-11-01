Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28196CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A53220650
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfKAPkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 11:40:37 -0400
Received: from smtprelay0245.hostedemail.com ([216.40.44.245]:49341 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727707AbfKAPkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 11:40:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id B8E50181D341E;
        Fri,  1 Nov 2019 15:40:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rod52_793f56825b52c
X-Filterd-Recvd-Size: 3011
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Fri,  1 Nov 2019 15:40:33 +0000 (UTC)
Message-ID: <bb87f5753b949dee813f226c8317148f6cf5644f.camel@perches.com>
Subject: Re: [PATCH 3.16 47/47] KVM: x86/vPMU: refine kvm_pmu err msg when
 event creation failed
From:   Joe Perches <joe@perches.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        Like Xu <like.xu@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Date:   Fri, 01 Nov 2019 08:40:23 -0700
In-Reply-To: <20191101080745.GT1554@sasha-vm>
References: <lsq.1572026582.631294584@decadent.org.uk>
         <220d8f2c1b299d2e71fdcf50b98286aae5b0c6f2.camel@perches.com>
         <05be6a70382f1990a2ba6aba9ac75dac0c55f7fb.camel@decadent.org.uk>
         <3078d0a186cca2dfae741908ffff41f1bdb30eae.camel@perches.com>
         <20191101080745.GT1554@sasha-vm>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-01 at 04:07 -0400, Sasha Levin wrote:
> On Thu, Oct 31, 2019 at 03:53:23PM -0700, Joe Perches wrote:
> > On Thu, 2019-10-31 at 22:14 +0000, Ben Hutchings wrote:
> > > On Fri, 2019-10-25 at 12:05 -0700, Joe Perches wrote:
> > > > On Fri, 2019-10-25 at 19:03 +0100, Ben Hutchings wrote:
> > > > > 3.16.76-rc1 review patch.  If anyone has any objections, please let me know.
> > > > 
> > > > This seems more like an enhancement than a bug fix.
> > > > 
> > > > Is this really the type of patch that is appropriate
> > > > for stable?
> > > 
> > > Apparently so:
> > > 
> > > v4.14.135: eba797dbf352 KVM: x86/vPMU: refine kvm_pmu err msg when event creation failed
> > > v4.19.61: ba27a25df6df KVM: x86/vPMU: refine kvm_pmu err msg when event creation failed
> > > v4.4.187: 505c011f9f53 KVM: x86/vPMU: refine kvm_pmu err msg when event creation failed
> > > v4.9.187: 3984eae04473 KVM: x86/vPMU: refine kvm_pmu err msg when event creation failed
> > > v5.1.20: edadec197fbf KVM: x86/vPMU: refine kvm_pmu err msg when event creation failed
> > > v5.2.3: 9f062aef7356 KVM: x86/vPMU: refine kvm_pmu err msg when event creation failed
> > 
> > I think not, but hey, maybe you and Greg do.
> > 
> > Porting enhancements, even trivial ones, imo is
> > not a great thing for stable branches.
> > 
> > My perspective is that only bug fixes should be
> > applied to stable branches.
> 
> Usability issues are just as bad as code bugs. Our human interface is at
> least as important as the functionality of our code.

Umm.

#define DEBUG is not set here.

Changing from printk_once to pr_debug_ratelimited completely
eliminates the output from non CONFIG_DYNAMIC_DEBUG configs,
and this output message is not enabled by default either.




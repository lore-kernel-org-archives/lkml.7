Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BFAC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A291D20850
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="bYRmT+nO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfFNQKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:10:21 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36640 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfFNQKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:10:21 -0400
Received: from zn.tnic (p200300EC2F097F0005D99B23723B16AB.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:7f00:5d9:9b23:723b:16ab])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A3D821EC0B59;
        Fri, 14 Jun 2019 18:10:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560528619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9iP7kaNUTW4uh8RBPjCNQNzmG+WPVpl2XJ6Z4LIb+Bs=;
        b=bYRmT+nO+tC01losVQRtbX9KE4RCwDwNk39EqUL7rt3jDPEJRoKBzwskcf+HMyH9R5nvEB
        RxbDws9pHka6PL3ZviJwIDgDZwaTA81mSFDv3CMAeaXDFnqfWiUGwL8w77mycgdeE2Ivde
        zMfQZlpegYJaTlq7HY6fiwGA1mWYVdY=
Date:   Fri, 14 Jun 2019 18:10:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 2/3] x86/cpufeatures: Combine word 11 and 12 into new
 scattered features word 11
Message-ID: <20190614160659.GM2586@zn.tnic>
References: <1560459064-195037-3-git-send-email-fenghua.yu@intel.com>
 <20190614114410.GD2586@zn.tnic>
 <20190614122749.GE2586@zn.tnic>
 <20190614131701.GA198207@romley-ivt3.sc.intel.com>
 <20190614134123.GF2586@zn.tnic>
 <20190614141424.GA12191@linux.intel.com>
 <20190614142139.GH2586@zn.tnic>
 <20190614143912.GB12191@linux.intel.com>
 <20190614145734.GJ2586@zn.tnic>
 <20190614152458.GA22634@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190614152458.GA22634@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 08:24:58AM -0700, Sean Christopherson wrote:
> On Fri, Jun 14, 2019 at 04:57:34PM +0200, Borislav Petkov wrote:
> > On Fri, Jun 14, 2019 at 07:39:12AM -0700, Sean Christopherson wrote:
> > > KVM can't handle Linux-defined leafs without extra tricks
> > 
> > and that's what I'm proposing - an extra trick.
> 
> It's not a trick, it's bug suppression.
> 
> Try running a kernel built with only patches 1/2 and 2/2 applied, along
> with KVM's assertions removed.  It'll probably boot fine since most of the
> affected features are option things, but Linux's feature reporting will be
> all kinds of screwed up.
> 
> E.g. this WARN triggers because CPUID_7_EDX is 17, not 18 as expected,

We can decrement NCAPINTS and word 18 in the header. The BUILD_BUG_ONs
should not fire then too.

But the easier thing is to not remove any defines in the enum
cpuid_leafs thing so that the capabilities array has the proper size for
after patch 2.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

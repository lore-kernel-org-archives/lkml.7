Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3B6C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB55721848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfFNQU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:20:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:3513 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfFNQU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:20:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 09:20:27 -0700
X-ExtLoop1: 1
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.36])
  by orsmga001.jf.intel.com with ESMTP; 14 Jun 2019 09:20:27 -0700
Date:   Fri, 14 Jun 2019 09:20:27 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Borislav Petkov <bp@alien8.de>
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
Message-ID: <20190614162027.GF12191@linux.intel.com>
References: <20190614114410.GD2586@zn.tnic>
 <20190614122749.GE2586@zn.tnic>
 <20190614131701.GA198207@romley-ivt3.sc.intel.com>
 <20190614134123.GF2586@zn.tnic>
 <20190614141424.GA12191@linux.intel.com>
 <20190614142139.GH2586@zn.tnic>
 <20190614143912.GB12191@linux.intel.com>
 <20190614145734.GJ2586@zn.tnic>
 <20190614152458.GA22634@linux.intel.com>
 <20190614160659.GM2586@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614160659.GM2586@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 06:10:12PM +0200, Borislav Petkov wrote:
> On Fri, Jun 14, 2019 at 08:24:58AM -0700, Sean Christopherson wrote:
> > On Fri, Jun 14, 2019 at 04:57:34PM +0200, Borislav Petkov wrote:
> > > On Fri, Jun 14, 2019 at 07:39:12AM -0700, Sean Christopherson wrote:
> > > > KVM can't handle Linux-defined leafs without extra tricks
> > > 
> > > and that's what I'm proposing - an extra trick.
> > 
> > It's not a trick, it's bug suppression.
> > 
> > Try running a kernel built with only patches 1/2 and 2/2 applied, along
> > with KVM's assertions removed.  It'll probably boot fine since most of the
> > affected features are option things, but Linux's feature reporting will be
> > all kinds of screwed up.
> > 
> > E.g. this WARN triggers because CPUID_7_EDX is 17, not 18 as expected,
> 
> We can decrement NCAPINTS and word 18 in the header. The BUILD_BUG_ONs
> should not fire then too.
> 
> But the easier thing is to not remove any defines in the enum
> cpuid_leafs thing so that the capabilities array has the proper size for
> after patch 2.

Agreed, Fenghua's proposed CPUID_DUMMY is way easier.

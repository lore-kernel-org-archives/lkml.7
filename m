Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D958BC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEF425D4B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfFCTST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:18:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:55903 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfFCTST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:18:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 12:18:18 -0700
X-ExtLoop1: 1
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.36])
  by orsmga002.jf.intel.com with ESMTP; 03 Jun 2019 12:18:18 -0700
Date:   Mon, 3 Jun 2019 12:18:18 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Like Xu <like.xu@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v3] KVM: x86: Add Intel CPUID.1F cpuid emulation
 support
Message-ID: <20190603191818.GF13384@linux.intel.com>
References: <20190526133052.4069-1-like.xu@linux.intel.com>
 <20190603165616.GA11101@flask>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190603165616.GA11101@flask>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 06:56:17PM +0200, Radim Krčmář wrote:
> > +			break;
> > +		}
> >  		entry->eax = min(entry->eax, (u32)(f_intel_pt ? 0x14 : 0xd));
> 
> Similarly in the existing code.  If we don't have f_intel_pt, then we
> should make sure that leaf 0x14 is not being filled, but we don't really
> have to limit the maximal index.
> 
> Adding a single clamping like
> 
> 		/* Limited to the highest leaf implemented in KVM. */
> 		entry->eax = min(entry->eax, 0x1f);
> 
> seems sufficient.
>
> (Passing the hardware value is ok in theory, but it is a cheap way to
>  avoid future leaves that cannot be simply zeroed for some weird reason.)

I don't have a strong opinion regarding the code itself, but whatever ends
up getting committed should have a big beefy changelog explaining why the
clamping exists, or at least extolling its virtues.  I had a hell of a
time understanding the intent of this one line of code because as your
response shows, there is no one right answer.

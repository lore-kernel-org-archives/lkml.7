Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F533C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D7A206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfCKLGU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:06:20 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38103 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfCKLGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:06:20 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h3Ikv-0002ST-T2; Mon, 11 Mar 2019 12:06:06 +0100
Date:   Mon, 11 Mar 2019 12:06:05 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 14/22] x86/fpu: Eager switch PKRU state
Message-ID: <20190311110605.2xxjx2ym3n63lpr2@linutronix.de>
References: <20190221115020.12385-1-bigeasy@linutronix.de>
 <20190221115020.12385-15-bigeasy@linutronix.de>
 <eedfbbbe-02d0-f977-2a64-e683b98d3904@intel.com>
 <20190308180849.hy22jejhffp4n6uh@linutronix.de>
 <b0f3ffa8-faec-73b2-f6f2-ea37ece3a3b1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <b0f3ffa8-faec-73b2-f6f2-ea37ece3a3b1@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-08 11:01:25 [-0800], Dave Hansen wrote:
> On 3/8/19 10:08 AM, Sebastian Andrzej Siewior wrote:
> > On 2019-02-25 10:16:24 [-0800], Dave Hansen wrote:
> >>> +	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
> >>> +		return;
> >>> +
> >>> +	if (current->mm) {
> >>> +		pk = get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
> >>> +		WARN_ON_ONCE(!pk);
…
> Nothing will break, but the warning will trigger, which isn't nice.

the warning should trigger if something goes south, I was not expecting
it to happen.

> > My understanding is that the in-kernel XSAVE will always save everything
> > so we should never "lose" the XFEATURE_PKRU no matter what user space
> > does.
> > 
> > So as test case you want
> > 	xsave (-1 & ~XFEATURE_PKRU)
> > 	xrestore (-1 & ~XFEATURE_PKRU)
> > 
> > in userland and then a context switch to see if the warning above
> > triggers?
> 
> I think you need an XRSTOR with RFBM=-1 (or at least with the PKRU bit
> set) and the PKRU bit in the XFEATURES field in the XSAVE buffer set to 0.

let me check that, write a test case in userland and I come back with
the results. I can remove that warning but I wasn't expecting it to
trigger so let me verify that first.

> >>> +		if (pk)
> >>> +			pkru_val = pk->pkru;
> >>> +	}> +	__write_pkru(pkru_val);
> >>>  }
> >>
> >> A comment above __write_pkru() would be nice to say that it only
> >> actually does the slow instruction on changes to the value.
> > 
> > Could we please not do this? It is a comment above one of the callers
> > function and we have two or three. And we have that comment already
> > within __write_pkru().
> 
> I looked at this code and thought "writing PKRU is slow", and "this
> writes PKRU unconditionally", and "the __ version of the function
> shoudn't have much logic in it".
> 
> I got 2/3 wrong.  To me that means this site needs a 1-line comment.
> Feel free to move one of the other comments to here if you think it's
> over-commented, but this site needs one.

right because things changed as part of patch series. 
You wanted to have in __write_pkru() the same semantic like in
__read_pkru() which is currently the case because __write_pkru() has the
check. It  would be great if we could rename it to something else and
avoid the comment. (Because if this user gets a comment then other
should, too and I think this is an overkill).

> > Last time we talked about this we agreed (or this was my impression) that
> > 0 should be written so that the kernel thread should always be able to
> > write to user space in case it borrowed its mm (otherwise it has none
> > and it would fail anyway).
> 
> We can't write to userspace when borrowing an mm.  If the kernel borrows
> an mm, we might as well be on the init_mm which has no userspace mappings.

If a kernel thread borrows a mm from a user task via use_mm() then it
_can_ write to that task's user land memory from a kthread.

> > We didn't want to leave PKRU alone because the outcome (whether or not
> > the write by the kernel thread succeeds) should not depend on the last
> > running task (and be random) but deterministic.
> 
> Right, so let's make it deterministically restrictive: either
> init_pkru_value, or -1 since kernel threads shouldn't be touching
> userspace in the first place.

I'm fine either way, just tell me what you want. Just consider the
use_mm() part above I wrote. (I remember you/luto suggest to have an API
for something like that so that the PKRU value can be 

Sebastian

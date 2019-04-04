Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A18C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB45420855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfDDObI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:31:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45258 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfDDObI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:31:08 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hC3OR-0003iS-M3; Thu, 04 Apr 2019 16:31:03 +0200
Date:   Thu, 4 Apr 2019 16:31:03 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v9 00/27] x86: load FPU registers on return to userland
Message-ID: <20190404143103.k7ycnblyefxswf67@linutronix.de>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
 <c4af28470a4347f5aa222a99471c939a@AcuMS.aculab.com>
 <20190404141409.upfk5z4re3pyvxzn@linutronix.de>
 <CALCETrU4hSC20sExsgPnhkUOfS+kd-hMHK7_amq_C5duNw33cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrU4hSC20sExsgPnhkUOfS+kd-hMHK7_amq_C5duNw33cg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-04 07:26:37 [-0700], Andy Lutomirski wrote:
> I think that David was asking whether we could make kernel_fpu_begin()
> regions sometimes be preemptible.  The answer is presumably yes, but I
> think that should be a separate effort, and it should be justified
> with improved performance above and beyond what we get with Jason's
> simd_get() stuff.

Last time I checked we had no very SIMD loops unless you count $ALG over
1 MiB data or so. And in that case you could use the
kernel_fpu_begin()/end combo after a complete SIMD loop. I would like
see that at least while going from one page to the next.

Sebastian

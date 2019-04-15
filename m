Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6715EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388C220656
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfDOJOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:14:50 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45025 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfDOJOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:14:49 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hFxhN-0003Ni-QG; Mon, 15 Apr 2019 11:14:45 +0200
Date:   Mon, 15 Apr 2019 11:14:45 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 23/27] x86/fpu: Defer FPU state load until return to
 userspace
Message-ID: <20190415091445.el2tj3yg6j3kfuom@linutronix.de>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
 <20190403164156.19645-24-bigeasy@linutronix.de>
 <20190412143615.GE19808@zn.tnic>
 <20190412152437.d2bswajqtx7hrpkb@linutronix.de>
 <20190412162213.GF19808@zn.tnic>
 <20190412163741.wq2iq44bnvcbne3a@linutronix.de>
 <20190412164827.GG19808@zn.tnic>
 <20190412171955.npe2pbomc6np326v@linutronix.de>
 <20190412172931.GI19808@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190412172931.GI19808@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-12 19:29:31 [+0200], Borislav Petkov wrote:
> > - in kernel_fpu_begin() we may trash the task's FPU state (by saving its
> >   registers or by resetting fpu_fpregs_owner_ctx).
> 
> Do we care?
> 
> You mean, in case you have workloads which might involve a lot of
> in-kernel FPU use which would punish task context switches?

Well, depends how you look on it. So for instance:
- Does kernel_fpu_begin() save task's FPU registers or are they already
  stored and it is a nop.
- The task avoid loading its registers on return to userland but that
  FPU usage in BH made it impossible.
- Is there any FPU usage in BH?

And there is this: My program usually works but with this scheduling
pattern and FPU usage in kernel it computes wrong result.
 
Sebastian

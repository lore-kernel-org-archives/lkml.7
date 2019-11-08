Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E3BC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 01:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F12214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 01:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PSXZrH1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfKHBN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 20:13:59 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48289 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfKHBN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 20:13:58 -0500
Received: from carbon-x1.hos.anvin.org ([IPv6:2601:646:8600:3281:e7ea:4585:74bd:2ff0])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id xA81C9Rt1394965
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 7 Nov 2019 17:12:09 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com xA81C9Rt1394965
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019091901; t=1573175531;
        bh=43nSIPM3zepQghDp/jhr28I5z95qZarMcNvR5GrYr0E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PSXZrH1vpjXgx1nKOpIBf/AJG3lZ8XnIMPAVA6TNg+11B7KTtMSJJ3gHZfbB64e38
         l0NTHtqU1zg3zMAZkooW1JuCkasknsC3QjyljFeBiTZMJu2EUcQkpExYNFXQTEGPWX
         TranzDOhqSY/Fp3wZXTZAgCe3tVRobLdInFT13/pYsTBAKHm34a2yiAOe+z8RSRTaW
         sKOwH1/PvUZ1cc18wbxbCToSOx72ToKS9AheiviBIS14NqN7qPU6nOeGj5xmr7Qz84
         qjzApv/2ljeRWThyHhnC81l1/CqBtoU35Mguexde4jGEBglHYAz0QSPpqG9aiFDTR8
         T0ddcrK6+BqNQ==
Subject: Re: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage
 further
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Brian Gerst <brgerst@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20191106193459.581614484@linutronix.de>
 <20191106202806.241007755@linutronix.de>
 <CAMzpN2juuUyLuQ-tiV7hKZvG4agsHKP=rRAt_V4sZhpZW7cv9g@mail.gmail.com>
 <CAHk-=wiGO=+mmEb-sfCsD5mxmL5++gdwkFj_aXcfz1R41MJnEg@mail.gmail.com>
 <CAMzpN2gt4qM41=96GpNHL-kbgBsjD-zphq+5oK0BXqoCFN4F4Q@mail.gmail.com>
 <CAHk-=wjocTzo+8OMwyKPX0MCVV=N4wtU8ifwSZ_qJJnDBgKJ8Q@mail.gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <6cac6943-2f6c-d48a-658e-08b3bf87921a@zytor.com>
Date:   Thu, 7 Nov 2019 17:12:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjocTzo+8OMwyKPX0MCVV=N4wtU8ifwSZ_qJJnDBgKJ8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-07 13:44, Linus Torvalds wrote:
> On Thu, Nov 7, 2019 at 1:00 PM Brian Gerst <brgerst@gmail.com> wrote:
>>
>> There wouldn't have to be a flush on every task switch.
> 
> No. But we'd have to flush on any switch that currently does that memcpy.
> 
> And my point is that a tlb flush (even the single-page case) is likely
> more expensive than the memcpy.
> 
>> Going a step further, we could track which task is mapped to the
>> current cpu like proposed above, and only flush when a different task
>> needs the IO bitmap, or when the bitmap is being freed on task exit.
> 
> Well, that's exactly my "track the last task" optimization for copying
> the thing.
> 
> IOW, it's the same optimization as avoiding the memcpy.
> 
> Which I think is likely very effective, but also makes it fairly
> pointless to then try to be clever..
> 
> So the basic issue remains that playing VM games has almost
> universally been slower and more complex than simply not playing VM
> games. TLB flushes - even invlpg - tends to be pretty slow.
> 
> Of course, we probably end up invalidating the TLB's anyway, so maybe
> in this case we don't care. The ioperm bitmap is _technically_
> per-thread, though, so it should be flushed even if the VM isn't
> flushed...
> 

One option, probably a lot saner (if we care at all, after all, copying 8K
really isn't that much, but it might have some impact on real-time processes,
which is one of the rather few use cases for direct I/O) would be to keep the
bitmask in a pre-formatted TSS (ioperm being per thread, so no concerns about
the TSS being in use on another processor), and copy the TSS fields (88 bytes)
over if and only if the thread has been migrated to a different CPU, then
switch the TSS rather than switching  For the common case (no ioperms) we use
the standard per-cpu TSS.

That being said, I don't actually know that copying 88 bytes + LTR is any
cheaper than copying 8K.

	-hpa

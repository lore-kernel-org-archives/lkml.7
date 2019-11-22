Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A79C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 21:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7742071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 21:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574457825;
	bh=Hx1S3yva9g7jFAFWnreddWvjyrSXWX9RxR8BMWD4FBs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VHG2dRpQlQEQP+AISYdsgdBEsVzOUUObFHc8VexKhabB/U0HxAx7tT9m5ehWZSvvU
	 vKVAGWj37dbOGkflD9KSrt2kMeKaiZ0dwDcFXoYWeRkinl5mXbz4VQuOd4LGSv1LCv
	 L49fwv7WG32ktFUeJv0nwNvGaWIhfTP3/O9LWuH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfKVVXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 16:23:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:58748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfKVVXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 16:23:44 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C646120730
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 21:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574457823;
        bh=Hx1S3yva9g7jFAFWnreddWvjyrSXWX9RxR8BMWD4FBs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jLAaVSD8MjThFW2QBvts5vEYotsB7eyNrFdA+ERJuVSMxl3I2sEbfLO4k6avBX7oI
         L3QRowbw0yYdVZ3vzs7QRbg62qxw5NAu+I3NX8mpUrsAmvHk2zzR+RhOVzx/dVrPPI
         gxO/HteNqg/0k5TiXtxfekxHNDxFR79+6tK8sbBA=
Received: by mail-wm1-f54.google.com with SMTP id u18so8940186wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 13:23:42 -0800 (PST)
X-Gm-Message-State: APjAAAXNg5BGGMVHD+jqz6HykqAK0Idz6YblmEPKl/L+L44aIBbGcLVJ
        OXuGrYxwLtH+yybrJHIU8fL0XVmAawbLqeMpz2p1zw==
X-Google-Smtp-Source: APXvYqwtuw4QGb+MOGJqeqjJP3Uj7PxMLUzry1BflsLBmFgn8IlkdD+2Mt/ECKwleLQRX1FPPKR+lxHd/Kr39xgl8z4=
X-Received: by 2002:a1c:ed05:: with SMTP id l5mr473220wmh.161.1574457821206;
 Fri, 22 Nov 2019 13:23:41 -0800 (PST)
MIME-Version: 1.0
References: <20191121060444.GA55272@gmail.com> <20191121130153.GS4097@hirez.programming.kicks-ass.net>
 <20191121171214.GD12042@gmail.com> <3481175cbe14457a947f934343946d52@AcuMS.aculab.com>
 <CALCETrW+qxrE633qetS4c1Rn2AX_hk5OgneZRtoZPFN1J395Ng@mail.gmail.com>
 <20191121185303.GB199273@romley-ivt3.sc.intel.com> <20191121202508.GZ4097@hirez.programming.kicks-ass.net>
 <CALCETrXbe_q07kL1AyaNaAqgUHsdN6rEDzzZ0CEtv-k9VvQL0A@mail.gmail.com>
 <20191122092555.GA4097@hirez.programming.kicks-ass.net> <3908561D78D1C84285E8C5FCA982C28F7F4DD19F@ORSMSX115.amr.corp.intel.com>
 <20191122203105.GE2844@hirez.programming.kicks-ass.net>
In-Reply-To: <20191122203105.GE2844@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 22 Nov 2019 13:23:30 -0800
X-Gmail-Original-Message-ID: <CALCETrVjXC7RHZCkAcWEeCrJq7DPeVBooK8S3mG0LT8q9AxvPw@mail.gmail.com>
Message-ID: <CALCETrVjXC7RHZCkAcWEeCrJq7DPeVBooK8S3mG0LT8q9AxvPw@mail.gmail.com>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 12:31 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 22, 2019 at 05:48:14PM +0000, Luck, Tony wrote:
> > > When we use byte ops, we must consider the word as 4 independent
> > > variables. And in that case the later load might observe the lock-byte
> > > state from 3, because the modification to the lock byte from 4 is in
> > > CPU2's store-buffer.
> >
> > So we absolutely violate this with the optimization for constant arguments
> > to set_bit(), clear_bit() and change_bit() that are implemented as byte ops.
> >
> > So is code that does:
> >
> >       set_bit(0, bitmap);
> >
> > on one CPU. While another is doing:
> >
> >       set_bit(mybit, bitmap);
> >
> > on another CPU safe? The first operates on just one byte, the second  on 8 bytes.
>
> It is safe if all you care about is the consistency of that one bit.
>

I'm still lost here.  Can you explain how one could write code that
observes an issue?  My trusty SDM, Vol 3 8.2.2 says "Locked
instructions have a total order."  8.2.3.9 says "Loads and Stores Are
Not Reordered with Locked Instructions."  Admittedly, the latter is an
"example", but the section is very clear about the fact that a locked
instruction prevents reordering of a load or a store issued by the
same CPU relative to the locked instruction *regardless of whether
they overlap*.

So using LOCK to impleent smb_mb() is correct, and I still don't
understand your particular concern.

I understand that the CPU is probably permitted to optimize a LOCK RMW
operation such that it retires before the store buffers of earlier
instructions are fully flushed, but only if the store buffer and cache
coherency machinery work together to preserve the architecturally
guaranteed ordering.

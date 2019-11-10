Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36490C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 17:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7DA20842
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 17:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573406480;
	bh=rHEH2PkY4A2TugcHgOSv5PxC0YceCfphkl5ndl04VlA=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=IgciNl2gr20k8CcD50CB5bc5ESVgfxm3Y8Nzq2iqmETlzZxXQVmIyqCWRAUEZHVKR
	 nvp+wMoo6j92MD9oh5PVOqfBuHY5IXgismT4otw9ya3S56TPuNw0jv0l5CJZbPHKPa
	 Dy68Q+Bkp7HOyn53iDEFYNFEbxeqvaaL6IzBgc24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfKJRVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 12:21:19 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36252 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfKJRVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 12:21:18 -0500
Received: by mail-pf1-f193.google.com with SMTP id v19so8820984pfm.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 09:21:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0R4OFUZi58Id9OiT2d8cG4KxzK+0jeWwqeV4pxS9htk=;
        b=CIxmci9cyjMcETGxirOlquAeibP3Cq1xM/a68pATDvLg2fazMpvoWC37TDmGmYuRc7
         ySJxorZEwXHM03rwsGamUkCXBO0dlumwaC4D5Sj+8cW0/SWUFD9KKE2l6sZESUD5bjKg
         oKWWX06xMDCzNp+0i54kCuHOr/vxrHGN3zGS3TY3bnHduO/Wkqu8CA55s7C8/HHImQPO
         CzJlKXzPMV0/ZGzt31rrYqLAv08i3+hq9viXf491/N6xa8Xc3EUojtF08BIknO5JHKmY
         qsVwZxjs80QUQ/f/VfmY/249RKziXrdyGSMDuO5F3TaWYeQ9Ww1Wlm9urOsiGX04X8Vp
         JffA==
X-Gm-Message-State: APjAAAW/mbiPU7P6+bT52ffFhHfdDvI9QnQMUfNVkqrvNXz0P8kUdbxT
        nwYjjdvJxLC/Or9cRWUW0XR53A==
X-Google-Smtp-Source: APXvYqzrqq9MaeJJ7B6S4DZTU/z/+Vs3sNctBHl2svdCGVJwYG9StQmgGJjoEu+jqpLt1z0ghyR5cg==
X-Received: by 2002:a17:90a:1:: with SMTP id 1mr21340490pja.42.1573406477900;
        Sun, 10 Nov 2019 09:21:17 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:3602:86ff:fef6:e86b? ([2601:646:c200:1ef2:3602:86ff:fef6:e86b])
        by smtp.googlemail.com with ESMTPSA id m68sm11881340pfb.122.2019.11.10.09.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2019 09:21:17 -0800 (PST)
Subject: Re: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage
 further
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Brian Gerst <brgerst@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20191106193459.581614484@linutronix.de>
 <20191106202806.241007755@linutronix.de>
 <CAMzpN2juuUyLuQ-tiV7hKZvG4agsHKP=rRAt_V4sZhpZW7cv9g@mail.gmail.com>
 <CAHk-=wiGO=+mmEb-sfCsD5mxmL5++gdwkFj_aXcfz1R41MJnEg@mail.gmail.com>
 <CAMzpN2gt4qM41=96GpNHL-kbgBsjD-zphq+5oK0BXqoCFN4F4Q@mail.gmail.com>
 <CAHk-=wjocTzo+8OMwyKPX0MCVV=N4wtU8ifwSZ_qJJnDBgKJ8Q@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <8ebcd033-818c-93da-9b86-8cd5e81f9590@kernel.org>
Date:   Sun, 10 Nov 2019 09:21:15 -0800
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

On 11/7/19 1:44 PM, Linus Torvalds wrote:
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

With my TLB-handling-writing-and-reviewing code on, NAK to any VM games
here.

Honestly, I almost think we should unconditionally copy the whole 8K for
the case where the ioperm() syscall has been used (i.e. not emulating
iopl()).  The benefit simply does not justify the risk of getting it
wrong.  I'm okay, but barely, with optimizing the end of the copied
range.  Optimizing the start of the copied range is pushing it.  Playing
MMU tricks and getting all the per-task-ioperm and invalidation right is
way beyond reasonable.

Even the time spent discussing how to optimize a case that has literally
one known user that none of us can bring ourselves to care about much
seems wasteful.

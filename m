Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDA8C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7B92238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="mj5vl9gl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388964AbfGYPOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:14:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33184 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388457AbfGYPOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:14:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so22925067pfq.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ukHOzhV4OjQKdS86FY0h+hNCicHoI0651/0C0J3cWEA=;
        b=mj5vl9glp7DP5T61HY0+vPtegSCe31ho4VIAdbXHy9XrLblQfwnKKitQjROxtx7+q1
         VJ+ZQPYMQA/KcwsOmoGuuMxiTy6D+OS/FwXNUEVVNjR1FuDx1SDTk1uzE1KbdvGOJxxh
         8jiohO+NpDY2kFA3KyTQdyGKp+oveJuPlHnqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ukHOzhV4OjQKdS86FY0h+hNCicHoI0651/0C0J3cWEA=;
        b=roYtdDi/VQZzAP8IcahiBtRG0D0D2c45CGwXLywfI/Loxqnz8ErxT6F6JX3YicJFAD
         iDR1rUbIQQVp1pK4L5N1HffLh2Np9M8PreBely7AnT9ghWHwQxyZAB9evO7NiztJcXw1
         VJnx9d0YNxv4oihmZxDX9GF4oSGVjAoyENQegsYDg2Hi6oomqBS9Qj2NEgZkAygP1CdZ
         sm7Aphi3/0zmDeZxDDFAxsofydXOUhlMPOjdXnCh4sjdCLGtzf3rkGIBoHnDDfApaYK2
         r3Ot3FLJ67WhDn0HR5uWatH63LJafZRzL3YdFnYI5kQNHcba1Lu0aRY6CrLqx61nBQQy
         S4pQ==
X-Gm-Message-State: APjAAAXNqP2qmB/qnNJDmu/JcTHJPl1DiAJNGccwQkpGCw+L+HxYIpzJ
        1Y+sCinEChsPtoxO9WQrJ0Y=
X-Google-Smtp-Source: APXvYqwtqHGriArgTp1C9fVIcp/6FzFQGzC1+p/PbioMgV0TBFelufjOKhRrjnP5ylCHNfN+Oe9r6w==
X-Received: by 2002:a62:ab18:: with SMTP id p24mr17273516pff.113.1564067672245;
        Thu, 25 Jul 2019 08:14:32 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id 195sm87695944pfu.75.2019.07.25.08.14.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 08:14:31 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH 1/2] kernel/fork: Add support for stack-end guard page
In-Reply-To: <20190725101458.GC14347@lakrids.cambridge.arm.com>
References: <20190719132818.40258-1-elver@google.com> <20190723164115.GB56959@lakrids.cambridge.arm.com> <CACT4Y+Y47_030eX-JiE1hFCyP5RiuTCSLZNKpTjuHwA5jQJ3+w@mail.gmail.com> <20190724112101.GB2624@lakrids.cambridge.arm.com> <CACT4Y+Zai+4VwNXS_a417M2m0DbtNhjTVdYga178ZDkvNnP4CQ@mail.gmail.com> <20190725101458.GC14347@lakrids.cambridge.arm.com>
Date:   Fri, 26 Jul 2019 01:14:26 +1000
Message-ID: <87r26egn8t.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rutland <mark.rutland@arm.com> writes:

> On Thu, Jul 25, 2019 at 09:53:08AM +0200, Dmitry Vyukov wrote:
>> On Wed, Jul 24, 2019 at 1:21 PM Mark Rutland <mark.rutland@arm.com> wrote:
>> >
>> > On Wed, Jul 24, 2019 at 11:11:49AM +0200, Dmitry Vyukov wrote:
>> > > On Tue, Jul 23, 2019 at 6:41 PM Mark Rutland <mark.rutland@arm.com> wrote:
>> > > >
>> > > > On Fri, Jul 19, 2019 at 03:28:17PM +0200, Marco Elver wrote:
>> > > > > Enabling STACK_GUARD_PAGE helps catching kernel stack overflows immediately
>> > > > > rather than causing difficult-to-diagnose corruption. Note that, unlike
>> > > > > virtually-mapped kernel stacks, this will effectively waste an entire page of
>> > > > > memory; however, this feature may provide extra protection in cases that cannot
>> > > > > use virtually-mapped kernel stacks, at the cost of a page.
>> > > > >
>> > > > > The motivation for this patch is that KASAN cannot use virtually-mapped kernel
>> > > > > stacks to detect stack overflows. An alternative would be implementing support
>> > > > > for vmapped stacks in KASAN, but would add significant extra complexity.
>> > > >
>> > > > Do we have an idea as to how much additional complexity?
>> > >
>> > > We would need to map/unmap shadow for vmalloc region on stack
>> > > allocation/deallocation. We may need to track shadow pages that cover
>> > > both stack and an unused memory, or 2 different stacks, which are
>> > > mapped/unmapped at different times. This may have some concurrency
>> > > concerns.  Not sure what about page tables for other CPU, I've seen
>> > > some code that updates pages tables for vmalloc region lazily on page
>> > > faults. Not sure what about TLBs. Probably also some problems that I
>> > > can't thought about now.
>> >
>> > Ok. So this looks big, we this hasn't been prototyped, so we don't have
>> > a concrete idea. I agree that concurrency is likely to be painful. :)
>
>> FTR, Daniel just mailed:
>> 
>> [PATCH 0/3] kasan: support backing vmalloc space with real shadow memory
>> https://groups.google.com/forum/#!topic/kasan-dev/YuwLGJYPB4I
>> Which presumably will supersede this.
>
> Neat!
>
> I'll try to follow that, (and thanks for the Cc there), but I'm not on
> any of the lists it went to. IMO it would be nice if subsequent versions
> would be Cc'd to LKML, if that's possible. :)

Will do - apologies for the oversight.

Regards,
Daniel

> Thanks,
> Mark.

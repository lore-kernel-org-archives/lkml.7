Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D656C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AEE22064A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556728894;
	bh=Nh8cX9+1gFLARxd7oyfPuW70nuppCwGeP1XhOwf4FeA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AdrQ7RX0vn0lJB+XAKh3TuuA1DtYx4GWSFscrnD3VBbIEcYii3vOSWSDuS1/AJsh+
	 TVXIVTJCPXq/SZHMR2NlisA229vcm4gfUZbigYaffbwKVbBO9lVjhrZ2TkPN2rrVZt
	 dt7eV7T6ULMSA5iBintgqvdwRUQc1KPrYdby7pMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfEAQlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 12:41:32 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:43891 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfEAQlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:41:32 -0400
Received: by mail-lf1-f53.google.com with SMTP id i68so13336919lfi.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 09:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YglL26BPkLdb+nB/L4IuDXbTHUR9z5OvamFj5OfgDus=;
        b=e6F542OnhRlxbTbq/st12xNkoNYfc8DIFE8Rk49sGbMS6dnVv2qoJ2gu0ufnyL6Kor
         qoKDS//JtmtMtU9SemEw0k1N169heWHAjP8DkUVXRFKw53dR6Z1594P0Jo5t5Ek4PEUF
         mvL5mFk9Z7sEWYutlcq9NuTfGAljRAzdxF1ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YglL26BPkLdb+nB/L4IuDXbTHUR9z5OvamFj5OfgDus=;
        b=tJtjwUSAWnP+jNrLy3xq9Mnv1YObAQwD06gKYXxrAIbzdqyD8miNFoSFv1JV/MNnqu
         j3M3dEOhbSbZgT200O2DwZWVwF1Vk/pA6sAEK6q9m0x+f3EhiJOwFQQ/U2nrvUTyPyzy
         fcz4Gbz4veuZsHyCTKQAo5eefnHtlKJ2mhrYSRle2uhxW2q3K+4iF0XpuBANN82n9BZ3
         hycWcZ+lJXgQf/IXMlIuINvxyT90VbijDWuyClUm6/wkIpFQ2MDBOudGwfG6Qe75+N/Q
         ILW73MxF2cyd16zrQHPxWwY3Q3XiSJU7ZkTEY1RTTQJB48+SanAupE4+ojtJZW06Qy6m
         t2CQ==
X-Gm-Message-State: APjAAAUSe/2uFtpQ6aTbnnI5GZJqsc7qeMXZdd5C8dlSEk7Xbu4SYcZf
        c0TDsBTBmuZxc0XlYPutxbIFs22JDwg=
X-Google-Smtp-Source: APXvYqwDMB92Y7tTjgOB6atzCy9dOkHtzPotAl/+gHnaOllKiWDteycCPOTSBP/O6MiWLw0ESdLauw==
X-Received: by 2002:ac2:4566:: with SMTP id k6mr39433785lfm.22.1556728888994;
        Wed, 01 May 2019 09:41:28 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id q29sm8287144ljc.8.2019.05.01.09.41.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 09:41:25 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id k18so13353262lfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 09:41:25 -0700 (PDT)
X-Received: by 2002:a19:f50e:: with SMTP id j14mr13102495lfb.11.1556728885147;
 Wed, 01 May 2019 09:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190429145159.GA29076@hc>
In-Reply-To: <20190429145159.GA29076@hc>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 May 2019 09:41:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjPqcPYkiWKFc=R3+18DXqEhV+Nfbo=JWa32Xp8Nze67g@mail.gmail.com>
Message-ID: <CAHk-=wjPqcPYkiWKFc=R3+18DXqEhV+Nfbo=JWa32Xp8Nze67g@mail.gmail.com>
Subject: Re: [RFC] Disable lockref on arm64
To:     Jan Glauber <jglauber@marvell.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>
Content-Type: multipart/mixed; boundary="0000000000003645400587d6305c"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000003645400587d6305c
Content-Type: text/plain; charset="UTF-8"

On Mon, Apr 29, 2019 at 7:52 AM Jan Glauber <jglauber@marvell.com> wrote:
>
> It turned out the issue we have on ThunderX2 is the file open-close sequence
> with small read sizes. If the used files are opened read-only the
> lockref code (enabled by ARCH_USE_CMPXCHG_LOCKREF) is used.
>
> The lockref CMPXCHG_LOOP uses an unbound (as long as the associated
> spinlock isn't taken) while loop to change the lock count. This behaves
> badly under heavy contention

Ok, excuse me when I rant a bit.

Since you're at Marvell, maybe you can forward this rant to the proper
guilty parties?

Who was the absolute *GENIUS* who went

 Step 1: "Oh, we have a middling CPU that isn't world-class on its own"

 Step 2: "BUT! We can put a lot of them on a die, because that's 'easy'"

 Step 3: "But let's make sure the interconnect isn't all that special,
because that would negate the the whole 'easy' part, and really strong
interconnects are even harder than CPU's and use even more power, so
that wouldn't work"

 Step 4: "I wonder why this thing scales badly?"

Seriously. Why are you guys doing this? Has nobody ever looked at the
fundamental thought process above and gone "Hmm"?

If you try to compensate for a not-great core by putting twice the
number of them in a system, you need a cache system and interconnect
between them that is more than twice as good as the competition.

And honestly, from everything that I hear, you don't have it. The
whole chip is designed for "throughput when there is no contention".
Is it really a huge surprise that it then falls flat on its face when
there's something fancy going on?

So now you want to penalize everybody else in the ARM community
because you have a badly balanced system?

Ok, rant over.

The good news is that we can easily fix _this_ particular case by just
limiting the CMPXCHG_LOOP to a maximum number of retries, since the
loop is already designed to fail quickly if the spin lock value isn't
unlocked, and all the lockref code is already organized to fall back
to spinlocks.

So the attached three-liner patch may just work for you. Once _one_
thread hits the maximum retry case and goes into the spinlocked case,
everybody else will also fall back to spinlocks because they now see
that the lockref is contended. So the "retry" value probably isn't all
that important, but let's make it big enough that it probably never
happens on a well-balanced system.

But seriously: the whole "let's just do lots of CPU cores because it's
easy" needs to stop. It's fine if you have a network processor and
you're doing independent things, but it's not a GP processor approach.

Your hardware people need to improve on your CPU core (maybe the
server version of Cortex A76 is starting to approach being good
enough?) and your interconnect (seriously!) instead of just slapping
32 cores on a die and calling it a day.

                Linus "not a fan of the flock of chickens" Torvalds

--0000000000003645400587d6305c
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jv5g69gy0>
X-Attachment-Id: f_jv5g69gy0

IGxpYi9sb2NrcmVmLmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoK
ZGlmZiAtLWdpdCBhL2xpYi9sb2NrcmVmLmMgYi9saWIvbG9ja3JlZi5jCmluZGV4IDNkNDY4YjUz
ZDRjOS4uYTY3NjJmOGY0NWM5IDEwMDY0NAotLS0gYS9saWIvbG9ja3JlZi5jCisrKyBiL2xpYi9s
b2NrcmVmLmMKQEAgLTksNiArOSw3IEBACiAgKiBmYWlsdXJlIGNhc2UuCiAgKi8KICNkZWZpbmUg
Q01QWENIR19MT09QKENPREUsIFNVQ0NFU1MpIGRvIHsJCQkJCVwKKwlpbnQgcmV0cnkgPSAxNTsJ
CS8qIEd1YXJhbnRlZWQgcmFuZG9tIG51bWJlciAqLwkJCVwKIAlzdHJ1Y3QgbG9ja3JlZiBvbGQ7
CQkJCQkJCVwKIAlCVUlMRF9CVUdfT04oc2l6ZW9mKG9sZCkgIT0gOCk7CQkJCQkJXAogCW9sZC5s
b2NrX2NvdW50ID0gUkVBRF9PTkNFKGxvY2tyZWYtPmxvY2tfY291bnQpOwkJCVwKQEAgLTIxLDYg
KzIyLDggQEAKIAkJaWYgKGxpa2VseShvbGQubG9ja19jb3VudCA9PSBwcmV2LmxvY2tfY291bnQp
KSB7CQlcCiAJCQlTVUNDRVNTOwkJCQkJCVwKIAkJfQkJCQkJCQkJXAorCQlpZiAoIS0tcmV0cnkp
CQkJCQkJCVwKKwkJCWJyZWFrOwkJCQkJCQlcCiAJCWNwdV9yZWxheCgpOwkJCQkJCQlcCiAJfQkJ
CQkJCQkJCVwKIH0gd2hpbGUgKDApCg==
--0000000000003645400587d6305c--

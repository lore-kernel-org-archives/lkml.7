Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4DBC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6602075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556912457;
	bh=wiuDX2x0ENPZpQvwPnxeF2+GqP8Q/LmZJGlZIyQiyuA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=C4Swrfe8N1v/EnaPLFspAL3y4kgPV8/bzKncuJ/K9ZbsZWZy8IElPI/OclhRD2yP7
	 G4VREMGCeZAHyYRICyI+o5UShWVNf7PHXplbs/QE8CB/BO4NoYrtnSymnS1PbECECr
	 6luv96RlklTnNfOuz/rS07v5bN0q6c+6hmNPlY3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfECTk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 15:40:56 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:41194 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfECTkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 15:40:55 -0400
Received: by mail-lj1-f179.google.com with SMTP id k8so6182224lja.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 12:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VveNzZAjXPBlYkWe2poT9sM0nBecoUnFUlLniFmqy38=;
        b=QXskVGEGvKifmiGq0XwJk+jLIWyk2HquWywFpIRDLlglZjN3GPkI4xyp+M2/GjUy95
         nvgp4UbOqLkdLtBy1tbU9hnCLo3S7Or1YJxBoCHN7LZpzhj+djviLLsDFMQ8U6cZJA8m
         uqwoEPfAUULAYl55QiZti76rKbbs12Z71hD20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VveNzZAjXPBlYkWe2poT9sM0nBecoUnFUlLniFmqy38=;
        b=qiYInDHFJ3z2vFUI8dFDfhhiWGRlgtCwMMsaxfhHFtVkYehjAT600xhfmJhgU1NS9h
         FNY5Shli4zUcw2iy7fpAoR0/CD1pUeTEKdLXDisrisNYphJLv2CvvNcM1QbrHzL0iDxa
         BjyPWhFsjjFjex+BphQVaNBv18Eeb5sXqgbscEdWTBGvOIbujSna9z6JIl6hs/HeDD58
         gz8w/7I0UzRT0/dV7mXpGuaBWvKeQZaD5dR7qg+/hkzUEraSL3m2nEstGX/Pn7UU0A0w
         6H3HpJUHw6rMCnUunGM0GedbLlBGLNPO3oRiIspzkj3X9a/mFnhHPyl2vDYjf6DqluSk
         P3HA==
X-Gm-Message-State: APjAAAVfWIYCC6UsWWHdeoII40D6sg5u4HgH9E4U472qZwp+0kRFjM/K
        qxrInFmzLvfiyiGgwpJPu8Z8nan/RcU=
X-Google-Smtp-Source: APXvYqwMflgZDrkx/76f6JmQu7j+VMGv4h01Q4BDp9q15n703BKn1SzFaoQX88bNJerW0H1KAuIQvQ==
X-Received: by 2002:a2e:9546:: with SMTP id t6mr6118540ljh.51.1556912452793;
        Fri, 03 May 2019 12:40:52 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id i64sm659715lfe.18.2019.05.03.12.40.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 12:40:51 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id o16so5186122lfl.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 12:40:50 -0700 (PDT)
X-Received: by 2002:a19:f50e:: with SMTP id j14mr5925434lfb.11.1556912450582;
 Fri, 03 May 2019 12:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190429145159.GA29076@hc> <CAHk-=wjPqcPYkiWKFc=R3+18DXqEhV+Nfbo=JWa32Xp8Nze67g@mail.gmail.com>
 <20190502082741.GE13955@hc> <CAHk-=wjmtMrxC1nSEHarBn8bW+hNXGv=2YeAWmTw1o54V8GKWA@mail.gmail.com>
 <20190502231858.GB13168@dc5-eodlnx05.marvell.com>
In-Reply-To: <20190502231858.GB13168@dc5-eodlnx05.marvell.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 May 2019 12:40:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiEahkwDXpoy=-SzJHNMRXKVSjPa870+eKKenufhO_Hgw@mail.gmail.com>
Message-ID: <CAHk-=wiEahkwDXpoy=-SzJHNMRXKVSjPa870+eKKenufhO_Hgw@mail.gmail.com>
Subject: Re: [RFC] Disable lockref on arm64
To:     Jayachandran Chandrasekharan Nair <jnair@marvell.com>
Cc:     Jan Glauber <jglauber@marvell.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 4:19 PM Jayachandran Chandrasekharan Nair
<jnair@marvell.com> wrote:
>>
> I don't really see the point your are making about hardware. If you
> look at the test case, you have about 64 cores doing CAS to the same
> location. At any point one of them will succeed and the other 63 will
> fail - and in our case since cpu_relax is a nop, they sit in a tight
> loop mostly failing.

No.

My point is that the others will *not* fail, if your cache coherency acts sane.

Here's the deal: with a cmpxchg loop, no cacheline should *ever* be in
shared mode as part of the loop. Agreed? Even if the cmpxchg is done
with ldx/stx, the ldx should do a read-for-write cycle, so at no
single time will you ever have a shared cacheline.

And once one CPU gets ownership of the line, it doesn't lose it
immediately, so the next cmpxchg will *succeed*.

So at most, the *first* cmpxchg will fail (because that's the one that
was fed not by a previous cmpxchg, but by a regular load (which we'd
*like* to do as a "load-for-ownership" load, but we don't have the
interfaces to do that). But the second cmpxchg should basically always
succeed, unless something exceptional happened (maybe an interrupt,
maybe something big like that).

Ergo: if you have a case of failing cmpxchg a lot, your cache
coherency is simply bad. Your hardware people should be ashamed of
themselves for letting go of the cacheline without just letting the
next cmpxchg succeed.

Notice how there is *NO* ping-pong. Sure, the cacheline moves around,
but every time it moves around just once, a thread makes progress.
None of this "for every progrress, there are 63 threads that fail"
garbage that you're claiming is normal.

It's not normal, and it's not inevitable.

If it really happens, it's a sign of bad hardware. Just own it, and
talk to the hw people, and make sure it gets fixed in ThunderX3. Ok?

                  Linus

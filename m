Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191A0C433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 03:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5592086A
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 03:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="FcYPOSRj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390896AbfHCDNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 23:13:38 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:20358 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389368AbfHCDNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 23:13:38 -0400
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x733DNqI021989
        for <linux-kernel@vger.kernel.org>; Sat, 3 Aug 2019 12:13:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x733DNqI021989
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564802004;
        bh=uXPbFDguOJaPvDuGiRBjQarLoNSHVJHSi4kQEKsha6A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FcYPOSRjUSESRvGCQtVUm6sHWlyFBunwzpHbspl/M1kwYKuP8GyTaC++iYsOEgEzv
         0FxIO6SuWj8zr1Bf9drD5YEquoziWacabsvzG6Agf0j3//+u00HPiSvXeFVr3QuSDx
         4Rfi0y3hdIzhOErXKRqxP3yurMk9NUeFWj1yV6zWz7BR2TALwRMJ7PEEu/RgACGwke
         u40EFIez0rNJYHW70uHsFqg5Aj2p2T7Rb/2MDfNjT/tF4jSl0YFEgPwt1sJdLvg/zB
         PEfunyVh+VO+q1eZmAkagI84z0ASSgtKHHQ7fDiigDTMpHD31uVdtLWeU0iJtbVXTL
         JiO4JjQ0900+Q==
X-Nifty-SrcIP: [209.85.221.169]
Received: by mail-vk1-f169.google.com with SMTP id b69so15738009vkb.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 20:13:24 -0700 (PDT)
X-Gm-Message-State: APjAAAXQnbBvBVXPD6lDE+VyaGJpgtA33RX2Es1eKFfr84LvSPxNJvV4
        gfdhbAwlgtII6SAzxS92M3hJe99lHTMdni+zy9I=
X-Google-Smtp-Source: APXvYqzNRE/Yf+cr17ZFzYqUJdA7GTPmlkvU3w8/x9kf3TiTr398oe7RJ0p7z9fLNtUDyyclIiadTBxNaKKsy+95r7w=
X-Received: by 2002:a1f:4107:: with SMTP id o7mr54479807vka.34.1564802002936;
 Fri, 02 Aug 2019 20:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <0306bec0ec270b01b09441da3200252396abed27.camel@perches.com>
 <20190731190309.19909-1-rikard.falkeborn@gmail.com> <47d29791addc075431737aff4b64531a668d4c1b.camel@perches.com>
 <CAK7LNAQdgUOsjWtWFnXm66DPnYFRp=i69DMyr+q4+NT+SPCQxA@mail.gmail.com>
 <2b782cf609330f53b6ecc5b75a8a4b49898483eb.camel@perches.com>
 <CAK7LNASw+Fraio3t=bZw-FzJihScTuDR=p2EktFVOmdLH4GTGA@mail.gmail.com>
 <20190802181853.GA809@rikard> <CAK7LNAT+cNxna4SER04MdkBsq_LDg4TwYR_U1ioNNxYOZWXigA@mail.gmail.com>
In-Reply-To: <CAK7LNAT+cNxna4SER04MdkBsq_LDg4TwYR_U1ioNNxYOZWXigA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 3 Aug 2019 12:12:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQv-5epL8DYDaUdHsQEQ=Va676t_6TgsaSYC30Eix=iyw@mail.gmail.com>
Message-ID: <CAK7LNAQv-5epL8DYDaUdHsQEQ=Va676t_6TgsaSYC30Eix=iyw@mail.gmail.com>
Subject: Re: [PATCH] linux/bits.h: Add compile time sanity check of GENMASK inputs
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 3, 2019 at 12:03 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

>
> BTW, v2 is already inconsistent.
> If you wanted GENMASK_INPUT_CHECK() to return 'unsigned long',,
> you would have to cast (low) > (high) as well:
>
>                (unsigned long)((low) > (high)), UL(0))))
>
> This is totally redundant, and weird.

I take back this comment.
You added (unsigned long) to the beginning of this macro.
So, the type is consistent, but I believe all casts should be removed.


-- 
Best Regards
Masahiro Yamada

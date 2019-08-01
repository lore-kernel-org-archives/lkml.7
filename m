Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364B5C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0737820657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFobVbi5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390180AbfHAXEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:04:00 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41681 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390169AbfHAXEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:04:00 -0400
Received: by mail-lf1-f65.google.com with SMTP id 62so46640544lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 16:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x2dypF0bu6hhLtnd+wiRyrjrgFpq+fDfD5eBkh4pWGQ=;
        b=EFobVbi5FzP+grNeF/Rkf3AQMIrWzWcWLsiYkHXOF3lhGsTXMrqf4DlVtpN2TYFTsN
         yc5fPiMY+FefP0jF0PwBaNdL9t97Ye9rPTW4E9rt4kzMjkFhnDHKoH83YrFT4mKo+aI+
         GJVBU/RpAMNLkQYfLsx8yN/2WyJM2b2GMSebN+8JW6sQ7Pxx7g1gPClE2Ys19hE88wT6
         oc50vyXlEOmi1R+enDN0BWuyuJV6lLyRXyWqPEcBjoE0apNoyBgGMX4QrkzbioYEAMIQ
         ZxbFNWZnPxerSJnE4PAluwfX5EGDTxkO+mMgpdSk3T/Bgh9jCcRLOHWxRWu0+JS5fXPq
         7Dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x2dypF0bu6hhLtnd+wiRyrjrgFpq+fDfD5eBkh4pWGQ=;
        b=Rz3zc4k/WPsVyjqyR2cihlfNDYQ0+mm85ADWffGKGtwRmHBqGDMVhuUSpvrsQgiV+q
         J4zN08mBdmwsiJbClOOF4VO6X7Lug5jsml5u54xA+g4AUupZbGIa21xl2atBD1FP6U38
         9cGyaLv5/hTFal3TyYmykobbiUcnYU7+x+6w11ygIVBbPghswmH/fMLcSNMq2i9iY/ZU
         PSll01bb75K99zF/7yJIipQXHpXRfpvQv6HcOErT1cmNHeRK2oric5zS3mXGzucThhHs
         Hrx9T4mnRcC6WKcYUOv9Zki5q4MHLh1J541P3JeP8DXFdN1kxJyC6lcrswUf1VCa3gqw
         GKdw==
X-Gm-Message-State: APjAAAWZKiVCH38q8XPh6q1QfZcmsOp/AEcpYJKFthWKXifLXKMq7Hy1
        FyopUnh0tmVo/qsYdls6RWs=
X-Google-Smtp-Source: APXvYqxF+R9oANpqDDR6iT1ZiZZHl6d9KWKsnbOyW6NKuwRfYhxoqxPDxCG/dYH62b0OvQ4xVhttAQ==
X-Received: by 2002:a19:c514:: with SMTP id w20mr63230712lfe.182.1564700638605;
        Thu, 01 Aug 2019 16:03:58 -0700 (PDT)
Received: from rikard (h-158-174-186-115.NA.cust.bahnhof.se. [158.174.186.115])
        by smtp.gmail.com with ESMTPSA id z83sm14865225ljb.73.2019.08.01.16.03.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 16:03:58 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Fri, 2 Aug 2019 01:03:50 +0200
To:     Joe Perches <joe@perches.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] linux/bits.h: Add compile time sanity check of GENMASK
 inputs
Message-ID: <20190801230350.GA4046@rikard>
References: <0306bec0ec270b01b09441da3200252396abed27.camel@perches.com>
 <20190731190309.19909-1-rikard.falkeborn@gmail.com>
 <CAK7LNAT2r8J+4C8bAPDZ1R4Xk7Psr+fAS9wcs_c+JhuUqj-uAw@mail.gmail.com>
 <d18482fae2c6ca7cdb955aff4c724b007ef45aba.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d18482fae2c6ca7cdb955aff4c724b007ef45aba.camel@perches.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 07:57:48PM -0700, Joe Perches wrote:
> On Thu, 2019-08-01 at 11:50 +0900, Masahiro Yamada wrote:
> > On Thu, Aug 1, 2019 at 4:04 AM Rikard Falkeborn
> > <rikard.falkeborn@gmail.com> wrote:
> > > GENMASK() and GENMASK_ULL() are supposed to be called with the high bit
> > > as the first argument and the low bit as the second argument. Mixing
> > > them will return a mask with zero bits set.
> > 
> > This is getting cluttered with so many parentheses.
> > 
> > One way of clean-up is to rename the current macros as follows:
> > 
> >    GENMASK()    ->  __GENMASK()
> >    GENMASK_UL() ->  __GENMASK_ULL()
> > 
> > Then,
> > 
> > #define GENMASK(h, l)       (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> > #define GENMASK_ULL(h, l)   (GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
> 
> Much nicer.  It may be better still to use avoid
> multiple dereferences of each argument.

Much nicer indeed, I changed it accordingly. There are no multiple
dererences of the arguments. GENMASK_INPUT_CHECK() and __is_constexpr()
both use sizeof() on the input arguments, which does not evaluate the
argument (unless the argument is a VLA, which is not allowed).
 
> Also it'd be useful to rename h and l to something like
> high_bit and low_bit or high and low.

Agreed.


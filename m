Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5180BC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFF927596
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559578451;
	bh=FVVoo4+poeWonnJJM6ojm7XX1p60P1ky76MuzIox/T4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yrJdLAQJvZFym49+gTUIDhCVRtxBOojau+PwVnm4jJC+q+1SbH4CwbXppzDpd+k8u
	 TU+ZwpowqW2OhS/vEWt5YgZWZYerL7dFNDaee55NuMzjLN8QuLhncGdj/b2sWCDRfU
	 KkdyYUgR8/LVIImnv2Kh9b/WkHEYxAe9FKPl6uf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfFCQOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:14:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38940 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfFCQOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:14:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id a10so13541634ljf.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 09:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lgsfrWNkeAwXitTJcoIdmm+S5jV0yGJC2wH7GAyc/RM=;
        b=WCXqjpyK9CxskKR1Rsa2JsUVjNbLjTBCO3DKbpdiCOAgDG3/x4OwA5zT3oR9AF+TAb
         KoxRzjysV3/yPddUMg57RzzWz8pj3wl00UXp/zI8qmqY5Pxb0GSO0BkOluklf9MnQYLn
         o8mf30F5cjoqsx0tY+OcCybKIrmRF+OMKq7aY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lgsfrWNkeAwXitTJcoIdmm+S5jV0yGJC2wH7GAyc/RM=;
        b=MZoN0RznvbxwXAV8llFuB8SQsZl77lGuh0P9nJU4YAjEaAq1eNHAtpcvbbVIm8e+9s
         qQPJ2s1OTyW2uzVGFW9X3Cbd4XKwpXHV6Dxjl9IvziHYZK9HWA9V2d8YHk+pKc/CO+Lq
         RyX1gCxvzOoj3q1s80zjKOjEv0qojGyoIynABo3KqLl5Sc2BVY3ObvSs+7P8Hb7gTO++
         C7j+g4/WepygFy4QsYWg1wOVqSc4E6siFgIeKzu330DKPwEK9QWa1+flglgN0xl0nVxv
         FruCgJI9mMq3761hJxeAM9/rOlC6SK+NjU1oy9AioX1spMhxC18P23vbKBbUyIkuRdrM
         LX5w==
X-Gm-Message-State: APjAAAXPtjS0V6WaMQ17X8DpIlFt8PLLtcCpRijBuxj6eJH5327Q8G1g
        vFVZ2oiKsIPBaTdMZRJkZwgG95EnP3Q=
X-Google-Smtp-Source: APXvYqznebQNTLsOVdmh1KJyvD7fkBl0VlVsigg/OctgM1RY+oQApUAAwVxrUrw7gjupjlk4B3zvqw==
X-Received: by 2002:a2e:868f:: with SMTP id l15mr8577978lji.118.1559578447516;
        Mon, 03 Jun 2019 09:14:07 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id y20sm1912527ljd.96.2019.06.03.09.14.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 09:14:07 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id a10so13541561ljf.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 09:14:07 -0700 (PDT)
X-Received: by 2002:a2e:4246:: with SMTP id p67mr14377820lja.44.1559578139147;
 Mon, 03 Jun 2019 09:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190601074959.14036-1-hch@lst.de> <20190601074959.14036-4-hch@lst.de>
 <CAHk-=whusWKhS=SYoC9f9HjVmPvR5uP51Mq=ZCtktqTBT2qiBw@mail.gmail.com> <20190603074121.GA22920@lst.de>
In-Reply-To: <20190603074121.GA22920@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Jun 2019 09:08:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5mww3StP8HqPN4d5eij3KmEayM743v-nDKAMgRe2J6g@mail.gmail.com>
Message-ID: <CAHk-=wg5mww3StP8HqPN4d5eij3KmEayM743v-nDKAMgRe2J6g@mail.gmail.com>
Subject: Re: [PATCH 03/16] mm: simplify gup_fast_permitted
To:     Christoph Hellwig <hch@lst.de>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-mips@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Linux-MM <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 12:41 AM Christoph Hellwig <hch@lst.de> wrote:
>
> I only removed a duplicate of it.

I don't see any remaining cases.

> The full (old) code in get_user_pages_fast() looks like this:
>
>         if (nr_pages <= 0)
>                 return 0;
>
>         if (unlikely(!access_ok((void __user *)start, len)))
>                 return -EFAULT;
>
>         if (gup_fast_permitted(start, nr_pages)) {

Yes, and that code was correct.

The new code has no test at all for "nr_pages == 0", afaik.

                 Linus

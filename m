Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535D7C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235822339E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMPzG8Ui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfH2N0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:26:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44384 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfH2N0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:26:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id b6so633183wrv.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 06:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+EbL5uHbRaVZhglSvt8d9cCBpYh3f0wExzjkbbLSM48=;
        b=aMPzG8UiwryTNNROE2Pc5seW3OriPSofsehPzdqbZaSQ78UDPkyihO1ob7/Q311TJM
         MaNZBWtX9/Orur7cKwBSvtl4IdQXKTyxQUdn+ke8IItrjxiZML8qgtWHVmtmgHBdZ8ZV
         9lrGqsHetZpqofuJDs39gdBiPapRscYw9uHw1wRy8tKq22RrcHHoO1UyHpNlpMjNKe4h
         YrGHT0rZoqcmaGCNhounO18RTffv9S2SaE4y6dBmAKlXlP2j/s2amVsg7T/MIkL2D6rq
         RlgPRvaEyTYZI5Uqdtp3wNibTKhrABkxegVyJY8DSw7C9AAD8thlpaTQWBoZ6qd3QqeK
         M5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+EbL5uHbRaVZhglSvt8d9cCBpYh3f0wExzjkbbLSM48=;
        b=ahs+oNQdhr07sGjvaFYUlfH1nO3AdQRZAA4/p2lJFm0j+qWoCOvoejqSYMoaHyCLbH
         qXJEkyGtMu8m/5yygIHwMP7G+b1/Mkd5kNKOvoTcAzliUsaW/XV2Hh5RkAjsQEvKkZha
         DnTvIszuLZNjFCDjFVHWJC5Qjv3XgYD/Yr0OGxFRjcgM5ZKN5PF0Lc3Zoo/yvmWLzF0B
         yvNNewYIO+FHVN2KB4ZjENU4K+p3cH/Km5ILbkPA6mSd33LWoNGpzDRblexn/mfIQSgg
         fW8y7h4z9b5kjI1jwm7ii5nvOnjnXFLNXzG83XDGNRaQO4yemdiiiEGE7YjtVCAUsTGC
         LhLw==
X-Gm-Message-State: APjAAAWExk45E6yBRJiEFouSmGjWtYhJWKBJtUTATuJuKJVDYtu2doaZ
        OulqZ+lvaWhXo7RpNqsXIBmblZQzuaQP5hwjnss=
X-Google-Smtp-Source: APXvYqxyXrxfpcFmjRjxuGmQZmmAdSnbq57OS2LBtTHGUqD79wm5itgipY4dVl2ztoQM+IcF7IBYxH1nWxwJTKulRes=
X-Received: by 2002:a5d:6987:: with SMTP id g7mr3690087wru.306.1567085196168;
 Thu, 29 Aug 2019 06:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190828204609.02a7ff70@TheDarkness>
In-Reply-To: <20190828204609.02a7ff70@TheDarkness>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 29 Aug 2019 15:26:24 +0200
Message-ID: <CAFLxGvyiviQxr_Bj57ibTU4DQ1H5wQC4DE5DNFBtAFoohcgbsg@mail.gmail.com>
Subject: Re: [PATCH] um: Rewrite host RNG driver.
To:     Alexander Neville <dark@volatile.bz>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 3:45 AM Alexander Neville <dark@volatile.bz> wrote:
>
> The old driver had a bug that would cause it to outright stop working if
> the host's /dev/random were to block. Instead of trying to track down
> the cause of said bug, rewriting it from scratch turned out to be a much
> better option as it came with a few benefits:
>
>  - The new driver properly registers itself as an hardware RNG.
>
>  - The code is simpler and therefore easier to maintain.
>
>  - It serves as a minimal example of writing a hardware RNG driver.
>
> I also edited the Kconfig symbol to bring it up to more modern
> standards.

So, you removed -EAGAIN handling, made everything synchronous,
and changed the interface.
I'm not sure if this really a much better option.

Rewriting the driver in a modern manner is a good thing, but throwing the
old one way with a little hand weaving just because of a unspecified issue
is a little harsh.
Can you at lest provide more infos what problem you're facing with the
old driver?

-- 
Thanks,
//richard

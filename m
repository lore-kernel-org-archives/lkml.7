Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9443C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FD820811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DEMY8LLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfCHMOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:14:44 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40638 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfCHMOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:14:43 -0500
Received: by mail-lf1-f65.google.com with SMTP id a8so14141404lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 04:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mvsLmwo6fwpX+8np85D5C6Gq1ByGCvd3L55hNbwBtKM=;
        b=DEMY8LLC5+DYiKX52NRqs7s1y/vaBSa/xh5SJ2HPm8TOs3pRl5jYAM1SR/xfNVeQbu
         n8dtE58J8DYsUqgkH8WfRdTrWDywtsIkg0pemqB0wvN09wcIfDPh62bD4dY60MnzpCAI
         XDNNN6eV5tqw/3FhWxDoPgrvmZFPqZQTc/wj0+xgM09km3jNjtB5JrrCdVK204e1w8V3
         GD3z8+cRg/+2gcVqTUzu5Wi8myQmnC0Rkeug6/7iFfOAKkkFp01P9+8ZAUprbdvYrkUD
         CQnFNSKq80ScXFKAHCk0diLC0+O/Ae8FUksGRmdZCR7HppXZoFRHYZkv4nY7slcxETx5
         VeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mvsLmwo6fwpX+8np85D5C6Gq1ByGCvd3L55hNbwBtKM=;
        b=qAWdU181v+tJg1joY32og5QGkA1AJSucI9AqamQPpoMJ0cdkSwQXKBw8EcWHGk2p5e
         F6UdnOkEXjxNH4AQjxo7sgJd75vGHng6QB99KFjIyY5l44PBX80NLIYjOTxt3UVdIJwJ
         uqhxUwx7LyXMGIyRjmNmUO4GNrwN1qYD+BW62Xb0ocDSpemljeKczdkFKO2Gq5rPwtC5
         pYeI4TfTpiCcX2t6q5GkxL6agZ+PyNNQbIcqnW2WJTjecE/vZpjuWxN7xQCVMaKGDyDa
         lwVLYKLiZ2MoUn8nnJe9yeuGwMMt2MCqSfFvoI646+H+4GIoDNmpKxp2n7ZX81p7vbqM
         V/IA==
X-Gm-Message-State: APjAAAV1+GXy6IRqbqt5RQ5zgr3Xu9KXJAWIsuUJ4sFcONIBIUeTmJJt
        0LNepKi88eL3cz3VsdkZAm19VTGdBZP49Wnh0XP62A==
X-Google-Smtp-Source: APXvYqwEpsPNqIb6tMvDKFQDCO9n+PK5Qqh8c0kTkThiij7jszG03h7PnQ1VZTRaAWQtnk4flkiBuT9i4TrtQ4FHTeM=
X-Received: by 2002:a19:ed19:: with SMTP id y25mr9278133lfy.51.1552047281495;
 Fri, 08 Mar 2019 04:14:41 -0800 (PST)
MIME-Version: 1.0
References: <20190304200918.1444050-1-arnd@arndb.de> <CACRpkdZmNbPcSQXU6mosQJk1j9k+vQfJbs2KUZcXTUo172_cCQ@mail.gmail.com>
 <fbc13c2b-1c9d-54d7-e29b-c279a5a42e33@metux.net>
In-Reply-To: <fbc13c2b-1c9d-54d7-e29b-c279a5a42e33@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Mar 2019 13:14:29 +0100
Message-ID: <CACRpkdaf-Y_JU-xrcbiKLT20+0DwK3eR2D0ifAjrMSyu0vS4ww@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: apuv2: remove unused variable
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 11:42 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
> On 08.03.19 10:11, Linus Walleij wrote:
>
> > As Torvalds did not yet pull the GPIO tree (maybe because of this
> > and other bugs, who knows) I applied this to my GPIO tree for
> > now.
>
> Great. I actually like it better this way, so his pull will be clean
> and consistent.
>
> Did you also apply the kconfig fixes ?

Yep!

Yours,
Linus Walleij

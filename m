Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D7BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 01:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBFD206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 01:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0FAF83q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfHABmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 21:42:14 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34677 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfHABmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 21:42:13 -0400
Received: by mail-ot1-f67.google.com with SMTP id n5so72458465otk.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 18:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZfGrI2T8Io+ZaXdoiPh/ozSsrOYzabAUcKD9H+JB39Q=;
        b=a0FAF83qeGlFS7k8/nxXJLJ5Kh6ewCif/DahOmBKgUQKDzBIvI56PZQsLKOY2vcKze
         a9qsiuXl4hEadSEa/L602ZAVxNmYmIqKw8NqNQRiQScBJWysXWviioyb/tBtBPZt6Jg3
         nNSeumFFwel+c+Cbmk2jWVq1zMrpW8MEt/dbfGHLN1eN9vZAzZdXJnaIy47mvA6NNmLz
         n4+7dspozOAiPSj7nvleG8W6Iy7d2CfCkbIANp9eQTb/2sLB3ZkXHlWygwrJ1UAXEitb
         tLixPPKoHnxFZcJ7MICrXLa6JMkjQ1X4Smp+ellrB1iVQz4GlNZdsfEaF2dZPGypLJGT
         9VpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZfGrI2T8Io+ZaXdoiPh/ozSsrOYzabAUcKD9H+JB39Q=;
        b=Q6pMRRQ+RHRdUk4sQ85vQDpsNFZ2TZHhfazll7LroORiHaV0xBfe1NUSqH7CYUWloW
         lYpT1wkaYAw32xfyxO4yYhbc/GPipSlbrdFKb/ud1IJELzsnKhkSsLeosqZdU6Wi0gWc
         sI6dFQ7Ze9xRmhMuZDQIOplo/of9ETe7T6Fu+tLQ124Dj592skY3NZNW1EYIThjOUcat
         azK8UYCIe2r3RydeaFIuXbojxkakyyc3bbPaTWaK7ti784IRrHIteyJXyggs1Cj8A6Zl
         n3t3DvztuJc3C0LMO4ZcGy1AQnBV32c+8faVixP6UrR4ZH1iiDguNHu8JPD11gPYUmXr
         vhDg==
X-Gm-Message-State: APjAAAUm+5rKV5QwsFYmsDUUDiivjI670V/dnqzMfXGbwZwPIN7LiDou
        +8JnwXrlpka5U1ePOL93MwtWY9XlV+UACBqvkVs=
X-Google-Smtp-Source: APXvYqyB6SEjgS9U7kTGYQ9tev8wMhiX2CLosAjncHGHH+VNkxfm4lsbU25vSYUhLTgFLbs/tmVXBUp0qgH186vaps4=
X-Received: by 2002:a9d:4b02:: with SMTP id q2mr57355971otf.312.1564623732869;
 Wed, 31 Jul 2019 18:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190731071447.9019-1-stefan@olimex.com> <20190731071447.9019-2-stefan@olimex.com>
 <CAGb2v64tzMypnB5Ho2A-gWPk2yYsmH9tNn+OKfb51c+d6pK=kw@mail.gmail.com>
In-Reply-To: <CAGb2v64tzMypnB5Ho2A-gWPk2yYsmH9tNn+OKfb51c+d6pK=kw@mail.gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Wed, 31 Jul 2019 18:42:14 -0700
Message-ID: <CA+E=qVcY2PE3zg3CRNGD4vLbLTdov6wgioUrbijp-W6km9SCaA@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 1/1] nvmem: sunxi_sid: fix A64 SID
 controller support
To:     wens@kernel.org
Cc:     Stefan Mavrodiev <stefan@olimex.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 1:43 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Wed, Jul 31, 2019 at 3:15 PM Stefan Mavrodiev <stefan@olimex.com> wrote:
> >
> > Like in H3, A64 SID controller doesn't return correct data
> > when using direct access. It appears that on A64, SID needs
> > 8 bytes of word_size.
> >
> > Workaround is to enable read by registers.

I came up with identical patch while adding A64 support into
sun8i-thermal driver, so:

> >
> > Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
>
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>

>
> And for single patches, you don't need to write a separate cover letter.
> Just put whatever you need to add after the "---" separator.
>
> > ---
> >  drivers/nvmem/sunxi_sid.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
> > index a079a80ddf2c..e26ef1bbf198 100644
> > --- a/drivers/nvmem/sunxi_sid.c
> > +++ b/drivers/nvmem/sunxi_sid.c
> > @@ -186,6 +186,7 @@ static const struct sunxi_sid_cfg sun8i_h3_cfg = {
> >  static const struct sunxi_sid_cfg sun50i_a64_cfg = {
> >         .value_offset = 0x200,
> >         .size = 0x100,
> > +       .need_register_readout = true,
> >  };
> >
> >  static const struct sunxi_sid_cfg sun50i_h6_cfg = {
> > --
> > 2.17.1
> >
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/CAGb2v64tzMypnB5Ho2A-gWPk2yYsmH9tNn%2BOKfb51c%2Bd6pK%3Dkw%40mail.gmail.com.

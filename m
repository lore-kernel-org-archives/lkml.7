Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8DDC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 03:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD06120659
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 03:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="piZgvaJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfKXDUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 22:20:51 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38903 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfKXDUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 22:20:50 -0500
Received: by mail-ed1-f65.google.com with SMTP id s10so9441126edi.5;
        Sat, 23 Nov 2019 19:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DswDOcFLyZVT9xwF1vsGxZkcCPuWKeyXIg9og7dtlf8=;
        b=piZgvaJNNJQkFNPD1naXDJPog8oAuiZWrOQxtD1YTv+pcKCBikgoGCMpeqILfe0Gcl
         rdHxFgCLIY5QG00zAvQ7v5br8WNxct8b8wGKtBExOc9zhmTDuOUyzoKlNOl4kVZbAPBS
         +3FLkTXVjOI4CAUhp6orJFeregApqmjoRg4Y7jmCfUZbe1YoDrKKA03D4Tb3hPTjbOhd
         6IkCz89DN/hff2OSqbvRF4URhnC4WaBp5F1nowZVwizhY8Ug0a3NwHajxkJG9o+BHvf2
         xE8FHM3JhkgfTHmVEYDt8VDwZYsG/0NiTKMQAK3wQ/OIa/7yVWbi5eZ5KefpJxYRPkBU
         zQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DswDOcFLyZVT9xwF1vsGxZkcCPuWKeyXIg9og7dtlf8=;
        b=aeYLXGZwLUt1tIQUZyz/xu+s0W0QXIxSN93aOzsoqOST/r4K4pn35lbBZ3pEajUirr
         q6lUoJ1djy7yhM+KdjG3M336/bhAPPWKlNxNOEhqv8RQj/0Dv/Ubtz5jExGvk3zgVGBB
         zsdt/KflSB4w+Hz0KraUkTiXEReRhG7n6RfW89ILka5mGej8197RXUn1JrPrzt5Y5TP/
         OYzyY7G+S6I/1CYjSKkBC9qHlUtU5jiofgq5Rd0YqTxiOsa2/OpFrZD454PiR1UHGyLK
         hoD8Hws2UuEXmPqov+/Z8wQB3ceNlM+UnaTbBQzYJFdh7UUgV4GR7nu8FL5P2LDpc3xU
         Lyhg==
X-Gm-Message-State: APjAAAX7IMqPtX7A2IefNFkrG9Mx2wpE4GodLPP3pY1q6yQEFeQIN8JF
        zm0CeShpHrRfxUz1mq6HOXg4soK6MvrBm6+gIM44H1X54pI=
X-Google-Smtp-Source: APXvYqxLkOueyCCVMHm0DePIqYpYXzySy3uuoEYtr96WqVqLGFs7hNFPXn3gVAe9suXLaj7G7+0vxP2j2+7SjATIM4o=
X-Received: by 2002:a17:906:aad0:: with SMTP id kt16mr5218127ejb.223.1574565648659;
 Sat, 23 Nov 2019 19:20:48 -0800 (PST)
MIME-Version: 1.0
References: <20191018131338.11713-1-hslester96@gmail.com> <CAPDyKFoBYchP96hv=7XfTo8CrCSD+KC0h_oFRAsOYT-Lc1SFZQ@mail.gmail.com>
 <20191023153313.GB5153@kunai> <CAPDyKFo9wYwhdy-1BDcRMJKTjADappsT-gBaKZE7hTLE4obxiA@mail.gmail.com>
 <20191031221211.GA3853@kunai> <CAMuHMdXSKU40E8Br0Z53H2FyrQsLxnB-EERZoN6HQHExP5tqxQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXSKU40E8Br0Z53H2FyrQsLxnB-EERZoN6HQHExP5tqxQ@mail.gmail.com>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Sun, 24 Nov 2019 11:20:38 +0800
Message-ID: <CANhBUQ3CsPbPWrs=NUZoFAv6g_ckuEV9sxy0Z_DTiPRJaXi+7g@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: add checks for pinctrl_lookup_state
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 4:30 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Wolfram,
>
> On Thu, Oct 31, 2019 at 11:58 PM Wolfram Sang <wsa@the-dreams.de> wrote:
> > > > Well, I don't like to bail out because this error is not fatal for basic
> > > > operations. How about releasing priv->pinctrl again with an additional
> > > > warning that pinctrl settings are broken and will prevent 1.8v modes?
> > > >
> > > > Opinions?
> > >
> > > Hmm, from a mmc driver probe point of view, I don't quite share this approach.
> > >
> > > I would rather fail as it forces the DTB to be corrected immediately,
> > > rather than trusting some developer to look at a warning in a log. The
> > > point is, in such a case it may never get fixed, if the product is
> > > shipped with the wrong DTB.
> >
> > I could agree to this arguement, iff the only way pinctrl_select fails
> > is a DT misconfiguration. I am not sure if this is true right now, and
> > we can't be sure about the future. Or?
>
> Isn't "state_uhs" optional? So bailing out if it doesn't exist is wrong.
> "default" should be there, if the device node has pinctrl properties.
>
> renesas_sdhi_start_signal_voltage_switch() already handles fallback
> to 3v3 operation.
>
> Gr{oetje,eeting}s,
>
>                         Geert
>

Just ping this thread.
I am not clear about what is the conclusion of how to deal with the error?
Should I resend a new version of the patch?

Regards,
Chuhong

> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

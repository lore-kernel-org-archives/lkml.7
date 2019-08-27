Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A740C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1A021872
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqNrQmQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbfH0K4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 06:56:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44089 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfH0K4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 06:56:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id e24so17993065ljg.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 03:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wq/U2uqRcLoFz7h5fswTveJreTohoqdRqnhzH4lXvVc=;
        b=NqNrQmQF1TMINxnG3tXMC6N5lSsJnysRJ2K4cMrSNhSxsvBEaXWJi9hcdMosgflzuj
         FCBt/kJFLNjNFxuovam6nPV8YMSq07JTyoks0a12zNst31Hu/OGjLsRQnmnk1u95vL8q
         96rtvTczjT2qyj0J5j+n2gVnXJiyMoxyl0gQYV9ANzRPa+zfFMBoVKLhcSm8IYrhujwS
         pucH7orz6GYQ98O8FpJXrIVLkQxoTmG40eyJ8t4D4x49aEERcS6lSRbxVwxNB7ZkJn3q
         q7pgDqiayFM2B6KfTf4GFJXxI/QfLb9Z65Qyd1G85gHlazbmKo/koDG+OvWDpGLLPzqd
         jMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wq/U2uqRcLoFz7h5fswTveJreTohoqdRqnhzH4lXvVc=;
        b=SZJYwJJXiTtnlUDoRIhmVMpXju9CJ62GxedP8HHIzLvI0PFgrsifDPNh3Hf3W1oudz
         UHQU3w88DynuKrS7XSOBy4GnkrGUvKmTwGuKWQPD2e6QQ0+ljcB4bHEdBK6bgi8goQ/F
         yKrniBByHeKKF+IRcrzb6LL92p5mUk/LTOcn45mCIyDHZmPD9g8T2NmczOWfArJpr/ci
         fdI/WJn9PsOJdb2NYpEhHJXzgOVPr7WiWQFGxmsNFLI4r3SDx9IRZodvrCm17Gnkxk+Y
         dMpVnUL2IlyAiieIEF9VAMA+K2KhZzqXKVsi7uW43Z23U+GwxoK91FPsGK8DdBRgYKcp
         hvMw==
X-Gm-Message-State: APjAAAWr8zYCDdN6OTWJw/iWZB54mlMpbe8gM3A/38xFbEbpFSpCg8R9
        lmal0sC2L8U3X2OE0lw4ZFj2AGe84mdP/2VVMtU=
X-Google-Smtp-Source: APXvYqzJByXIYwML49GNgKStE890AUBK1DvwMnysuxEQMAxx+kxsF/bgtN7N1xuNGViTj1IJJw3i7Lf8ckkaj1at2EY=
X-Received: by 2002:a2e:3c12:: with SMTP id j18mr12914274lja.50.1566903358224;
 Tue, 27 Aug 2019 03:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190826180734.15801-1-codekipper@gmail.com> <20190826180734.15801-3-codekipper@gmail.com>
 <20190827093429.fkh4cqbygxxyvkk3@flea>
In-Reply-To: <20190827093429.fkh4cqbygxxyvkk3@flea>
From:   Code Kipper <codekipper@gmail.com>
Date:   Tue, 27 Aug 2019 12:55:46 +0200
Message-ID: <CAEKpxBmpNk=QPnOqCX7cWCV8qvxqhgEVT2AWhwGUmFMRyoF50g@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] ASoC: sun4i-i2s: Add regmap field to sign extend sample
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019 at 11:34, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Mon, Aug 26, 2019 at 08:07:33PM +0200, codekipper@gmail.com wrote:
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > On the newer SoCs such as the H3 and A64 this is set by default
> > to transfer a 0 after each sample in each slot. However the A10
> > and A20 SoCs that this driver was developed on had a default
> > setting where it padded the audio gain with zeros.
> >
> > This isn't a problem whilst we have only support for 16bit audio
> > but with larger sample resolution rates in the pipeline then SEXT
> > bits should be cleared so that they also pad at the LSB. Without
> > this the audio gets distorted.
> >
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>
> If anything, I'd like to have less regmap_fields rather than more of
> them. This is pretty easy to add to one of the callbacks, especially
> since the field itself has been completely reworked from one
> generation to the other.
>
ACK
That's fine....I've been doing that with the patches which follow this.
CK
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

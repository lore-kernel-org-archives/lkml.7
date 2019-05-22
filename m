Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A04C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 04:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E12217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 04:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="itsCJKdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfEVE7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 00:59:10 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:40657 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfEVE7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 00:59:10 -0400
Received: by mail-ua1-f67.google.com with SMTP id d4so413933uaj.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 21:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pfnQkeXApE9YhAL04oZ9pUNXjKBFEtVB3H8ZellBg+s=;
        b=itsCJKdwgb46ITQkTRPoR292kcfck5T1rUAFHDfske/5D5WuP7F7P3FokSkTHFunNf
         7YQ3BXR/Xmoj2jTOP1hfkdJt1lDEmYafTUxvNuFTUleUmyq5ofyPgY6K17FZitXLDLBW
         kj+iGHmuoeu+c5e9mdy7m0/Q22dVjzeQz6NzlsNr3bF2uX9x2lqdQJugNy9c/inxvahE
         s9deVGS5LGzqxTmCVeVTiUYlsDogXeDmD+B0siLITPFo6hjidNKTbr/yuKGPBpmo54LS
         E5sF5haPxlVlTjHw49x9ASoRzcJXsV2qcr4unFMySxZUMuUTc6FwsM1+q3P1NiMcd6AM
         6oFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pfnQkeXApE9YhAL04oZ9pUNXjKBFEtVB3H8ZellBg+s=;
        b=NPhqkpcN766EkS95qQieDjnPqsvj1YDzCe5agE17SGW1G2G1r+Ucf7ZTaAH12+/ub8
         4TmOh5/uyiJsryOnfyHbdwhLu0tRfgg0MdAvN8s9mfkd/fxosxrfrj6CzAPglu4IhHgS
         7tEVYZ5jsvQHm+Zpv3mZ7sUuvOChC6FScJ6Fa7KWIwlIcMiz63T9sTQBJpsMP4Ll/lUr
         XQ/McrWGMtIbmP9RsBU/iVikHIsN+onwZJEUr3zq8uZD7U0djtEeLMf6lkXmO2IVxBpk
         m/9FKyK6FCjVlUK57N4vPJzl0Tm5k2+O3JXRVkPsnL+U3g1KwCbqIRzSi8z0GwS5MGI0
         5Gjg==
X-Gm-Message-State: APjAAAUwW5Hgivv3EbD1w0z/PtjZEpP7Hb45VnPjSUQg8fNh3ShxrgNM
        b/fWJKm4ieyofWRlPooT//NNpIIqVPJwKwcsPe2gHw==
X-Google-Smtp-Source: APXvYqxVjzH04GMwRGsl2rdzhYHjRj2cXzo6oi7TYlti/cF3kn9df3BQ4J7NHUBk2S9snvBN4LcYAu8LQxGMcT/lIYg=
X-Received: by 2002:ab0:3119:: with SMTP id e25mr3548887ual.96.1558501148962;
 Tue, 21 May 2019 21:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <1558445574-16471-1-git-send-email-sagar.kadam@sifive.com>
 <1558445574-16471-4-git-send-email-sagar.kadam@sifive.com> <20190521135439.GM22024@lunn.ch>
In-Reply-To: <20190521135439.GM22024@lunn.ch>
From:   Sagar Kadam <sagar.kadam@sifive.com>
Date:   Wed, 22 May 2019 10:28:58 +0530
Message-ID: <CAARK3HnTkpkH9rP4oW456V6KYsCah7-gAXdjm5+3cLwJaPs6tg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] i2c-ocores: sifive: add polling mode workaround
 for FU540-C000 SoC.
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, peter@korsgaard.com,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Tue, May 21, 2019 at 7:24 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> >  static void ocores_process_polling(struct ocores_i2c *i2c)
> >  {
> > +     const struct of_device_id *match;
> > +
> > +     match = of_match_node(ocores_i2c_match, i2c->adap.dev.of_node);
> > +
> >       while (1) {
> >               irqreturn_t ret;
> >               int err;
>
> Please keep with the idea of i2c->flags, which is set during probe.
> Just because it was removed because it was no longer needed does not
> stop you from putting it back again if it is needed.
>
I had modified the implementation, so as to keep it compatible with
the new implementation of polling mode.
As per your suggestion, I will keep the older method (the v5 version
which you Reviewed earlier : https://lkml.org/lkml/2019/5/20/1261)
 and submit a v7 for this.

>        Andrew

Thanks & Regards,
Sagar

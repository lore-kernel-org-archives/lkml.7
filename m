Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E37C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED4820714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYyWEbnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfKVQWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:22:10 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41856 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVQWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:22:10 -0500
Received: by mail-lj1-f194.google.com with SMTP id m4so8019301ljj.8;
        Fri, 22 Nov 2019 08:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ykwPMbHIRKgLrVpSpWF8yIw4jd/QEDDbiLYlnpgiqSI=;
        b=aYyWEbnDZW6Y3pbQjaivmMd8tp9cF7ULcfzumRtyQReRZXek4w0sbzD4eUBdg0JE3b
         sUVwwSqB/FOV7j7TQ7Tkww7sjnIRZTTUh6vVPHkg3cKfTA3o9EhkxYJQub+Tla0Tx/6G
         UI2nzfTzxrKMd+8KSEyORBtenIqbFwcSU0pDEhNjB8UwxuKBnyvLkQd2/OLnGk7o4Vgp
         5GRNg7DttdKOkEBDVhLDKN6SJ6Ap3Pd6M2hBo7WnaSPy6L1Dhwk84+1/LJcvHx96+KA9
         ze+6MMe4hgXwpKpGv7Z+4GBNvST7X36o7+HtxNaC3fuA3oo9aC0rY4/KwmAtmRmtvegK
         Yx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ykwPMbHIRKgLrVpSpWF8yIw4jd/QEDDbiLYlnpgiqSI=;
        b=bWqfdtpuXtXU8MJxj8TUhkzQeBQZC9OOiOJCPeZwvZd5JGDAC+wY2f42WrTcJfQ9T2
         bxou6DpD2CRTLrynuV3gJvQCqMRbicQCTDwj7sfSQkGaDntNYzznfYuujfeMFP/NPehT
         i6T+okhO4pq8cs9k7OkOdXIo4if6hZrpPfy1slM0AxTBkx9KjpYRLGwZIDTWYRrlZtjS
         uFS9E6204J71AwkwsHiSzjnEuFOYCQUjefgUxZCc3LXrVyj2qndCmSf1EshQ+O8Ze3VF
         rWwz+y+TEvf8Ne3iTwBs1EPAxJtGNwV0EU11Xk11TCk01Pfw2Jsu9J4z3RNGfUJgBhVp
         fRSw==
X-Gm-Message-State: APjAAAXIFrFFsRIe+KKw8EBhwniDAGIdGrh8z0Crqlc08xyZRXcdC7i2
        lIQyYTSq33xyI8bYKjmGzYWwqwJOAHIfwH1VPBA=
X-Google-Smtp-Source: APXvYqxx1GyP5F+ZOvgpKTjMKTAnsDhbPnJsEFf7YDLg/RvrkoqvPDe/pDx2fHxwvW0O1wDgiuNIFRu+JFSthZOpKiQ=
X-Received: by 2002:a2e:9016:: with SMTP id h22mr12761538ljg.137.1574439727760;
 Fri, 22 Nov 2019 08:22:07 -0800 (PST)
MIME-Version: 1.0
References: <20191120154148.22067-1-orson.zhai@unisoc.com> <20191120154148.22067-3-orson.zhai@unisoc.com>
 <CAK8P3a0x83ueAiCjLg30csc9t7VtZLEbvTp1SsbNDnwCXmWRGA@mail.gmail.com>
In-Reply-To: <CAK8P3a0x83ueAiCjLg30csc9t7VtZLEbvTp1SsbNDnwCXmWRGA@mail.gmail.com>
From:   Orson Zhai <orsonzhai@gmail.com>
Date:   Sat, 23 Nov 2019 00:21:55 +0800
Message-ID: <CA+H2tpHtb8HHkBoaN0jsifq0oP2H=Mi8JcFwE0g6CaOLnD9aqQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mfd: syscon: Find syscon by names with arguments support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Orson Zhai <orson.zhai@unisoc.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kevin Tang <kevin.tang@unisoc.com>, baolin.wang@unisoc.com,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 11:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Nov 20, 2019 at 4:44 PM Orson Zhai <orson.zhai@unisoc.com> wrote:
> >
> > There are a lot of global registers used across multiple similar SoCs
> > from Unisoc. It is not easy to manage all of them very well by current
> > syscon helper functions.
> >
> > Add helper functions to get regmap and arguments by syscon-names all
> > together.
> >
> > This patch does not affect original syscon code and usage. It may help
> > other SoC vendors if they have the same trouble as well.
> >
> > Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> > ---
> >  drivers/mfd/syscon.c       | 75 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/syscon.h | 26 +++++++++++++
> >  2 files changed, 101 insertions(+)
> >
> > diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> > index 660723276481..e818decc7bf2 100644
> > --- a/drivers/mfd/syscon.c
> > +++ b/drivers/mfd/syscon.c
> > @@ -225,6 +225,81 @@ struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
> >  }
> >  EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle);
> >
> > +struct regmap *syscon_regmap_lookup_by_name(struct device_node *np,
> > +                                       const char *list_name,
> > +                                       const char *cell_name)
> > +{
>
> According to the binding change I suggested, this would not take a 'cell_name'
> argument, but instead a an arg_count.

Got it. This is much convenient for caller.

>
> > +
> > +int syscon_get_args_by_name(struct device_node *np,
> > +                       const char *list_name,
> > +                       const char *cell_name,
> > +                       int arg_count,
> > +                       unsigned int *out_args)
> > +{
>
> and I think this could be combined with it, like
>
> struct regmap *syscon_regmap_lookup_by_name(struct device_node *np,
>                                        const char *name, int
> arg_count, __u32 *out_args)

Ok, I'll send V3 next week.

Best,
-Orson
>
>     Arnd

Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8453C2BBE2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB12220637
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvBjg1YJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfLDI23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:28:29 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40438 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLDI23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:28:29 -0500
Received: by mail-qt1-f194.google.com with SMTP id z22so6897306qto.7;
        Wed, 04 Dec 2019 00:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uCZKNDAWGqV6WX7WGX2zLuCaauh33mKw/9lBmVTJ0ho=;
        b=gvBjg1YJe/IrgjhMS9JhufqyINkwEbIy+RWFYHR8NZAu2kCC5HDcADIa9KOonJVUMh
         x7npQ2M1Gwtzb01zbPcFN1d4+1KPuGhN7931x+ADgxvT34FpDGlSRmRTWzKDgOgXXFZE
         yW4H9qRNanJnl1JyGi5SuSKkGCbT/3MFLiuLhzleGytWEbahqN2qHO/Ttikp4/rhPLVX
         MFgI2W3MZsQ8Bg2XD/YSh30Yl3ktzvucbKdheQMnZDcOiwr4GddhWIHvVnsENi0TGRXD
         6UV8U7GFZdjRzKAjddqxcWGaxBxUQ+rTHYcacIHRLMig57fygCtyIb8nGXoTTddswSIW
         Fp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uCZKNDAWGqV6WX7WGX2zLuCaauh33mKw/9lBmVTJ0ho=;
        b=QU1CEAK95CU2KAlS3TBaoJXKTXNDoP5VURoMGpQbgIpJzkWzy9n0gw5g62TCAvNmWl
         N1ol7dtXhLXyNx7kiDtu5bEBBRfTKxefxJMg6uaAOpPs6FnhABzbS2EcW40y5TAvUeSr
         DB28M5lSFFPFMWwBitHgpad7wbM1yln1ZTHLODl2e+eOLUCN2EXxF0SU9YQRkt5qouMi
         8QnR88wopAyfQTvo1u/9+VnTg1p93nmR9MUgK0GiLhvaEoOadb/3qZAg2UBICbp3qYwT
         WnnIfYNpi9Qbi6CcuhucYkhe0qvUPyLp9h+qifqOKJT4MxtCv2hkU4EeDOflc+U4dkdo
         46kg==
X-Gm-Message-State: APjAAAXarGz73eLhCu8FqZyYQ0hExS0F3FcLMrxjoscYUlcObBWJaonC
        VQilrwyIH8uDvCyuf7TVB4+A9/ZhYAI4PSspyZf2QA==
X-Google-Smtp-Source: APXvYqy42lrbvBO0PxmylNsnUOfkNboxvBZlj0DuNVhD+5LgfpHEOmahKkd9pLCkOj8ycJdUS1RZFPe6vl3a7cNcC9M=
X-Received: by 2002:ac8:7652:: with SMTP id i18mr1580423qtr.292.1575448108482;
 Wed, 04 Dec 2019 00:28:28 -0800 (PST)
MIME-Version: 1.0
References: <45ef9ee8c6265743a9c30d8e4d9dcbac1ee3aabe.1575286886.git.shengjiu.wang@nxp.com>
 <CAOMZO5AXnw7QDdfKkZ+FBwuWWvr+t0rRsHQ4muW-T00he2f73Q@mail.gmail.com>
In-Reply-To: <CAOMZO5AXnw7QDdfKkZ+FBwuWWvr+t0rRsHQ4muW-T00he2f73Q@mail.gmail.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Wed, 4 Dec 2019 16:28:17 +0800
Message-ID: <CAA+D8AN-UrAyixp+cOw3h=V7xLfCNQRB0XDhxCeYAmnZo9UWBw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v4 1/2] ASoC: dt-bindings: fsl_asrc: add
 compatible string for imx8qm & imx8qxp
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Mon, Dec 2, 2019 at 8:58 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Mon, Dec 2, 2019 at 8:56 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> > -  - compatible         : Contains "fsl,imx35-asrc" or "fsl,imx53-asrc".
> > +  - compatible         : Contains "fsl,imx35-asrc", "fsl,imx53-asrc",
> > +                         "fsl,imx8qm-asrc", "fsl,imx8qxp-asrc"
>
> You missed the word "or" as in the original binding.

will update it in v5.

Best regards
Wang Shengjiu

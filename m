Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE752C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A022173E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1cZEu7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfGYGGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 02:06:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40458 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfGYGGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 02:06:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so43548353wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 23:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KCKWfzF66+ujdKKdWZwTIX1edTZnqRGNlAf5n/ijexc=;
        b=l1cZEu7oBoEUbaODHvPDj4hs5QwlbKDNhhHJ+bLSfsucvkhINm8tK2olBGb590JxN6
         8cC0kOI38URs6KzfUm2ptxQ8aU7Qu+yVy9ewhyPBm0JQ3ZhDyplUfBWXXYzfyXpb1+xs
         s9ZF+EvZ2TmDL9mKPay0zyi9g0VWCNnWrRdzOtKjCgJib6v4vcIkHGzQcBua4hTdy4tH
         o0tvMqqwkS+Z21/CbxeDSwmMbtH9E9jkSVAJ5giy1VeIyr0blOIlXK9SvP+dUDlMXVYz
         +NdvK8byqXj/kGmO/ThzaxA4SKOCjI3HM5j9aYFe4YnjXaQqcIzixxG0vf/KUbs07fu7
         O0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KCKWfzF66+ujdKKdWZwTIX1edTZnqRGNlAf5n/ijexc=;
        b=lpMRzqyBW6xeaUQP/pZHEub9qI/h/T/kkLvlD8rqEN/hYmVslkRh4Z+9YYmjUxvOPv
         tkGP8DsxAEZ+VN3XOWde8TuvsrBQg8ntVFPK+szk465p+/MgmmjXEsIg6c0uElRgVKCw
         SrjTimdzpWE3JWh3TNH2eZT6VAO2n77PY/Ol2YJDakM7aRMQXLI331WOr/WDK/UG2krw
         e7VM1hMS83ZKtSuPK0X5qZ1CpbHkHa2Cy2+XODvKiPipj7szjlfax2NoEfIR7OmQEj+l
         YByzricoPQQEblNC6WEW1WXbY2xoHPUS96+mVTJfecDxm2AhTJcx+jW8c6UjfBLvT06K
         M6KQ==
X-Gm-Message-State: APjAAAW95PSHWD64QjlNZaTOL6NmvdDOSOcS5S/WdEn3jdj590UHkZdS
        skWJATB6DgLI5mgWOe9wFvmcvxZOXBFeh3mYmPE=
X-Google-Smtp-Source: APXvYqxIPslz5P15OAhT39MHqqaUtf1TLMeZSR/qP2Piw/0OfQIpnkCOtBjfyWYriXs7PAGzu/zSsxP85pq8AEZPaM0=
X-Received: by 2002:a1c:96c7:: with SMTP id y190mr71636835wmd.87.1564034799292;
 Wed, 24 Jul 2019 23:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190722124833.28757-1-daniel.baluta@nxp.com> <20190722124833.28757-10-daniel.baluta@nxp.com>
 <20190724233212.GD6859@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190724233212.GD6859@Asurada-Nvidia.nvidia.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 25 Jul 2019 09:06:28 +0300
Message-ID: <CAEnQRZC+5OWwBJfifjeD_8zD3z9efdNMb4Ey0P1Ka+y63v-XNA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 09/10] ASoC: fsl_sai: Add support for SAI new version
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, "S.j. Wang" <shengjiu.wang@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 2:32 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Mon, Jul 22, 2019 at 03:48:32PM +0300, Daniel Baluta wrote:
> > New IP version introduces Version ID and Parameter registers
> > and optionally added Timestamp feature.
> >
> > VERID and PARAM registers are placed at the top of registers
> > address space and some registers are shifted according to
> > the following table:
> >
> > Tx/Rx data registers and Tx/Rx FIFO registers keep their
> > addresses, all other registers are shifted by 8.
>
> Feels like Lucas's approach is neater. I saw that Register TMR
> at 0x60 is exceptional during your previous discussion. So can
> we apply an offset-cancellation for it exceptionally? I haven't
> checked all the registers so this would look okay to me as well
> if there are more than just Register TMR.

It is not just TMR exceptional. There are like half of the registers.
Thus: half of the registers need to be shifted and half of them
need to stay the same as in previous version of SAI.

I'm not seeing yet a neater approach. Lucas idea would somehow
work if regmap will allow some sort of translation function applied
over registers before being accessed.

Maybe Mark has some clues here?

thanks,
daniel.

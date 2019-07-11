Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566E5C74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 10:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FC4208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 10:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+63J3Ki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfGKKJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 06:09:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38355 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbfGKKJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 06:09:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so5621694wrr.5;
        Thu, 11 Jul 2019 03:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PE3ATibgQJk81OKmbhO7EWb879db6yKZ7K39bmfgNiE=;
        b=i+63J3KioY+pHzWSDbGYBjNsJaK1pG9cNumNv8Zepcf9tZ08M1Zs71SPffN4Q+FW/X
         lmMhI57wRRWO5QM0C0PWWi+vwfK00ILL1a/mCp22N+tFUPJ3cfpYfftEhceZ0EGyg6cR
         1vEtZpTr14ee+0I6HUPi+knYAUFww4CraX8rlkgly71ReTb0+sIlEyWQ9AHcnepTTp9z
         0VtkCgDun00T5jwOrotGkKZSvBkzGEjeW1hrZpVjKsRvtc7N+VrMr6Sl5hFErNxnlVy9
         DRx1jWIGaQu80efVI+vRiJmMmQFBDc7h4NODSEYipAJxLb/j9LCAuo6LnUI6iGCsCyai
         So/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PE3ATibgQJk81OKmbhO7EWb879db6yKZ7K39bmfgNiE=;
        b=j1AOuH6LrrPB1vIIG0UmqJ8ZQxNCnZd/hHwBzw25vWSwI8qKxt5pnqtqXLg760/Bkt
         FNNdvV0zzp/z9EpHwz65/So76MpJyut6QLu4076NTs8Kq2OWB4Fcb5x0qU5CJFCkrqxC
         YAsaH3nUfM6xgcJ6UkdQmOFKhWVNNUlysY3UmFB8hU9ur2gZTJXzzkKWKhSfa4ukkhO3
         coXM9ylIU6H1+tovZiBscw24C4EEBO3nq2Xr8Xrq94dUzyEZotvbBUvK++NEPDAwZZkU
         3WKNL72SeKiFm8NUZS0Id7T7/bpiIidhoQjLN+5cbtay8o+KGZHh5aSXqQRwS0OtyEOd
         b6Wg==
X-Gm-Message-State: APjAAAXopc+r66k8wPldebTRTc4Yv9yX+O6baP5UNrXSGb/3qRtDMIL+
        nNkQElQSpSRf6PYv56OCAqiQfGDyLqmK0uilMgM=
X-Google-Smtp-Source: APXvYqyEj9eFm1y+IpLtv431dxcLyER5Q4h0ADyC4J15pgcfJlc6y1GcGPSysmGWhMoH78RNfRpVx6idEB1RY6eDUIc=
X-Received: by 2002:adf:c70e:: with SMTP id k14mr4353852wrg.201.1562839768794;
 Thu, 11 Jul 2019 03:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190619074000.30852-1-oliver.graute@gmail.com>
 <20190711082039.zze4t22rvlgdxzow@fsr-ub1664-175> <20190711085725.GA1385@optiplex>
In-Reply-To: <20190711085725.GA1385@optiplex>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 11 Jul 2019 13:09:17 +0300
Message-ID: <CAEnQRZBmcRLZKKAj5Nr9=SZTrbr3u-KdvRzg3StY=sY+06psdQ@mail.gmail.com>
Subject: Re: [PATCHv2] clk: add imx8 clk defines
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 12:19 PM Oliver Graute <oliver.graute@gmail.com> wrote:
>
> On 11/07/19, Abel Vesa wrote:
> > On 19-06-19 09:39:52, Oliver Graute wrote:
> > > From: Oliver Graute <oliver.graute@kococonnector.com>
> > >
> > > added header defines for imx8qm clock
> > >
> > > Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
> >
> > Again, this seems to be taken from some vendor tree, so please keep the
> > original author.
>
> yes the header defines is from NXP vendor tree. One of orginal authors is
>
> Author: Anson Huang <Anson.Huang@nxp.com>
> Date:   Thu Jan 19 03:53:31 2017 +0800
>     MLK-13911-3 ARM64: dts: imx8qm: add dtsi
>     Add i.MX8QM dtsi support.
>     https://github.com/ADVANTECH-Corp/linux-imx6.git
>
> Whats is the right way to attribute him?

git commit --amend author="Anson Huang <Anson.Huang@nxp.com>"

Also, modify commit body and add
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Then add your Signed-off-by.

thanks,
Daniel.

Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178F9C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E012F23400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3YefOAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392748AbfHVUGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:06:25 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33476 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392689AbfHVUGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:06:18 -0400
Received: by mail-io1-f65.google.com with SMTP id z3so14688351iog.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 13:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hsSpn9hGEc+4R8e8fM9phFi1Gxa64aABU+4CIuIySwQ=;
        b=e3YefOAIAkPen79sC/z3FeJcEtTSDDxtGIpTx0MKzfxYpWbHAU6YT0jAsEXUNJ9n9K
         zV/02U83jNhXCwxe0cJVWD0qZ2fXSVzjnRNmwU9YaswhphX/c7MT82J+0wB4oYOAfIdf
         o3t/Bqgk97YtBogPYkk+Z6m2DSrKvtLTfjFovUJFPYPZsWR2WlF38PbpsHZuauwRMHck
         km1KO2U9UdcyghSHMH942MHDeSS3GxhiDi1pI/rvWaBejPOT2w5lN+J1nfkROn3k98me
         k3KvTcyKKKYXV72i+mLnPzHu5qCM+l1w8QTs8fro0vJ41lrqh03Y60Y3DadG+GUUGroJ
         GbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hsSpn9hGEc+4R8e8fM9phFi1Gxa64aABU+4CIuIySwQ=;
        b=M+kpDzMMwUbKHBBmqMOD+f1qHnMeWM9hDYM3qH/4JaQRVc7D/Re7vFpTCAIUc9li9e
         2MnbzaLBZWbIo6+6RTW6f+xOQXmIlyL6+Kn1Xu4CdP5MPTkSeU7yP95223wtwUHfgLvz
         7jrYf8IXWbPmkl5q74e22RuLx26+3n0yvNLskl+kGx8M+PGRAjFK0NWjvMWEvkNrSS3X
         lZ/FYsIoD89+TkSWPFgqg3w+p8cK6I8QYNcjFMIx5Is7yadZor29qQnKspJFuj89Hihx
         nAIm11/0DzSVC2BfFahEymDLuFN3p9qhOMMsdzjW3fbXPEBOK2LdORlAknV76qZf02oi
         ZATw==
X-Gm-Message-State: APjAAAUXHAOSyObpDhOPp1xddYH+1kMXWV5gIGZ3d16d4XB6shhK5PWh
        NkEI8tB9s6XPKTxyUzZdXTwlBBM+dkuNAAiYYOU=
X-Google-Smtp-Source: APXvYqwJwJfQRekS8pIphZHiktR5Z63xT/ocdJ4BcGIsoRN24AEWfNDp/0UbySpNcl8VOzLJtdf2clOAKG5G16UAk1c=
X-Received: by 2002:a02:bb13:: with SMTP id y19mr1425878jan.86.1566504376856;
 Thu, 22 Aug 2019 13:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190731180131.8597-1-andrew.smirnov@gmail.com> <VI1PR04MB7023AE3910B261877892EEABEEA50@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB7023AE3910B261877892EEABEEA50@VI1PR04MB7023.eurprd04.prod.outlook.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 22 Aug 2019 13:06:05 -0700
Message-ID: <CAHQ1cqHBzFi80ZCa+jgs0Qy=dMP4yP7am1x-hMTxzb-8Zpok0w@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Drop imx_anatop_init()
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Peter Chen <peter.chen@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 10:33 AM Leonard Crestez
<leonard.crestez@nxp.com> wrote:
>
> On 31.07.2019 21:01, Andrey Smirnov wrote:
> > With commit b5bbe2235361 ("usb: phy: mxs: Disable external charger
> > detect in mxs_phy_hw_init()") in tree all of the necessary charger
> > setup is done by the USB PHY driver which covers all of the affected
> > i.MX6 SoCs.
> >
> > NOTE: Imx_anatop_init() was also called for i.MX7D, but looking at its
> > datasheet it appears to have a different USB PHY IP block, so
> > executing i.MX6 charger disable configuration seems unnecessary.
> >
> > -void __init imx_anatop_init(void)
> > -{
> > -     anatop = syscon_regmap_lookup_by_compatible("fsl,imx6q-anatop");
> > -     if (IS_ERR(anatop)) {
> > -             pr_err("%s: failed to find imx6q-anatop regmap!\n", __func__);
> > -             return;
> > -     }
>
> This patch breaks suspend on imx6 in linux-next because the "anatop"
> regmap is no longer initialized. This was found via bisect but
> no_console_suspend prints a helpful stack anyway:
>
> (regmap_read) from [<c01226e4>] (imx_anatop_enable_weak2p5+0x28/0x70)
> (imx_anatop_enable_weak2p5) from [<c0122744>]
> (imx_anatop_pre_suspend+0x18/0x64)
> (imx_anatop_pre_suspend) from [<c0124434>] (imx6q_pm_enter+0x60/0x16c)
> (imx6q_pm_enter) from [<c018c8a4>] (suspend_devices_and_enter+0x7d4/0xcbc)
> (suspend_devices_and_enter) from [<c018d544>] (pm_suspend+0x7b8/0x904)
> (pm_suspend) from [<c018b1b4>] (state_store+0x68/0xc8)
>

My bad, completely missed that fact that anatop was a global variable
in  imx_anatop_init(). Sorry about that.

> Minimal fix looks like this:
>
> --- arch/arm/mach-imx/anatop.c
> +++ arch/arm/mach-imx/anatop.c
> @@ -111,6 +111,12 @@ void __init imx_init_revision_from_anatop(void)
>           digprog = readl_relaxed(anatop_base + offset);
>           iounmap(anatop_base);
>
> +       anatop = syscon_regmap_lookup_by_compatible("fsl,imx6q-anatop");
> +       if (IS_ERR(anatop)) {
> +               pr_err("failed to find imx6q-anatop regmap!\n");
> +               return;
> +       }
>
> Since all SOCs that called imx_anatop_init also call
> imx_init_revision_from_anatop this might be an acceptable solution,
> unless there is some limitation preventing early regmap lookup.
>

Would making every function that uses anatop explicitly request it via
syscon_regmap_lookup_by_compatible("fsl,imx6q-anatop") be too much of
a code duplication? This way we won't need to worry if
imx_init_revision_from_anatop() was called before any of them are
used.

Thanks,
Andrey Smirnov

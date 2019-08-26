Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C2DC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 18:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A26C20850
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 18:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdQxsuUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387669AbfHZSIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 14:08:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44510 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729777AbfHZSIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 14:08:45 -0400
Received: by mail-io1-f68.google.com with SMTP id j4so31166495iog.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 11:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3xah1lt3wlvEGCrDzsIKSHmElIRBV0MEzfEYCJTIRls=;
        b=bdQxsuUWSvNpsg0AIG13yaf3RhMlQzVC7EwbV348reACqNAzHdsJrHuxOo886AFHM6
         BAdMIcvJ7+d1LwlNyHYnQtmFCMfYzjDcfqLw+A1IWJe8l+z3Z3jtGGZTnEDVtlaE0pyh
         LYkP4vRYvhARifbGhDrmehnv5FgIhTdO0ZlPCsogbihy8z6GL+0uWLpVsLQb3CRuKvJN
         zQLI6glxaQEMdTv0ChHmh7NRpQOF0ddiM/9tL0Vt9RF+vzpOnEL+rt/+IjbMuqO3BF6N
         LKgEeyo4SlDaqEpZSwhI4+T67dXuW9xcUp7n6btaElxSG2m9ixUuyPUEKOEUi695r2XF
         poOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3xah1lt3wlvEGCrDzsIKSHmElIRBV0MEzfEYCJTIRls=;
        b=jk70RMb9VREC/uDM/x4DTZWmPEMOy5Rtt3jF2AtSMDsGT7c3zM20D0mT2dRU/PXuoH
         5HYtjPXDv+GGlGNez3g/iq+J+Tqy4m/1nD6WX/QSsiXoM/8aWvzAu1RiBv0R/r73MsgQ
         qXguxYSQxA+tKxI/hjlI7XhFecqJEScamQhfyqQ1Jjdq3aRgnFsfiB8whB3fu9CJlgVg
         iAWTlYtiQ32E6G/SFTGpySPv6BgWV5kwl0nvU5lB8hPJN1FtOLQ0rL1Ho/lFAw/rasWi
         KKugHrjSQQeCkD4ZX693yczy8LV1ilVcwWZOQhXA3jOiJfRpWhrpb6i8J2jQA98BCVTk
         Er/w==
X-Gm-Message-State: APjAAAXjnca4aRnr32s01B4LqvVuKisXwmyse9mR1p+KsXZNJpC/r3zk
        mrLexBvw6IWYQnXG3zLfYx8jvZSFmiL89qjzpZs=
X-Google-Smtp-Source: APXvYqzY1l2S7dZb4q9PB6apMM06+uMptYaLxj2TPY4bAk6d/GzS5TYysGR1ZfRCTmGF0Wyx6Qt6C8fvkwK/idYfNfc=
X-Received: by 2002:a5e:a802:: with SMTP id c2mr17047667ioa.263.1566842924484;
 Mon, 26 Aug 2019 11:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190731180131.8597-1-andrew.smirnov@gmail.com>
 <VI1PR04MB7023AE3910B261877892EEABEEA50@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <20190824183108.GA14936@X250>
In-Reply-To: <20190824183108.GA14936@X250>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 26 Aug 2019 11:08:33 -0700
Message-ID: <CAHQ1cqGMXEEpXC=sihO-h6oZ3XQc6+W4TpqBZA_1EW6GCiQMWw@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Drop imx_anatop_init()
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
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

On Sat, Aug 24, 2019 at 11:31 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Thu, Aug 22, 2019 at 05:33:13PM +0000, Leonard Crestez wrote:
> > On 31.07.2019 21:01, Andrey Smirnov wrote:
> > > With commit b5bbe2235361 ("usb: phy: mxs: Disable external charger
> > > detect in mxs_phy_hw_init()") in tree all of the necessary charger
> > > setup is done by the USB PHY driver which covers all of the affected
> > > i.MX6 SoCs.
> > >
> > > NOTE: Imx_anatop_init() was also called for i.MX7D, but looking at its
> > > datasheet it appears to have a different USB PHY IP block, so
> > > executing i.MX6 charger disable configuration seems unnecessary.
> > >
> > > -void __init imx_anatop_init(void)
> > > -{
> > > -   anatop = syscon_regmap_lookup_by_compatible("fsl,imx6q-anatop");
> > > -   if (IS_ERR(anatop)) {
> > > -           pr_err("%s: failed to find imx6q-anatop regmap!\n", __func__);
> > > -           return;
> > > -   }
> >
> > This patch breaks suspend on imx6 in linux-next because the "anatop"
> > regmap is no longer initialized. This was found via bisect but
> > no_console_suspend prints a helpful stack anyway:
> >
> > (regmap_read) from [<c01226e4>] (imx_anatop_enable_weak2p5+0x28/0x70)
> > (imx_anatop_enable_weak2p5) from [<c0122744>]
> > (imx_anatop_pre_suspend+0x18/0x64)
> > (imx_anatop_pre_suspend) from [<c0124434>] (imx6q_pm_enter+0x60/0x16c)
> > (imx6q_pm_enter) from [<c018c8a4>] (suspend_devices_and_enter+0x7d4/0xcbc)
> > (suspend_devices_and_enter) from [<c018d544>] (pm_suspend+0x7b8/0x904)
> > (pm_suspend) from [<c018b1b4>] (state_store+0x68/0xc8)
>
> I dropped it from my branch for now.  Thanks for reporting!
>

OK, it sounds like I can submit a v2 that only removes
imx_anatop_usb_chrg_detect_disable() and keeps imx_anatop_init()
intact.

Thanks,
Andrey Smirnov

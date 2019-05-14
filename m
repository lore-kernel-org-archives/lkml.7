Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82CAC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E26020645
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F15QTDXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfENIjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 04:39:05 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45231 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfENIjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 04:39:04 -0400
Received: by mail-ed1-f65.google.com with SMTP id g57so21664869edc.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 01:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVI9iWgc55Qe0q3tLtvRyel7wrcIN68nuDWX5YnzBtc=;
        b=F15QTDXnjQ7h1JnwI/L/yLlLHNZz3LU5SuAP4NtoAxncLb9P+u6MXb0HOEomLvKrBX
         3R9ouMCzZJj6s16y+Np4CXsnPFiAOlSVa8xYckHTSa1HLBClfVhbUguAPcjWoqOvWPuv
         tV5M9+7jxZSHo1moP4c4ra1XRQeRyuTrJn4kI8khIhUhF/EpSRRo3Atj1lPHAgnIHylm
         wvMtnm6MJ/nMjug4ihZ4d+//xf/pNpsXyGoDbE6mlzji05xNaUfGMsL3JaqClUCqmqTC
         o/nyt/ObxuovlVXJDhYwxJroRLP1vPfKnMjW35G99l4PLkfjN/A6jJj1l8dvl/9C2oAg
         Dd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVI9iWgc55Qe0q3tLtvRyel7wrcIN68nuDWX5YnzBtc=;
        b=cN9QZGj99x6EXVOu//dCI6mKKuFT3HF17XmwEFQeNvLFiVcGgGl+c+GLafAMLp6wKu
         RrVSwERGDIhqiRkB3uL3tm6HxI9IPi8UniVM/rNM2b3YDxb5mpilgHNv8Zqj7zGHnFCF
         q71rvWlnL2ckhGFVhgfxK424MszkOACf4OZBMl7iZKKIxTwaD0KK9azD8e4JRgXUqV+O
         Ry7rH7OG0FV/EfIsZTPV74wh9sGiFmOONUj6lGSWTU1NAH0zQga6x7hruciZry+WB0RJ
         3C5/rMGBRz+zGW9rx2Vwcmce/wYCA0pbXQBYvLkW7aDdJiVDFRjhImaEAB/EeGo/J/E4
         heXQ==
X-Gm-Message-State: APjAAAVvgflYfmoJu1nHLnvkmkoESlPJkknljjnPYfWJIzqWfp+m4guY
        om8K3xJHCkp/gfFHgRPyOgLhHJZwEE2n7HJSv/Q=
X-Google-Smtp-Source: APXvYqzsuyJYkvShd5DlSehIbVnkw3GSm4SjUrW2ugHXKkw4JHSYr09nLMugB2wNXgGzymTdiBIdkaEWk1hFz8jrH1w=
X-Received: by 2002:a50:9441:: with SMTP id q1mr34683894eda.101.1557823142649;
 Tue, 14 May 2019 01:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <1557716049-22744-1-git-send-email-Anson.Huang@nxp.com>
 <CAEnQRZDSTuUMrc9AC1S2zfo0PdQ-v35GmNrf70Zoasid_XMJzw@mail.gmail.com> <DB3PR0402MB3916A46BFFE5E6F3D4832A33F50F0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916A46BFFE5E6F3D4832A33F50F0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 14 May 2019 11:38:51 +0300
Message-ID: <CAEnQRZB0fs2g=h4pq97t+E9U9LOxSafYhx07Xia_J+snjqefEw@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] soc: imx: Add SCU SoC info driver support
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 2:34 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> Hi, Daniel
>
> > -----Original Message-----
> > From: Daniel Baluta [mailto:daniel.baluta@gmail.com]
> > Sent: Monday, May 13, 2019 10:30 PM
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: catalin.marinas@arm.com; will.deacon@arm.com;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com; maxime.ripard@bootlin.com; agross@kernel.org;
> > olof@lixom.net; horms+renesas@verge.net.au;
> > jagan@amarulasolutions.com; bjorn.andersson@linaro.org; Leonard Crestez
> > <leonard.crestez@nxp.com>; marc.w.gonzalez@free.fr;
> > dinguyen@kernel.org; enric.balletbo@collabora.com; Aisheng Dong
> > <aisheng.dong@nxp.com>; robh@kernel.org; Abel Vesa
> > <abel.vesa@nxp.com>; l.stach@pengutronix.de; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; dl-linux-imx
> > <linux-imx@nxp.com>; Daniel Baluta <daniel.baluta@nxp.com>
> > Subject: Re: [PATCH RESEND 1/2] soc: imx: Add SCU SoC info driver support
> >
> > <snip>
> >
> > > +
> > > +static u32 imx8qxp_soc_revision(void) {
> > > +       struct imx_sc_msg_misc_get_soc_id msg;
> > > +       struct imx_sc_rpc_msg *hdr = &msg.hdr;
> > > +       u32 rev = 0;
> > > +       int ret;
> > > +
> > > +       hdr->ver = IMX_SC_RPC_VERSION;
> > > +       hdr->svc = IMX_SC_RPC_SVC_MISC;
> > > +       hdr->func = IMX_SC_MISC_FUNC_GET_CONTROL;
> > > +       hdr->size = 3;
> > > +
> > > +       msg.data.send.control = IMX_SC_C_ID;
> > > +       msg.data.send.resource = IMX_SC_R_SYSTEM;
> > > +
> > > +       ret = imx_scu_call_rpc(soc_ipc_handle, &msg, true);
> > > +       if (ret) {
> > > +               dev_err(&imx_scu_soc_pdev->dev,
> > > +                       "get soc info failed, ret %d\n", ret);
> > > +               return rev;
> >
> > So you return 0 (rev  = 0) here in case of error? This doesn't seem to be right.
> > Maybe return ret?
>
> This is intentional, similar with current i.MX8MQ soc info driver, when getting revision
> failed, just return 0 as revision info and it will show "unknown" in sysfs.

Ok, I understand. Lets make this clear from the source code.

   ret = imx_scu_call_rpc(soc_ipc_handle, &msg, true);
+       if (ret) {
+               dev_err(&imx_scu_soc_pdev->dev,
+                       "get soc info failed, ret %d\n", ret);
                /* returning 0 means getting revision failed */
+               return 0;
+       }

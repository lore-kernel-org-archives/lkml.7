Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88152C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 23:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BFF20989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 23:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1CPd+tb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfEGXJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 19:09:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42511 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfEGXJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 19:09:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id y10so9287549lji.9;
        Tue, 07 May 2019 16:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vk0G5/KAtP9NDw7LHnLsf8NsNY0KwtVtgkW1AKkGjKQ=;
        b=u1CPd+tbyoZQI1gzBERndNqWsMbS3AKZU4SiYvB3NKDoyr+iQDI+S7eYiCP3LUFwUN
         XHoIDcHXOLM2p9b9VoxLLfj9KtmvX9Y8iXkTG8GPZ4xyT59sad5tFTgF6RmJJwzA3Sm8
         cIr+cOinLVxbBpm8dJaLh1dAoM8O6nKC3JmRnuuYaR5zKccd2VJqIP5r14JG5dHM5K7E
         0Z6dLmXI0hDpyRpqGgjVeUvall8r5Bw1h03TqjklRbxHrtAh/XkikWBRQ41rm6v7ClIL
         NpGVVOEkF3iFy2pgOdrTlehEih+Oy+/+KePA8fFJs7xwS3jeYPPsofP6gVgF+AhvYjiC
         iu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vk0G5/KAtP9NDw7LHnLsf8NsNY0KwtVtgkW1AKkGjKQ=;
        b=PMIM1+CMoe7q1MfRORC1ZgI74ZDXxpEcytN2o3hN6Fs/IE7nb+66odm2MOOy2knYag
         VITEc0h/yt9u+QTDqJpCvHQmdq0CwdRJ2VCMsWuqbF9zoNPUja5UdDQp6eW1AqK1wo7+
         4uofcOP1+zNv+XJ+OynFJ2dqOjGpMyQs1Wp2Q0MyHC9Wxg/sPMbNncpri//+aXK0tT/U
         2h421vo3/CwKhFHhyFKby1KgYwME1gKjSxGHz3M4Lnf3DHrDh1bi7agpcqtSCf9Jgvsq
         6R5j/Um9Nft1ENOq/dYVogIWDUQjj62igvXoxfDENKUEXyrt2R5WWWgVkzxFLB5w16Fa
         rU1w==
X-Gm-Message-State: APjAAAXlhVM0mmv1UIWctF+Ds0TIsCsMtYfzToITWpTpuBmm6s3dWo4y
        JNhnwDOoipeHRoxxRXoctSQ2RyZuV4HP2bJKUx4=
X-Google-Smtp-Source: APXvYqxikcAzHK+93rRK0elQZX4vQRe2yPPmD/LRGFuhwj1hmj5kgDPmGBPnPCDqLM2nPxVZ6JJ0t10IsEa4a59y/kI=
X-Received: by 2002:a2e:2b81:: with SMTP id r1mr4146671ljr.138.1557270592446;
 Tue, 07 May 2019 16:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <1556190530-19541-1-git-send-email-liuk@cetca.net.cn>
 <CAOMZO5BbA6oq8okTR-r800k4XY76XxxEdufd1mjcV6HdTpVotA@mail.gmail.com>
 <AM0PR04MB421133A3F3C6B534B6ECEA7880370@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <VI1PR0402MB360058CE70AD60C116EE0634FF370@VI1PR0402MB3600.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0402MB360058CE70AD60C116EE0634FF370@VI1PR0402MB3600.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 7 May 2019 20:09:58 -0300
Message-ID: <CAOMZO5CSaRZEiaqxBTcBhaYjRLxMjb6Boyy0eO6OAEFBPv3_Kw@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] ARM: dts: imx6sx: Use MX6SX_CLK_ENET for fec 'ahb' clock
To:     Andy Duan <fugang.duan@nxp.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>, Kay-Liu <liuk@cetca.net.cn>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Sun, May 5, 2019 at 5:15 AM Andy Duan <fugang.duan@nxp.com> wrote:

> Nack the patch !
>
> Firstly, i.MX6SX has ENET AHB bus clock for MAC, and currently it is set 200Mhz like clock tree:
>         IMX6SX_CLK_ENET_PODF 200Mhz -> IMX6SX_CLK_ENET_SEL -> IMX6SX_CLK_ENET_AHB
>
> IMX6SX_CLK_ENET the clock is IPG clock for ENET IP ipg_clk_mac0_s/ipg_clk_s.
> (Please check RM Table 18-3. System Clocks, Gating, and Override)

Ok, but could you please show us where in the Reference Manual the
IMX6SX_CLK_ENET_AHB is mentioned?

I don't see ENET_AHB in imx6qdl Reference Manual either and we don't
have a ENET_AHB the clk-imx6q driver and nor in the devicetree,

> Secondly,  for your issue you caught, which was fixed by patch:
> commit d7c3a206e6338e4ccdf030719dec028e26a521d5
> Author: Andy Duan <fugang.duan@nxp.com>
> Date:   Tue Apr 9 03:40:56 2019 +0000
>
>     net: fec: manage ahb clock in runtime pm

Would this also fix the case where power management support is disabled?

If I understand correctly the explanation from Kay-Liu he would still
see a hang in the case when PM is disabled.

Thanks

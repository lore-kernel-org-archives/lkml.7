Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7FEC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCB221783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ugA74A81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfKKLVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 06:21:55 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46790 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKKLVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 06:21:53 -0500
Received: by mail-lf1-f68.google.com with SMTP id o65so5857231lff.13;
        Mon, 11 Nov 2019 03:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8D7FBZWNeYQoIdRr1oY1OfdugIxxf8OTSU99lGfG9qQ=;
        b=ugA74A81U6n8SMIfSZr7aZqtzweH40047f8NhMqylHmOvtbnQ6zBRuto0AFvq+2hqV
         fNiKl+Z8TmgIAs5e01YW5+dVYQCiZVL2gjG5tyOsTUp6Dr6Duw9z9djzZvX6YXILUoZj
         Oipl/zxgQ/PfXRbni4LxMcT0k9AUoPE0U8Di0iUuwpbWbZRzqKvT32pKNmtTMhm4aVA8
         79lpF1a495r9WPjRHlXT4zPewP0/ZiDBkToH5kStc804V+wThWDJ9ZtoT98IEYCug6gQ
         lA/C3M52KjeX2OFHK1mE/IgK/n1wr8/T9sbZyS9k2BfN1uDyQF/4PUJDI0OPzb6hG6mb
         1/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8D7FBZWNeYQoIdRr1oY1OfdugIxxf8OTSU99lGfG9qQ=;
        b=HyaWsyPHhM6arxFrOWU3Kg7NQJRce7mnk/P6R9Nno3RGJrsqGpVisruGsFmzHCUErj
         g+bJP7pPPe2+ho25859+28px5UCg58wtpCker9eufAoNRWJLPJvIroNWabp6aHsYq/e0
         eJK8BDNdaWm4fyxhS7yBv/WENkbMU97EFT2VGoYZ6yd8VoPvIwyTQnAHQrzV21UHVip6
         jz66SsP3WVIRyVf+p9QfjE+FIDeZXLFiP4wzaDtJkDkifVzUhWxJF0onssCCjolrVWcx
         cbEaNCvZJu5rQx0j6VMBDqdOik7n/7od4PZpODvjznOgMK33n1O5oXkZigRXNhmyZpgQ
         TxJA==
X-Gm-Message-State: APjAAAXEvgqX2OhqMBV+EFL9XkpJVgqgSAZNpbv2T1fQ884cpEXaZ3Q4
        vcFFefiivV/uu0eT4cguRDA+28K9Ae99QCSAotA=
X-Google-Smtp-Source: APXvYqzdYoiEJjshCXOPVIThPM0dEfQ7V560bnYDQA4R2ViUh18tXK3rrzo8/na4YLv0MOp0RVHKUNeJF/uN0xTJHUk=
X-Received: by 2002:a19:2358:: with SMTP id j85mr10685518lfj.20.1573471311279;
 Mon, 11 Nov 2019 03:21:51 -0800 (PST)
MIME-Version: 1.0
References: <1573435732-30361-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1573435732-30361-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 11 Nov 2019 08:21:46 -0300
Message-ID: <CAOMZO5By4Tvk=KFxEC+8BC+FZ498pCzOpskvWst1=gWsDnb=Gg@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] ARM: dts: imx6sll: Update usdhc fallback
 compatible to support HS400 mode
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        =?UTF-8?Q?S=C3=A9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 10:30 PM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> The i.MX6SLL SoC can support HS400 mode, hence "fsl,imx7d-usdhc"
> should be used as compatible string to support HS400 mode by
> default.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE85C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792E6204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7jgFUeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfETTcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:32:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38027 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfETTcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:32:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id 14so13595129ljj.5;
        Mon, 20 May 2019 12:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5CJy2dAeiox6uSZJUrT6ntHN0iGf8wFFMkB5gRGvXDA=;
        b=P7jgFUeHCs7+AjBG2AuXEKKQm5HcQoiMOoF6dgnHtTQWgFTGB3HAfSrc5U2ov3Em/L
         b79q/0mf/FFYJypHSacZs8WRGrSlp9cgw+zcrCpOR1ntwuDY9EATpN8iT/YRz8P1qNqe
         KIEARqWbHtJzyNCTJ+khfi+ZXKBl2rHzEAuxO4BXV22mIkN7ySEi+NjY9qUeAja/cVA/
         IDIm81sG289xyiGnqBYD47UafLoPCgUfglPwxPv6xusBU9eeho31r7FzUMJXfJzGZ4v/
         eCQRo9ES5JkNExo4UiGGqj6LyOtYicz7ScHR6Ntt86Si15X7J2ciD+kGPYXxIm8l7ZyI
         A3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5CJy2dAeiox6uSZJUrT6ntHN0iGf8wFFMkB5gRGvXDA=;
        b=gyyMBS5NYDxI31y//yhFcUgm/Y2OUeXLgJvTa9Q0uWVXGZiRVbSEHL1MxWND4xjB4D
         ZRAsWPDlrV+D3UuQrG6shyrCgnYyEiyQujmWAvMpxGRc2GtZZkZC/08CO2c3Pea2u1HG
         h4xA1zkvzbpH+0xLumGHSqVZvz5StW46yGPATIS8LsRaYOitTlEy3KKCvdCQSgQguqSZ
         FzIdjMnLF8RJkbE9KTbR0ZohIoJJy7ycmhxje+kdYqhMc0wc70KMKnIM7h1cQVAKYWxi
         vjXqGmir+f6W1ff0sSkguDNXRBmUgPCgw797LYDvj2ZF369aVoXrcV7zq79U5emVZgke
         f7qg==
X-Gm-Message-State: APjAAAWh7VzlNx2m90fMq00r7Z1NXRmrqDXDMGXGwPui2KI6OyWVp62W
        x1ubBgHKJKpk5dcb3Tt0sRYGUecLYb+t/39fFb4=
X-Google-Smtp-Source: APXvYqway49cEPUGdvZjJ+hP18SCMMVwpRB8TXHDrRQznMNpDxg0nRMzVHOAdVngIuP5ja63eqiL/FnRQg2ZgigufaQ=
X-Received: by 2002:a2e:1f02:: with SMTP id f2mr37741905ljf.86.1558380739291;
 Mon, 20 May 2019 12:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190515144210.25596-1-daniel.baluta@nxp.com> <20190515144210.25596-3-daniel.baluta@nxp.com>
 <CAOMZO5A6Gv5k3up0AtKrhQPyMLMe_8SXift68KEP2J+j8D_cJg@mail.gmail.com>
In-Reply-To: <CAOMZO5A6Gv5k3up0AtKrhQPyMLMe_8SXift68KEP2J+j8D_cJg@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 20 May 2019 16:32:14 -0300
Message-ID: <CAOMZO5BTqwnun6d7G1vcHUu_Rs+xfvgxTzamWnBPy76W7eeF_A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: imx8mm-evk: Enable audio codec wm8524
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 3:35 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Wed, May 15, 2019 at 11:42 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> > +               simple-audio-card,codec {
> > +                       sound-dai = <&wm8524>;
> > +                       clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
>
> IMX8MM_CLK_SAI3_ROOT is the internal clock that drives the SAI3
> interface, not an external clock that feeds the codec.
>
> It seems you should remove this 'clocks' entry.

Just checked the schematics and the SAI3_MCLK pin clocks the codec, so
the representation is correct:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

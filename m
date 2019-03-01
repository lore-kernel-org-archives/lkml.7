Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EA8C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEC320850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Totj6Qhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388807AbfCAPyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:54:01 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37923 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbfCAPyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:54:01 -0500
Received: by mail-ed1-f65.google.com with SMTP id h58so20403006edb.5;
        Fri, 01 Mar 2019 07:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1IMi1r7Hx8ZUCIO0MQp9zJZFpHjdZ8rHXQqjEmCISwc=;
        b=Totj6QhrEyDf6/EhR2QiDmeCng1BxyChBxw7ZDaWKXCnGXOx6KewyVSAO2VqxY+Wn6
         S7Jp293rPpDzmkhNNlh+mmYAvJCzzIGVl52kDRt5sdVkVmsIn7znAycniLjHyvjcE8tq
         cW7djabselXBHLD6HrNXDcACNSqThuVulQSXGuO5J2UHaMFWl9n7eRk9Xm8GdhzrxguZ
         Ju/MEKf/VJpnVjXQrMwtkp0audXEnThothU1x15GzSNPv71HiAcGu2flXJbI/DBmqBAt
         zSFnlXbRXwAs6c9bt3cQWZzDZB1hf7+lebbZqFuvv5w4W1K/HDu2G/2ijRT4mf7ce0to
         lzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1IMi1r7Hx8ZUCIO0MQp9zJZFpHjdZ8rHXQqjEmCISwc=;
        b=G1Ww5edf16OeYAql8DDt5IcN4pSlRAHHk2v5o6rm+9brOiEagH9CF+b7rbTFyQQ3kt
         Ox4F43lPBLiuEokEMDKxvzxH8z5zmGbq8FTcgG0Z3c7kWqTehuEwJImkdI/vwCKNUbRj
         y9WXrFkOtBzW/WI631bAVHLs066yRDGFmAg05j9N/vSrhNhdW4WYUcdSy9YqGJHXc2ll
         PA+gptoRYJ62q8ExrhCsFEOcOGqvWv+g873086gDoT4Vh3W0zsUNtgeJAi7tG1adEYGa
         h6UAHBuL+MU7mpdpvPlICB2W5bSLtvzLHBR7neWJYdnHX7vVgrUYcchj9N+1ZCMwdpIr
         9EMQ==
X-Gm-Message-State: APjAAAVCYzNYr1gorIL0SbSRPQTlz69t7SDPz6O/idVtHQhdiE8bfdw7
        KoefhQbmleEVJ4hguXnnDlYZzNwVSbNnknQJ6tw=
X-Google-Smtp-Source: APXvYqyovl9PjQq59vtt+baDtkn4o7WqMz9YabWwsQrirpPLkINGE5CW+7ESc+O+sYC8JDIL1LSM/kaRIy582AOEfwc=
X-Received: by 2002:a50:9063:: with SMTP id z32mr4784624edz.164.1551455639159;
 Fri, 01 Mar 2019 07:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20190227063737.24445-1-daniel.baluta@nxp.com> <20190227063737.24445-6-daniel.baluta@nxp.com>
 <CAOMZO5AY--Q7FDwK-k8u=mkR-9bxz0XWXN3HNZb4Pb+MESZ6Dg@mail.gmail.com>
In-Reply-To: <CAOMZO5AY--Q7FDwK-k8u=mkR-9bxz0XWXN3HNZb4Pb+MESZ6Dg@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 1 Mar 2019 17:53:47 +0200
Message-ID: <CAEnQRZCyUG33SbwhPkE95tuaBdJ7Lo9WbVfJz06ZB1-X9ZbKww@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] arm64: dts: imx8mq-evk: Enable wm8524 codec
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "spencercw@gmail.com" <spencercw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:09 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Wed, Feb 27, 2019 at 3:38 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> > +
> > +       wm8524: audio-codec-0 {
>
> This -0 is not needed as we have a single codec on this board.

Ok, will fix.

>
> > +               #sound-dai-cells = <0>;
> > +               compatible = "wlf,wm8524";
> > +               clocks = <&clk IMX8MQ_CLK_SAI2_ROOT>;
> > +               clock-names = "mclk";
>
> The clocks and clock-names properties can be removed, right?
>
> I don't see them defined in the binding doc and the codec driver does
> not call clk_get(), so there is a mismatch.

They are used by simple-card.c machine driver.

asoc_simple_card_parse_clk
-> /* Parse dai->sysclk come from "clocks = <&xxx>" */
clk = devm_get_clk_from_child(dev, node, NULL);

>
> Also, I still think this one and the previous patch could be made into
> a single patch that adds audio support for the board.

Ok.

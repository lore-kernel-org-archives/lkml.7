Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5F6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 11:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBE320851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 11:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvzOGQxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfCHLw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 06:52:26 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44485 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfCHLwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 06:52:25 -0500
Received: by mail-ed1-f67.google.com with SMTP id b20so16152398edw.11;
        Fri, 08 Mar 2019 03:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rmoIicOUfKAbdWBF1twctGd9siL8/G/6oY19Hb9Cc5o=;
        b=CvzOGQxzc9HX5whEGJsruEdgGMV/wuo9865VjKsDJLYaA+XI5/dXltZsAAIXis6peh
         93aRm1r/z+b2v09az27NfVEyQE+ulnSa0Ga/Jgf6qB3I3xf9dtSpA1mZW0NvlRiyOoGo
         fFbwvazLn5t1VGNdaF2qp9YOD55iv+yh6CypC6X6SKQC0Tp7WM8td30CLM9oxOOKOKkc
         8GjrKQpQG97peTeDYH855NNZmk91JYm9+8ZFBQAE9G/EJTG28opKMlJ8VFssxlw6odzp
         loUtL9obJbXCfARu/D97dixIkce8vQwBvuc8oB08XCiW4YCZ7KzsAwg42LvCESdnSXR2
         /N1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rmoIicOUfKAbdWBF1twctGd9siL8/G/6oY19Hb9Cc5o=;
        b=mjfqEQeqtw6Whv8npxrm/I6CZ5iRgRcYYhs7p9tql3kTy7I9NRRgnErx+d9OMIDI29
         IOUDlRp48u/b8ABDsxbB4gdL9ErsiPRsbZIDNF6mk4kiM8vJnnEYY5DLBdRfgfz42C8+
         AaWBnjKnYDNdddKKWSTVbaVO1ry4yHDkf7dJToyD8P43coBtBid02BmdAV0wwAE0uWpW
         9HzUx8B7xt1XOWPPOCt7AFXUryOaB376N9UeIBltmC+cQisNZ+/+Fn4gMxCIrYd0dTb0
         QJkCU8+kTtLdwFfHauzRcjzoYID5TDHZQ2ZF4rLQaqL1vNRueKJjPuYn5Qtj1OwrKP22
         V9TA==
X-Gm-Message-State: APjAAAUIH+Zg9fgRQz3gwVZPBBuP/BnN5dFKwApaVnHoBVYuBA9ZUsja
        jj9St+T9IDLbUwafq7IrrDEGhVNg/J9Kpq7GaCk=
X-Google-Smtp-Source: APXvYqwJCfkvJZLj/3SeehlmxllSDaZ9SPqm5R8hzx0CYdPOvob6ODls3/WKfcP8vTCVGXozJ0qzjb54PDPaySAaan4=
X-Received: by 2002:a50:aa2e:: with SMTP id o43mr31778552edc.67.1552045943734;
 Fri, 08 Mar 2019 03:52:23 -0800 (PST)
MIME-Version: 1.0
References: <20190227063737.24445-1-daniel.baluta@nxp.com> <20190227063737.24445-6-daniel.baluta@nxp.com>
 <CAOMZO5AY--Q7FDwK-k8u=mkR-9bxz0XWXN3HNZb4Pb+MESZ6Dg@mail.gmail.com>
 <CAEnQRZCyUG33SbwhPkE95tuaBdJ7Lo9WbVfJz06ZB1-X9ZbKww@mail.gmail.com> <CAOMZO5COQNvpbdxG808aRSfMhMHznorPzoCD-Kp7rB6e8jz4Ng@mail.gmail.com>
In-Reply-To: <CAOMZO5COQNvpbdxG808aRSfMhMHznorPzoCD-Kp7rB6e8jz4Ng@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 8 Mar 2019 13:52:12 +0200
Message-ID: <CAEnQRZCwW-zqGRHwy8eUUDxFP2kYMpH6PJgSVZuZJCaFJrv+xA@mail.gmail.com>
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

On Fri, Mar 8, 2019 at 12:32 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Daniel,
>
> On Fri, Mar 1, 2019 at 12:53 PM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> > They are used by simple-card.c machine driver.
> >
> > asoc_simple_card_parse_clk
> > -> /* Parse dai->sysclk come from "clocks = <&xxx>" */
> > clk = devm_get_clk_from_child(dev, node, NULL);
>
> The simple-card looks for the "clocks" properties inside the
> simple-card node, not inside the codec node, right?

I see your point now.

Indeed, "clocks" properties is the one inside simple-card.

   sound-wm8524 {
               compatible = "simple-audio-card";
               link_codec: simple-audio-card,codec {
                       sound-dai = <&wm8524>;
                       clocks = <&clk IMX8MQ_CLK_SAI2_ROOT>;

Will remove them from  wm8524: audio-codec node because
they are useless there.

thanks,
Daniel.

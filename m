Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A35C468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 20:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE66212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 20:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zKZercwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfFGU7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 16:59:11 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37417 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730315AbfFGU7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 16:59:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id 131so2902385ljf.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 13:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tEZvWJsFue7fCIY7RY9rcYSd3HaVbUE9nAN1OkAVWME=;
        b=zKZercwpsPXX2K9QFr6z2ZW0wE6hyQk4g2lpewtU9wiouEVRmpfzXJ2VygkU4n8H8m
         8c2xBCQWDSy8rslj7GVT82J32G1k5dUcZSQK2StFiSRstoq08PXTblGP+tmvyrO61A+b
         cUzpdTPsLrJAHqZWd9LirbPd3tNmwJh2c114GMeFGiCu6OtXeVfiaRHVKhr8sT78fYz+
         +y6Z2yxXoy/wbOz6++aYBeQN5aX6qabuor2J8GbgWvnRrA1Mh+zwhfAnqWcti2HlOolw
         MLOw7T6JSlZRCbJxHvpQnTmpwYKOZvuyJMa49Yu26JrfN22afylMLUQ6pAjek5Lq52u4
         YmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tEZvWJsFue7fCIY7RY9rcYSd3HaVbUE9nAN1OkAVWME=;
        b=ALXVT7EafaWL5Ph72IOB9cXji5zxEbEh6na+KKNf19SJwBUmynnoCaGxj+nSZjn0LZ
         4mVpfLWy9FRuv7R91QT5JwyfXs6wus1vVUdE+iTAiEnbseS+SoyuEyIjkKgccdmFZ9ml
         E5NLZCICEgH0Glm8WCyvvxxLaFsPizcaOvv3jAxXoqH+j12p1jYeOyZ55RyyS1FFP6Wb
         pYntZoYOmZobqUg88BkPRhx4jFZWkmQZbF7u8B7wijSpiedQc4skYomGmERFF8LrhA+c
         STOqSRwuuEVpZuGBzmB1XV49YDFtvNGfSE4jLyM89ZkxcgBILriJNtonE74mNuviPHNd
         RoZA==
X-Gm-Message-State: APjAAAWb64uO1P0xtsCFK3Hq0ZJ4CXgeB+LjMooODXt1uOvZAa+P/A2D
        pxXpxGE/kXyMMZibye05604ak2CF3ryGjU5UQw70og==
X-Google-Smtp-Source: APXvYqybb7KzOkDvVRauSyZjrruBmBWId2yXwpYH1HIMQi6UsJ2mD7CwnPWMbaLG8x56HQlC6vvpZipHjgVXHICJWec=
X-Received: by 2002:a2e:9753:: with SMTP id f19mr5258986ljj.113.1559941148941;
 Fri, 07 Jun 2019 13:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190530031357.17484-1-Anson.Huang@nxp.com>
In-Reply-To: <20190530031357.17484-1-Anson.Huang@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Jun 2019 22:59:01 +0200
Message-ID: <CACRpkdYmX3GRmXCuPe-zoQE6PEYr_TQruj_ymR3G_jBjtjrwpw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: imx: Correct pinfunc head file path for i.MX8MM
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Sascha Hauer <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 5:12 AM <Anson.Huang@nxp.com> wrote:

> From: Anson Huang <Anson.Huang@nxp.com>
>
> The i.MX8MM pinfunc head file is located in DT folder, correct it.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Patch applied.

Yours,
Linus Walleij

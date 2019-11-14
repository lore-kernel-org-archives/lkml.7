Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3C8C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F2D206E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jmdHDXBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfKNMyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 07:54:01 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45652 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfKNMyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:54:01 -0500
Received: by mail-vk1-f196.google.com with SMTP id i6so344928vkk.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 04:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j7kaYv+E/e8ORn2Gy+9BvMNe/wGdZZ8Ltu87P0bR2PM=;
        b=jmdHDXBhhLyio2z3d9cvr0uOQLVHLSVGA2z0qYJ0zIbiAo2MFl8MKHWVLkO6Q1QBjI
         nEgVba6NRuH2arLCk89WtqyD60ns5PQ/ABDOj29hb9Ldw3HqqjxABeeBov79x0lCy3A3
         1dKSzwQ+rrK15q38Y4AZJkv1wJeEQQE/wyh055dPZMKFzbRoQEQqjSOOXd4jR6kS1ZVb
         WrwOQFRQDHK1xcO6unINH3oMoi8ffSUFg4rvPzydLnGNliXQw3cUglJv22pXKzItg+hp
         KhRV8uCAZVvYZNpVo6wgwcLJ8QMOvFZ967e8VrI1A7x3UCYcCbA9hboWp+nvxDWRF4UR
         FnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j7kaYv+E/e8ORn2Gy+9BvMNe/wGdZZ8Ltu87P0bR2PM=;
        b=BnlHSqu26vin98cn40Sdw6/FDHVjNnfmKuC/pS9rgmv3vka0tCP0fgABGqbCs08Wnl
         rgF4/F/ecjvIOHcxiX/veQpmo4NRGV0vNpErzxQ/sTUv33FcXd52PitawP6viZ/zX9qz
         ukOR3GR+c4bXSRRH9GfHNd2+USuPheq3nQ8YVHF70HnUh16WMRoaaAeaHvMqt59T9j/W
         Vw0enHpRP8RCpnyhlh/fxtORlWUMFUlsAI5kaGxn2wLTzSOiFA3l8q5KeXHrnk99vDM/
         1nK8Nb9tCNGJBacBjdAV/qeRYf6LYHIPaOlKiQvI4Tl1ZQw9YCkjhAb3mOs7omFijCfu
         teMw==
X-Gm-Message-State: APjAAAX1DhikC9Khm08Uj+j2RCJSx5FlwPmP+u86AFXmE5zaoj2+4Yyr
        0wRK9wOpztbumi3WmHEL5DaQY4IHLhHu1z/g7sM7Ow==
X-Google-Smtp-Source: APXvYqyqmcQFAkEm9m1Jnd6vFouVrLC+OhhaXGWaFFzu1LdB9oTyBPhsXXff0IBdvNsBO1U1ZdQHtW10o/YdvuxHcPw=
X-Received: by 2002:a1f:ee0f:: with SMTP id m15mr5092437vkh.43.1573736039900;
 Thu, 14 Nov 2019 04:53:59 -0800 (PST)
MIME-Version: 1.0
References: <1572949321-8193-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1572949321-8193-1-git-send-email-peng.fan@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Nov 2019 13:53:23 +0100
Message-ID: <CAPDyKFoL7oJ+2hvi77N9=1hBKFgCXRUppcte1u=eF4z+Fz8TQw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: add imx8m compatible string
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2019 at 11:23, Peng Fan <peng.fan@nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Add imx8mq/m/n compatible string
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> V1:
>  imx8mq/m/n.dtsi already use this compatible string,
>  but not listed in binding doc, so add it.
>
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> index f707b8bee304..2fb466ca2a9d 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> @@ -18,6 +18,9 @@ Required properties:
>                "fsl,imx6ull-usdhc"
>                "fsl,imx7d-usdhc"
>                "fsl,imx7ulp-usdhc"
> +              "fsl,imx8mq-usdhc"
> +              "fsl,imx8mm-usdhc"
> +              "fsl,imx8mn-usdhc"
>                "fsl,imx8qxp-usdhc"
>
>  Optional properties:
> --
> 2.16.4
>

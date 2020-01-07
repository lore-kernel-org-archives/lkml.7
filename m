Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AEDC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F370222D9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578436557;
	bh=BgA8C4OTAz+hxCasEQP7pvCyh/DwxtbAh1GUts8nezA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=F5bWnwt8lFQLsgqKSvcI3YKpJ7VQweLcYMgYoqzjGzr3aJlEnzqWAJEJOQIX34as/
	 7Ex8oSo7yriZoxIwNK1A3WmxY0Wh3LOS+M3hChvoDyJBHE3fdR4vhQ6vDitcuIBXQy
	 YtFjZs0KX2VsD7WtXMsP/Nkp0rOOA8lN8ADCv4Xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgAGWf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:35:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgAGWf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 17:35:56 -0500
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09C492075A;
        Tue,  7 Jan 2020 22:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578436555;
        bh=BgA8C4OTAz+hxCasEQP7pvCyh/DwxtbAh1GUts8nezA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yWOcJ4bv5iW4TRnYRgZGZ/BJs0qsGOFzjb8o7RBKqqrNguvml8lzupE1xJuIKaMfB
         iErWnLpwyYpb6/w875DR52n37uZOZ50MpkkmU6b1oda4BfsL9V9X4B05cj4e6y0NeY
         cbcUjXUTWOvd7AhemGfOZySLN4qSG1W1W5qGbZCY=
Received: by mail-qv1-f44.google.com with SMTP id y8so601497qvk.6;
        Tue, 07 Jan 2020 14:35:55 -0800 (PST)
X-Gm-Message-State: APjAAAWmUIUfw6jA/QWX0bqXgpRQxub0TRJ5Slh3xQm+cOvu+bpHwQhg
        XQ4R51rFN0W3KfI1KIvdKgP5/hhlJPyM2TyK3A==
X-Google-Smtp-Source: APXvYqzopuxiPCMInWh5xVv9RadZ1sApQkhglDfFUgmBFrCNOFhOQ9CLkzQ4agTXHKEgEAENe2y53m3p+ZuzT2OQ6J0=
X-Received: by 2002:a0c:f68f:: with SMTP id p15mr1502340qvn.79.1578436554153;
 Tue, 07 Jan 2020 14:35:54 -0800 (PST)
MIME-Version: 1.0
References: <20200107185753.28308-1-rjones@gateworks.com> <20200107185753.28308-2-rjones@gateworks.com>
In-Reply-To: <20200107185753.28308-2-rjones@gateworks.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 7 Jan 2020 16:35:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKYvJPJNdnEoADMQm_7zFUtF2vSZA90t4Us0tp899iV5A@mail.gmail.com>
Message-ID: <CAL_JsqKYvJPJNdnEoADMQm_7zFUtF2vSZA90t4Us0tp899iV5A@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] dt-bindings: arm: fsl: Add Gateworks Ventana
 i.MX6DL/Q compatibles
To:     Robert Jones <rjones@gateworks.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 7, 2020 at 12:58 PM Robert Jones <rjones@gateworks.com> wrote:
>
> Add the compatible enum entries for Gateworks Ventana boards.
>
> Signed-off-by: Robert Jones <rjones@gateworks.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 37 ++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index f79683a..9f73bef 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -154,6 +154,43 @@ properties:
>                - ysoft,imx6dl-yapp4-ursa   # i.MX6 Solo Y Soft IOTA Ursa board
>            - const: fsl,imx6dl
>
> +      - description: i.MX6DL or i.MX6Q Gateworks Ventana Boards
> +        items:
> +          - enum:
> +              - gw,imx6dl-gw51xx
> +              - gw,imx6dl-gw52xx
> +              - gw,imx6dl-gw53xx
> +              - gw,imx6dl-gw54xx
> +              - gw,imx6dl-gw551x
> +              - gw,imx6dl-gw552x
> +              - gw,imx6dl-gw553x
> +              - gw,imx6dl-gw560x
> +              - gw,imx6dl-gw5903
> +              - gw,imx6dl-gw5904
> +              - gw,imx6dl-gw5907
> +              - gw,imx6dl-gw5910
> +              - gw,imx6dl-gw5912
> +              - gw,imx6dl-gw5913
> +              - gw,imx6q-gw51xx
> +              - gw,imx6q-gw52xx
> +              - gw,imx6q-gw53xx
> +              - gw,imx6q-gw5400-a
> +              - gw,imx6q-gw54xx
> +              - gw,imx6q-gw551x
> +              - gw,imx6q-gw552x
> +              - gw,imx6q-gw553x
> +              - gw,imx6q-gw560x
> +              - gw,imx6q-gw5903
> +              - gw,imx6q-gw5904
> +              - gw,imx6q-gw5907
> +              - gw,imx6q-gw5910
> +              - gw,imx6q-gw5912
> +              - gw,imx6q-gw5913

I missed that there's 2 sets of compatibles here for imx6dl and imx6q
variants. No point in combining these, so you should have 2 separate
entries for 6Q and 6DL boards.

> +          - const: gw,ventana
> +          - enum:
> +            - fsl,imx6dl
> +            - fsl,imx6q
> +
>        - description: i.MX6SL based Boards
>          items:
>            - enum:
> --
> 2.9.2
>

Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8801CC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563DC215EA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIGoxNHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfFUOA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:00:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41709 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUOA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:00:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id s21so6060758lji.8;
        Fri, 21 Jun 2019 07:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HdPpqlE5KQOryOI+FWcAGSlfSeIeXjYoyYw5O4jWzks=;
        b=LIGoxNHDQCkPWYXbaamae5C9X8NCDUGNdSiwdnSAcKkGC4KheSc0mzoT1Cskr/yd3g
         Wr+SU7sDp7Tw4CZQsezQV5/q+W+jASBXRTn4tXM+mHtiTG6qGGoASTAURKHSApuJo8+9
         QSvN/nn5pFLhP5f1auMMhhQJOUwITRGQmUXw8MOjooFLqNZiGRoAfcCeG2jRn4wRla4B
         WOxnCjZpJj+JoxeuujISG7BfaNMLW8WNf+KRHTrtZ5JinzZaFhuGLfA64Tt0muspivH1
         zKh2eVkJotVuzkZGoS8ljYhrxU/37XydWz/dvzJeUU91iFZtbCmsHJOwsPRxLF+825bO
         N6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HdPpqlE5KQOryOI+FWcAGSlfSeIeXjYoyYw5O4jWzks=;
        b=sSSkcg59vI55eh/8HzeOHMx+4EDGQCY5O0OFTeIixRrcZHAAmSgFm8BvnM+EX2hivC
         /gcUW6zHgzXHN5/z6okmDSkYhyNMvYOPgVOU/UqQKa8fBIboJA9H+YRR6W9ollIHeTUp
         RNV6ezGMI0YAX+McEHcY/35atZqNWEFqYpkYwZyw40DmqOl8p7/9WD+ABDs/7xWHmmS5
         YIMGYTXOVEUuIXnu5LjzlmLV6JW508FqkDtpPSZgfOhp472QvVOQUHp+KwssQS5/7y0z
         5ZkWT+Yi+ZuYLngIbOKUgMo5/4RyAFwLdZygCMP+Gf1ICZByTuTkEXYmNhIzwL0S1d2k
         C7xw==
X-Gm-Message-State: APjAAAU2ANldyoJOCOIoHsd6+WHG7qUPl5Q3t39paaeR+zKSbte6v1x9
        8wgxXAY6x5CeTZX5nvC17c4mI338VV5HvkvFo6A=
X-Google-Smtp-Source: APXvYqzHIiebJqKGNowqGUaOStPrvIC4CDHyk3T1vJyUD7aGteNqYdBz5YnghaRqCjI8auZqhyn4Z6jZuR2Eayg9KkA=
X-Received: by 2002:a2e:8650:: with SMTP id i16mr24506131ljj.178.1561125624436;
 Fri, 21 Jun 2019 07:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <1561037428-13855-1-git-send-email-robert.chiras@nxp.com> <1561037428-13855-2-git-send-email-robert.chiras@nxp.com>
In-Reply-To: <1561037428-13855-2-git-send-email-robert.chiras@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 21 Jun 2019 11:00:42 -0300
Message-ID: <CAOMZO5DunK3+ovBd0c0X4NTf-zkW1Tjz6KgXFMaRQKMk2SBMiw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: panel: Add support for
 Raydium RM67191 panel
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Thu, Jun 20, 2019 at 10:32 AM Robert Chiras <robert.chiras@nxp.com> wrote:
>
> Add dt-bindings documentation for Raydium RM67191 DSI panel.
>
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  .../bindings/display/panel/raydium,rm67191.txt     | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
>
> diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
> new file mode 100644
> index 0000000..52af272
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
> @@ -0,0 +1,39 @@
> +Raydium RM67171 OLED LCD panel with MIPI-DSI protocol
> +
> +Required properties:
> +- compatible:          "raydium,rm67191"
> +- reg:                 virtual channel for MIPI-DSI protocol
> +                       must be <0>
> +- dsi-lanes:           number of DSI lanes to be used
> +                       must be <3> or <4>
> +- port:                input port node with endpoint definition as
> +                       defined in Documentation/devicetree/bindings/graph.txt;
> +                       the input port should be connected to a MIPI-DSI device
> +                       driver
> +
> +Optional properties:
> +- reset-gpios:         a GPIO spec for the RST_B GPIO pin
> +- width-mm:            see panel-common.txt
> +- height-mm:           see panel-common.txt
> +- video-mode:          0 - burst-mode
> +                       1 - non-burst with sync event
> +                       2 - non-burst with sync po ulse

No power-supply property?

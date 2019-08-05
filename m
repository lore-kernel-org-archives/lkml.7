Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4F9C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2C720B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkfMXok2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbfHETUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 15:20:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43896 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHETUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 15:20:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so10931571wru.10;
        Mon, 05 Aug 2019 12:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2TegqMOUww6ucAQOrDSmZWCD2zW1ZeQiYP4aaG1iBTk=;
        b=FkfMXok2gYOMBtgt4OD6EuQ0jE+LIt2r4qz2TX0fHBv5s7AytSW7HkI1NubsCzzdrq
         A7y2defmKDPD7FKTEEiYsNT6qIW0eYODGnnDuVtD5GAOoadvV3+3klUU54PLKK3vvGEm
         tdUGsmTAdQsqbF6lY+pC95nJhTBfffLyA2hN+RnDgyEu9UPV0WA6prW6MZGr65YXMIYy
         uAE8Mbxl8yOXU7cNesKbEemjRcBwMB+XrvDtlb89fw1AaGM87p9V0ecppUJlLV80Te2S
         rXutmSnPp3B2xY+kIBNG0I7+THQLLwyidmUFJLyCL3P4Ok2HR2lDa40SMdIQPFcUSv5A
         8G6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2TegqMOUww6ucAQOrDSmZWCD2zW1ZeQiYP4aaG1iBTk=;
        b=FhncErdbdTOnot61zo6OFh6YJy3/5GsrWefsRw/Ofl2PN/cA4BpO7p0eQAKot0Jsr3
         mgKwghs64XaZRd3T/6u1oCZuU+IQSD1JkBCsAzNZpCSAVKzPsBcTyBhYRdpYMQ8KPl2t
         brygTlAB1KMFO0IIs/i9ULjbYK4t9uAVUV8ImtVRcDwOndEfe+sqG/Qdy/23JNkvDRDK
         BqoPQ2jSrvBQg6YVVz+aX27g3ae+1GT5ayWw/dt4U/rfa3oRf7lXuyyD5QoubLfOvY3o
         Ebtwg0ZJYUduDcn2xHRYDwAS91ghbchKOW5D+4nhtSCfJyUFi6Sa18avULuXsb0Chna5
         UHSg==
X-Gm-Message-State: APjAAAXZlrb/+wfkOJuamUx+f3gUiXFtKydFBPCftoA5Sdmzv1/lyV+C
        Uex9MHDIcGxI+bxYtzHfIvIpvpmTvyLfyuEJU+Q=
X-Google-Smtp-Source: APXvYqwHXAfZFSv8+QZRn6k4uc291rKaB8dWSZ586h51aozoyd21jnfCOwffY0fPZxy79fpFQmcZFA4ZDe9XNkNDTwQ=
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr27385276wrs.93.1565032833619;
 Mon, 05 Aug 2019 12:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <1564980742-19124-1-git-send-email-hongxing.zhu@nxp.com> <1564980742-19124-4-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1564980742-19124-4-git-send-email-hongxing.zhu@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 5 Aug 2019 22:20:21 +0300
Message-ID: <CAEnQRZBHBzXGCAihRVpAT4LoUzrXbUWh53zzwM_7pNCesx55+g@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 3/4] dt-bindings: mailbox: imx-mu: add imx7ulp
 MU support
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     jassisinghbrar@gmail.com, Oleksij Rempel <o.rempel@pengutronix.de>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Rob

On Mon, Aug 5, 2019 at 8:18 AM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
> There is a version 1.0 MU on imx7ulp, use "fsl,imx7ulp-mu" compatible
> to support it.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

> ---
>  Documentation/devicetree/bindings/mailbox/fsl,mu.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> index f3cf77e..9c43357 100644
> --- a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> +++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> @@ -21,6 +21,8 @@ Required properties:
>                 imx6sx, imx7s, imx8qxp, imx8qm.
>                 The "fsl,imx6sx-mu" compatible is seen as generic and should
>                 be included together with SoC specific compatible.
> +               There is a version 1.0 MU on imx7ulp, use "fsl,imx7ulp-mu"
> +               compatible to support it.
>  - reg :                Should contain the registers location and length
>  - interrupts : Interrupt number. The interrupt specifier format depends
>                 on the interrupt controller parent.
> --
> 2.7.4
>

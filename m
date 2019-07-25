Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A05C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746AA22C7C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+/2hx5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387877AbfGYOLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:11:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45673 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbfGYOLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:11:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id m23so48072888lje.12;
        Thu, 25 Jul 2019 07:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jrNLPp3bYzLEDpFwB8WgHdHYREWfUZXv7BJCALM4nMs=;
        b=e+/2hx5NHVl51pt1NoaAoxtOSPUgJyMBrXs5dukRJ1aHbWbr/J+zpahxrXK3AgWKqf
         SWfpzTsD1VTIIL/Qay3uuk5XlDjRcihMMzNXo6umEyByVYASmGDPvndRWcis7ufx4och
         tu/PHfw2z1mk7WqODC9xEAeEY47OnalZSUBE9HEG8BR+Bq7Vuvra7Aa4FeOW3LweYqkZ
         /ie7cwtrsfgLO9UEYPqp9zk5WxuMh8X28QhSGeEP+L7jW5qMdvrZZuCy7XG07gdmn4lj
         wY6olIf2XlYDqFyJrpcLxCyHWe5oyMc/YrSsmY57AKlKb7H6SxFaVl2Pkbd11PH+5BLv
         xixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jrNLPp3bYzLEDpFwB8WgHdHYREWfUZXv7BJCALM4nMs=;
        b=E99etn3zEhEexjRtHvWBPthtL2iUGM8yC1jbw/ltdEulmov8+tNE5bb7P90tYr0Rgx
         uwh8sDcHsUgyTT8/iaJf+S55HcgGUmK6FovUewqSPXn46jaNkKXcdzCKPYnFI6ouX8Cy
         sRUKNQXmU+GwHygqIpJ9juCPW6MoS525F6bUKlbvVJjltNMGDEKhp+LvsXGs/8IjlKX/
         JBBp8CQOZGmaHqZE8Hstb58lYU2FwGcqi5OF8CsKfqj705HScNf/o+Pn1YPAycKX9dJQ
         uN0wJLNMhQXV9lT6R4PCFIgpzuEhzNunsaR2zbGxKtNQdP0GfG+JdowidO6LuzlWF/Xk
         Sx7w==
X-Gm-Message-State: APjAAAUEc8d/FA/r/M9AUuFA6KfvxBQXknAxrDAACrBLXJBj7rbBp9Fa
        wGmLeSJ4ZUf3pMX9ImhybuM9OHxq49SEbn9BeS0=
X-Google-Smtp-Source: APXvYqyZ2xU3Q3DBuDrKPPtRFmzwXjv7b2fsezBfSsrDgdvw3PESauQBwgujk6jS3/yZmnECnwmNvlSxES79Qhh42rw=
X-Received: by 2002:a2e:2c07:: with SMTP id s7mr9166631ljs.44.1564063876251;
 Thu, 25 Jul 2019 07:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190725121452.16607-1-dafna.hirschfeld@collabora.com> <20190725121452.16607-2-dafna.hirschfeld@collabora.com>
In-Reply-To: <20190725121452.16607-2-dafna.hirschfeld@collabora.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 25 Jul 2019 11:11:17 -0300
Message-ID: <CAOMZO5BWarNdbCc5eVW7TTO9ahkG5wMwX_3XXKkngzKcjk+mpg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: imx: add imx8mq nitrogen support
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Ezequiel Garcia <ezequiel@collabora.com>, kernel@collabora.com,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        Troy Kisky <troy.kisky@boundarydevices.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dafna,

On Thu, Jul 25, 2019 at 10:56 AM Dafna Hirschfeld
<dafna.hirschfeld@collabora.com> wrote:
>
> From: Gary Bisson <gary.bisson@boundarydevices.com>
>
> i.MX 8Quad is a quad (4x) Cortex-A53 processor with powerful
> graphic and multimedia features.
> This patch adds Nitrogen8M board support.
>
> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> [Dafna: porting vendor's code to mainline]
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 7294ac36f4c0..728c41ef83bb 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -227,6 +227,12 @@ properties:
>                - fsl,imx8qxp-mek           # i.MX8QXP MEK Board
>            - const: fsl,imx8qxp
>
> +      - description: i.MX8MQ based Boards

This line is already present in latest code as we already have some
i.MX8MQ boards listed.

Please rebase it against linux-next.

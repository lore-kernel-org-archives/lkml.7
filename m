Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9172FC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6925F206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zhr6f8EK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKUSWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:22:37 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37188 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUSWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 13:22:37 -0500
Received: by mail-lj1-f193.google.com with SMTP id d5so4349820ljl.4;
        Thu, 21 Nov 2019 10:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jRbXaossvgNQlopnRSIA2Yl2HFLcrBhDcNGtWuCOj50=;
        b=Zhr6f8EK4Z2+uO3VRrAu49wH9Z1Ee1FaYAYIQlmfxntGL2vEO3ij0WE4bwpZBAgbwa
         IVKPRtmfG1v+iL8lbrr+ONj97kMuTwZ6YzrMZwEppys4SWx3C8Bwrd74jdLlqK395CTM
         8Wu6/zcjsnaPXZiz89w5CRjWDG2QQA0szG40gJ86nLx2Yxt8emOQVYGfpClQNPo0qX87
         60RsMrs0Qc3PSZrVtRoOuq9OHqa90OySPob6VrX92Z7Oq1o6Oz81iQWEcG7XgSLRJwq/
         Gt5i8HW8n+jjK2MeVGRBmZU6LM6MljrsAzYbhQ5jK5awgWxIU+ceEQalxlLfy5k++wSN
         Sgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jRbXaossvgNQlopnRSIA2Yl2HFLcrBhDcNGtWuCOj50=;
        b=ssmiDbBN6hNa1Q9HnvmW8YQjn0Ya9gmsfZeWgboJSdZsCrP1iyAlctD0OSTzg5EXKM
         gNsciVONwJc4TQrfw9Wr8/MiHkcOUW50zAN9cXpLJY6D1+yfGErjUnkknitGuEf66xLZ
         0nJzpjH0EwgkdvWStF3jggVd1l0/UvO9K6jkHb1X20gJx7b9zD6GzthOpJaVjnTngDDA
         61bSlNopyhmm33Zai+hGz9LksHuAp3noJRaBf1NrASFQgR3VWzLs8TGaIrN7Q79J/Q9g
         lNEs63X9HkomzMOjSInXMKU9/OtZKXp0VjsP8pmBaIHbLdcWgOIZcjZLwgSkff/CNuzb
         g9cA==
X-Gm-Message-State: APjAAAXQQPN4z0w91lBMLkS+3VdNlxzmhJav9hFOb4JVuiMinvqv6FmF
        k3R8ANJ+88ie2MImzyIQ5PT94HmEm/+gsw4cS4E=
X-Google-Smtp-Source: APXvYqy33q+XRzz09cKmgzvK0eHNtVJV5yycdfRULgvmsv5bQhWkals2c0IdzhcxVervI3IIc5XNQaLA5auLBU2U0FI=
X-Received: by 2002:a2e:6e15:: with SMTP id j21mr8902410ljc.17.1574360554504;
 Thu, 21 Nov 2019 10:22:34 -0800 (PST)
MIME-Version: 1.0
References: <20191121162520.10120-1-marco.franchi@nxp.com> <20191121162520.10120-2-marco.franchi@nxp.com>
In-Reply-To: <20191121162520.10120-2-marco.franchi@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 21 Nov 2019 15:22:36 -0300
Message-ID: <CAOMZO5ByMkp1i=rMScgadT9_ucnsxqn_pnSP4bmLUPnxPdYHvw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: freescale: add initial support for
 Google i.MX 8MQ Phanbell
To:     Marco Antonio Franchi <marco.franchi@nxp.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcofrk@gmail.com" <marcofrk@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "atv@google.com" <atv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Thu, Nov 21, 2019 at 1:25 PM Marco Antonio Franchi
<marco.franchi@nxp.com> wrote:
>
> This patch adds the device tree to support Google Coral Edge TPU,
> historicaly named as fsl-imx8mq-phanbell, a computer on module
> which can be used for AI/ML propose.
>
> It introduces a minimal enablement support for this module and
> was totally based on the NXP i.MX 8MQ EVK board and i.MX 8MQ Phanbell

Please remove the "totally based on the NXP i.MX 8MQ EVK board" as
they are different boards.

> +       memory@40000000 {
> +               device_type = "memory";
> +               reg = <0x00000000 0x40000000 0 0xc0000000>;

The memory size here does not match with the one used in the Google repo.

With these changes you can add:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

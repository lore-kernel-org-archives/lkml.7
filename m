Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89075C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632D02231E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5lESrFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfKSSVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 13:21:21 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34168 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfKSSVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 13:21:21 -0500
Received: by mail-lf1-f66.google.com with SMTP id l28so8405609lfj.1;
        Tue, 19 Nov 2019 10:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0dUXKYCswQ0fk3ChDtCHMcNLvLahQKNVxckNHbLK62U=;
        b=e5lESrFN8MyoYepnYPws1P7yf4C1dXiYfMOkmezNqIXAiZCpH6SxlKI9ix3SlSORNf
         /5JsXZyp1E+IjqGqwMhUYHulRiSh9QJkMf1GIFQllRE77579xVcB4EDXytX2AWhcMFvQ
         1ksK6LpTugAMceaAYTPHCvwtSWDKN7rqeIueDTbWQtIHR4HQydG5oXkfTtYGFdaIoyjU
         CylOl88XU0mV6aCUOh7u/8Q+Yga6rgxzX3jS4Uzen0MivFUrqkq6uYhpdWXn0ASFSQew
         25whUzIeI6GQW/U3sk+CCl9AnoSAUrolJLK0fI3TEVzTWkTXjIjQqrrTPxWQjG7LKd5E
         juzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0dUXKYCswQ0fk3ChDtCHMcNLvLahQKNVxckNHbLK62U=;
        b=hFKk88AGKEQsXUJsQecvDfOHklYS+Mjvwe5VP0vgkVKiGMAUR+uuUXmifzMYyKuZGT
         6xpaGktrvldf96Ph0gnyCPFM2uurQOlwczHQD3XoxaJtlFI5qwL71kfYqdxh3+0yXBMQ
         EdU0UEK2fqTfyvO6Jj0fEgoBsRtoJAygewp7YnlxqEpCD+FpLEZ68Kz3wc4FW2hRV1Gw
         4WzKy4qCYyomJ0x3OKTMpbOQTbJBdpuOnrvVvqwcyGMU941nZVm3Pwmjqozdml+QtM/s
         HuAzObTURvwyfKZPOBKnUjMHGjxmaxrPh1nQrtMZJy2IUvZw74OLYqNQjpJct6KQGtDD
         aDqQ==
X-Gm-Message-State: APjAAAU3RGINO3AC5giwceh/QPBW0ZBvkK24IebAedRSNYFJIPEl0c/8
        35o9sFfF/+3bxRxsvFBIYDciFkbXteULQv273OeJ0GNw
X-Google-Smtp-Source: APXvYqzVzn1n+QdLBDwkgCKvCRCAJA5gUf/1Cpb09fd0k1gg5uwHXZcpoFJbgiH7FOKqOuf17TVa1Ixb5NlB5WAK620=
X-Received: by 2002:a19:4318:: with SMTP id q24mr5172404lfa.12.1574187679050;
 Tue, 19 Nov 2019 10:21:19 -0800 (PST)
MIME-Version: 1.0
References: <20191118152518.3374263-1-adrian.ratiu@collabora.com> <20191118152518.3374263-4-adrian.ratiu@collabora.com>
In-Reply-To: <20191118152518.3374263-4-adrian.ratiu@collabora.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 19 Nov 2019 15:21:14 -0300
Message-ID: <CAOMZO5C5gpW6KF9d-79wd=-7ZGAbXQLAXw3kLi+_5DBW_DYrTw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] drm: imx: Add i.MX 6 MIPI DSI host driver
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-rockchip@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Sjoerd Simons <sjoerd.simons@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        NXP Linux Team <linux-imx@nxp.com>, kernel@collabora.com,
        Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Mon, Nov 18, 2019 at 12:25 PM Adrian Ratiu
<adrian.ratiu@collabora.com> wrote:

Some nitpicks:

> +
> +config DRM_IMX_MIPI_DSI
> +       tristate "Freescale i.MX DRM MIPI DSI"

This text seems too generic as there are i.MX SoCs that use different
MIPI DSI IP.

Maybe "Freescale i.MX6 DRM MIPI DSI" instead?

> +module_platform_driver(imx_mipi_dsi_driver);
> +
> +MODULE_DESCRIPTION("i.MX MIPI DSI host controller driver");

i.MX6 MIPI DSI, please.

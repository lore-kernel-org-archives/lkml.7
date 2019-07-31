Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E4AC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AA7206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3eumO8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfGaMmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:42:37 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46762 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfGaMmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:42:36 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so65566333ljg.13;
        Wed, 31 Jul 2019 05:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2lttJaWeNAFLT7UvhBTaO2ZYIgG1MGHq7T2if8RJxqY=;
        b=B3eumO8eqQG3I1elp/UlpeHy3gdGRkakbE1GjKMxFWk3bvUUe9uPEbB9sZG+06J5a8
         rr01H8MKZ+WxGo7wlS7BK5nnhrzM/OTq9no8U/MnyCQrtE1bxF1i01z+klhdWrcD8Tbf
         BukMPo/nMLjtpBVOvQ1i5YV3nblWi/6o0JtOM3/SaPn/YvbRO+u+6whPWy1C+W5zTXPx
         YeDAEJRyKL0edCjh9T47qC6y4pTqgm/3vbdJqYYob91cEj0a2bkeplUxr67drYQJziV1
         1Dawb6/rrIpSsgj3XEvLaHV5T+Mra73DzWvmgwpQ9hLeXTsCehiERcld93GGzM3KH2YJ
         D8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2lttJaWeNAFLT7UvhBTaO2ZYIgG1MGHq7T2if8RJxqY=;
        b=P2NopaozEfPFrSnA9sKXr6dHm6MUHkhsg2un2/zXuLJ5pGwjBHqw2L6h+5Uvdh97IV
         9lg035/gsB3FLskwEUGldMTjn+iH/Kae69BK8eg0Jiql3NcsAsC6nAkzMtqwxzAEWcuT
         RjJCbS7VdOtccWKb6uhPr4ksU26YPmfd/t4pop8XfVFjDyYLvLwbjMqs1oKhhcTxYFiI
         cSNKSWWwotM4ab3hvsR7D8qGB/xfNR2aC6DG63iims8N33OxhF4OVloFwNU5q9H4XRYm
         mWms9ZN2rXkYT2JlRozyP/3M0zZ2oxa/BhDq7J0C0oYtQpjsHXyHsehMqiJVscIwm+DJ
         BtCg==
X-Gm-Message-State: APjAAAXF9xCyYj9Y3Ykiw8l+RySrSu87GEryglAj0UGzGnyZPbCuAhlB
        qVVewBdDsVMzNSG+WQkVsW84iqCLzSryfpMOIrc=
X-Google-Smtp-Source: APXvYqxx/q5CVs4/7M/DyQInpyLarIwQ6MN8cFZtux5bea54lDsZXckkTKqlUSKYccysfyya6bM+I3oV+spUzssUEi4=
X-Received: by 2002:a2e:8650:: with SMTP id i16mr64945835ljj.178.1564576954236;
 Wed, 31 Jul 2019 05:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190731123750.25670-1-philippe.schenker@toradex.com> <20190731123750.25670-9-philippe.schenker@toradex.com>
In-Reply-To: <20190731123750.25670-9-philippe.schenker@toradex.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 31 Jul 2019 09:42:40 -0300
Message-ID: <CAOMZO5B3BcpjbnsXuE5abX8YsuLDrkkHU=RBt6w_SpwuRkTvXA@mail.gmail.com>
Subject: Re: [PATCH v2 08/20] ARM: dts: imx7-colibri: Add touch controllers
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 9:38 AM Philippe Schenker
<philippe.schenker@toradex.com> wrote:
>
> Add atmel mxt multitouch controller and TouchRevolution multitouch

You missed to updated the commit log ;-)

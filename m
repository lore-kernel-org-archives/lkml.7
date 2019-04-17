Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83503C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42179206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGpkwt9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733265AbfDQTF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:05:59 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37648 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733243AbfDQTF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 15:05:58 -0400
Received: by mail-lf1-f67.google.com with SMTP id o19so15362690lfl.4;
        Wed, 17 Apr 2019 12:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8XfweZxs6pyLxC8hqbgl7TIoBJpOIwbzAiI6ZdSXbAA=;
        b=RGpkwt9rGCFsogQ4kGMJumGYoUi9wxlI52ENYZzyB/F9Z2p0Z0Q0nePCvkXDot22j9
         slmmvNV2I/qdfil4aP/hTvXyo09yEF/qCbdRdWMW4eLEz6KW+QzAKJXeYUFgWY9XbMBD
         pNfSdQXoEdViysf352bBAbR5DYQBYO/Vohti8nynT7MnWyPe+v5Z/mU1v8wvcPuc5P4z
         8iAV91EaTDdPqvaDis0ovlxd2aj/qgtTdaRYJYWuPR2TZBpMWoBthxyC2sBQqqiv7XkY
         DedT5oTzgJOI6ZPyS6XJqtihrk0dMah6LBTVIxAa+SNFnyfh/JMZZYjQxLcGbTr8AAJP
         fI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8XfweZxs6pyLxC8hqbgl7TIoBJpOIwbzAiI6ZdSXbAA=;
        b=TomCejOZ/dVJ32P7XQqG6EwnW/qXYvPZOui5UXeZ8t3pLmQJAfHLXujpwrbEKtGngF
         6Q0fRlZjKoJuiSPxaA4RiDP18EvS8coAzmcaS1gUEbnO/RPUiyC+2XdnPzpXnt+0Mj8d
         grHk5+eaIdigoQaZf/X8aaQDJ/VsuK0w5mwa7ST6tFC9+PkFGL8u4EUx5X3D55094H3t
         rS4S83ZWDS/hD7AW1Qh+h58hTmsx73iCPoIoMGbgm0HkwSLRA9uHFaZhUjwGPnisFmhC
         4fI1+bRsmXccl6DGIHRi7kvb1vLCekTpjNc9KuuDlkr7up2g6lMxT6uzpU0kjiXDlDuu
         xEEA==
X-Gm-Message-State: APjAAAUP/nsSGvrdyG8WDm//DPkUiMmoAoM/iYL1RN3NMpXVebbfgYW+
        bC+o2AZW4KWWUOYBUxE/+A+RnvYGG+5JDyHh0LY=
X-Google-Smtp-Source: APXvYqzSLQZnkWfNtlPN8ZSRNw8cviRwUxKZ+WdXSJr//BRJ7i864mAiJ2imrFqYDNaYGkeqqiEfYOrXrLJKxYr3g9s=
X-Received: by 2002:ac2:491a:: with SMTP id n26mr15910465lfi.122.1555527955997;
 Wed, 17 Apr 2019 12:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190417084457.28747-1-andrew.smirnov@gmail.com> <20190417084457.28747-4-andrew.smirnov@gmail.com>
In-Reply-To: <20190417084457.28747-4-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 17 Apr 2019 16:05:44 -0300
Message-ID: <CAOMZO5A6iw6FfUmWVYHH0Z9DHFpXdeHep3TDfvxVa+KK+-9eGg@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: power: supply: Add bindings for
 Microchip UCS1002
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-pm@vger.kernel.org, Chris Health <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Wed, Apr 17, 2019 at 5:46 AM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Add bindings for Microchip UCS1002 Programmable USB Port Power
> Controller with Charger Emulation.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Health <cphealy@gmail.com>

It seems there is a typo in Chris' last name.

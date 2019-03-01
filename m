Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C034CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 01:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8858B20842
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 01:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d77leMh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733239AbfCAB05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 20:26:57 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39545 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732400AbfCAB04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 20:26:56 -0500
Received: by mail-oi1-f194.google.com with SMTP id b4so18217782oif.6;
        Thu, 28 Feb 2019 17:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AkeUb/mA8860AiimzwK6cl7k1McwKlclTFc97mdiwOU=;
        b=d77leMh2kTO9FTOZmqZ1paJLC2T56AXAG4nu2gZbAbUqpJ3WILVU6v5Tj0Sm+3SBeu
         Zve5KCbWCR4MwwdgdxB+giQ3bXxfr8g9vG3l3nwflT7w2y1H2qSle0l9BYj5CxBHakAs
         7OuKidbYXUYGDnhqb9SzTlva8f4ehYnd1cxzHiGURquENVYrdF2gjYsn8p6C/yrFZluQ
         uR7Bn90sUh3yXwByTZYik/JOv9noARzbUTrC4n01ezylKmA/HP5l8JZH4hfk7vdAI47k
         ndX7ijH4AwpIvnERq98f5gB9YFogwwXyjJXH4R1VfrQYW3wMxM0WqS9hZog4aoEFYfFm
         Oprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AkeUb/mA8860AiimzwK6cl7k1McwKlclTFc97mdiwOU=;
        b=nUe0SQvQEDAJvqUQUxL/KFLT6aPPY0QrgEbIXSpsLmAoBwOIWUj/mk5VTZAYRIIyHU
         rEWa39Z6u03gIatqs9jOoIUE4VRXbG2qa3PGWvB0GUy/+QrXIYDk1MnM6Li3dmfYQUKr
         9JJ4EagVlMCj1fjmfzv9+c6yG0N3U95tB0Toi+6gCEx6sSohQpRM05rNgyu//8v0apIG
         yEhFftYqagrQfE380AkSrykSPfoxFmeSknK00q4TXmPlma2fRJIAGu/cdeJQSUiAzPj5
         nrULQPnPbZdh3IBjrETyhZx+jn8sr1MuajLsbf8Y/0Cntp+Su11Yqddpa/i5k6KWTu/A
         0QUA==
X-Gm-Message-State: APjAAAUJWkjFIAqQi1jwcNQk0KOONmatp3aEthsB69Y2MAvwOdk05Gue
        cxNOE8la45P/hr/ok8ts++PPdM4kSsq+UxczIGY=
X-Google-Smtp-Source: AHgI3IaquKQS0G5sDLHPQ3a0lRaafAADgSGpZsC2VuVIw0cevHwxYWjPR7JcsscDgXwu1Gb5Q7UH0TAX6KWQiHtTVFo=
X-Received: by 2002:aca:b5c1:: with SMTP id e184mr1741373oif.75.1551403615802;
 Thu, 28 Feb 2019 17:26:55 -0800 (PST)
MIME-Version: 1.0
References: <1551403185-16314-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551403185-16314-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 28 Feb 2019 22:26:47 -0300
Message-ID: <CAOMZO5ArmD6eSpQ2Mk20Oaw+n1fXQwJeAKeh=V=GqRjXZDVTaw@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] dt-bindings: memory-controllers: freescale: add
 MMDC binding doc
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:24 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> Freescale MMDC (Multi Mode DDR Controller) driver is supported
> since i.MX6Q, but not yet documented, this patch adds binding
> doc for MMDC module driver.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

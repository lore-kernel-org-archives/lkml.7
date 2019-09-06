Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C94C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 00:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E4B206DE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 00:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FFRoIBeM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391546AbfIFAYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 20:24:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34981 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389986AbfIFAYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 20:24:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so3061073pfw.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 17:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:to:from:cc:subject:user-agent:date;
        bh=DSzjso2AJLvfSyD5dg7v4lN+c7meO/zdU3rQw+Q3m90=;
        b=FFRoIBeM1oaZ3ljxrttUV2y0pgDtCbQwWEaXr3yRCXP/CcLiHji3lE20vNWTFjk1+H
         Oz7hxvsjoE/Bgguk1rlLH6A14k1Djc1cuPzxGWT9+BaB2EFh4APaKWwpX0ecHF4fYhWE
         YpVdSd3ULGedOfTCEHL8fXenyisAVoEGqgAFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:to:from:cc:subject
         :user-agent:date;
        bh=DSzjso2AJLvfSyD5dg7v4lN+c7meO/zdU3rQw+Q3m90=;
        b=LwB2a/6ieZQRUUO8gf9CTh7MPKSqGsHr1xY1wfgVeE1hos1wqBc+Jce6ndpgDE/sAV
         4lENBMG4aHq0dp0kHi3fEbyw6lz/XKA9Ttoni3HO8KFWc72JZ81gAsSWIwJcz1aEqeu2
         vU4q/9P8BS5L6K3S3fPMRD551T5KtjpLaaML+oy6F4KFxoRyJVQUorMFJUFNhoHLADSd
         s3+h8YSpGELmnJN3X8jhBO2q0diPvcDIB4atDED8xCfAbY8aY18AWtfIL9mJwPBDk9r9
         c/5cByCrMZddE0IVZ720XBFVdtcDG+maFLRAVFo7E31IOtZqa4CKfQFDPBxGe/ug0NC9
         McKA==
X-Gm-Message-State: APjAAAXLZTH7e576cSX87azWIbKiMFGvZAhDBR6ezGntaLlWGZ217xUR
        YeJE+9iktLBC51TaIFvePT3WLw==
X-Google-Smtp-Source: APXvYqy7ej8CqOzurKLhZUiScAimCJ0smbuorKW3l54k4ecoUYK5iivoA/lqIebdNU2zg5yPO7C+ew==
X-Received: by 2002:a65:5382:: with SMTP id x2mr5669447pgq.422.1567729461915;
        Thu, 05 Sep 2019 17:24:21 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k14sm2937689pgi.20.2019.09.05.17.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 17:24:21 -0700 (PDT)
Message-ID: <5d71a735.1c69fb81.8f334.825a@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190829181203.2660-12-ilina@codeaurora.org>
References: <20190829181203.2660-1-ilina@codeaurora.org> <20190829181203.2660-12-ilina@codeaurora.org>
To:     Lina Iyer <ilina@codeaurora.org>, evgreen@chromium.org,
        linus.walleij@linaro.org, marc.zyngier@arm.com
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, mkshah@codeaurora.org,
        linux-gpio@vger.kernel.org, rnayak@codeaurora.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH RFC 11/14] drivers: pinctrl: sdm845: add PDC wakeup interrupt map for GPIOs
User-Agent: alot/0.8.1
Date:   Thu, 05 Sep 2019 17:24:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-08-29 11:12:00)
> diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom=
/pinctrl-sdm845.c
> index 39f498c09906..5f43dabcd8eb 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> @@ -1282,6 +1282,84 @@ static const int sdm845_acpi_reserved_gpios[] =3D {
>         0, 1, 2, 3, 81, 82, 83, 84, -1
>  };
> =20
> +static const struct msm_gpio_wakeirq_map sdm845_pdc_map[] =3D {
> +       {1, 30},

Please add spaces around the braces. Maybe you can have 5 per row? Would
make it a little more compact and still easy to confirm.

> +       {3, 31},
> +       {5, 32},
> +       {10, 33},

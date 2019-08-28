Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FC5C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 00:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B78E21883
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 00:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iTFhK8ta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfH1AcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 20:32:24 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:33416 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfH1AcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 20:32:24 -0400
Received: by mail-pl1-f174.google.com with SMTP id go14so359413plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 17:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=rRH/oTtD3I8IIyF+9ud7/7W7Zdl189HtmJUsrlGsRtc=;
        b=iTFhK8ta3SUOBZEzLh0hSBhpRav6zxEilbiZQBtkE3bi9j5CcgtM+UA1NEDLyZxlM/
         izAbHfrXvgyUHqIs2PkHmmv4qvC5s1mQ+n52vmb5YHSOhFmqgomb+HUMBbJhSL2cDZQ3
         OeLyPNDMIEdjfCCP5aV9f+kuUXuzaWppq04fQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=rRH/oTtD3I8IIyF+9ud7/7W7Zdl189HtmJUsrlGsRtc=;
        b=PQxUNEp6yQJUVg9P30sdhboQclFPtZ84iZ02afgyLz1UJrCYEdWySN6Y8d/ipcOY0Y
         Y7S/61VnvgveQRQBkp5IElvmB7BCjarVI8MJsXYUOeL4mP4wQCIqKAfENH4Pdzt/19ST
         uwnKxG1dRMpquUudWvWayrnP+pMbUqC80uarp6jEATRxX1SDLjsIMZuLEV5u+bIkSvDp
         NCo7GXBjaFSDPAR57go3zKfDlFKU8MW8mDmRuCdW2Ek2FwGM1xCV5HYis/xzUCObvwrP
         ORIDfhlUnVEIUyfTULP8bWj7HIL9nnpHCMHWXObuIh16cGH/nBilGsvTMOfd2FEj7KR3
         TApA==
X-Gm-Message-State: APjAAAXquLhVQeRdljEgQWQAZ0P3bmSgEtjkFX/VgZGZwNqSVKA/NXOq
        F1ENKlPvQDIAWVIhU+IMnFaHYw==
X-Google-Smtp-Source: APXvYqwTf7ms/JWpe3OBFYi+xb8boCkEOe4dk+DzF8IONxKvMPJqjevptKlFAAuwbZm4fRRbUdagsA==
X-Received: by 2002:a17:902:6f10:: with SMTP id w16mr1535055plk.143.1566952343304;
        Tue, 27 Aug 2019 17:32:23 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b14sm504174pfo.15.2019.08.27.17.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 17:32:22 -0700 (PDT)
Message-ID: <5d65cb96.1c69fb81.2e8ad.2450@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5b26d4410b50387fcacae939d97f9f75853e69ea.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org> <5b26d4410b50387fcacae939d97f9f75853e69ea.1566907161.git.amit.kucheria@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: Re: [PATCH v2 05/15] arm: dts: msm8974: thermal: Add thermal zones for each sensor
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        marc.w.gonzalez@free.fr, masneyb@onstation.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Tue, 27 Aug 2019 17:32:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-08-27 05:14:01)
> msm8974 has 11 sensors connected to a single TSENS IP. Define a thermal
> zone for each of those sensors to expose the temperature of each zone.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Tested-by: Brian Masney <masneyb@onstation.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>


Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33049C3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 23:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F243820679
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 23:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mzfyNIBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbfHUXkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 19:40:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44881 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbfHUXki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 19:40:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so2220964plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 16:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=PdGmstYjj4UcbwNUp869OtVuxov1WvQjhoAxWHt7vJo=;
        b=mzfyNIBHNRCTGRIjuIu6tTYOToZwmVVnG633lROYmZz407Fg369qEh433GRk9g46qr
         qZET8vlULsVr/1I0eG4WGKcI+worE3kCeP24qFF+KIORfCcaQs8wyob4PbLoMIm1XpDf
         WanKKGUVelZOnpW4sKm+nFUXJMthRLptAYWZmioldfobL4WbEeKjQzxZq4uhY3SxNFuD
         N3vUAk0TwaNsSApmgBV3FFc/UXPQrBiGaG02+d+yUDGbCdSRiN8TghsG86TSNeadztFI
         cT9z4ZPH3G821E42COUqMezutD91ivm1ulCeE0SkybxPehAzaryyXVVOA6mOBtYcSZOu
         pVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PdGmstYjj4UcbwNUp869OtVuxov1WvQjhoAxWHt7vJo=;
        b=t+hA98yrhtpiTNYhLnuoxWsNzfkxmMyYnLQH/YTCMJk6KAsGeNX2VLjvpqD38ldCid
         1tvo2wQEm/iMcPgRUefJx6O0tjuO73rUJvykQuynO1X1d2Irv93rDfVtIGdNrs04Wut+
         P0HkRab1NKQHegEMg4DKCvTmFE57ayNlYV5IeFJCri3Oe3LHiv23YYc2EXIqSSwUOYUh
         dCPiWKgvbyMMzbQNcFVZ86BNlHmTbfQJVMESULlesf8Hq9YpMRu7+2h6wx2aMF+um3NV
         zZYyIMKLtFxRHm+/yvwfilsquTl2Sney8NOq/9ZaWkcuQrRn3UoS1+2LBQhRrzVZWKCK
         gGGw==
X-Gm-Message-State: APjAAAUE3DVI/1jNdktal2oAnMXdjMhTKDC53sKVU8Rgv89Sk+6qdhRY
        sD+p8BycPkrYUOI7NT5o56ZPSQ==
X-Google-Smtp-Source: APXvYqzBpl28fBuk/sy46hFZ1+kwlWBC/dMV3X0jeBb3i46IAc+BgSafaFw9tf/2hKy8B3vf8N/ceQ==
X-Received: by 2002:a17:902:e592:: with SMTP id cl18mr5064788plb.291.1566430837336;
        Wed, 21 Aug 2019 16:40:37 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id e17sm1122052pjt.6.2019.08.21.16.40.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 16:40:36 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Guillaume La Roque <glaroque@baylibre.com>, rui.zhang@intel.com,
        edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v4 1/6] dt-bindings: thermal: Add DT bindings documentation for Amlogic Thermal
In-Reply-To: <20190821222421.30242-2-glaroque@baylibre.com>
References: <20190821222421.30242-1-glaroque@baylibre.com> <20190821222421.30242-2-glaroque@baylibre.com>
Date:   Wed, 21 Aug 2019 16:40:35 -0700
Message-ID: <7hef1e5bpo.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume La Roque <glaroque@baylibre.com> writes:

> Adding the devicetree binding documentation for the Amlogic temperature
> sensor found in the Amlogic Meson G12 SoCs.
> the G12A  and G12B SoCs are supported.
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

nit: put your sign-off at the end.  The tags you collect from
reviewers/testers should go first.

Kevin

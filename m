Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D211C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6340B21783
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="e1POAryf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfEIRfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:35:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38685 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfEIRfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:35:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so1562512pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 10:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=zX74GvSVOEa3r9Bsv+StbAMT/sdno07qDVSzxK/DkMM=;
        b=e1POAryfWOAkgAo7r+nE7m/OBxAvTUNZneYzdM/CAG/P2iw7nP6MVlZbhlm2mXQNf3
         6pnpb9xETfdJ1oRG94kw4lxgas2VviA3Lt8Z0IOpwQ3f6P/zowtru1v7xUIkLFCDE5Vw
         YWIIu9MwWy0bTxDqZKCXLpioP8lRzzG3U6iH46YK4k73AAjPUobuk1a5zHIMe4SJ0eRV
         dpUSo/mXt6X7t68d2AznkwJqO09clJ50Q7hlIe0Kt18SpWIJ8ogKEapQGigaD+9UbXXb
         m9hL9XvifvxTrI0LSy9pnCA/yRUZXF4hlWX3XRLhTWFg841BJWZs0bdOnxL7yGDZ31oN
         wWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=zX74GvSVOEa3r9Bsv+StbAMT/sdno07qDVSzxK/DkMM=;
        b=PUEUHWQF+HkIQEHKAtFWpu807zeXHJnG1VMp/xfK764bZ6C2Eg8ev9wnttpyr5a5zO
         keSfXYZqzE5Ecy/2nnEs4u044nUAsZ3QSl8FENgYeD+xiynC8bXneOborZp8sOcMFhZk
         czUgcIGcZ+rffkqYpYokYgtAVK9X6RED4QSfwWINgWfK8QxZol91siHpeT29wcydP3XW
         ZUOrmz1GN8LWu49BLOemAI70jHulviOopnqV2z9TVT1uVYYd+TgAIFDIlM3IfNo2C0qM
         e795lbOTVRLSaP0fHfv5ga77lwaA+qRz/oySL5fY4KP96TC0uNlMDRuTsboUf6cYP5MQ
         137w==
X-Gm-Message-State: APjAAAX+Ovw7bCSl3MevBXZZQX9OkWQ+OeP9veRQsyHH3ftOE3AN7kuL
        xXkm1Hu+ZGa0HORPdJUtzGFGXQ==
X-Google-Smtp-Source: APXvYqwS7WimrfI1E3YNXr+sXRr9qBkaFQ0XqpEKS/H76BcklmD6ZZmvCasxKn1QPxA/n0YZ3uRJOQ==
X-Received: by 2002:a63:ba5a:: with SMTP id l26mr7236440pgu.183.1557423312287;
        Thu, 09 May 2019 10:35:12 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:7849:6889:3e03:e97c])
        by smtp.googlemail.com with ESMTPSA id j32sm3288300pgi.73.2019.05.09.10.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 10:35:11 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Guillaume La Roque <glaroque@baylibre.com>,
        linus.walleij@linaro.org
Cc:     jbrunet@baylibre.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] dt-bindings: pinctrl: add a 'drive-strength-microamp' property
In-Reply-To: <20190509162920.7054-2-glaroque@baylibre.com>
References: <20190509162920.7054-1-glaroque@baylibre.com> <20190509162920.7054-2-glaroque@baylibre.com>
Date:   Thu, 09 May 2019 10:35:11 -0700
Message-ID: <7hzhnvfs4w.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume La Roque <glaroque@baylibre.com> writes:

> This property allow drive-strength parameter in uA instead of mA.
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> index cef2b5855d60..84adce9f2a75 100644
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> @@ -258,6 +258,7 @@ drive-push-pull		- drive actively high and low
>  drive-open-drain	- drive with open drain
>  drive-open-source	- drive with open source
>  drive-strength		- sink or source at most X mA
> +drive-strength-microamp	- sink or source at most X uA
>  input-enable		- enable input on pin (no effect on output, such as
>  			  enabling an input buffer)
>  input-disable		- disable input on pin (no effect on output, such as
> @@ -326,6 +327,8 @@ arguments are described below.
>  
>  - drive-strength takes as argument the target strength in mA.
>  
> +- drive-strength-uA takes as argument the target strength in uA.

s/uA/microamp/


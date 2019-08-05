Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353F4C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 21:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EE82086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 21:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RYsmyURo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbfHEVXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 17:23:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44618 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbfHEVXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 17:23:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so40244105pfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 14:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=HSmoEp/ziBaJEwse1a0IgnFQRWhZvjEvYtd+aetfTSk=;
        b=RYsmyURowgYjpUDb5ZIOXfn0WP3QsStZ/1uQEgQmPgOol8mkIRe8+9P5OEafLEeiYt
         Z6RBz65k5km+Lzt82HrTM1fGDCgHTGldzrZoKygIekf6Yksg94J+Ga8KNpYKt1xicvnp
         CkFWTQm14jHJd+HaS7tw0u10ibpRAlUozKxFP8b7CrzyTiXmli2xxYEMY4sBKWM9isui
         HpsZJNaaz4R58Z0sCNFfp47Ryqg7JlHH017DylL7Tteb9Mt2f7EUa/ZSD6jzc+Ie1Eyz
         ysVTifrLVw0OlKVH0TEUUOkWPScsNBr5wiObjKfZLRIVtE80xRp/qWNYWNXwdyJj49vf
         LCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HSmoEp/ziBaJEwse1a0IgnFQRWhZvjEvYtd+aetfTSk=;
        b=bbwpxmRQb/z1x618HEK0/KpIIEJPAirqJuVPYbQdJze+ns3jZsMjcerCLX1ddpEYgG
         8BVkXSgifYLcpAHaBXcKTIH6GseYhm68hDh47Fa4GgDkNKHRxwoRF6wSqqEZP1OHuDCX
         L9xlanY8Urf+dasbmzuYGobaHbSGq7Eez1G1SCZ6pRWB/s+xPXbJypDh1tQmQKL26H/Z
         hCNW3hHj/mO0VWJZM576rMqs2WpEjFK+q2KVtGUINP4bchsTojBic7taxMOWL1YkKfUg
         ZL8xgVCD6DZK/zZxR8WtXQmzANlztF+JoDAZWI1SxV2WbT2l/WndIl7CHnZLPo+2wUCB
         dFbA==
X-Gm-Message-State: APjAAAWjcPiINmP93ACnYH1NHha+MDYbUKagZSLyjXssFr/xeKZ+UWR6
        IVCIhH6BkWC1MLWNSQbF/tugVQ==
X-Google-Smtp-Source: APXvYqzGhD1zDypW1mivoRqjSzY9R2U5h7sDfLfd2LohUb5Pzua5KyGy9CGK99REHRRiokWBGH7BwQ==
X-Received: by 2002:a63:6106:: with SMTP id v6mr21815264pgb.36.1565040202848;
        Mon, 05 Aug 2019 14:23:22 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:7483:80d6:7f67:2672])
        by smtp.googlemail.com with ESMTPSA id m13sm28025691pgn.57.2019.08.05.14.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2019 14:23:21 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux.amoon@gmail.com, ottuzzi@gmail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 0/2] ARM: dts: meson8b: persistent MAC address for Odroid-C1
In-Reply-To: <20190727194647.15355-1-martin.blumenstingl@googlemail.com>
References: <20190727194647.15355-1-martin.blumenstingl@googlemail.com>
Date:   Mon, 05 Aug 2019 14:23:20 -0700
Message-ID: <7hlfw7gvcn.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> This series makes Odroid-C1 use the MAC address which is programmed into
> the eFuse.

Queued for v5.4.

> build-time dependencies:
> patches are based on top of "ARM: dts: meson8b: add VDDEE / mali-supply"
> from [0]
>
> runtime dependencies (without these a random MAC address is assigned,
> just like before these patches):
> - "nvmem: meson-mx-efuse: allow reading data smaller than word_size"
>   from [1]
> - "net: stmmac: manage errors returned by of_get_mac_address()" from [2]

Looks like the nvmem patch isn't queued yet, but AFAICT queuing these
will have no adverse affect.

Kevin

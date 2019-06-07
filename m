Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE14C468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0862020449
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZaRcvhRJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbfFGWbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:31:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39470 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730078AbfFGWbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:31:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id 196so1862643pgc.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=DjeIfF6JVcOuy3AfVkOGht8864fNBaz7bDSsSWoX9TU=;
        b=ZaRcvhRJt+lWFHNijIWNhrnilHwAsieAqy37yaaaiRUxylGw+20sUHDgYTvLwZXoLQ
         7Kz8Wr0w2D1hgQgm8qwXPISrC/NsfiVyGa0Ays+kZ12z05H2xaVjwsSI54FDH+4vgaXb
         DKW2YYHK6FYOHtehJJ7mwFSm272oTXDX/+bKAqtSKIHNTP/1Yc9ts3dK6dNVo5AmMRQu
         RVMEHaN2lksBao7riU/CVRglNW5yVlvDzQVHNpypOeXl6E0z6nWrOK4bVmi0ee634i+h
         U07KQLErwYvKttiJYrkU8RURfL/zNKTY6JyTWFQVTLRM2wWnJUmoAFJYBxrCQoHjEX6q
         g3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DjeIfF6JVcOuy3AfVkOGht8864fNBaz7bDSsSWoX9TU=;
        b=Wkdlp5If3RRDu9MhnkXk3DzmJYFsYKraoRwtcpVi6g/7f8CdsjVzv4tmKYdazmkqEb
         F4nazPoAdg6n2fwyFEdZJP3XOHFzKpUCF7YMVhTGUkvef/3GeIzzEDrrZk9nWnLXhkEa
         V7TzNosD6ZgoxTEL+Pxl0qzhkNp4KNbgPHMH+4mdikygRHJ8K3RmFv0iUIsCXpm/fLnH
         tQM2779lfTqSyqRbKf8nR60BgNf9HurzDUK23U6+uIL3kmj0RfPUZlNXqOe97OwEbZPP
         8v9iD4jPigDcrg7WxQkxcXiCT2XZmRu0HEpSg/qN4soaXpuesF566PzN5SesRHXq4DSK
         vs7w==
X-Gm-Message-State: APjAAAW/EBVcmPkTgWLGTjGuLI2ESSInfuPV9v3M0yuKL0YgBlMi2PaB
        QeZKx+GIMvJOO6r000j8bgFLeA==
X-Google-Smtp-Source: APXvYqy1arVJLueel+cI+iNSxrU0sdtYKURzlXY9sOv3HhCRaoXzJNw0gelleuoSn1Mvz1PB8ZaEkg==
X-Received: by 2002:a63:514:: with SMTP id 20mr4976382pgf.272.1559946676909;
        Fri, 07 Jun 2019 15:31:16 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id ds14sm2846230pjb.32.2019.06.07.15.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 15:31:15 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: meson-g12a-sei510: Enable Wifi SDIO module
In-Reply-To: <20190607144735.3829-4-narmstrong@baylibre.com>
References: <20190607144735.3829-1-narmstrong@baylibre.com> <20190607144735.3829-4-narmstrong@baylibre.com>
Date:   Fri, 07 Jun 2019 15:31:14 -0700
Message-ID: <7ho939auz1.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The SEI510 embeds an AP6398S SDIO module, let's add the
> corresponding SDIO, PWM clock and mmc-pwrseq nodes.
>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Queued for v5.3,

Thanks,

Kevin

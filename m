Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A088C31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E99221721
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OWHL9uXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408156AbfFKXcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 19:32:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42646 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408126AbfFKXcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 19:32:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id l19so5215718pgh.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 16:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=n4utO1qIjYj4MGuS7hIfGXs+tpiAYsWzBnQD5g4fpBU=;
        b=OWHL9uXMvXBp4WyP6XbYf8ngdd9BOGYtfKlznowe2eZXC8BTT87VlB0/rYBBnjrDKD
         pvCvc3dKtXEt2ccEl+5tO3LuvjVUteL52BK0k4m/G6hGBfSyL8JdLtXGCfGhVgHD5/hZ
         zXTEVipfe5LP1ChUjH+6SDLz2sScHI72x/NfbZmtV1mznhwunG7ogeC3xqpQwsRHsAud
         Lr6bHi0YxzMX7vIUYMvbbg/Bvcxz7PYvRK3hGd0DnhD285skUhCFS+YNvY6WycsnwuwC
         SLC69nfTolSPUMIXbkdaINLayG9V2CC1rDYPMC2S1/r0245/ibabd9IxaQCT86cP1u2D
         irpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=n4utO1qIjYj4MGuS7hIfGXs+tpiAYsWzBnQD5g4fpBU=;
        b=FTrme1QryGlnQT+H6MosLyypAzpDFHmpt7cMu61cInJDA71ds1NVvqCMZ4ctZn8a2l
         9uz9UIHeHzCgMsdHC8aNUpZzhzViZb0hXCtwsolYF5wiycSa43H1Z/thUqT0O3RqURmK
         yWhFdLS7YpVDBc3FjymS9F3K8VZbwyGIkrIBLt4oAS0NdtGlqn+tnT6vckrE9i6YPVMx
         6diHlZeawGABFA77cZEMHw78TlFrA8XUA04dayi3q7m0ap/9hlsR1t27JnmsNiGkRSZu
         TyV8ERBO2awEbH32gEq0YWEdZKRmKZMruTT1RMJOoR4t5UxRtvK2znatGDgufXLtagM2
         XsZg==
X-Gm-Message-State: APjAAAUUFRdQ2HKgUjoBAHOHI5joq6ym9jFQgaPNlC2l8UQG47Sry6L/
        kN6SxpjGFMmsZjTBC+CvcdOhsQ==
X-Google-Smtp-Source: APXvYqwWX/bN3QMS+ZSVHnHRL4KnDn8A/IIaaCNAM7jGCzy6OnJYRwGBmJaNVgi34cIXq1tip8qnTw==
X-Received: by 2002:a62:d0:: with SMTP id 199mr51540334pfa.253.1560295931319;
        Tue, 11 Jun 2019 16:32:11 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id w36sm14250463pgl.62.2019.06.11.16.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jun 2019 16:32:10 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 0/4] ARM: dts: meson8b: add VDDEE / mali-supply
In-Reply-To: <20190525190204.7897-1-martin.blumenstingl@googlemail.com>
References: <20190525190204.7897-1-martin.blumenstingl@googlemail.com>
Date:   Tue, 11 Jun 2019 16:32:10 -0700
Message-ID: <7htvcv3dhh.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> EC-100 and Odroid-C1 use a "copy" of the VCCK regulator as "VDDEE"
> regulator. VDDEE supplies the Mali GPU and various other bits within
> the SoC.
>
> The VDDEE regulator is not exclusive to the Mali GPU so it must not
> change it's voltage. The GPU OPP table has a fixed voltage for all
> frequencies of 1.10V. This matches with what u-boot sets on my EC-100
> and Odroid-C1.
>
> Dependencies:
> - compile time: patch #4 depends on my other patch "ARM: meson8b-mxq:
>   better support for the TRONFY MXQ" from [0]
> - runtime: we don't want the kernel to change the output of the VDDEE
>   regulator to the maximum value. Thus the PWM driver has to be able
>   to read the PWM period and duty cycle from u-boot. This is supported
>   with my series called "pwm-meson: cleanups and improvements" from [1]

Just FYI... unless I hear otherwise, I'll wait for the PWM cleanups to
land before queuing this series.

Kevin

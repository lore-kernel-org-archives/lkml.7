Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4351CC33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 18:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1029D20678
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 18:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hpES8SdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgAHSw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 13:52:57 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35633 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729362AbgAHSw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 13:52:56 -0500
Received: by mail-pj1-f67.google.com with SMTP id s7so14549pjc.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 10:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=hCOCHoRkkp5UhkO13eAqohn7PL1ou6ER+9SiJJ5LA7k=;
        b=hpES8SdR9Uct+j5WAd8zNLCHlHLI0Dpp7FDalu+Q8dq7QprTl2szIsh+6DBrWb4NNz
         xRrBGudrw+X/Ehs59ly2N8d8DSql+Fw7Ppwdjr4XpX75C+4sgM5xKFuqbIkO+z3QChEl
         iQYQ0JNOqgh+OuuWj0mFms7QubXPP6Q/OqvExcsyRbIwKARY9jgHP2914Gc3gDTgacjJ
         CR7FlFxLhEsgcA9/zQ4FxzryADWNeNR+68ozE/oMrV3BXa3+q5U8PWFc9AiE31Wd81R0
         25Cgh1ITcxRibM6EOVZlV9vd99Nz5cGzZQ82KxKqCxpzlKEY6ZSH/lut8bdb5+a1U84z
         Zw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hCOCHoRkkp5UhkO13eAqohn7PL1ou6ER+9SiJJ5LA7k=;
        b=Cemh4Gi13HpKw34dzPQBrgHKXrRefNN/xM+jgiUt3L9/K8HzPHmP5ctdnc0hV2BnGv
         2A8L2YePFoW7GPmMhuNxndUYTz229PE6sdD2sfilelMV2KyI+zCQ+FIMokUpSy6ttoEn
         LcEvfcdjJupnWIHx/CWG9/fQ4l4uFCNav1CW2QD8+UmL/xYWhxK73l1pb63jOgqzHf19
         iV3l1xoB/1EuagB00NBXPsKXtBt8DxtOZfd/We6CBYs9BJ/Y4z7f54dvUsbM4pW2/4df
         qEElnEK4UNLbSEsZT6ZDmujGTjODxqelcRNWpDBoIhbmG1fCcr1Nl+z6i/+ZfSvUfuq6
         BWzQ==
X-Gm-Message-State: APjAAAWxs1FsJntMNRKuc1LioM8QOVmyeW4vLtNIu+hkkn17W9qr916n
        V2uPzPOotlfCKN/HtC0hFBl0/A==
X-Google-Smtp-Source: APXvYqyaHwgFqHkdB1vUFNMuHsw49pWnr1JXRS+Ome1dK+LyPoCS43sUUsv8UcMPR7AbUHvBPCKp0g==
X-Received: by 2002:a17:902:34a:: with SMTP id 68mr6646218pld.250.1578509576062;
        Wed, 08 Jan 2020 10:52:56 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id m3sm4429923pfh.116.2020.01.08.10.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jan 2020 10:52:55 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: add audio fifo depths
In-Reply-To: <20191218202452.1288378-1-jbrunet@baylibre.com>
References: <20191218202452.1288378-1-jbrunet@baylibre.com>
Date:   Wed, 08 Jan 2020 10:52:54 -0800
Message-ID: <7himllg4qh.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Add the property describing the depth of the audio fifo on the axg, g12a
> and sm1 SoC family
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  Hi Kevin,
>
>  The binding documentation for this new property will be merged through Mark's ASoC tree [0]
> [0]: https://lkml.kernel.org/r/applied-20191218172420.1199117-3-jbrunet@baylibre.com

Queued for v5.6,

Thanks,

Kevin

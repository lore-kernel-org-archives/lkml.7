Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0622BC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1F02173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jSm5ZYDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfEUIIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:08:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34711 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfEUIIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:08:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id f8so11035192wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 01:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=06+DCEbyMY34D3BOjzKRvN7V1nIU5XaEGS8h9soAWyg=;
        b=jSm5ZYDHwpEZV6Lzr77c04c2MsvRIb8GM2tdOjIu3a2j2Kuvh1LWiDWnldvzLDlnBj
         HPNkQsMMobx1yQDQdatXHtT/9sX8GU5yKkLkVHTt0+p3194e/HDjg1nkNJ7XKxTEGBga
         EcdX0Gfgcbm7mFDeTcViHTODqK/m48MVMH4N3DoATpMRcUxtLdFW1jVevWos//50lGmt
         0K2J4UrYGQVYEM9PI67EJdGFvRMoJKYo7J4Ki8Pz132sHFpC62odL2CfXsm2CARdgey7
         WOCYjTdhVfor+T3w+k4roiYmD3KjwBpH4OaDtikgsMElU8vUvadU2JYcpC3mlr3miOh4
         +NTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=06+DCEbyMY34D3BOjzKRvN7V1nIU5XaEGS8h9soAWyg=;
        b=SRhncexb87q4G1TCLeWJ+fonaE20kRnVT8L9r5JiM3KRbVp366xzDcDod7BGqcwjvH
         NO02lp3lv2ZZnzpMhsaZ8z+ahzmefR/b/X8wKmhMgdvjbbdvx9ZgMR1bljSyXTdj1NDH
         Fnhn0z7SS5FKba+e4R1FgBcJIqdwTuTVTvHO3FTvalz5/ursW/wj2eikkDAnxjUJZFBn
         1ZLYRVfzXINlWJz77daoD4IKZMhUuZaJjh8BQB51D8MxACAuITn3MH4WQmKtOCqmKSxw
         1NFysYUxoIFpnrc9WUT51pAFiHFxpmTX1nEhRXBiLX+axuHp6u5tNZ7IrjpWRVtCAyIq
         nZKg==
X-Gm-Message-State: APjAAAWkwAXGWJiUURj+Aja2eyYwYTAUDKupPupjtHecLt3kagpWbZDV
        4tMMy1iYJ2c7yoZYqznJFegK945gCQIwIyihD/pJbg==
X-Google-Smtp-Source: APXvYqy1XwQ/YD98w6cEQSPMGYKJYFFqtxnEz9VURWZ8UkMaYFj8x70GVpHFVifwBScAIxHO6A61uC4G2dXRZMxc1kg=
X-Received: by 2002:adf:dd51:: with SMTP id u17mr44688507wrm.150.1558426084074;
 Tue, 21 May 2019 01:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190520194353.24445-1-martin.blumenstingl@googlemail.com> <20190520194353.24445-3-martin.blumenstingl@googlemail.com>
In-Reply-To: <20190520194353.24445-3-martin.blumenstingl@googlemail.com>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Tue, 21 May 2019 10:07:53 +0200
Message-ID: <CAMO6naw0Fe9g4pTODFs8TfcWBWO8jdf2EOB2ZAhyebqmfMWg9w@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] soc: amlogic: canvas: add support for Meson8,
 Meson8b and Meson8m2
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 9:44 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Maxime Jourdan <mjourdan@baylibre.com>

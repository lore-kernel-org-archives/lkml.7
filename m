Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7140FC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 18:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9A6207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 18:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="z0UDEipE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436865AbfIXSez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 14:34:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:47096 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392088AbfIXSez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 14:34:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so1844747pfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 11:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=jkBCXzn4Uj1xLOMo29hksQeWQpwjGA82dIjcLoLZzTE=;
        b=z0UDEipE4W/AzOwgLuwPGd0hbYj8lB6P6p5iCggsB+uSOZ2ercDuI6QViE8trcyi68
         Ms4bpDlbC17FktVTBM5gBlQ8QRBa/OvosuNUn8F9cuqs+nnRgHavcXYsV+fXIn4fOfHi
         3q+G+MOUuWBNFpOrO58Nvy2MO67v5H5csoVbOuHFdSn2E3jLpAvwwn61KL0KvX26re9h
         S6apGVlqOmapAPl58/oSQBvm4AnBTkNGbaE12ncpt23zSxAPwjzixYva1rmfmWA87KtC
         DL8FB7ElOkvo+l+Vcqt3S5bOGU+5NT5G2NZ1yzPV8VUutxTR9xN2DCHz51458mFtWBnR
         DTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=jkBCXzn4Uj1xLOMo29hksQeWQpwjGA82dIjcLoLZzTE=;
        b=O+smtEkvZRRQc7UoXtHqoyUZ/yINZdTZTAOTTBw6801qNRiG0b1bAgEHjOZePZQRq/
         d96FK6ZkU23wjhsfzDiAx/FkF8oFk5113c2yGHJl6n/KPJ6Ky3F0lcyBUkL3YcTQ46gU
         TzimUgnQ1Bs1IBPzVMUcv5yBraR/30gRRb986B/AyziTjuca1QEEh1Dzug0RyuSztM4q
         7rX8GgR9c91k5mqQN+HklBFC48/Di6MXjoaW7V2X05mpqBAQbRyfaf4CowyTrR/AVeb6
         iss0wsQ6/M+1QTfU2m+eYhOQjW1IKlRvjp3KDwIyPCctJ3wWM5O/2u+vTi/e8NllttQg
         c70A==
X-Gm-Message-State: APjAAAU20IYCM+vlvgXRmjUONnKed5mO0dG+j+wPAwlMzjtqHPgitq1f
        ZF+7tHno+lBmGOQdq3kGo0zbNg==
X-Google-Smtp-Source: APXvYqw2jfPgxdDoSNqWWhnD7kHlXKrQE4WFeQl8IkHVJv88EXWMyWgt15LGw/6oqqVsdoLFFr5Qmw==
X-Received: by 2002:a62:4e0f:: with SMTP id c15mr4989864pfb.42.1569350092855;
        Tue, 24 Sep 2019 11:34:52 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id f62sm5013581pfg.74.2019.09.24.11.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Sep 2019 11:34:52 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] arm64: dts: meson: audio updates
In-Reply-To: <20190905125956.4384-1-jbrunet@baylibre.com>
References: <20190905125956.4384-1-jbrunet@baylibre.com>
Date:   Tue, 24 Sep 2019 11:34:51 -0700
Message-ID: <7hk19x7dbo.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> The patchset features a few updates to prepare the addition of the audio
> on sm1. It fixes the register range of audio fifo which was incorrect.
>
> It also create another layer of dtsi, common to g12a and g12b but not sm1.
> The audio related device are moved to this file.
>
> This was done because the audio bus, which was at 0xff642000 on g12, has
> moved 0xff660000 on sm1. Overwriting the reg property was option but it
> would have left confusing node names on the sm1.
>
> Jerome Brunet (5):
>   arm64: dts: meson: axg: fix audio fifo reg size
>   arm64: dts: meson: g12: fix audio fifo reg size
>   arm64: dts: meson: g12: add a g12 layer
>   arm64: dts: meson: g12: factor the power domain.
>   arm64: dts: meson: g12: move audio bus out of g12-common

Queued for v5.5,

Kevin

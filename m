Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99ABC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 22:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD666206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 22:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vs1Wwtdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfECWE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 18:04:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43084 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfECWE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 18:04:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id t22so3333870pgi.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 15:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=RHqjWmIkEHkJIYN5J/tVVIuTNo00OY/OtIEp+UgaBMs=;
        b=vs1Wwtdj12+4iyb5/FTiwoquXxOvfotLHiVZQBM0eVs35LqbzeLBSZ21Cbuv9Jzj6k
         +l3Gkzfrp5skcy8xbupOg1WR2hrh8rTeKUrNindpPWulnAX23kBMZX7/1FioAqXcRahi
         jKQ30nPtK6HRUtUC7TJ1oWfG3OiVR/GAwuGK/W8wsHt4SlcLPDnc5dHM4SNZuNWoQDg5
         CBIdoOGjfFOOGHPJPR9Rs1LVS0zwX5TIpnFpIPEEaOMlvmL0s/FrrD9jlnnUwomNHh6t
         xcl6m991Fwkj4cDdGMdWNtTKS66pd5YBnLACLiBRdj1M5xru8xXNs8OPgSdTUA0pDFhU
         antQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=RHqjWmIkEHkJIYN5J/tVVIuTNo00OY/OtIEp+UgaBMs=;
        b=ao3gXPd6MvohZumxT7kINcEgN38lqIjv2QxFtjOylM9YpVSCba0K88Gt4OaH8I5qzv
         CGpoBb4r3rnHj2PDhAaKttcdQtc9uDaNTf5jZ/kvrvsxaavyYmFhmIaNoToL46jMtu8K
         A54xY+QpKIdrDfui2e4PEJCxfhrxkHZA6aGa2LsGDtsT5UAfyW04/tD8j5ohChVMiOFv
         bShXXjlOPfuGgCpCDIdN9u90T2BZ8jsXSPfalyuFEsbZj8h6mT+fhGi0CiCPOKXed/Bb
         QiACfVoEId8iNtL7sDOmbvDN8rbuCjqWGl2LW/pJ4cRGniQFYTz6Ff1cMD5o9BTRAZ3f
         Ao6w==
X-Gm-Message-State: APjAAAWeDbDZnKzWO6qzBL+ScjEIPDsHB6KdDohn5BAHznQrT3JoYJXI
        6jYw5M3qTacv2rKylvoPxOAkXQ==
X-Google-Smtp-Source: APXvYqzyU+wMWrFoRA1gvmfadd4aYpSMdzHEAgB0uTziUcb1/nwfYiSc4SEq8pdkNU7ww0+yBusrfQ==
X-Received: by 2002:a63:3746:: with SMTP id g6mr13796813pgn.422.1556921068758;
        Fri, 03 May 2019 15:04:28 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:84dd:d87f:858b:45f])
        by smtp.googlemail.com with ESMTPSA id s32sm4512668pgm.19.2019.05.03.15.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 15:04:27 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patchwork-bot+notify@kernel.org
Subject: Re: [PATCH 0/6] arm64: dts: meson: mmc clean-up
In-Reply-To: <20190418122714.30805-1-jbrunet@baylibre.com>
References: <20190418122714.30805-1-jbrunet@baylibre.com>
Date:   Fri, 03 May 2019 15:04:27 -0700
Message-ID: <7hh8abkxec.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> The patchset is bunch of clean-up found while debugging meson mmc.
>
> * The first 2 patches address the libretech-cc which actually uses 1.8v
>   eMMC modules.
> * Patch 3 is a pin bias fixup depending on mmc pins.
> * Patch 4 lower the mmc max frequencies on gx chips. It was not easy
>   to spot but, according to the datasheet, the maximum UHS rate
>   supported by these chips is 100MHz (SDR50). This explains why we
>   never really managed to get a stable SDR104. SDIO is limited to HS.
> * Patch 5 adds missing pinctrl definition on the vim2
> * Patch 6 remove hs400 from the supported modes of the vim2. This mode is
>   mode reliable enough with HW/SW ATM.

Queued for v5.3 (branch: v5.3/dt64)

Kevin

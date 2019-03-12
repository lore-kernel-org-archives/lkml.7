Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF2EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A392171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="D7cUhY81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfCLUZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:25:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33892 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfCLUZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:25:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so2698011pgq.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 13:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=UjIkLDF+WPlQwj3k/SSeB4jZh/jn2w9+5oluq0KnIUs=;
        b=D7cUhY81VVg8b5cI72uuLyMu/I0u4rPjDpmIgRiXo66lt2wY4Q8p+ac0J32Hi5oD1b
         n9x7imRmVjkzMu5YkGZMv4n4I/tRbEAamoWvNbymMmcO3D1SlsSiDQanBX9h1v8bhmKG
         JCiij8MlXbO/2OmQvuSgYbFBlzTB1Rld99b+f4IXw7mvCdo6iou221Wqzdy2nuLsf8FI
         Y+XyXrwCi6+hXZLEsrQ+A685yMGnakU8O0AjnYUy1hG4CqZ6xJ7JErevPlobUVSphUwg
         qeEwYpMFWN9Am9T86VnCj2vGmqMupCXEB8lGlVep3uoootcCvqU0DRCFP0wteC3e9/Lr
         /Fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=UjIkLDF+WPlQwj3k/SSeB4jZh/jn2w9+5oluq0KnIUs=;
        b=uAv3NR40HC/ja4A966FoCTk+AoOBVnc68EFYtxl9m4s7UdOr4PZFrdLZWKnldTNGTF
         OS0hBy3TlqdvR2ZGtuwy2ezQutGfqTObRG6TSiMFlOswE414ZYJ9ilFARU2MYRexlU6w
         gGUiv5tvwtjxltoUdDKpNsupqqIRngrTPG6rmVoX4QOU1Ol3NVU5rm9oxO2LUi6XhOk3
         l+U6NQZnUKJUlubeFJ8FzmtznpZ51HmKwGxE0FnZTJE4nurcujoU2Wbo19rL5F+8yw/O
         rt9NyIDZIOGoE7eu+8ITkUZklAfaVnI5khi0TG1qzPBgTzKw1TorUTGUJrJz58WJU3ZB
         eXTg==
X-Gm-Message-State: APjAAAVuXmI+EV00auOc/27m1h9Wte1qJVehnoucjOb9HyDT9YG2JiJD
        yLbeMFBfgoelte/RN4uyamArrNaHo5yaJQ==
X-Google-Smtp-Source: APXvYqziQRiTJeiwGTiIRDq9NYpwFOikItHR6HFTIuUY+EDHlVCfxIGM/negzlpNYOslqFYPlyWr0Q==
X-Received: by 2002:a65:6489:: with SMTP id e9mr36608788pgv.260.1552422325658;
        Tue, 12 Mar 2019 13:25:25 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:1daf:3f96:9f7f:33ba])
        by smtp.googlemail.com with ESMTPSA id e15sm4545527pgk.30.2019.03.12.13.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 13:25:24 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] arm64: meson: Add SoC ID detection for G12A
In-Reply-To: <20190307140147.22047-1-narmstrong@baylibre.com>
References: <20190307140147.22047-1-narmstrong@baylibre.com>
Date:   Tue, 12 Mar 2019 13:25:23 -0700
Message-ID: <7hlg1ju9fw.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This patchset :
> - Fixes the package id detection for S905 variants and AXG packages
> - Adds new SoC IDs and Packages IDs for G12A/G12B, and S805X/Y
> - Adds Add AO Secure node for G12A dtsi
>
> Changes since v1:
> - Added G12B S922X package ID
> - Added G12A S905D2 package ID
> - Fixed patch 2 commit message

Series queued for v5.2.

> Neil Armstrong (3):
>   soc: amlogic: gx-socinfo: Add mask for each SoC packages
>   soc: amlogic: gx-socinfo: Add new SoC IDs and Packages IDs

Applied to branch: v5.2/drivers.

>   arm64: dts: meson-g12a: Add AO Secure node

Applied to v5.2/dt64,

Thanks for all the new SoC detection!

Kevin

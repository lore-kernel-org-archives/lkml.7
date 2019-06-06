Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F04C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B372083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ufbn7N0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbfFFRZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 13:25:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41232 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfFFRZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:25:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id 83so1723609pgg.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 10:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=3LKp2333dAsdHgcKPbSCpFKyWi/YPsxy5d/uBrW1vJw=;
        b=ufbn7N0jryrG0HOBOgiTOLSXC+8CPoOdNvpRg5ioCQ2Qnq3/MrgCcULLU781HRzV/Q
         FyI1xMLATPNfnzoHevVmHhEXmu0Xb3yn/a/9SpyrVKYJmdbTqEyUtphCSQkrcuaaX+p2
         adStH4+ROigx3lYaPqm8G8VWsXfWia6rq8hgPt3dBflYTEzen7o/cT/jlTXf/BHfde5S
         Rvg73ZoiiSSqjn6td0HTTOV6iHyNqYfY9lysMaLD7aAicDH2SlsSwX1J4n1H/vRwl6MB
         VGx72V80nauy5tZgAFakAmBVh8F0Ja4xXvg/+RxALTR++Q0atOThCsvkcv1gNEd/HkWz
         LwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3LKp2333dAsdHgcKPbSCpFKyWi/YPsxy5d/uBrW1vJw=;
        b=eqPPFyuZT2FhktMFbMRAmYMJZB58i7BFg6dEmaO1wQswJsxds6YUbU6gUKy82M57pD
         yO4tPDmBtoWaC+S9x0V2QYx4eIBP4gT0W7k1op+xpmqRVnkrt826CfP8rKL6CVoRJMhN
         SIZ1uVs3AaBBTP+dUGDPRxskccIlFK6nU7a+2B3EE5qkSWa/19EcktBZ+MH7xmD1sxTp
         PN0Q+cTQ/NzzeNWt24+c6BugmxcnLeOWhQRL+ygKkZ2AZOmK7dfqp+nP6g0xw1w26XO4
         vhfkCaoVgSncSUB+gBfnYAXA0YRCpaYG/OBqezpnAYz+AnpbNmu3ZPyrEr6kcAKeFkkA
         z4Ow==
X-Gm-Message-State: APjAAAULQbWPD2ZQb7c59estTFY2V8DG1daBO1P8Td8oaJrs0iv7RnGA
        AgcgUCAegNuL2MIRAP9v0W51Mg==
X-Google-Smtp-Source: APXvYqwY6ai4KXXEJsOuFBjETzbH/6l5KeGhPhmBm9jpS8OgNIxzeR41NaXMlAcOyAEwxTNJhTZOnQ==
X-Received: by 2002:a63:445b:: with SMTP id t27mr4314682pgk.56.1559841950934;
        Thu, 06 Jun 2019 10:25:50 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id t4sm2201097pjq.19.2019.06.06.10.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 10:25:50 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/2] drm/meson: fix primary plane disabling
In-Reply-To: <20190605141253.24165-2-narmstrong@baylibre.com>
References: <20190605141253.24165-1-narmstrong@baylibre.com> <20190605141253.24165-2-narmstrong@baylibre.com>
Date:   Thu, 06 Jun 2019 10:25:49 -0700
Message-ID: <7h8sueeici.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The primary plane disable logic is flawed, when the primary plane is
> disabled, it is re-enabled in the vsync irq when another plane is updated.
>
> Handle the plane disabling correctly by handling the primary plane
> enable flag in the primary plane update & disable callbacks.
>
> Fixes: 490f50c109d1 ("drm/meson: Add G12A support for OSD1 Plane")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

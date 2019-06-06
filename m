Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C291C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA662083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wm/5HuCV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfFFRaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 13:30:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44111 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfFFRaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:30:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so1910383pfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 10:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Er5DZ+jmgl4pACBM9mSuCYlxA1ZXYVy+Ri46ksNsKNU=;
        b=wm/5HuCV6OCqFPMj5n7IL5mdjhSWRNBQjjf7DDWELSUHyHSEkxAJJUzCUh5K1Q/PrT
         1rU9XPLawCPwYK34YEcRmd16u3HynW0SaTlCWw1xW/8f0xJXLaJFv5Amj8aU+x3jBRGZ
         OirbFJ6smfoYmqM4vpdeGuUA2Diiozc28Ql/BUymxNlyCnF3U3NuNesy19sKjTxlBCZ9
         xYkQgCVNc212j+aq83vwctLQsFzBYDYeCb21vGVD1yCTxbTMQZP9cLHvVL8JSwKlQeP+
         HhhL48FMk2LjvcQQ5bdf6g41dqIbXtWQEnc9Q7xerefNu0gaXl87goSWT899hImcaaCN
         b4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Er5DZ+jmgl4pACBM9mSuCYlxA1ZXYVy+Ri46ksNsKNU=;
        b=UgtMgYoCuJEpNLWTZ1BTMw87NNIkJnEqYq+TyTNGuJNwwSW/VJnvh9ItuiTilizF7u
         XgAPsOddBzqKXBXTFWlZMhg4kXPX9OH+OerJsa23yqllc/sACy88YbcnglQboeVAiQqq
         2uzmBLPS2z5zbOoJP+LXh3iZl+dEPmolhGhB4dTdzqjU0vzio8huuTXWHZjVxMl/a9bb
         RAgQ0NSOO9atk57gW8zpsC9FcpodZ+bBLpOKJG1Yc1Tb7XMwiaz9Cj2zG88/VTYsuoLd
         SvU2NCZjuS1LaZ5n3Rkn/N7LOOgjpAfX1NZSYHMKt8/oJ/eotpqJD4mOT/dZTojbwTCf
         SmYQ==
X-Gm-Message-State: APjAAAU/N9YNwxl8lP/1vOZrF9XByPzxIGza5hz57DEM7U7UIqC8reWb
        i5LoYz1giymdVxDQyqlJqVwQEA==
X-Google-Smtp-Source: APXvYqxcHDkEaPOHT2K2CyUbipGrVEDze7r7eLCeuaNBURmbKlAo/gGUVa+qM337klyNBaUWwbt8aQ==
X-Received: by 2002:a17:90a:6505:: with SMTP id i5mr924412pjj.13.1559842213424;
        Thu, 06 Jun 2019 10:30:13 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id o70sm2769938pfo.33.2019.06.06.10.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 10:30:12 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/2] drm/meson: fix G12A primary plane disabling
In-Reply-To: <20190605141253.24165-3-narmstrong@baylibre.com>
References: <20190605141253.24165-1-narmstrong@baylibre.com> <20190605141253.24165-3-narmstrong@baylibre.com>
Date:   Thu, 06 Jun 2019 10:30:11 -0700
Message-ID: <7h1s06ei58.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The G12A Primary plane was disabled by writing in the OSD1 configuration
> registers, but this caused the plane blender to stall instead of continuing
> blended only the overlay plane.

grammar nit: "...instead of continuing to blend only the overlay plane."

> Fix this by disabling the OSD1 plane in the blender registers, and also
> enabling it back using the same register.
>
> Fixes: 490f50c109d1 ("drm/meson: Add G12A support for OSD1 Plane")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

As noted elsewhere, this driver is also full of magic constants used in
register writes which makes reviewing this kind of change for
correctness that much more difficult, but since that's already been
pointed out elsewhere, and it's already on your TODO list, it should not
block this important fix.

Kevin

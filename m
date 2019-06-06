Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BC1C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3901A20693
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="N63CQleF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfFFQyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 12:54:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39749 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfFFQyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:54:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id j2so1864358pfe.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 09:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=uP+0RK/olOLeLANX1udo5x/E16Z31PJSvZb1HggqSws=;
        b=N63CQleFfxxkHFbTvUxXAUj00SNojMJgEc+8bCzpWUz1SMMaeJKUxegJaRKSTsMDGD
         1dXL8l79JGZivWqLKJiapBgjCIILm1saH34vLs86d0CTrZQtYOHd6/VsvTF4VTF33DxE
         5fAuWLUp0CA31TSfKw1iDCioDpxjx75VLgGB1fA73diiIFdwTIXaIcn330n7y7owgAXi
         ljqZsxObVnsQT+OOpjXyaIV8X0gLvZ20AV6HnZZxfVZiGZmBbfD3tTQto+WJYNzcO6r1
         Dkvo1fjPrA0HVKT0OyHi1NhWbKG11qmOtQBEYhkXv3pC+TbRtof1/eAeSVruo5LY+hhv
         1dAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uP+0RK/olOLeLANX1udo5x/E16Z31PJSvZb1HggqSws=;
        b=BbCOnuV+daX0cTtSoHgjPNevhE+MDjh1oqHXkWTqyq2ki1jSCyApWtT49RP1Wz0W9s
         3hXrcc4i93M9sOFcDLhVugHQnt87IZgQAAgLtEvth3HjqLy643KpTeU3kjNQiedjRb1m
         OoIYiH/koF8bg0IsYjgi7KH6fAld7x8Efrj/ociNy3czDHW9bQoJ2aBUHBk7Fppk/TjO
         xw5aYEgld9JnslmsprvEJeiVnmlsw8/IDXnBRPoCNwTLWaNQHSH1lRwDrffNV0zsjQcW
         03UkTAhjcp5vj2dNEkAxeTlQeAIMxAsLqGwfDTqsuR7gGKFUeEaRDB+R7pubGs65vKCM
         dcoQ==
X-Gm-Message-State: APjAAAXtjgpceSAe67A+9UWP5fOef4xvgqi/AbrD3OpYk3m3aDEaQ1rw
        AgXV174HeqjhEU5oczQqSWeXvQ==
X-Google-Smtp-Source: APXvYqz6c0pC8u38g28qlOAS2XbmDD8MZ971NxMGdinizUMqohDxRr61H7/m/o7Wl3Ba2JWsSM4ODg==
X-Received: by 2002:a62:2643:: with SMTP id m64mr52532743pfm.46.1559840046284;
        Thu, 06 Jun 2019 09:54:06 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id 132sm4535503pfz.83.2019.06.06.09.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 09:54:05 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/meson: Add zpos immutable property to planes
In-Reply-To: <20190429075247.7946-1-narmstrong@baylibre.com>
References: <20190429075247.7946-1-narmstrong@baylibre.com>
Date:   Thu, 06 Jun 2019 09:54:04 -0700
Message-ID: <7h8suefydv.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Add immutable zpos property to primary and overlay planes to specify
> the current fixed zpos position.
>
> Fixes: f9a2348196d1 ("drm/meson: Support Overlay plane for video rendering")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

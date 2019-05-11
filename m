Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BF7C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 15:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3AB20989
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 15:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="W8NR9LnI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfEKPqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 11:46:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40997 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbfEKPqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 11:46:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id d12so10771507wrm.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 08:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=9EyAvll/ATAIGdWTAfOnNvm6AJWZDwOSY5TYnJ4aLu4=;
        b=W8NR9LnIM746OC6UAr+I4/mwaTFWbv/cXM9gmgPM3KoD0ltprY3CktFRo2rAiOPbfr
         4VhYGiIKa+rfIYOCCPIx4IMHeveJirtAo3Ya+zx7+TstMMo14LBljvp7nPdgFK5M1Dyp
         wyGi0Mft856R9ZsfcbaAH+AnJr6G6SzFMSCtQ3FtYpRO8Ucn56f2eiZTa+32s0+Luat2
         WObr+TQMnPFKjqYEK6SUC1Gtw47yjmdPe70Rz8jDksZKduyeield1foYZhD+qWaeewTb
         lZEVwyr8ulZWRoKyFgqd6DdaueObW7u5l/7YBjzndbwKzWQzW4AQ5ODiRidBxSk/pFBI
         y5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=9EyAvll/ATAIGdWTAfOnNvm6AJWZDwOSY5TYnJ4aLu4=;
        b=nDV3UtVYb5kLcOO+EeP4Jx4DTsLtfZPo6Yp0k72VAKW7u3pxb22ZCK6+ENnNGpzx5J
         D8h47QhMJZI5fAtgKgf8kUQOvW5Ori7F5ii/pbWPGNhF+M/sQdepTbvoCDZwFOGk8q0c
         SNzENx22nQKJn4AP0k0VnBEOddBoxv9yGXUU16m+1W1y0wOd0dEyH4bdGsMcH7MLe1VY
         E7eyRiwgWbHarb+8lO7y8QhlzMBT4sAZDII6+xxruFo65Utn1Cbtn1KphOze7ePoixKE
         zFGkQMvZbPPpAkVjZ8iEbQerQnA/w8a+9OqDKCRUSMDoK0D1tJFloZPdoR2L4m3/buAJ
         JxNg==
X-Gm-Message-State: APjAAAVBm7OOdUll0Tvk2Mz++p50WMidGTIUqMsUw/ZsBKSF1UDwcMYw
        xJE//kfRZi+XsF3RMxMH7hVavA==
X-Google-Smtp-Source: APXvYqxB8d87irChUP/Gna5KPAG1k70rARyG7XAXhFYcz1xreLZlylj5y6uj22gjPVvPo3HoulXyHA==
X-Received: by 2002:a5d:50c7:: with SMTP id f7mr11637247wrt.95.1557589613287;
        Sat, 11 May 2019 08:46:53 -0700 (PDT)
Received: from boomer.baylibre.com (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id y6sm11486952wrw.60.2019.05.11.08.46.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 11 May 2019 08:46:52 -0700 (PDT)
Message-ID: <bf1360ab62a4e7bd3928052ebb6c969e8059f29e.camel@baylibre.com>
Subject: Re: [PATCH 5/5] arm64: dts: meson: sei510: add network support
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Sat, 11 May 2019 17:46:45 +0200
In-Reply-To: <7ho94ac4jn.fsf@baylibre.com>
References: <20190510164940.13496-1-jbrunet@baylibre.com>
         <20190510164940.13496-6-jbrunet@baylibre.com> <7ho94ac4jn.fsf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-10 at 15:45 -0700, Kevin Hilman wrote:
> Jerome Brunet <jbrunet@baylibre.com> writes:
> 
> > Enable the network interface of the SEI510 which use the internal PHY.
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> 
> I tried testing this series on SEI510, but I must still be missing some
> defconfig options, as the default defconfig doesn't lead to a working
> interface.

That's weird. AFAICT, the net part has hit Linus's tree.
You should have everything needed by default, the mdio mux has

> default m if ARCH_MESON

> 
> 
> I tried adding this kconfig fragment[1], and the dwmac probes/inits but
> I must still be missing something, as the dwmac is still failing to find
> a PHY.  Boot log: https://termbin.com/ivf3
> 
> I have the same result testing on the u200.

I don't any other patch pending for the network of the g12a.
Maybe I've done something wrong while rebasing. I'll check on monday.

> 
> Kevin
> 
> [1] amlogic network kconfig fragment
> CONFIG_STMMAC_ETH=y
> 
> # following are needed, but automatically enabled if above is set
> #CONFIG_STMMAC_PLATFORM=m
> #CONFIG_DWMAC_MESON=m
> 
> CONFIG_PHYLIB=y
> CONFIG_MICREL_PHY=y
> CONFIG_REALTEK_PHY=y
> 
> CONFIG_MDIO_BUS_MUX_MESON_G12A=y
> CONFIG_MESON_GXL_PHY=y



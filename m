Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F163FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 07:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C893620663
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 07:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XyPVZBz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfJ3Huw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 03:50:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34428 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfJ3Huw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 03:50:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id t16so1133157wrr.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 00:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FLPIpnHOBePg/Y6da8w9/WRUoNiVkxQNWcq2DQOe07M=;
        b=XyPVZBz2kVqf6z+1cIyhTkCY9EFXOZzeQZGpHure5f5izzCxjf1ZVQ6kVBYmm9H1+U
         d/t30k/IvFZWYAj66fXjRzzv6d+hZ/7mVXinYxHIyoMrDgHZnV8vHynTWW4njmDFj9a6
         vEs84X07ky4e9x3e9KtjF1LWqsIFnWK6+82TOscZunOTqiGZeOYVRsNxts9VjEQKa+lt
         FhdpBJnumN6gY9IAN4yvMFF80r4RX3gQFjM1jg9NhL2pXmvBoC3b9DJa8zBtK6RPIeAl
         DqxNx0LhriVy4PCV06zjT9oR0h6QR3/Rd7c6ScnJbVfmiu0iLZnoBeXTiIVq1McqfwwE
         Y6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FLPIpnHOBePg/Y6da8w9/WRUoNiVkxQNWcq2DQOe07M=;
        b=PxE/1uDsetKiAjU+5N2s6Bh0t0RK24m/HxnRT9ghtTmerPKA5LJi7tV6U4tLlIPwox
         7gVLWHipkAMioeRiavE4ZQtAdbqelv9LG6ZDbPGKr/ikO0Iy95q7vdyhxPzdLJD7X5mH
         54qx0dJQ4mrdZMMyL25U2V+zcczPD+K4W8o/RAEo14AQ5/epp+IRMxCuGgkWd1nxGPrp
         mwfMfGzQ76/n3kNJmNbnenVfYuchjkDjh3v5YoD5gE3VAdSLsuuRGPdO337lXAuaQR3a
         plHU0s6JdsOkrcWEW1rNlwkvqPuwF0pT8+benBGmhPYAJxoJ3wUNyQx2HWTOEUyi/2Wi
         sHBg==
X-Gm-Message-State: APjAAAW4c8QqUdmUL3CACp0uqvrXPpcEq/iMaxi6UuRnad7RB3wY6PGd
        SBn2hSaSPh5GscGja2DEFk4eOQ==
X-Google-Smtp-Source: APXvYqxqLawwSBkqOwElIXw0EitJZw7c5fIQELur6Ziwo9Eowbi50RtGdHxZjDIulp8GE33dkMbA8A==
X-Received: by 2002:a5d:4808:: with SMTP id l8mr22968551wrq.118.1572421849544;
        Wed, 30 Oct 2019 00:50:49 -0700 (PDT)
Received: from dell ([2.31.163.64])
        by smtp.gmail.com with ESMTPSA id r19sm1929303wrr.47.2019.10.30.00.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Oct 2019 00:50:49 -0700 (PDT)
Date:   Wed, 30 Oct 2019 07:50:47 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH next] dt-bindings: backlight: lm3630a: fix missing include
Message-ID: <20191030075047.GC4484@dell>
References: <20191029185350.31155-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191029185350.31155-1-andreas@kemnade.info>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019, Andreas Kemnade wrote:

> example failed to compile due to undefined GPIO_ACTIVE_HIGH
> fix that by adding the needed #include to the exammple
> 
> Fixes: ae92365cdd75 ("dt-bindings: backlight: lm3630a: Add enable-gpios to describe HWEN pin")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../devicetree/bindings/leds/backlight/lm3630a-backlight.yaml    | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

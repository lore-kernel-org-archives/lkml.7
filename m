Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C26C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520DB214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Wa47Q87Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfEHIIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:08:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51244 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfEHIIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:08:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id o189so2021663wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 01:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=86uV2HxREIhuwS4GJK2Jn9KN6S6XEQro7aC0j5fNqaQ=;
        b=Wa47Q87QsTzZzMoc0lgH3dN5QS5PlcHSVtDDVyW5uCaLEews6uOxM5hSxUqnt32Due
         TdJWBlfvIVsOz+MlL05tFkgVODnYnKZETpeeDNrAIqNqFsei7fKmyGurn1kRL0KlKyZ5
         jHMdDOSGsYr2+9+wIU3CXiNPFsBPfjTOuO6ReuB1tME7L1KLHx2Zkeb9w3mUUvHGUK08
         4SDZA0LxFGrO2pqw9KHMg8V2YE8WC0mlIl7cOQ/ih7eFkCq70OTgJTkXbsozCnTpBtxS
         sS47yZAf1+1cWiyBcyHKHBIC8z2q/4zQdj7Ybhek+hKJhjWbun72BzQZE3Ieuk1aP9yg
         8ehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=86uV2HxREIhuwS4GJK2Jn9KN6S6XEQro7aC0j5fNqaQ=;
        b=EdYRdJ148t7erOqAM0uzIVXR59j1eNG77hZfq50Jx/B8fBFA/6XRI4wkn8jcwoujnp
         Ed1qaQCFNKzuKWTe6nxoX0X3J939jRVSaE7sCn4KbTiHUW6SpgUO/Gei+km0G6X+hl/4
         UsEGZCAVMRSIpNQpHsVsO8LWXnDkscTl8kUbxSsIW1tTk5xZQls6WpSoNF06qLy6Ikuf
         MjI5NmhK/fzNQ4s7T3ODFQA8bt38ZWSb6tB3AYCfM7VyVV1kTkx8x541GmZA+Erl7Mlh
         WrXZGtopg5WTrhjQEV3fVXkTE48HQJNqEwqzsmak3wpfD5zwUmr0UZ/q1zLx+O/7kWgm
         21+g==
X-Gm-Message-State: APjAAAUhlJQv9fFCVEy5wxx5ni8IJQexLf+G133qSjCylkuIjoP5LHT+
        Z2VEJswORFvMFHUOnsMa1TT3wg==
X-Google-Smtp-Source: APXvYqxnCHnnuRVpXbAZJH0rRCaLSN9SfrDf8LxsMRt1drEGr3nMB2tZ13hyFOUV6PMsoGG32FurPg==
X-Received: by 2002:a1c:9c03:: with SMTP id f3mr2010807wme.67.1557302926262;
        Wed, 08 May 2019 01:08:46 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id h24sm1626063wmb.40.2019.05.08.01.08.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 01:08:45 -0700 (PDT)
Message-ID: <fd633a5597703f557d75e43c14213699efe295f0.camel@baylibre.com>
Subject: Re: [PATCH v2 2/4] ASoC: hdmi-codec: remove reference to the
 current substream
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Date:   Wed, 08 May 2019 10:08:44 +0200
In-Reply-To: <20190508070058.GQ14916@sirena.org.uk>
References: <20190506095815.24578-1-jbrunet@baylibre.com>
         <20190506095815.24578-3-jbrunet@baylibre.com>
         <20190508070058.GQ14916@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-08 at 16:00 +0900, Mark Brown wrote:
> On Mon, May 06, 2019 at 11:58:13AM +0200, Jerome Brunet wrote:
> 
> > Remove current_substream pointer and replace the exclusive locking
> > mechanism with a simple variable and some atomic operations.
> 
> The advantage of mutexes is that they are very simple and clear to
> reason about.  It is therefore unclear that this conversion to use
> atomic variables is an improvement, they're generally more complex 
> to reason about and fragile.

The point of this patch is not to remove the mutex in favor of atomic
operations

The point was to remove the current_substream pointer in favor of a
simple 'busy' flag. After that, I ended up with a mutex protecting
a flag and it seemed a bit overkill to me. Atomic op seemed like a
good fit for this but I don't really care about that particular
point.

I can put back mutex to protect the flag if you prefer.

Another solution would be to use the mutex as the 'busy' flag.
Get the ownership of the hdmi using try_lock() in startup() and
release it in shutdown()

Would you have a preference Mark ? 



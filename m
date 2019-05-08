Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCDDC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E5321530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pcmjCkM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfEHIJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:09:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46733 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfEHIJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:09:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id r7so25870811wrr.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 01:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=fxFNIEA7V7ZTCYue3C9CGZ6JTXB6kcJzDAiUiQhZtzA=;
        b=pcmjCkM2jD1XewDN3VhIEI63Qp4BoAQ6NJySwkHFRHbzYPzhRhWaSxwD39xBosPhvV
         IexZw+1R9w+ZmujpBaSFfhsnD096FyhuS7+5uOdr7Ao3MPEwR+dT+aJvhEqxAHGXpmeL
         4GC5KiLO6Anv4Rc05gjNqwCyWwhXRrwInZovJUU8yOj1se8oExjvckYrGt2NV94JDI4j
         PcXdSoYEF4qVoIoIjuFq4Hqt52mIVdGGNeC/QmXlVSjimOoyxJwOnpBVdPyXzanIxpYt
         mtggrUDUa61XgmSSUhTQ2a1XYHDtUMsmVk3a0DJPfAt/u3wE6iYLaU7N2fq3aHbqgh9t
         MsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=fxFNIEA7V7ZTCYue3C9CGZ6JTXB6kcJzDAiUiQhZtzA=;
        b=Ei/jOeSiTJHT0CmQb7L7Qww8wMIbyxBpXYBNWflyhD2ITVZfhTc/yzY4J1RqBacJ6w
         U5naUQrV//Z9d3DnlPv0HkxGZzYkD8+lo12VCrR5Fdovya/Fd1j+JdKgcyt/kDRZXjuv
         YM0QPVStYUVjwzWb1NRPqyl7g28ng81hUetHivvKvc+0nA5Z4pcn6FM7ycdND7nAZbk3
         yuNtXZ4r7QhTncur4N8kkhpVR8dzexbsXczkoXFynZTfCse5X1wlLOunPdqx1jnasGGG
         k45kAoCjzYnHaGVDUUiZtBW4Vm2aF+4uyJWKV8s16kiDSlhvBTsTRYRDOS43LG8jz5fP
         LnkA==
X-Gm-Message-State: APjAAAW6Z0YLTl0SnQg+22TU7V60GISWG/xkKgLZtjEoAvstoB99MedZ
        tHWBzmv8jtXdRE+tRwTd3RAjRQ==
X-Google-Smtp-Source: APXvYqw7wQtH4AXjNUiDLs2Zh6bWTvzpqq77mI0gNIJaWkzh+2WDHnNjEzVb4o/1mEThOBfHwGBogg==
X-Received: by 2002:adf:b641:: with SMTP id i1mr25882376wre.288.1557302940061;
        Wed, 08 May 2019 01:09:00 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id h123sm1635385wme.6.2019.05.08.01.08.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 01:08:59 -0700 (PDT)
Message-ID: <08ee1bbfb5ae15b5cb2bd421abe6979b83097553.camel@baylibre.com>
Subject: Re: [PATCH v2 1/4] ASoC: hdmi-codec: remove function name debug
 traces
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Date:   Wed, 08 May 2019 10:08:58 +0200
In-Reply-To: <20190508065016.GP14916@sirena.org.uk>
References: <20190506095815.24578-1-jbrunet@baylibre.com>
         <20190506095815.24578-2-jbrunet@baylibre.com>
         <20190508065016.GP14916@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-08 at 15:50 +0900, Mark Brown wrote:
> On Mon, May 06, 2019 at 11:58:12AM +0200, Jerome Brunet wrote:
> > Remove the debug traces only showing the function name on entry.
> > The same can be obtained using ftrace.
> 
> This is not a bug fix and so shouldn't be the first patch in the series
> in order to avoid dependencies from it on anything later in the series
> that is actually a fix.

Sure, I'll re-order



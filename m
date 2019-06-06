Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5634DC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2317720874
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BSqi0C2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfFFQx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 12:53:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41793 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfFFQxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:53:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id q17so1862403pfq.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 09:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=zGrqsmVewnpRBL6cgILQS0mdV4kn0nEbbTIMAtPnZ+0=;
        b=BSqi0C2QpXTjyH/B1kVfcYczMGoJJzapcHSKvOz6LV0IIIDSFaGv+EF8ULJghex95X
         bVVg8Q4OJtZf1ZNH/uJZKqEHDQwdjmZSGofFxXOhMFsizAuOjtaqb55JrX/Z3M1qADiu
         XOpO7NAcmvvb19l488bihdEov0+9zp2MoK124Gji15egxg4QRCYgCBUFpUZ+8enfpnZK
         oSS0k+dDTj8R8SO2spVt422LdwjFCYu5kih9OGSm1GFN5vWDElPfetT4y7tJJR+6GrRG
         M241gxaRtBUsB0irpw5n45jxZJJj53Ufa1xDc+l/CsYU81gvk+bc7qmWx2RsnyAxJ5pX
         Fxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=zGrqsmVewnpRBL6cgILQS0mdV4kn0nEbbTIMAtPnZ+0=;
        b=KSD2DBpKrCV0R+tDsLvwnrZ5Q+hzfH3yKYc6EIxhuYUQatj9APwiE/JcPA9hOqkm3I
         K3vTDzpcnd8YuJ03SPb6reHrPafJ8tRLLmPZY1TdwXD0ddfgPkHAXzzlwTmt//4KIxXo
         HhCOoLPaLcWURPVimoWJdIclwb28Whq0DviQk0RSxrFx7rVD6vy76kGmKimkk2iZaxR5
         oYx4KA8sFNAZaPDJVsHMOjKmRRDaSf4Uq7HXnYWknwVmKkixtyfR0GxhAz8zmo7uvAt/
         y/zNnZozhxCawT0iNjpCR7jy+5x6OqX8vcDVCJ2qYqpOfkttJhssL/VjKITownPU8jdv
         ffDA==
X-Gm-Message-State: APjAAAVjqNVwk+Xo9kO+kqJZCDwq6F3s2MlURx3A549umVbtvU4UzoPQ
        7QU1io7fgJdCMxjiQzicE05VVBu1Q54=
X-Google-Smtp-Source: APXvYqxZ4JQdtqCpus9ijZY0A4itD2/gcxz6vva8D0mzSp8j3sFAes2+/v8tO/ZWyHXyyw0rHJanlA==
X-Received: by 2002:a65:520b:: with SMTP id o11mr4270398pgp.184.1559840004995;
        Thu, 06 Jun 2019 09:53:24 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id g15sm5711877pfm.119.2019.06.06.09.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 09:53:24 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/meson: Add support for XBGR8888 & ABGR8888 formats
In-Reply-To: <20190429075238.7884-1-narmstrong@baylibre.com>
References: <20190429075238.7884-1-narmstrong@baylibre.com>
Date:   Thu, 06 Jun 2019 09:53:23 -0700
Message-ID: <7hblzafyf0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Add missing XBGR8888 & ABGR8888 formats variants from the primary plane.
>
> Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

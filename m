Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E19C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D157214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rISgOv/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfDYJGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:06:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43854 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfDYJGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:06:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id a12so5948450wrq.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 02:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PKlaTnAlCgVIzuGnj77yzvrLkhPjokOBr925naoIOJU=;
        b=rISgOv/hpFgSTOrSIUazBAq+4GfMNKFMtYdwx3WjMXXY6AxRoUKfJoaEpDZwN4y0px
         gvNU9YvmZxmqEW5AxzLlY1OpMm0Mx9F+8/O59xZwAd0wODXqTiYWjnQS+fneuxz1x/Qd
         /6cWkFRloaNtfXckBVPelR0/Sj0cf1neWxi11e6DVryTxWWRjCOnS6vYEEjcEPyreOMC
         u8LNlfAJt7Dk/q3FoawHGUe06fxgzVhcDl6q29FMIiHfC+Tz7IVLEYkTV7Y8wDncJ3IR
         qhTTYYLG8o9VpDC2rQ/KLzaA6yFIwoBOepEeD391vCDMkPqN4WUiRWsQ13MvPzFmLMKO
         3KrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PKlaTnAlCgVIzuGnj77yzvrLkhPjokOBr925naoIOJU=;
        b=fpH3FD42omJ96GTFQQbgqIPjZtBmoSOY77AqRHFx3VHP0xq06lCGrLkwL3DjzWtCB7
         UeKfkGbVFRF0BDP4rtKV+iN+aW2L2WZs166mSJ0q9PigH0u6sbmDR0eLgzJ0+sgeC0Ta
         +NnOjZwNBMrAGgrOkug7vPlNnDRci+zrLt+NTehmgnOOgq8iXAXy+tQUwxRZoDXWnQyO
         Q6Zx02X2YxQ60Zf4SUQMIxfzxjo8MhoNAR/r+CET5wWsCL/1kvlOyzouMcPlbn5Abukb
         mTaF1TdXLDI412HKSe3Likww3ISQTE6V9SNzkT5IP5Ovm6V6OSeoBXYJxT6z/eftdwB/
         h+cg==
X-Gm-Message-State: APjAAAVjiZN9Al6d0UXk6Sh02UAIOoLtNU4QpXLrIXLO0CBbL3Aew0Ak
        kqnAiM2k/v+19fpvf3WBY88HMw==
X-Google-Smtp-Source: APXvYqzLq/S1hvu10+HbLsXVMDpTNkKa8JPB1mEoi6/BoF6xV/06t57mFlFy0JbcSFTVCDOd+Bxc1Q==
X-Received: by 2002:a05:6000:118a:: with SMTP id g10mr3662785wrx.233.1556183177948;
        Thu, 25 Apr 2019 02:06:17 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id s2sm14765072wrr.50.2019.04.25.02.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 02:06:16 -0700 (PDT)
Date:   Thu, 25 Apr 2019 10:06:15 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 7/7] mfd: cros_ec: differentiate SCP from EC by
 feature bit.
Message-ID: <20190425090615.GG14758@dell>
References: <20190412071851.60332-1-pihsun@chromium.org>
 <20190412071851.60332-8-pihsun@chromium.org>
 <9bf20470-e5f6-7c12-9cc3-d9c6041a3bf8@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bf20470-e5f6-7c12-9cc3-d9c6041a3bf8@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019, Enric Balletbo i Serra wrote:
> On 12/4/19 9:18, Pi-Hsun Shih wrote:
> > System Companion Processor (SCP) is Cortex M4 co-processor on some
> > MediaTek platform that can run EC-style firmware. Since a SCP and EC
> > would both exist on a system, and use the cros_ec_dev driver, we need to
> > differentiate between them for the userspace, or they would both be
> > registered at /dev/cros_ec, causing a conflict.
> > 
> > Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> 
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Lee, there are several patches touching these files right now so you could have
> to solve some trivial conflicts. If you want I send a series with all that apply
> cleanly just let me know.

It would be ideal if you could bundle them to avoid conflicts.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

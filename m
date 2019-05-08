Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777C6C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F9E20989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k/NSxz7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfEHKcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 06:32:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35674 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfEHKcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:32:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so2581880wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 03:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1r7P9UsZbgNqNY1l6abhHXfspcGLO10OT1tcOU7stKw=;
        b=k/NSxz7Z77jhksjFxSrX6bJzVJZGjt8NFTY171SnzReQAlWVan0HMuPMFKRDSuklIW
         YMUYxL4jxsTBcWSu1YtuPiZhLPuVliNY2lrqebyVl/Fb72hpmxeK8GBVbueliPnEh+GF
         elpFQuGbMkIbNA3xbaMsQg8KSiZBlXhi6IlYcKoUJsSIQY7+b+kZ2C07EROGtOYf/vkq
         7/EHa1WERb39h7wISiuO1r46G4TLssXQKI20UufV1yaSdOau3zD5JB5Rd6ITjlyCRnlq
         kvDE5C94BPJPYelTCiqWVy4UYGwWpWmlYgohJV74HDd9gMNVUzokLyfR2OlTe05YTbJb
         DP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1r7P9UsZbgNqNY1l6abhHXfspcGLO10OT1tcOU7stKw=;
        b=bXz+1qMDRYN9WSaQcmtEDCB4hkQdNxbonDUdBRhp6x8xSKo05augp91TnbtKzazOus
         hiQZPhxcVLAXWWgSEs6lYuCvNPCzETw+pqkKVitgXmZWl/AP8vpta/NN4W8kcy/fHB+U
         RC7oE3FaCNgq6HE55RkE+dy2fQOEj/9VsKTUtF1CxupkzGXYEdiAzxMUtOIFXIaU5Tj9
         MytKL/grilDb2eWOzToCJ4xoXiLPvJKxWqWOI0fYzxsEPnaNffpK2oR6MvSKMubEynDT
         6qqHxi9XuN6LyamL+u0nq6ZH3M4BxWI016dDxaeLBcHHNVzSxpoPtUP9hENg0OTcO3Ho
         yqhQ==
X-Gm-Message-State: APjAAAXVoPhU2Zk33ATtF/8s+UqI1vq9iTxBxIPG2dSvGxmHDBGVxEZS
        d1Oo++3RxpslQepxyf9xk07nN7LTln4=
X-Google-Smtp-Source: APXvYqxeg6+Lpg/EWNmgS98GOVvRTH8s8Zf/pDOjnLsBZJws8UU9v9xDgbwcDKg54dh83FoESlVVJA==
X-Received: by 2002:a1c:5fc2:: with SMTP id t185mr2564178wmb.95.1557311565420;
        Wed, 08 May 2019 03:32:45 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id f7sm2513280wrv.17.2019.05.08.03.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 03:32:44 -0700 (PDT)
Date:   Wed, 8 May 2019 11:32:43 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: da9063: Fix OTP control register names to match
 datasheets for DA9063/63L
Message-ID: <20190508103243.GK3995@dell>
References: <20190426140607.9D2553FBD0@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190426140607.9D2553FBD0@swsrvapps-01.diasemi.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019, Steve Twiss wrote:

> Mismatch between what is found in the Datasheets for DA9063 and DA9063L
> provided by Dialog Semiconductor, and the register names provided in the
> MFD registers file. The changes are for the OTP (one-time-programming)
> control registers. The two naming errors are OPT instead of OTP, and
> COUNT instead of CONT (i.e. control).
> 
> Cc: Stable <stable@vger.kernel.org>
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> ---
>  include/linux/mfd/da9063/registers.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

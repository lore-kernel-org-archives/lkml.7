Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7D1C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6AD217D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p63qBkbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbfIBJK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:10:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51398 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730015AbfIBJK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:10:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id k1so13680620wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 02:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=F+R1VokAMpRs9tEY/DwWMta9ZH4Twx4r2rQIJQM1G/I=;
        b=p63qBkbfBV6lM1WU5vBh/cE2qcf9fweRiYXdO/0wTiXgPKpFTvAtxCAzFOWh1eLBsA
         7+Vwfn6FbEbdu/HKroatQsZTneRFwAbHDcJfek36BDZtE8iFedFMxEioiM8YRSOaFrS1
         arJ9ZHt7P/19Dhl362GkEpEJ/vTzur/yebCX63WS2fUleJaEYFzlH7o9qaAtnEl1pSML
         fZYAvXQQaAeoGRw6W8QFFH3+CByWxgP+jtSI3MTjyZ/OJhKyIdFAjEFmcnuczQws4Hia
         L/hM0i4xkAN3yl/gnqaDHSdAwyigHY0j0XP1V+EIirNSPMaYNejTT2wqgzkEwBwxLA0x
         i8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=F+R1VokAMpRs9tEY/DwWMta9ZH4Twx4r2rQIJQM1G/I=;
        b=WZiozTbGG2emY12GMlagvknAzOEuJhKIn01VSlf1qtBocCH4JbBlO+4GZf9FAS2gXY
         2x1Jen8Nl9kD6r/qLgpmv8HEIrQuaA55nAIfkeQI+6mEojuImAUPgH3KVPb9mqlDbRHb
         Yx+7I/v+M70uGcGrCYLFaZQmIzo0r6AKj0MY5w+KIMEknndg9vmTYbPSFWK9xVTtG50w
         UY2C+RNom7KVrbGqOfevA2SKlgR+RlW+8z70vfuuNkFwc7fKd/vpQ3Yw8zHMvpxLcs8R
         JUsnMY6L/5KDzm5qYfwrS4I9VyjZruKxiPf58+AcihB3OUDVtJ5XHa5RaDwWDyshiEhx
         pTqg==
X-Gm-Message-State: APjAAAVJ7voAb6N7j1uXX+G1MyczY51pCgjj3rQoGLz6EqZhoz83uNRC
        nRvko9Hfm9C2YIuNG5rULP9scpBWIUDjWQ==
X-Google-Smtp-Source: APXvYqwFRKtM/WYAg/TV5ot4eMnd9RM3Jn9GeeEoncMi/2YqmCEYkjAamqX3AC04cglaU9fc5336gw==
X-Received: by 2002:a1c:a796:: with SMTP id q144mr26533342wme.15.1567415456793;
        Mon, 02 Sep 2019 02:10:56 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id q26sm905084wmf.45.2019.09.02.02.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 02:10:56 -0700 (PDT)
Date:   Mon, 2 Sep 2019 10:10:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: intel-lpss: Use MODULE_SOFTDEP() instead of
 implicit request
Message-ID: <20190902091054.GF32232@dell>
References: <20190821083712.4635-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190821083712.4635-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2019, Andy Shevchenko wrote:

> There is no need to handle optional module request in the driver
> when user space tools has that feature for ages.
> 
> Replace custom code by MODULE_SOFTDEP() macro to let user space know
> that we would like to have the DMA driver loaded first, if any.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss.c | 29 ++++++++---------------------
>  1 file changed, 8 insertions(+), 21 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

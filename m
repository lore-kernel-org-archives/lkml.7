Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B43DC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCCA2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W6xhQGJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389679AbfHHHcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:32:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50497 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389247AbfHHHcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:32:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so1344128wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 00:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cdeGr0ZxpYxqKAREv9bEF6Lm91cCQB0EI/1CSCmLaDM=;
        b=W6xhQGJMlLaAAbRWQ1WyaYi4nzW6FgHKCqeu16DMj3xQ9NcDv8miboXhZZvHZ+olQm
         SJYNhWb+65WGeIehcPPeiP5TF6NH7SXIQtvCXHpbyikuepwOJK5ptSd8GMuPEDOEQhxi
         eB0PteEAr5Z7sELHoQhZyM8jFbQARkLGZzbEuv1z6oB1RxdDjQB2F2Sg9V69Fw29prfg
         pGonXftshSo9cyF94m4j59zCMXqsUCPovyPGH1Vzj4Xf72eMZQNZpeMOJZoPXQJk8KqD
         /zXifkMFRXjGxwOqt9oe6Q1imyLZz4+0njOLivTbldf2+44apSNfJgrxN71Zyy/w7OUQ
         tWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cdeGr0ZxpYxqKAREv9bEF6Lm91cCQB0EI/1CSCmLaDM=;
        b=i2cLszM0xiWvWKHkK/HA8aOK2RrXxY/JbT1GS7AVT8VAqOPjGkWOm5Bk7lhKPl1708
         yHzPEqgRnWXL5FVAny4i5HBbpZnARBjHEiTUHkyUBijG7BBoZWwY/lU3Yu31GBCOQ+aS
         /7M0SH2Zlh/loh87r/mn6aBgCubBzt2e3x36zTHg2e5uIJrjBD2rK8OeLAcYquN4M8Cd
         L02tzkj1iXMrMnGdHLYbHErs2CceEPJpynxJEpm5RK2bprOwuydU87uMvNYtf7cP3VBr
         wPey62tnNV5hCXkcQiMyaw3u8U5A4nqQj6Wb9O+LcniULF9xVj7DajHd3PNmMlhdzu5C
         502Q==
X-Gm-Message-State: APjAAAXHbrdJiaiLXdbO7K2j10V1xeagC9QWPfv0aMw+RTL80CbuIBTK
        NHV6Uov5Pxe/LECqwS4ldCCV2g==
X-Google-Smtp-Source: APXvYqx/icXlgxHRHQn+sOev/u//ftapjI1TrAoW8rfx/t6xUgedYecR3Z9qwNPcmYzX3BSBTD1Dlg==
X-Received: by 2002:a05:600c:2243:: with SMTP id a3mr2497357wmm.83.1565249569173;
        Thu, 08 Aug 2019 00:32:49 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id c9sm1548602wml.41.2019.08.08.00.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Aug 2019 00:32:48 -0700 (PDT)
Date:   Thu, 8 Aug 2019 08:32:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mfd: aat2870: no need to check return value of
 debugfs_create functions
Message-ID: <20190808073247.GM4739@dell>
References: <20190706164722.18766-1-gregkh@linuxfoundation.org>
 <20190706164722.18766-3-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190706164722.18766-3-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Jul 2019, Greg Kroah-Hartman wrote:

> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/mfd/aat2870-core.c  | 13 ++-----------
>  include/linux/mfd/aat2870.h |  1 -
>  2 files changed, 2 insertions(+), 12 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

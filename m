Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B987DC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893E720679
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qgS5fB32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfKML2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 06:28:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42007 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbfKML2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 06:28:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so1917963wrf.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 03:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BmQn2+JI30pjs3q//rUIoFYr+fhQ3TzYqYpLdx2xVA4=;
        b=qgS5fB32UUmJ6yTR7LH+stMBJ/ij2CZSMU+0PstotBwYCMxul1AMI1wmeQTyBDf+o8
         XDT02unZSA9xlSCwWAxvKpDUmDVFiliY9IpXUCEUg4Lcran4E1+lA2E/G3Xtgfzt8jWE
         iiN/UDL7EDXlKdunhJ2Oe00fJ+8g9Hla9MLkZwn+ngCnxuNmUGpd5NDUet2XvXnTYZ2Q
         zpRRTt2a+CQajc0Ax94bv5jdhlnFNfSo1tYnLgRhDg8L8V72V6zi2JNOrBDGkLU9vHKT
         mIcyG64iQcsS0GsWlRIzul4M+EAhTEeKTQ8t/gto0ifpfyUOcG48uF6jfshyIYzhJyiz
         TPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BmQn2+JI30pjs3q//rUIoFYr+fhQ3TzYqYpLdx2xVA4=;
        b=V+KMrOjKFP+j1+vnCUwknlzIgugpYFRyLdgTFx8F7LKVZMWheGZZuayCAAxnQmeK3k
         tTXjElmKqS5L/w3YS/wt9/CO+mVcnTYvgqrAHL474lrXAOtSFi34GHydoFRwK+fWSAH4
         hKnp45r8+9XQRrbvJeHqoK3PBHq+oVSGRsqUEMOh95bWX5Mc6WpZne1t+j5qGadbfqE3
         FQS9GECHtRd4Z6ePfJpYZS+OL3pu4oq9Yo9MO/t/IwoBAv3mU3kjaLw5hQgyZ9pwpAXR
         5Yni8bIIbd+dtfmk2vAFzz09OUM9na1v8z+4igWouQbp0zP/SOcFAqUsH2OIMT3gzXCx
         A92Q==
X-Gm-Message-State: APjAAAUsYV5Nwvh4FNimB0lV8G9cXhxqGlLDn9+08murx2a2VU0D78zW
        hRY/5X9r6lL/aI2sWm5JbtWaaw==
X-Google-Smtp-Source: APXvYqzI/UviUoIaptTYvr3dfDojL0NhkcOZcwLl/yLoCK8a/JLscez0wAVXHOLpYzDql1uhNChAHA==
X-Received: by 2002:a5d:4991:: with SMTP id r17mr2405973wrq.176.1573644483751;
        Wed, 13 Nov 2019 03:28:03 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id c144sm2071122wmd.1.2019.11.13.03.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 03:28:03 -0800 (PST)
Date:   Wed, 13 Nov 2019 11:27:52 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v1] Revert "mfd: syscon: Set name of regmap_config"
Message-ID: <20191113112752.GA3285@dell>
References: <20191113102226.71492-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191113102226.71492-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019, Andy Shevchenko wrote:

> This reverts commit 500f9ff518cf55930c670b0e2b8901caf70a7548.
> 
> The original commit is a duplication of the exactly previously added
> commit 408d1d570a63 ("mfd: syscon: Set regmap name to DT node name").
> Revert the unnecessary later one.
> 
> Cc: David Lechner <david@lechnology.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/syscon.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

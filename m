Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B770EC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C9520663
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z5KMSQTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfHLJls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:41:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55966 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfHLJlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:41:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id f72so11502374wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 02:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ghSDQBe6NHYJS0160VuJrWezyQlXXK/lUqJBOhGGCQc=;
        b=z5KMSQTfHArgB/xchizw1naR4kaRCDimQGh6l+iwh95PBcTzLZFNAm8vLTg93mFWnO
         xy5wF9o3NKEDHHDxCQ8zH+UBuIrPSZoyOl6dWTtyD0Dx/mpODknKhQUgNvBIxhoAUuzS
         ERksk8W6RWT821IZA9/ZcRYavAotnSRp//4Ep9Tk/qoTIjEUlbUZ65Pfoj2seMMOhqhN
         uFqDsrjkXaProWwI16ceXqchxGG8MxyYH9grq05kodHOWHawxaPRYrEvf3JpuTNMU2PJ
         vHdWW/0Tk7vkszQU0Cb9SUu4+xOdsSdjRz9xX9XlNZALhLGzZeywdgTgn9fpriB7Z7mR
         7nYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ghSDQBe6NHYJS0160VuJrWezyQlXXK/lUqJBOhGGCQc=;
        b=PtjCS1MisBNKsYs1wq4F5kgZHXz6jHBhTqWiltoUHu+RLCgLR1aqdiW/Rno17ypNlx
         yqZMcnhxn1yunTsTBlzPF40E02kk+ggonmGSqJ79t+EB35zBgI65SK/BjZ4pTuKZWAQz
         5lZ0idz8bP31kUz/pfVogjsw8j2FS5pDjuIp88ricPiDkj8BLtX49k2dYEqkyzeGsP4I
         5jt82yfWVD589aklkg5e5MWvVNOoguZCvDMa3Id+TRU+6ZziTkkhe5Ps75D5CZOLgPYC
         EluRCMIatvLfQLSDtlwvu5fyfVbY/CIQ08AoUMRcUkAS/x6DJxW/jX6AxXB+TnLhcvLl
         Q/7g==
X-Gm-Message-State: APjAAAV5KVk35eiWGLshMCSB8tCY3SE+MZ+xIvsn1iDSfhi4UNPH7wqF
        EmVIJ1y7DehB6Zx8tFt5rm+4dA==
X-Google-Smtp-Source: APXvYqw+rIuAkbfOVDFgYlcFKTyUlKU+B3RNccQ4UuT+VQVYGnccuWJKM6WnyHN/JfurCqAtXbNUpQ==
X-Received: by 2002:a1c:ed06:: with SMTP id l6mr18701425wmh.128.1565602905662;
        Mon, 12 Aug 2019 02:41:45 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id n16sm6188281wmk.12.2019.08.12.02.41.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 02:41:45 -0700 (PDT)
Date:   Mon, 12 Aug 2019 10:41:43 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: intel-lpss: Add Intel Tiger Lake PCI IDs
Message-ID: <20190812094143.GC26727@dell>
References: <20190801132841.71645-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190801132841.71645-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Aug 2019, Andy Shevchenko wrote:

> Intel Tiger Lake has the same LPSS than Intel Broxton.
> Add the new IDs to the list of supported devices.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

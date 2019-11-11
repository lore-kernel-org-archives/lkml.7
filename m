Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C009C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49CE2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ttoY3wvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfKKIpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 03:45:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50863 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfKKIpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:45:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id l17so11534400wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 00:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EK18B9QZyV4jnCqfqkVYQrPKW6P0mT9Ad8azIEuB/P4=;
        b=ttoY3wvTzROazUqlKjqwt/l6HTPdwcAvzmwHO9jyTo64nDUomWbOL4wqLYnkrHu1nO
         w775gZq7o09MUhaxVfFY6/1JRs1jj6GebF69W3U1qC+wXkU9/DltXBovTS2wtcu/Tj3p
         ZBa8pak5Q8jAXq3FUwLcTYPfigNW+m59cB81Bx+oe31xgajk3OdddURjI4qbLF11KelS
         hJe7FJUFtbFzQtArsW3yEETMZOjbEtnWQLXyf+akz1Q5M+uMIS2parIOUDIwIRPU8dh9
         oBD2ZP445sKaCth0kMNa1/J1UWhbQYiNk3EOzdaWRvqhRfJxFCeq3X6HzbqkS8UmrNBj
         cYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EK18B9QZyV4jnCqfqkVYQrPKW6P0mT9Ad8azIEuB/P4=;
        b=HQahyT9eQzASv9auPtP6VgNX5D0/SCXXHerTbGtNOAqq7RrfzOEv3fIe6wIHBO0wiV
         KmcRfZJinmAQZHPBfVKPoy4C8m4dRC6XPUKhm9WcqaoCB+D/sadf8TkWpENdZ9mUeblr
         5SC8V+1AIoCWc6fTR/JPNUsmUhzIUWVWGHnJZodKB0lZDJjD4+GOfl+9o7apsB45cKxk
         jd65OKKqIlncFz2QMCQLS0Ok78J7y67FmzntHHU2dcU23NxGFS2LV9CpuCWGT1cfw16e
         /O2zWR3OmeyHrryO0ZhsiLUBVSZ2R9x4SEFhE9QiaBUaBi2QZyAbc1//bxC2yekCjuqx
         cuxw==
X-Gm-Message-State: APjAAAXN1pJr890xHDAykJ0rIDkRUUSq6hTePwmnuB07gsrk6Udujikr
        Xh5xOTKXvnmXlHsX1InzlYQI8g==
X-Google-Smtp-Source: APXvYqxcQjtkGYqFYtlGx4wVN1bfsfLN9y8wxU8r68YqnzJFwgi+pfxn3f8HlKzJvn7gZ0xn1msfZg==
X-Received: by 2002:a1c:7519:: with SMTP id o25mr18696343wmc.70.1573461941226;
        Mon, 11 Nov 2019 00:45:41 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id o81sm15961872wmb.38.2019.11.11.00.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 00:45:40 -0800 (PST)
Date:   Mon, 11 Nov 2019 08:45:33 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: intel-lpss: Add Intel Comet Lake PCH-H PCI IDs
Message-ID: <20191111084533.GM18902@dell>
References: <20191029094409.43741-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191029094409.43741-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019, Andy Shevchenko wrote:

> Intel Comet Lake PCH-H has the same LPSS than Intel Cannon Lake.
> Add the new IDs to the list of supported devices.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8808FC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCF5215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xaIwB5jD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbfIBI4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:56:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39702 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730657AbfIBI4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:56:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id n2so12307217wmk.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 01:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=csXIXezVfosSetvNhuk5RT9+DSjA7uU/OtWfWU7u/z8=;
        b=xaIwB5jDefFzK9+m9mOPZIUrZo6Ic+kYvM+u9LPnMVc29JCfvRBogoHbYNM9g+kmy5
         BDo26HjgDUJw8mGnDp6bS9pDBoU7S69VpvYwsJuCK5rVHiNkqFc4gev0QvG3cC1Id8Mb
         4F9V7Jhinus0F1CqwePw5V2k5QhVgl6oATUKwgBKF44HKRaC74qw6HfmIIQ9rpycbCL5
         mKs7OZUIB7xLBJNbA8VcCGdu2Q2Gt0kzSL3aKQycg6B1XW+cQpVlzSp9Gwmz7SOhEHRh
         h8ZFFolojUCHe05GBkU+GC7mYUImn4Sz6C5xxSIwJBd6Y+2QAFHUsEdr6ZD78/c2qOj7
         /GsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=csXIXezVfosSetvNhuk5RT9+DSjA7uU/OtWfWU7u/z8=;
        b=FxwX1MruAIfEWzsnijrV97Co8iK7M1RC+AiGbFu5MIdKuF0d20s2NVK5yMPYxX0Kw6
         FAuDjkMhtuRFHgE7tiwccquV6MjFV5P/zvR/degl1pejCih1xhcHTxXwGdNqgIjZ/IT7
         EqcQyhZMV7qkb8A1sytkSC7+DW7blVEfE6fxTy1vTZASrJrmCzFfTLl1KuuGssLE6Owi
         15N9Aug0cVjtJXcmQo/wpiDaAaNqr31PrQ8znmdNI1uMmvz/m+l3jqlxgKLYFFndyTpG
         n6Cl2wCgSfXxsDDeqBHmVjCn5Lk7k2GnTx2H0YXbNFvpV08IfpWyUBe6TF0iu6d8VOgf
         h9/Q==
X-Gm-Message-State: APjAAAUPB8FR8uBoylrtocIOopWizcmBZf2KJGTWutSkIFWEpb05H2DR
        4tf9rd2Z1kXlT7mBJ8Q8h/LUDUhz29Frhg==
X-Google-Smtp-Source: APXvYqzep+6NjkeLG3kCMMYMiYizZmsE98xnd6SL5Uu7F8L/cJrzQi8Z/ZEFDIW7kZYnhYunWgvmEQ==
X-Received: by 2002:a1c:1d8d:: with SMTP id d135mr7374757wmd.7.1567414579949;
        Mon, 02 Sep 2019 01:56:19 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id j1sm2629363wrg.24.2019.09.02.01.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 01:56:19 -0700 (PDT)
Date:   Mon, 2 Sep 2019 09:56:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: intel-lpss: Add Intel Skylake ACPI IDs
Message-ID: <20190902085618.GB32232@dell>
References: <20190816175602.42133-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190816175602.42133-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019, Andy Shevchenko wrote:

> Some of the laptops, like ASUS U306UA, may expose LPSS devices via ACPI.
> 
> Add their IDs to the list.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-acpi.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

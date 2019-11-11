Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC1CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E277E2196E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dgM+/geC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfKKIle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 03:41:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43680 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfKKIle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:41:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id n1so13574134wra.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 00:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hKfSs3Nj7VqeG2uAfXiugrhUE69Zz52fpCqjC/5SwVE=;
        b=dgM+/geCygg1uYNJilJ1O6oBTQ1NAi2zkXQQaPign4Y4xmyj9nIhzhEIWf+YHyEGMp
         6+o8MBsb0gDh89GClv0Do6xva5tecd61M4TqlNyuChUyYETlDN0IvHHj3V++MvoktwFs
         /rEAsHT/KQ1SYODkRRn5q52c+G/kKunpARUFVUQ0A2v75a1rxJNcidJqGzICLUeSwBbo
         Mt2/CzOaOLBMr84IGMG0/JhjsZyVEtVbo++8muO3lkDW/V9RR6W0ZMN2BVzYU6+nFL8/
         Bd/ke/g1l21P8lwwfplScdudSZNJybmwAr4tdAQWH2BqBf9ttfgwiUmfLyz995txFk9k
         WHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hKfSs3Nj7VqeG2uAfXiugrhUE69Zz52fpCqjC/5SwVE=;
        b=un/idnj7aO5FYN1AkLhISA5cuvjOy2sb3w2gLqN5bAvO1gs7bE85Br4smItO7dzv3E
         qv8xXJI9zolUTmxUxVDxYJGwBhKuo7AJhtqhMbHX7E6YC/JZ520FYQY09Ahp8brp+CRO
         WVcTKD3IwrdJtSotCSbLj7q7BRfjiq2WnhuxT7Sz0qRlNw/vtNjAni9zA69455Qo0Nuv
         KU21MUaG6zx7cq2BPuDbnec9CgkbUtoMSt9AZ+RNh+OOZXCVASQW8FwUSz+oLw1bjTc/
         krey3coJxxfMQyqnTBY+RNPaonnmQ7Zyqomg1vjvvYV9s2E7hg4Ibhra6M4Avv8XEuLL
         QRYA==
X-Gm-Message-State: APjAAAVBbLB2c8uyzgPtB0CrOkAJW3iqGfs5CnkVS5jPkITOJlB9bwkS
        JvO/XWeFEKaOJc290894TIZaGw==
X-Google-Smtp-Source: APXvYqyPPIA6Ue1we/xjKN/Mi3P1KtGZTemPi4XnnZd1LfBwJZzenbu1U6t8JIYL4oYJM5F/wpJ+tw==
X-Received: by 2002:a5d:6a8d:: with SMTP id s13mr9023717wru.23.1573461692077;
        Mon, 11 Nov 2019 00:41:32 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id w18sm19913357wrp.31.2019.11.11.00.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 00:41:31 -0800 (PST)
Date:   Mon, 11 Nov 2019 08:41:24 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Tuowen Zhao <ztuowen@gmail.com>
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        mika.westerberg@linux.intel.com, acelan.kao@canonical.com,
        mcgrof@kernel.org, davem@davemloft.net
Subject: Re: [PATCH v5 4/4] docs: driver-model: add devm_ioremap_uc
Message-ID: <20191111084124.GK18902@dell>
References: <20191016210629.1005086-1-ztuowen@gmail.com>
 <20191016210629.1005086-5-ztuowen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191016210629.1005086-5-ztuowen@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019, Tuowen Zhao wrote:

> Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
> ---
>  Documentation/driver-api/driver-model/devres.rst | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2F9C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E049B20856
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GGcUwzWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfKKIlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 03:41:07 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:37006 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfKKIlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:41:07 -0500
Received: by mail-wm1-f50.google.com with SMTP id b17so4005780wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 00:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fHZyE8Y/b8/GHffAqrPVxeIUbjpAPExpWpCVapn1zRs=;
        b=GGcUwzWMI30zR3zzL3Dd51RVCN7QhF9Gywr088MgsZeIMaVjBt+6rFT/fPdKegOdFA
         xnmqWYvAo6PaUKE4zx5x38NJU+YHygWTsvPAL169sJbdpY8iWQJmaxt6wtPn9pEMtraj
         JjLK34uYME6RrMLi6zvFUbIH3GYk7pMSb+qJxrRlIox+GN6vUq98YbUZH9VzKNuBUNep
         w0qLcEvfADIx1995pAKdVIAE3v6Rz6TZ0NlVas/gWYwe/W55hMd/vzJrcftSNSyTCxO8
         9IJtdT/F+7UB3KL2zfuDZb/VSWM7+RN5vWVRfm6ocjdXQW6Cs4jKYUQZi/i1/30GMea5
         phpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fHZyE8Y/b8/GHffAqrPVxeIUbjpAPExpWpCVapn1zRs=;
        b=kKIVpDIAfvhQSt9Ku8t51TGaf3Hhpeyy09nVNgfe4TSlD32isB5rGcDPj+Qi8ZXhB7
         by6A0s9+6YPINuNGYFU/KzIMBxrF1ETaI0w79KTYUVXSUkaE+eP/BxiIU7DkAzw58PZf
         M7OOiZChWfy7dBLg1p1RsQVCbCVaPicq9q4fFir2cLGrpNFPvowjhnavco7zsGKGkpc3
         5iBEKpvYGLOaDzgGS5r88xPAoE8lACclI0liqanVFQC4KqYjL2k0CbOTsDYpYP3yqI6+
         ZpCLrciqJuDSo5RFjPfLJLWMcgX9zOJkC3GViZto+2b2Dt+BozNGhdGWe2n1NraXwpLE
         Pi0Q==
X-Gm-Message-State: APjAAAUjvdALj3Nv7FtGyKlfVsJO8A8pSHEw+Hz0jofb2/OZBbwZ+Efz
        QF+rCz3h6fW3uOLwO5wSfLGOBA==
X-Google-Smtp-Source: APXvYqyYxXpSsfbYQwWrLdnLfBzUFE5L6oQoC05Z3sgSlHmWv96hgSucSAPFAT1/nVg0u6XrrV3kNg==
X-Received: by 2002:a1c:f317:: with SMTP id q23mr18617215wmq.97.1573461664231;
        Mon, 11 Nov 2019 00:41:04 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id l4sm13422936wme.4.2019.11.11.00.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 00:41:03 -0800 (PST)
Date:   Mon, 11 Nov 2019 08:40:56 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Tuowen Zhao <ztuowen@gmail.com>
Cc:     sparclinux@vger.kernel.org,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        acelan.kao@canonical.com, mcgrof@kernel.org
Subject: Re: Fwd: [PATCH v5 1/4] sparc64: implement ioremap_uc
Message-ID: <20191111084056.GH18902@dell>
References: <20191016210629.1005086-2-ztuowen@gmail.com>
 <5c5b9dec7ea401fffa13446af2a528cbaf6e1046.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c5b9dec7ea401fffa13446af2a528cbaf6e1046.camel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019, Tuowen Zhao wrote:

> Adding sparc list. Sorry, first time missed the list.
> 
> Looking for some reviews.
> 
> Patch set: Fix MTRR bug for intel-lpss-pci
> https://lkml.org/lkml/2019/10/16/1230

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

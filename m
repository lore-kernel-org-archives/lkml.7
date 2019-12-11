Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F012C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0276B2073B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pOLJCHVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387813AbfLKPod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:44:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44506 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733014AbfLKPoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:44:20 -0500
Received: by mail-wr1-f66.google.com with SMTP id q10so24539221wrm.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 07:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zTeAMitJBFyTpo1SLC9FDWJuZxg2pIG+EP0HCZfhl0I=;
        b=pOLJCHVHJYDyPogESOHu5eSOC0iZmXtd7Moc1RqXnzMeYrkXXT2uJ6MN+GBcjIldDo
         N1NMWAndifJdnJNZujfnuX3xAPYEhliqNfRumigz/7iXep+ev51u+JvMzEFpirxxTht1
         S/lkPoW8wEQd+UFqCafa6uN+m+ws8r2r33fNZjI4C9Jkkbd4mU959c3nooEd1d0rMm72
         nMUdhdjTR7gKaikD2XYXDfm0Hr4zhYNIYfuml8NF6wUeYNZ6HbKRMFNPk8H7celmF9y2
         pLKwPfg3PKXGEhKpXxODcgtOwjUkqFK0SjgxOgYiFnUJiSyFTJToigREJ56mUm80oBcw
         on4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zTeAMitJBFyTpo1SLC9FDWJuZxg2pIG+EP0HCZfhl0I=;
        b=tKiuV5GTV8gLyL4AlbY4jGDbahOt2N81vVHAzxlWARTJHnKDUlGbEthzHdwR2utUHv
         II07Ur4FGOcFjvZD5dkHebm/44CCZ9C1QOnAMgaqyo3bNcJtc8sTDgBewTGRZvFtwpZl
         G+FLaHJN4BG/Dsd0p2/3P4QZwLBd9D+P7Ql9MoVq9iYbR14qYDbb0HQuAF8uBn7T80UG
         KdqiOOgi+EJTThEbmzxeHQlBqpEyQVDGsIlRoa9yq4tZS17pcRxXByuJ0L+e9uA1v5iC
         s2wKdd85QtOiyDVt07hFzY3xof9r1CrepHbilYiqnSJ5nY3IS9wDfbO2pHUkOb54AY69
         Ah5A==
X-Gm-Message-State: APjAAAVO1PkVrpmXDV6mIMPLsTAOFWtqOsFJRGTcV7/tHQeEBq1xyMvN
        hN0yz34dxFBXSn9dQ1kF2Vcn/w==
X-Google-Smtp-Source: APXvYqyb4Pp7PLP/3DKnjab13q0ueZ+RiAZW/2+2GzBfRU2szkzvYsUcLcSImdIwSLGU5xpIHlfSTw==
X-Received: by 2002:adf:e591:: with SMTP id l17mr404663wrm.139.1576079059232;
        Wed, 11 Dec 2019 07:44:19 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
        by smtp.gmail.com with ESMTPSA id z12sm2693401wmd.16.2019.12.11.07.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:44:18 -0800 (PST)
Date:   Wed, 11 Dec 2019 16:44:16 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iommu: virtio: Use iommu_put_resv_regions_simple()
Message-ID: <20191211154416.GA1927@myrica>
References: <20191209145007.2433144-1-thierry.reding@gmail.com>
 <20191209145007.2433144-6-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209145007.2433144-6-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 03:50:07PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Use the new standard function instead of open-coding it.
> 
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

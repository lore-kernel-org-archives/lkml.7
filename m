Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA9FC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545982084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="enBXaEXp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387900AbfJDRSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:18:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38541 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387458AbfJDRSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:18:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id l21so6628187edr.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 10:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P6ILDe87atoSpFhr4YLtT8v1Dvs0XN+7b56hhQlsV+s=;
        b=enBXaEXpHjow9+Pz4mdlFTKzl3G3RGqsECSmVPyToON6sDWTvSqWHSCx3aJP7zHb8m
         c5uclc8HWH8hKvhXKNL0V66ONtWbEHwLYEKfdDFvB2KSdfzcCscgixU48XqCxakcz/FZ
         +qIWnSiT09Tf9EyszAAZicDPeHJ5BrbR8rjE7aaiuwurLJA1u9SBnHjmsCMQJKhElirg
         3Qhh9ao8k5amjIpmewf2qbDCXbwfHZ4YoESlQVwSlJiqcB76aEbrl7hu5ITYQIiY+qyI
         Czo3TxSQRSd/4RyxPrqJtpyVh/yUh1/W7htb9LUJ+WVZaB22qdnYAd4q5YLPc3FHkbz6
         G+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P6ILDe87atoSpFhr4YLtT8v1Dvs0XN+7b56hhQlsV+s=;
        b=Q16ze2IaqyWWvSm9+5w4ie6M14GQs288k5jPPqNd8/PKxPB1bbLNBEiZKXUQa/ejzw
         3DDo5ksHxy0k8u5UAWl8prsswJLOT/1wrRlD7UDKQ06CXcUyO5Msr2/Gai1JLS9vqrzR
         tQwTYfnx0VNE/KtWGI7i/Jtkt+gDQfQJTeXpoA/bHoJjMTs5NG1LBSRH22gFsxA5UKjT
         KyZYm3RcJM+jJBuOJqcX0rW1SvIF07uHLRgCC+d/KAxFOKXBrQXj0Q00/qeKM8gZlGg2
         M7WR+Pqp3nDtQ4+yrlsydymFom3g5ik9nCvB8Rh6cTkW55wM+E9Co1hZOwS6kGpqEbs+
         ogjA==
X-Gm-Message-State: APjAAAUz/gOlSmWNEyjLp9imzyyAQIDPVMaUGJ6ujyWzHgbeYqPKUZtP
        40wcVfqWIT6S0WtkPhDdQ6EftA==
X-Google-Smtp-Source: APXvYqzwBvrnmFzZsa1Mpgi+XTXje83ZYwyx65gwJfmNiNPb0bxR4U6+rzPdd2I0VzhmJVaxNcWfaQ==
X-Received: by 2002:a17:906:b30b:: with SMTP id n11mr13772893ejz.35.1570209518810;
        Fri, 04 Oct 2019 10:18:38 -0700 (PDT)
Received: from lophozonia ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id s42sm1230595edm.57.2019.10.04.10.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 10:18:37 -0700 (PDT)
Date:   Fri, 4 Oct 2019 19:18:35 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH v4 3/4] iommu/ioasid: Add custom allocators
Message-ID: <20191004171835.GB1180125@lophozonia>
References: <1570045363-24856-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1570045363-24856-4-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570045363-24856-4-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 12:42:42PM -0700, Jacob Pan wrote:
> IOASID allocation may rely on platform specific methods. One use case is
> that when running in the guest, in order to obtain system wide global
> IOASIDs, emulated allocation interface is needed to communicate with the
> host. Here we call these platform specific allocators custom allocators.
> 
> Custom IOASID allocators can be registered at runtime and take precedence
> over the default XArray allocator. They have these attributes:
> 
> - provides platform specific alloc()/free() functions with private data.
> - allocation results lookup are not provided by the allocator, lookup
>   request must be done by the IOASID framework by its own XArray.
> - allocators can be unregistered at runtime, either fallback to the next
>   custom allocator or to the default allocator.
> - custom allocators can share the same set of alloc()/free() helpers, in
>   this case they also share the same IOASID space, thus the same XArray.
> - switching between allocators requires all outstanding IOASIDs to be
>   freed unless the two allocators share the same alloc()/free() helpers.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Link: https://lkml.org/lkml/2019/4/26/462

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>


Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02D7C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA47217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442351AbfIYGuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 02:50:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405260AbfIYGuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 02:50:19 -0400
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0EA486662
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 06:50:18 +0000 (UTC)
Received: by mail-pg1-f199.google.com with SMTP id e1so2983816pgg.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 23:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qR/cKb1LH4Ut6XBt6GUfg+wU8+q9TeAgUhlA6c+rO4c=;
        b=MgMtkle6r6y5RxP8vgffUPP0ERwB2pE/u9g0RH/0ZDBZ2fJOUE92rAhqBUnVBmYUdM
         28jYSO2KHHc1hkC6SDploDeoZVNseOWWdGkW3xIgE5vu9dxuA4+7OJsKH4DxRcmhTI9c
         yRgDqJ7JKT7YRISQWpDl5XopyG1NtudH+OC4zcc+Nn2KlBRckVFA9JVS9GF7BVeQGBlE
         UkyiAqDQNSwJOFjmhFC7eEU7tvIlmmtvnuUANBuJ8L+nr939lkm/imab2aVYB4g39f4B
         pamaPTQ8wweP3/zvv8ujbc5laeQNwftWoz4wdWZKvnXBjvjgEfkArhkvymuYfaeIfR0v
         PJCw==
X-Gm-Message-State: APjAAAWY7rmTxbkECGf+KPX6Xogu9UetTHpFEiRqJYefbM4N8xnWEkj5
        BBU8h6r/K+tCdAkEaXGnwgMMDWGEb6ylTnT+HOhOeG4ObKtlB2hdQ5uD6PtJKAWhBXaVbpFT/Id
        pmNbZUGOL/pF3T1gtSWfbsSkS
X-Received: by 2002:a17:90a:32c8:: with SMTP id l66mr4786660pjb.44.1569394218437;
        Tue, 24 Sep 2019 23:50:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqypWllblpMbhsSgwCAwLu+m/4ke343KRyPgiqd/aaN/IjsSQuc6mo4RWHK4cbHfclvFvQlQKQ==
X-Received: by 2002:a17:90a:32c8:: with SMTP id l66mr4786640pjb.44.1569394218177;
        Tue, 24 Sep 2019 23:50:18 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u1sm3296193pgi.28.2019.09.24.23.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 23:50:17 -0700 (PDT)
Date:   Wed, 25 Sep 2019 14:50:06 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        kevin.tian@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
        ashok.raj@intel.com, kvm@vger.kernel.org, sanjay.k.kumar@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        yi.y.sun@intel.com
Subject: Re: [RFC PATCH 4/4] iommu/vt-d: Identify domains using first level
 page table
Message-ID: <20190925065006.GN28074@xz-x1>
References: <20190923122454.9888-1-baolu.lu@linux.intel.com>
 <20190923122454.9888-5-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190923122454.9888-5-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 08:24:54PM +0800, Lu Baolu wrote:
> +/*
> + * Check and return whether first level is used by default for
> + * DMA translation.
> + */
> +static bool first_level_by_default(void)
> +{
> +	struct dmar_drhd_unit *drhd;
> +	struct intel_iommu *iommu;
> +
> +	rcu_read_lock();
> +	for_each_active_iommu(iommu, drhd)
> +		if (!sm_supported(iommu) ||
> +		    !ecap_flts(iommu->ecap) ||
> +		    !cap_caching_mode(iommu->cap))
> +			return false;
> +	rcu_read_unlock();
> +
> +	return true;
> +}

"If no caching mode, then we will not use 1st level."

Hmm, does the vIOMMU needs to support caching-mode if with the
solution you proposed here?  Caching mode is only necessary for
shadowing AFAICT, and after all you're going to use full-nested,
then... then I would think it's not needed.  And if so, with this
patch 1st level will be disabled. Sounds like a paradox...

I'm thinking what would be the big picture for this to work now: For
the vIOMMU, instead of exposing the caching-mode, I'm thinking maybe
we should expose it with ecap.FLTS=1 while we can keep ecap.SLTS=0
then it's natural that we can only use 1st level translation in the
guest for all the domains (and I assume such an ecap value should
never happen on real hardware, am I right?).

Regards,

-- 
Peter Xu

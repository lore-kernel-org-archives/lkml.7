Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2389CC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 04:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DF020665
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 04:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633936AbfIYEbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 00:31:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442273AbfIYEbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 00:31:04 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 572987BDA1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 04:31:04 +0000 (UTC)
Received: by mail-pg1-f197.google.com with SMTP id r35so2782369pgb.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 21:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ynUg0HQbXYGY2EZQxVg6auXL0jYkF08J5NPdzyoPwU=;
        b=LK5D4BvpaJhXze/8hezTV2JtY4sLr5E2QaDF17SBM3jdEYlAuMvct+RJM3o0/hTLOa
         /HE8vWYLwGjrA+dNRbDHv7ReBb8yRWfnceiPdmuiFnu5OegvloEt67slyFUloMreSJKr
         DYgEkxDBshvhjP7j0CeoFWDBE4wxAqvwg8uHUYJrFUd1QzdIgTX8mMUCArrXhtv/BEf5
         6N0QK6c44VvTrnr0/AojRF7Ua8UACWj86NDZsApiDfgq8TlDaHPuLiHBHLU52IsaIx5d
         eVGP/dYGMdGqWtTx8pCp6pKNWQ28M5mmLyawj9jT+8Y01uPSt+UJcsGbjM1o+hcaLu5J
         9daA==
X-Gm-Message-State: APjAAAWdPAPHeKOlt6mbF0wFKHJAd+W4PvLs54Q/izJWXzPmGKcg//AR
        DiAZM5nzdyt8VTytuDlBdp921Ae0PBqsWUXds7to+UUGAoqkCVPRi9yA3r+IEdvBq+pBgk+sFKO
        nw5tupXBYJ5Is38kL8v5rU5pB
X-Received: by 2002:a17:902:7796:: with SMTP id o22mr7013586pll.222.1569385863921;
        Tue, 24 Sep 2019 21:31:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxYc48a4lrqvlO6kVhQ/UCi7qF+uCt4R+18KQwSaFo3Uxwb45dh8PhpKk4Lh42FKW2HgHzXYg==
X-Received: by 2002:a17:902:7796:: with SMTP id o22mr7013535pll.222.1569385863511;
        Tue, 24 Sep 2019 21:31:03 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id ep10sm6428239pjb.2.2019.09.24.21.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 21:31:02 -0700 (PDT)
Date:   Wed, 25 Sep 2019 12:30:50 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>, kevin.tian@intel.com,
        Yi Sun <yi.y.sun@linux.intel.com>, kvm@vger.kernel.org,
        sanjay.k.kumar@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC PATCH 2/4] iommu/vt-d: Add first level page table interfaces
Message-ID: <20190925043050.GK28074@xz-x1>
References: <20190923122454.9888-1-baolu.lu@linux.intel.com>
 <20190923122454.9888-3-baolu.lu@linux.intel.com>
 <20190923203102.GB21816@araj-mobl1.jf.intel.com>
 <9cfe6042-f0fb-ea5e-e134-f6f5bb9eb7b0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9cfe6042-f0fb-ea5e-e134-f6f5bb9eb7b0@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 09:38:53AM +0800, Lu Baolu wrote:
> > > intel_mmmap_range(domain, addr, end, phys_addr, prot)
> > 
> > Maybe think of a different name..? mmmap seems a bit weird :-)
> 
> Yes. I don't like it either. I've thought about it and haven't
> figured out a satisfied one. Do you have any suggestions?

How about at least split the word using "_"?  Like "mm_map", then
apply it to all the "mmm*" prefixes.  Otherwise it'll be easily
misread as mmap() which is totally irrelevant to this...

Regards,

-- 
Peter Xu

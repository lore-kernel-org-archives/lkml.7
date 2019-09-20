Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC85DC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933CB2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p0JX8gdM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404623AbfITQdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:33:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42929 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389956AbfITQdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:33:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id y91so7041777ede.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 09:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lz9d3bT2iTDFavDzy6sAIcID8XZxtTEbzw7l4vQwzrM=;
        b=p0JX8gdMWPJU184XlO69i0Dlt3nW8kFvKt8mI963agSS06/JfSoqSlNokWJrWOKWTm
         34RIqR5pKEa+G7begH2OXw4SQshgckQPX/dXppsMtx+N2MeAdFmLsgDOLXqoN0UkXhoi
         QojJOoTY7Xi5lrmxoWHP/xp0t0QhRz/4ipE6wAexrkOYXdfFuSotQe7avVo0e7lsoGhS
         wtwhC7Go94C8+nRODNZTDZeIctMnWV806PBo4h4LUEJnV3BuyrWZyVrM2uDVyubj/aA8
         B3LFm8EMoUqz12lM4t85gB/96Q5Y5L/78XophmMcqaoqescwo+YIpC80OGyBz8UjhmAh
         fdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lz9d3bT2iTDFavDzy6sAIcID8XZxtTEbzw7l4vQwzrM=;
        b=eI4hpx1bhcSTFYlxrrIV+yVMSAuf101Pt/Xa5BFsqwGnRyqiuNnb1f7WzxLXwoPhSJ
         ByL2hUuB7pyYdTuOZrLT7rqZVroYjl8oL0tNRMvW+l1glOcSRnIbsX+KqpK4toRTugMq
         F3lDOsIsYq+p09P9tJK5u/C1rxMPFqJsLEj2wxC6uR/VSohexAaxqJoj9qHZ7evoz7OB
         WNICbqq9abpuoMUhW5qACSRqRrTIvW9fD8h5Aiul9VWTJR+jmNozxv/LLTcSaWMCBoFD
         SmgKYDInYBSsBGYOH3eKonwqSUSuhYUZR4lTDPhKa1LoNzM//BMQblikz4ImDv5+9Z/Y
         tkzA==
X-Gm-Message-State: APjAAAUUqXiQFR7tdr441HT26sFG7eoq80rN6Nfdxd/N9MdCbU9Dnskm
        19Xr+6yEaE2HqQbHZAX47ODIjw==
X-Google-Smtp-Source: APXvYqzhC+eWw5Se8TuzumlFhoWwytYvsZACh42IA+xfxeZVTTmhMBFQK9tBtPE5dAtAIa6Slhjkjg==
X-Received: by 2002:a05:6402:696:: with SMTP id f22mr21000371edy.216.1568997209854;
        Fri, 20 Sep 2019 09:33:29 -0700 (PDT)
Received: from lophozonia ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id s16sm406346edd.39.2019.09.20.09.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 09:33:29 -0700 (PDT)
Date:   Fri, 20 Sep 2019 18:33:27 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 2/4] iommu: Add I/O ASID allocator
Message-ID: <20190920163327.GB1533866@lophozonia>
References: <1568849194-47874-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1568849194-47874-3-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568849194-47874-3-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 04:26:32PM -0700, Jacob Pan wrote:
> From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> 
> Some devices might support multiple DMA address spaces, in particular
> those that have the PCI PASID feature. PASID (Process Address Space ID)
> allows to share process address spaces with devices (SVA), partition a
> device into VM-assignable entities (VFIO mdev) or simply provide
> multiple DMA address space to kernel drivers. Add a global PASID
> allocator usable by different drivers at the same time. Name it I/O ASID
> to avoid confusion with ASIDs allocated by arch code, which are usually
> a separate ID space.
> 
> The IOASID space is global. Each device can have its own PASID space,
> but by convention the IOMMU ended up having a global PASID space, so
> that with SVA, each mm_struct is associated to a single PASID.
> 
> The allocator is primarily used by IOMMU subsystem but in rare occasions
> drivers would like to allocate PASIDs for devices that aren't managed by
> an IOMMU, using the same ID space as IOMMU.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

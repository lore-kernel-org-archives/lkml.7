Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A33DC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DA220706
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="XbGG7IUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfKVO7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:59:25 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:32856 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfKVO7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:59:24 -0500
Received: by mail-qk1-f194.google.com with SMTP id c124so2092256qkg.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 06:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=czmRFawPbRA4wPPyXKr/45ohSDBaFeSUF30l90PueKM=;
        b=XbGG7IUMCmvWd+2Zfh4Z0zzCFA2YV9Yk+qwUrcoqfwiSOEtswc8NG0bzARjBR78kiH
         hLb8AV81UBoA8FtccPYG4v/yLV//ZNkm1u3EEzcciUrmcKt6ohVHbE/f/ctoKSBy/ASi
         Z9XsVYrMHoPtFkr3OVpIlc7TvtjnA8BtHxI72MjvHJnn03urkucOhHS3B87CpoTzlP+O
         cdRJcMcmTCp7vvt5aQhm21ls6lvUhdZmRKnraFhGm3/NnVk9FbP1v0Shmy7/aByw8ohz
         JK4k7eow7o64LXPM5WE2cQN0KV8APCyDDkZYfDiRkOCosZWeF1FAFLaJ/20UPDf7t0Ag
         T0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=czmRFawPbRA4wPPyXKr/45ohSDBaFeSUF30l90PueKM=;
        b=cGyemhRN/budIXCOfhAcqu2jzvsConlrXcFw5BrSH/gKRq8ZLQGOD/SyUU92QsR2cc
         8CYA6WHGiyD9hf3r2xrgAyAW/ZsaxW7y0X35MGdQfSYopVHnpZdNV7wraKUY+Uz93CMk
         JWcXQDKlx/cZsKDQo2PFKrlmEIUNVG3rUo/ne4RkYCC1S+JouiEWRZ4w56fKg9WZV+I7
         4WTOC/0IM7+7bkPUMT2QS9xZjyLkhN7iZPXys5KemIv0fGAjBytkP9D5YUbIzGVEvs7Q
         LaCOXM2JbIyTV8mWdqph1eA3o1WKSL5oHwPKhrTE2yRpTTd/fLVE4iMiY5fa78Q3LsKP
         adLQ==
X-Gm-Message-State: APjAAAWkOB8vko2hV7Y4e43GF2GWx2pXu+OijkeITe6+KiJGt5PyYyCr
        kU0E0Ops27+dXkqV1eKvb8nQlSoIz+8=
X-Google-Smtp-Source: APXvYqxM/Mq/oZx9N3SQRd4yH7GRI8jHA57x9C0cgRY6OyHUe5QZyZcJZVN9LAmaC1fIu8T/1NRQWA==
X-Received: by 2002:a37:a642:: with SMTP id p63mr5872287qke.85.1574434763130;
        Fri, 22 Nov 2019 06:59:23 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j89sm3496929qte.72.2019.11.22.06.59.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 06:59:22 -0800 (PST)
Message-ID: <1574434760.9585.18.camel@lca.pw>
Subject: Re: [PATCH v2] iommu/iova: silence warnings under memory pressure
From:   Qian Cai <cai@lca.pw>
To:     Joe Perches <joe@perches.com>, jroedel@suse.de
Cc:     baolu.lu@linux.intel.com, dwmw2@infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Nov 2019 09:59:20 -0500
In-Reply-To: <7fd08d481a372ea0b600f95c12166ab54ed5e267.camel@perches.com>
References: <20191122025510.4319-1-cai@lca.pw>
         <7fd08d481a372ea0b600f95c12166ab54ed5e267.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-11-21 at 20:37 -0800, Joe Perches wrote:
> On Thu, 2019-11-21 at 21:55 -0500, Qian Cai wrote:
> > When running heavy memory pressure workloads, this 5+ old system is
> > throwing endless warnings below because disk IO is too slow to recover
> > from swapping. Since the volume from alloc_iova_fast() could be large,
> > once it calls printk(), it will trigger disk IO (writing to the log
> > files) and pending softirqs which could cause an infinite loop and make
> > no progress for days by the ongoimng memory reclaim. This is the counter
> > part for Intel where the AMD part has already been merged. See the
> > commit 3d708895325b ("iommu/amd: Silence warnings under memory
> > pressure"). Since the allocation failure will be reported in
> > intel_alloc_iova(), so just call printk_ratelimted() there and silence
> > the one in alloc_iova_mem() to avoid the expensive warn_alloc().
> 
> []
> > v2: use dev_err_ratelimited() and improve the commit messages.
> 
> []
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> 
> []
> > @@ -3401,7 +3401,8 @@ static unsigned long intel_alloc_iova(struct device *dev,
> >  	iova_pfn = alloc_iova_fast(&domain->iovad, nrpages,
> >  				   IOVA_PFN(dma_mask), true);
> >  	if (unlikely(!iova_pfn)) {
> > -		dev_err(dev, "Allocating %ld-page iova failed", nrpages);
> > +		dev_err_ratelimited(dev, "Allocating %ld-page iova failed",
> > +				    nrpages);
> 
> Trivia:
> 
> This should really have a \n termination on the format string
> 
> 		dev_err_ratelimited(dev, "Allocating %ld-page iova failed\n",
> 
> 

Why do you say so? It is right now printing with a newline added anyway.

 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed


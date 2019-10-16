Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7A7FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5EC221A49
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="g/UCtlkl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405888AbfJPPxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:53:38 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42849 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfJPPxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:53:37 -0400
Received: by mail-qk1-f196.google.com with SMTP id f16so23211887qkl.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 08:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oq8S8FNdMSuL/j2d44Hg8fdfb7pmW+shnprb4O6S0Ms=;
        b=g/UCtlklSOkAfjTb2IAewWlunaRFdtYuwHMWE8nNLQ52+TqEcZ1qL/XW462jg80nGS
         KgDr+S/7Ei+ZW3CubrhL/AZUB2dUkGZzRCsFdN2MVKjRJG/YjZqpH+PvFASc6LYmK0AV
         eBHPtw7EOXqppjPq93B0t0I97Ize+AuCMiLcqrngzlHh1rUiiBwrWIglzOyukM5QRquH
         WtjzZj5U379YG5DAQ5ONkHvx/Wv6zd7Mik+szBaEsyj3bQOex+aDDyWrcVE8wgvzxin0
         At9cChuOxbOABCJSuRc8svEWhU/2I+YbDjEnlbq2Dg2cU+GxIwZ/YCoyID/ZdzI2s8nP
         Cl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oq8S8FNdMSuL/j2d44Hg8fdfb7pmW+shnprb4O6S0Ms=;
        b=slPJvsZKUkaoWKxgMzgEF6fRMLBLdSDHGBSglYo2VAUfA8fcyw8W6H77AnBVW+E7tT
         IvrGuV8qCWb9hiMYWTuTPVVIJeogOP+djOVxFNdFqHzLqoHnO8ou1+PB/xRny+dX00nd
         ZjPvO4Endp8TCpkqtEZ/fhTph4yCcxkjdAr2k/lCtT31wwBLaeeYHnNPURcXtAAOj3ZH
         l647xe0TtmhXWzD/ZddURdFofHBpWRgzYDI1CyB5PHew3GcWd+FnF/dFrM0ZzxoQmoav
         v1Es5P46W2tRdztC9tUpa+Y63VeBZ00/DC+rg/BumZ91uY7vacOImRb+17p2dSuL5841
         4OVg==
X-Gm-Message-State: APjAAAUZnVvzCF5vg8wZv1lSNwg0qyB0sfBwLGffem5+cMNDUgXyuNMj
        1bv/ZrrYOACT8axhEls4encFLg==
X-Google-Smtp-Source: APXvYqxrfQDTp4TMHFewBROXx/2TDqe/t+wvoX4f1U9HFPFkND2wBump3a4cR8SrdyIuEfiv6K6V2Q==
X-Received: by 2002:a37:2ec5:: with SMTP id u188mr41488023qkh.94.1571241215231;
        Wed, 16 Oct 2019 08:53:35 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d10sm1683190qko.29.2019.10.16.08.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 08:53:34 -0700 (PDT)
Message-ID: <1571241213.5937.64.camel@lca.pw>
Subject: Re: "Convert the AMD iommu driver to the dma-iommu api" is buggy
From:   Qian Cai <cai@lca.pw>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Tom Murphy <murphyt7@tcd.ie>, Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Wed, 16 Oct 2019 11:53:33 -0400
In-Reply-To: <20191016153112.GF4695@suse.de>
References: <1571237707.5937.58.camel@lca.pw>
         <1571237982.5937.60.camel@lca.pw> <20191016153112.GF4695@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-16 at 17:31 +0200, Joerg Roedel wrote:
> Hi Qian,
> 
> thanks for the report!
> 
> On Wed, Oct 16, 2019 at 10:59:42AM -0400, Qian Cai wrote:
> > On Wed, 2019-10-16 at 10:55 -0400, Qian Cai wrote:
> > > Today's linux-next generates a lot of warnings on multiple servers during boot
> > > due to the series "iommu/amd: Convert the AMD iommu driver to the dma-iommu api"
> > > [1]. Reverted the whole things fixed them.
> > > 
> > > [1] https://lore.kernel.org/lkml/20190908165642.22253-1-murphyt7@tcd.ie/
> > > 
> > 
> > BTW, the previous x86 warning was from only reverted one patch "iommu: Add gfp
> > parameter to iommu_ops::map" where proved to be insufficient. Now, pasting the
> > correct warning.

The x86 one might just be a mistake.

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index ad05484d0c80..63c4b894751d 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2542,7 +2542,7 @@ static int amd_iommu_map(struct iommu_domain *dom,
unsigned long iova,
        if (iommu_prot & IOMMU_WRITE)
                prot |= IOMMU_PROT_IW;
 
-       ret = iommu_map_page(domain, iova, paddr, page_size, prot, GFP_KERNEL);
+       ret = iommu_map_page(domain, iova, paddr, page_size, prot, gfp);
 
        domain_flush_np_cache(domain, iova, page_size);

The arm64 -- does it forget to do this?

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ecc08aef9b58..8dd0ef0656f4 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1185,7 +1185,7 @@ static struct iommu_dma_msi_page
*iommu_dma_get_msi_page(struct device *dev,
        if (!iova)
                goto out_free_page;
 
-       if (iommu_map(domain, iova, msi_addr, size, prot))
+       if (iommu_map_atomic(domain, iova, msi_addr, size, prot))
                goto out_free_iova;
 
        INIT_LIST_HEAD(&msi_page->list);

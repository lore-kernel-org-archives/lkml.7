Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98C3FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4FA2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="djCl8ge6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405951AbfJPQLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:11:31 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43961 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405917AbfJPQLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:11:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id t20so31562234qtr.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V5LpZROAelGKYa34xxex4t1vsbB4R8zCDB0bSSRCrdI=;
        b=djCl8ge69vKY6bvWZDwrEev6a1m/Mo4WRCkutOLMT+ZKhCqtE2JReuB3/Z4QNbB9nh
         ll8VYFbNtu8j+wzkkatFqhAH40MOxBl4CdmVQeaQjkcCEVrJTFaBWkMaQsxegdR/MFh8
         EzqHh8t1B/Ekw7ErM9Wd1qfRDLqLIs56svyW12C6vu/FOnlZ/3P3dUi8WS/SNdbP95C2
         0z7BVC/Friv3Cg80cAEvyUl/SDQanS7oXYPdwKwtngzf3Q+AQCfI+03afiTSto+/JUaQ
         fcwwXf9RK8nNFCt3XITiYwd6Mn0OgL6U6j/5aDxtDQPd3qcUyiSxSurS7SkOEzApgyPk
         OmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V5LpZROAelGKYa34xxex4t1vsbB4R8zCDB0bSSRCrdI=;
        b=BIBEJtQuENI83xKLK9D+WeOx/iSgpk2x8YOKIHhvp/demKxm00DI947ksgnWneIv7U
         Vn+tqur6318B3QVMlzNKEfqdgdQB6t48C7nSlr+aL2Nxdk2kqrFmnDVrzLEQVNyVls/6
         I72u6UwiDSQZko9QDHhM4LUbw5/FGTOQUOEkgq07RnJOVvFPpqs/G6q/Yztr0O3ye/E/
         3IjxllozMLy9hsFckd1O6ugU7uGstSAtcHpEigOhLOXM0ZKiOUzX8JizBWfGdYch1tbl
         1yrI/8ZIBEeUhKfAk+NDIZ58cA7ryn44oplNH0D4MqILIaKsAVNsJ25jaG5JmiMkbTV7
         o5Uw==
X-Gm-Message-State: APjAAAWt/EFCujlFUfBAD7SK0gB1Rpm4lH+eCZ1Upkw0nddanVYBjo6X
        oXhXynn8AgFx5I5LBbrLcwcxPA==
X-Google-Smtp-Source: APXvYqzrpz9pCngh5tAZx5raOXdkrzSoKVIoogPFkTzIF7MxBL/2E8LGv672lfL8rdktSCqiKwM1JA==
X-Received: by 2002:a0c:e2c9:: with SMTP id t9mr42079536qvl.22.1571242289809;
        Wed, 16 Oct 2019 09:11:29 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y58sm14854019qta.1.2019.10.16.09.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 09:11:29 -0700 (PDT)
Message-ID: <1571242287.5937.66.camel@lca.pw>
Subject: Re: "Convert the AMD iommu driver to the dma-iommu api" is buggy
From:   Qian Cai <cai@lca.pw>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Tom Murphy <murphyt7@tcd.ie>, Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Wed, 16 Oct 2019 12:11:27 -0400
In-Reply-To: <20191016160314.GH4695@suse.de>
References: <1571237707.5937.58.camel@lca.pw>
         <1571237982.5937.60.camel@lca.pw> <20191016153112.GF4695@suse.de>
         <1571241213.5937.64.camel@lca.pw> <20191016160314.GH4695@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-16 at 18:03 +0200, Joerg Roedel wrote:
> On Wed, Oct 16, 2019 at 11:53:33AM -0400, Qian Cai wrote:
> > On Wed, 2019-10-16 at 17:31 +0200, Joerg Roedel wrote:
> > The x86 one might just be a mistake.
> > 
> > diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> > index ad05484d0c80..63c4b894751d 100644
> > --- a/drivers/iommu/amd_iommu.c
> > +++ b/drivers/iommu/amd_iommu.c
> > @@ -2542,7 +2542,7 @@ static int amd_iommu_map(struct iommu_domain *dom,
> > unsigned long iova,
> >         if (iommu_prot & IOMMU_WRITE)
> >                 prot |= IOMMU_PROT_IW;
> >  
> > -       ret = iommu_map_page(domain, iova, paddr, page_size, prot, GFP_KERNEL);
> > +       ret = iommu_map_page(domain, iova, paddr, page_size, prot, gfp);
> 
> Yeah, that is a bug, I spotted that too.
> 
> > @@ -1185,7 +1185,7 @@ static struct iommu_dma_msi_page
> > *iommu_dma_get_msi_page(struct device *dev,
> >         if (!iova)
> >                 goto out_free_page;
> >  
> > -       if (iommu_map(domain, iova, msi_addr, size, prot))
> > +       if (iommu_map_atomic(domain, iova, msi_addr, size, prot))
> >                 goto out_free_iova;
> 
> Not so sure this is a bug, this code is only about setting up MSIs on
> ARM. It probably doesn't need to be atomic.

The patch "iommu: Add gfp parameter to iommu_ops::map" does this. It could be
called from an atomic context as showed in the arm64 call traces,

+int iommu_map(struct iommu_domain *domain, unsigned long iova,
+             phys_addr_t paddr, size_t size, int prot)
+{
+       might_sleep();
+       return __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
+}

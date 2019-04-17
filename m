Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4193BC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B4521773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732989AbfDQUsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:48:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47984 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQUsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:48:22 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <dann.frazier@canonical.com>)
        id 1hGrTg-0000OP-BW
        for linux-kernel@vger.kernel.org; Wed, 17 Apr 2019 20:48:20 +0000
Received: by mail-it1-f197.google.com with SMTP id o197so73941ito.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 13:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FKs6b6RLzOW6Pz03ZnepEKUCxUG5lBr2ZKHFqCP8uyY=;
        b=ewuInX+FOw1AIuaS50Wc1sYSNkK/+EsWmTtMoS7PmzNtgK+0u4gtuVgRBziAvyTYMi
         TSFQYOm/be8CuKwdI2JtAYZPP6AE9jbgYSwDn3SVkdK0Q4k5lzJ3tSF1IoKZCFtZ+OiM
         APOVypppoRjSb7Tu+4TpeJ7puyq2DYsLCrpb9prWShPqvew1Ri7GCHa5Kw8/zAFrTtaR
         EdtdrDKIFSb+RNl6bPQEn1TPdYDVPPHaL6wrDPDDPCoye7w+OmfNyt/8q/SdqOc+KQH7
         5mybXg2EIbiw2c0o0Az5DjI+U5ZaNWJY7EtQBEOmu/KAyW5TiaCrAlsaC3TD7hD6XuWy
         4wDA==
X-Gm-Message-State: APjAAAX5m9eUAlznqsGAXtwZxLQTK3Ftkc9ITBnLXsph/qDHmCHHnI8d
        DJIs218l80rWHUHH56NpNRBFjiSDFdVLQI5g06foC0AS6jcsupEb8kdaY25d12JjkxVALF9p5B4
        nn/v8dCiWvG8oRv/ecGmrH+0OPxw2WmEwPVrqMul5ww==
X-Received: by 2002:a05:6638:60e:: with SMTP id g14mr35030884jar.62.1555534099336;
        Wed, 17 Apr 2019 13:48:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxhLv8FzWKOUKRcFaZQ9Q3wrgT5tWJRdwXvjRnIIBQ9dn0sCLbXg/33/O5gcbPcDwLcpplrVg==
X-Received: by 2002:a05:6638:60e:: with SMTP id g14mr35030865jar.62.1555534099071;
        Wed, 17 Apr 2019 13:48:19 -0700 (PDT)
Received: from xps13.canonical.com (c-71-56-235-36.hsd1.co.comcast.net. [71.56.235.36])
        by smtp.gmail.com with ESMTPSA id c99sm47406itd.4.2019.04.17.13.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 13:48:18 -0700 (PDT)
Date:   Wed, 17 Apr 2019 14:48:17 -0600
From:   dann frazier <dann.frazier@canonical.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>
Subject: [RFC] arm64: swiotlb: cma_alloc error spew
Message-ID: <20190417204817.GA28897@xps13.dannf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hey,
  I'm seeing an issue on a couple of arm64 systems[*] where they spew
~10K "cma: cma_alloc: alloc failed" messages at boot. The errors are
non-fatal, and bumping up cma to a large enough size (~128M) gets rid
of them - but that seems suboptimal. Bisection shows that this started
after commit fafadcd16595 ("swiotlb: don't dip into swiotlb pool for
coherent allocations"). It looks like __dma_direct_alloc_pages()
is opportunistically using CMA memory but falls back to non-CMA if CMA
disabled or unavailable. I've demonstrated that this fallback is
indeed returning a valid pointer. So perhaps the issue is really just
the warning emission.

The following naive patch solves the problem for me - just silence the
cma errors, since it looks like a soft error. But is there a better
approach?

[*] APM X-Gene & HiSilicon Hi1620 w/ SMMU disabled

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 6310ad01f915b..0324aa606c173 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -112,7 +112,7 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
        /* CMA can be used only in the context which permits sleeping */
        if (gfpflags_allow_blocking(gfp)) {
                page = dma_alloc_from_contiguous(dev, count, page_order,
-                                                gfp & __GFP_NOWARN);
+                                                true);
                if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
                        dma_release_from_contiguous(dev, page, count);
                        page = NULL;





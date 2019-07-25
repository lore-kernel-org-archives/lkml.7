Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2345CC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 01:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFB721855
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 01:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CLuwqZyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfGYBO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 21:14:27 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36670 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbfGYBO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 21:14:27 -0400
Received: by mail-qk1-f195.google.com with SMTP id g18so35229754qkl.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 18:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2QscBl/3tbBrXReK2tsv96us6PdZtQnqjBeeXbxeJtw=;
        b=CLuwqZyxlnhSQLNy2YRvagdU0Et/zZ17Ms4ehbdSvHLmk/gxwl3Wy/TTFegvnq+Et5
         4OpzVJv31gfdKu+/y13I9cSc1xlCIrpNLtabHb96qgORKl53PzbY30X66v61S563aYvw
         Z37UCLu003OZv8+NzTJzDSWyvzaPJpCNXSGq9hTC782PqR5qb6OfdY663YIxKKz6zIal
         IUoHez0chz3E2syIDBmGa7w0i9EJIB2xJ/Oxn1p3vnYmrNLjnuIVSG83ByHoyfGxuzLd
         v/OfQGlL/BCupE+LUBwfJE+qrXBuBE9jk/6+jF2E0ImNgnz9zBrdwCRnFkuXmowLxdCC
         tjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2QscBl/3tbBrXReK2tsv96us6PdZtQnqjBeeXbxeJtw=;
        b=rQMblhUpPE9YfCjPszKFwIZ+EYBFKVxOcoSPBrhJpYH912BUwojGuPYgTLGzmdVWK8
         MXdmPQF+mlezegjACzasmlz51vg/ndOw51fNiGeGXW5p8fGby7q8bcjukhV0r2mflq0B
         2aA6ZCjy9L75QX2nrguQ8OIgRRGNcLtrKHpbQEaTaoRo440c3mKCwXuTB9GhlAPvs7qh
         1fs3QHpXqrMB5+DZEPFvuzdy5YSV2Pk+LFFVAV5YvZrZq1cOinhEIAn+huQpBwUHeE96
         jySGU29VqckeDo8jLsrQpmNtfZ/2XpKRC6rBiaexmTMj940UjXW2Bx81wnIT5BbivcUC
         oFFw==
X-Gm-Message-State: APjAAAVXNO2H8PJqfQ2ho2ZFu+5OfzeokM8tmEFNmjC/7chBvx+pxxdj
        /nbav4abjoO/zPITGKe9QjZjtw==
X-Google-Smtp-Source: APXvYqx9ciisQdvPSwTvcdjpywJ+TPlixY+OV7qviQmXLqIq62Jmz3/cvYtUMzroSQEs8t3xbOZYHw==
X-Received: by 2002:a05:620a:1ea:: with SMTP id x10mr54556510qkn.484.1564017266127;
        Wed, 24 Jul 2019 18:14:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id k7sm20307997qth.88.2019.07.24.18.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 18:14:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hqSKu-00006q-Vv; Wed, 24 Jul 2019 22:14:24 -0300
Date:   Wed, 24 Jul 2019 22:14:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH] mm/hmm: replace hmm_update with mmu_notifier_range
Message-ID: <20190725011424.GA377@ziepe.ca>
References: <20190723210506.25127-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190723210506.25127-1-rcampbell@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 02:05:06PM -0700, Ralph Campbell wrote:
> The hmm_mirror_ops callback function sync_cpu_device_pagetables() passes
> a struct hmm_update which is a simplified version of struct
> mmu_notifier_range. This is unnecessary so replace hmm_update with
> mmu_notifier_range directly.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> 
> This is based on 5.3.0-rc1 plus Christoph Hellwig's 6 patches
> ("hmm_range_fault related fixes and legacy API removal v2").
> Jason, I believe this is the patch you were requesting.

Doesn't this need revision to include amgpu?

drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:         .sync_cpu_device_pagetables = amdgpu_mn_sync_pagetables_gfx,
drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:         .sync_cpu_device_pagetables = amdgpu_mn_sync_pagetables_hsa,

Thanks,
Jason

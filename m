Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69942C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC2821473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DOYEYXNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbfEVScG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 14:32:06 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37384 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbfEVScG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:32:06 -0400
Received: by mail-qt1-f194.google.com with SMTP id o7so3617140qtp.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 11:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CaDjZ/LTZEWIV1k6jmaoesTLyIfde7eaoYVq6F0BEbE=;
        b=DOYEYXNFXZtj3Fxv6GkbcrmxU5qsq07byb5Z/nKMwy5d7BkU/5zXVjPqNAaD0l6xyH
         xlB+AdtKp1epaSxw5VkAKq4S8M3K7YgmevLZSH75UeUvXXQlWK90b5D/k+Nvf6ZKGqXj
         TWtBp1hiphibJFzUinRHHxjMNpCRyVDdIkY+DSX07WsbkGoHGI2pLPzK4+CAvsrMzAEx
         A30oAnOWmiUTpX+/9fNvXkEEyo1w3wikiXyWNCGgaJs+rdfODCsZexTq0hyq5k9GrnTa
         75hribAj3aj4O1x0Zhj+2Q/GjAJBxqGS0eU9LrDXGTcw9licqCzF5A1gt0CFtCJ74HM4
         1gSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CaDjZ/LTZEWIV1k6jmaoesTLyIfde7eaoYVq6F0BEbE=;
        b=CdDVd+A7D+zjiSDBgeWIjjvsRH2YF0MdaQN/jKYdUR5eE9TFWab50F3oglTocNf+tJ
         qt/tyizJ2GPn1wl/xEXNxU2yi7WHmtykELf2Of/YMPtbpPbE7xsjIYtbKgXq+7ru7Yog
         d0DnHBGjW+FQ44UAUsfF8U266B1K5oAYK5HwLqMscsztMFaoIB/EYNJeZ/edhs/47a8s
         oAfOU0MVt94gIDI1753TIqlLnAftt6VioKHZVUZJXRXHo7ZJ/E6yWmwYn/BuQ/vNkolA
         G0tQwV+zCozc0sP6h5H7QVmNhmFszuWX4IJucrqm7sBgbKb7WkTOhoiIHrQZg21fuauX
         pz/g==
X-Gm-Message-State: APjAAAUkxXYgEhJQUF0MO5YadODnvSv4cgpyvP6OJFTpYG/n+BAYqlWA
        /s6otov37VDDgx0QDl20lRrO1w==
X-Google-Smtp-Source: APXvYqzf05Cgzli4/sO/d45KwJM6VGf3KpJ+mO5Il0PMQODrgkuDAUi8F/XB67dWwlfl0xja9rPWRw==
X-Received: by 2002:ac8:18c2:: with SMTP id o2mr77676877qtk.165.1558549924824;
        Wed, 22 May 2019 11:32:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id g12sm11725833qkk.88.2019.05.22.11.32.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 11:32:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTW1z-0005Gd-IY; Wed, 22 May 2019 15:32:03 -0300
Date:   Wed, 22 May 2019 15:32:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH v4 0/1] Use HMM for ODP v4
Message-ID: <20190522183203.GE6054@ziepe.ca>
References: <20190411181314.19465-1-jglisse@redhat.com>
 <20190506195657.GA30261@ziepe.ca>
 <20190521205321.GC3331@redhat.com>
 <20190522005225.GA30819@ziepe.ca>
 <20190522174852.GA23038@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190522174852.GA23038@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 01:48:52PM -0400, Jerome Glisse wrote:

> From 0b429b2ffbec348e283693cb97d7ffce760d89da Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
> Date: Sat, 8 Dec 2018 15:47:55 -0500
> Subject: [PATCH] RDMA/odp: convert to use HMM for ODP v5
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Convert ODP to use HMM so that we can build on common infrastructure
> for different class of devices that want to mirror a process address
> space into a device. There is no functional changes.
> 
> Changes since v4:
>     - Rebase on top of rdma-next
> Changes since v3:
>     - Rebase on top of 5.2-rc1
> Changes since v2:
>     - Update to match changes to HMM API
> Changes since v1:
>     - improved comments
>     - simplified page alignment computation
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Leon Romanovsky <leonro@mellanox.com>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Artemy Kovalyov <artemyko@mellanox.com>
> Cc: Moni Shoua <monis@mellanox.com>
> Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Cc: Kaike Wan <kaike.wan@intel.com>
> Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
>  drivers/infiniband/core/umem_odp.c | 506 +++++++++--------------------
>  drivers/infiniband/hw/mlx5/mem.c   |  20 +-
>  drivers/infiniband/hw/mlx5/mr.c    |   2 +-
>  drivers/infiniband/hw/mlx5/odp.c   | 104 +++---
>  include/rdma/ib_umem_odp.h         |  47 +--
>  5 files changed, 233 insertions(+), 446 deletions(-)

The kconfig stuff is missing, and it doesn't compile in various cases
I tried.

The kconfig stuff for hmm is also really obnoxious, you can't just
enabe HMM_MIRROR, you have to track down all the little required
elements to get it to turn on..

Once I did get it to compile, I also get warnings:

mm/hmm.c: In function ‘hmm_vma_walk_pud’:
mm/hmm.c:782:28: warning: unused variable ‘pfn’ [-Wunused-variable]
   unsigned long i, npages, pfn;
                            ^~~
mm/hmm.c: In function ‘hmm_range_snapshot’:
mm/hmm.c:1027:19: warning: unused variable ‘h’ [-Wunused-variable]
    struct hstate *h = hstate_vma(vma);

Because this kernel doesn't have CONFIG_HUGETLB_PAGE

Please fold this into your patch if it has to be resent.. I think it
fixes the compilation problems.

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index cbfbea49f126cd..e3eefd0917985a 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -63,7 +63,7 @@ config INFINIBAND_USER_MEM
 config INFINIBAND_ON_DEMAND_PAGING
 	bool "InfiniBand on-demand paging support"
 	depends on INFINIBAND_USER_MEM
-	select MMU_NOTIFIER
+	depends on HMM_MIRROR
 	default y
 	---help---
 	  On demand paging support for the InfiniBand subsystem.
diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
index e1476e9ebb7906..f760103c07349a 100644
--- a/include/rdma/ib_umem_odp.h
+++ b/include/rdma/ib_umem_odp.h
@@ -115,6 +115,16 @@ static inline size_t ib_umem_odp_num_pages(struct ib_umem_odp *umem_odp)
 
 #define ODP_DMA_ADDR_MASK (~(ODP_READ_ALLOWED_BIT | ODP_WRITE_ALLOWED_BIT))
 
+#define ODP_READ_BIT	(1<<0ULL)
+#define ODP_WRITE_BIT	(1<<1ULL)
+/*
+ * The device bit is not use by ODP but is there to full-fill HMM API which
+ * also support device with device memory (like GPU). So from ODP/RDMA POV
+ * this can be ignored.
+ */
+#define ODP_DEVICE_BIT	(1<<2ULL)
+#define ODP_FLAGS_BITS	3
+
 #ifdef CONFIG_INFINIBAND_ON_DEMAND_PAGING
 
 struct ib_ucontext_per_mm {
@@ -138,16 +148,6 @@ struct ib_umem_odp *ib_alloc_odp_umem(struct ib_umem_odp *root_umem,
 				      unsigned long addr, size_t size);
 void ib_umem_odp_release(struct ib_umem_odp *umem_odp);
 
-#define ODP_READ_BIT	(1<<0ULL)
-#define ODP_WRITE_BIT	(1<<1ULL)
-/*
- * The device bit is not use by ODP but is there to full-fill HMM API which
- * also support device with device memory (like GPU). So from ODP/RDMA POV
- * this can be ignored.
- */
-#define ODP_DEVICE_BIT	(1<<2ULL)
-#define ODP_FLAGS_BITS	3
-
 long ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp,
 			       struct hmm_range *range);
 

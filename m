Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4759C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E30020674
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4+/tJPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbfDQSVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:21:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46160 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfDQSVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:21:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id q1so12358876pgv.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 11:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vOuimekE8NbfgdHPy5nv6BcziXj9tFjoRdCDEhswAWM=;
        b=e4+/tJPy9lZwMFKr1lYS3q3eI9IoHyKSQhAgMxR+bPSmv8loX5z6dYO2v2AaBiWwQr
         5bA094hod0B34csbEBBjE+gvUycjTRfBKflPToNuCtG0YlEM3qcLynIEErSW66mo6Cxp
         DsrAuc1OiGEexuBiL4J8KkETdasvfZu/Eo4k/e0ZRexFY+rqeqzIPE2N1maA3jsmXA2U
         gXLKNobxJyPtVlRcRxvmT0qJVH1SshV04HIwMuJ2p6mGGux8W9PHSV2zVfA7t0TC9SOu
         Oo1FO5EMMrcYnb7qjkjw3BGHLk4ZRFL5urqhBUsnaPjF5uOlB9w2NII2U35LBv938aFB
         8CPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vOuimekE8NbfgdHPy5nv6BcziXj9tFjoRdCDEhswAWM=;
        b=YEV8yq1oW4SFzSnVcCnJmlvJep2T0mbd2CCPIhhAOfQJHMPAfaVmYu1gxgocGcTIpR
         0fqG9uYclj4ntRS0l7x8hV4Xqtx9CBYF5HvLPCYSiMR5uSG8OfyGzgMQPFfduPXE+sQi
         JrMtIsavm9t6Jm0l0BG8uOd7Yto0Ff3ctn74JlMXi6EYZKrDGuBCi+F4kYP0FUthBx/f
         YdDXTD60dbZsfXl8tVlJ7xCasPtZZPoActy/3XwedPkf0BKQPoj7a/uBuYaFOUtDakgq
         KMAnYz3jT0s8qgos1nX2ZLxcwPLZPwoLO26UpHetvyHR+Gxl0VP/8/0SYPY//GbsDlGs
         1CDg==
X-Gm-Message-State: APjAAAX8JEoBh17ukJxd6LKS2641XVV6jRNhMNaZYA7T//7ejcBdBaw1
        FdilVQcx03KzhOCdrIF62Yo=
X-Google-Smtp-Source: APXvYqzx0ob/O2sv9bLyl1/8sl4QBaI1CzJIblQrJnVdq12BlB+M+ece4h5MiJ3ybKRGa8WdqTk8QQ==
X-Received: by 2002:a63:7153:: with SMTP id b19mr81205327pgn.289.1555525279839;
        Wed, 17 Apr 2019 11:21:19 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e21sm75010222pfd.177.2019.04.17.11.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 11:21:19 -0700 (PDT)
Date:   Wed, 17 Apr 2019 11:21:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     jglisse@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH] mm/hmm: kconfig split HMM address space mirroring from
 device memory
Message-ID: <20190417182118.GA1477@roeck-us.net>
References: <20190411180326.18958-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190411180326.18958-1-jglisse@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 02:03:26PM -0400, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> To allow building device driver that only care about address space
> mirroring (like RDMA ODP) on platform that do not have all the pre-
> requisite for HMM device memory (like ZONE_DEVICE on ARM) split the
> HMM_MIRROR option dependency from the HMM_DEVICE dependency.
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: Leon Romanovsky <leonro@mellanox.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Tested-by: Leon Romanovsky <leonro@mellanox.com>

In case it hasn't been reported already:

mm/hmm.c: In function 'hmm_vma_handle_pmd':
mm/hmm.c:537:8: error: implicit declaration of function 'pmd_pfn'; did you mean 'pte_pfn'?

and similar errors when building alpha:allmodconfig (and maybe others).

Guenter

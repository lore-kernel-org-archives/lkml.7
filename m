Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C091C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2582073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Zc/Sb8xa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKOGSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 01:18:22 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7032 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfKOGSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 01:18:22 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dce43300000>; Thu, 14 Nov 2019 22:18:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 14 Nov 2019 22:18:21 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 14 Nov 2019 22:18:21 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 15 Nov
 2019 06:18:21 +0000
Subject: Re: [PATCH] mm/hmm: remove hmm_range_dma_map and hmm_range_dma_unmap
To:     Christoph Hellwig <hch@lst.de>, <jgg@ziepe.ca>,
        <jglisse@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20191113134528.21187-1-hch@lst.de>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <688e4271-bedd-c296-6a35-4547191c8f93@nvidia.com>
Date:   Thu, 14 Nov 2019 22:18:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191113134528.21187-1-hch@lst.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573798704; bh=sNcshHEF2avVA9rnTZtLVohwfbWOQokarhKdv+S/gRc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Zc/Sb8xaujNVQ4vAJcVfvPPo9owAxzqF7WFgRq5g3HWn0xwmUv6krqoZt4lBVWB/D
         nO4E439bNvYQDRD2M0We8h4vUYMDGeQ3N7E8mea/iBSF3HL2cnRQ9vk3luE6ZY2z28
         qIsAT3jP2R5tE6rTrzgq8wsLWk5BxmvCE4qH0Q98usL50EijewJZGrg27jLQdNqGnY
         dk5sVbJZl1fMiNse0AQcmLv+sHwp0bLpI+fh/OsQ/Bz3qUQP9+ztszxsgFVn87/8uo
         aINr2qgVbIF3C8tdx6wNa0P8Z3kPE8gB3fRhRTc7bQaA8fcsUpfwlx+YOKTW0oFuNh
         NhR+M72R2ud7w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/19 5:45 AM, Christoph Hellwig wrote:
> These two functions have never been used since they were added.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/hmm.h |  23 -------
>  mm/hmm.c            | 147 --------------------------------------------
>  2 files changed, 170 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Also +CC Ralph just for another look. But I know we're not using these 
routines.


thanks,
-- 
John Hubbard
NVIDIA

Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E24C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 23:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0B320679
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 23:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jjOqVbu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfG2X36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 19:29:58 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18374 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfG2X35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 19:29:57 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3f81750000>; Mon, 29 Jul 2019 16:29:57 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 29 Jul 2019 16:29:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 29 Jul 2019 16:29:57 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Jul
 2019 23:29:55 +0000
Subject: Re: [PATCH 7/9] mm: remove the unused MIGRATE_PFN_ERROR flag
To:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
CC:     Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20190729142843.22320-1-hch@lst.de>
 <20190729142843.22320-8-hch@lst.de>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <32f08aa4-c9a3-9545-69aa-2cc3695e15df@nvidia.com>
Date:   Mon, 29 Jul 2019 16:29:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190729142843.22320-8-hch@lst.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564442997; bh=0+thxvZnJ+gcbF/O0zGGEBA6QvsuJ+b1Oc5FzJoq0pI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jjOqVbu0SE9IxctyMwqyl6NjiHxbcjJTt/QVPTeHFWZn91g7rXHLoSsXIJCkRMepQ
         4RDY3eiq+JBeMQ2R9fiv8HeECvSmM4knWmk7sjO4TB+BOlqd8o0nizQlMk7DYq6sLe
         +sqF9pqPZKgpUwuguZXMwVmav3HEr6qCsATcyT863EyZfvbK1jjnL6yqbPEQd9ijjJ
         ydsHBn1jU60iHnXNioMmy0fn3Po4Y09SrgrhUiGTMRt6lWOqkn7isWclIxYgC0avDf
         v8q4S08zaE3ikIRtGMn7WjLZkqBtGEBL5IeWH0mes0o8HnufoNHBj4X8jpeZ1nRHSl
         igU0UgPAUNzQQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/29/19 7:28 AM, Christoph Hellwig wrote:
> We don't use this flag anymore, so remove it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   include/linux/migrate.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 093d67fcf6dd..229153c2c496 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -167,7 +167,6 @@ static inline int migrate_misplaced_transhuge_page(struct mm_struct *mm,
>   #define MIGRATE_PFN_LOCKED	(1UL << 2)
>   #define MIGRATE_PFN_WRITE	(1UL << 3)
>   #define MIGRATE_PFN_DEVICE	(1UL << 4)
> -#define MIGRATE_PFN_ERROR	(1UL << 5)
>   #define MIGRATE_PFN_SHIFT	6

The MIGRATE_PFN_SHIFT could be reduced to 5 since it is only used
to make room for the flags.

>   static inline struct page *migrate_pfn_to_page(unsigned long mpfn)
> 

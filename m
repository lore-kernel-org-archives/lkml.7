Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE27C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 22:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9467421721
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 22:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="THHxjtsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732974AbfGOWEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 18:04:15 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4949 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730647AbfGOWEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 18:04:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d2cf85a0000>; Mon, 15 Jul 2019 15:04:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Jul 2019 15:04:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Jul 2019 15:04:12 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Jul
 2019 22:04:11 +0000
Subject: Re: [PATCH] staging: kpc2000: Convert put_page() to put_user_page*()
From:   John Hubbard <jhubbard@nvidia.com>
To:     Matt Sickler <Matt.Sickler@daktronics.com>,
        Bharath Vedartham <linux.bhar@gmail.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jglisse@redhat.com" <jglisse@redhat.com>
CC:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190715195248.GA22495@bharath12345-Inspiron-5559>
 <2604fcd1-4829-d77e-9f7c-d4b731782ff9@nvidia.com>
 <SN6PR02MB4016687B605E3D97D699956EEECF0@SN6PR02MB4016.namprd02.prod.outlook.com>
 <82441723-f30e-5811-ab1c-dd9a4993d7df@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <2278975b-6ea5-5417-eb0c-9d7debdf68ce@nvidia.com>
Date:   Mon, 15 Jul 2019 15:04:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <82441723-f30e-5811-ab1c-dd9a4993d7df@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563228250; bh=7F+lrioE5/qbngjXwfnCWvzn3KWHU4WQV3R2Uk1MWm8=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=THHxjtsgf8LosY3HKog1RQ/BDV+9F/bTT64YX2I6T2AHWxoBAi0RLmklmhwM3ewuk
         OX2zlNOoGNrmox7hKvIBOIFmnJslo5CUp7RmxvNgFJCavNuCywtZwx9qel9OqBItAE
         P+rc1zZKXVbY8PZlPHkgV6xctZUI4ye2lqS+p5KgZRSDRw5AD1lZR4UfhS+ZKvl/jS
         hMQKOx3zzmXt5XuNUXh7mBFZcc4Z8kxcr7xPK49Hx+ate4QIV3mr/eky3l1SzDrtKS
         KSOMqk9cAXNlVUBhj/Q6LAOAOQVrgKk0xs5pROzdtxNCjzIBEvMLG7MeGOuyRaGQVd
         RMPff+4MqyInQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/19 3:01 PM, John Hubbard wrote:
> On 7/15/19 2:47 PM, Matt Sickler wrote:
...
> I agree: the PageReserved check looks unnecessary here, from my outside-the-kpc_2000-team
> perspective, anyway. Assuming that your analysis above is correct, you could collapse that
> whole think into just:
> 
> @@ -211,17 +209,8 @@ void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
>         BUG_ON(acd->ldev == NULL);
>         BUG_ON(acd->ldev->pldev == NULL);
>  
> -       for (i = 0 ; i < acd->page_count ; i++) {
> -               if (!PageReserved(acd->user_pages[i])) {
> -                       set_page_dirty(acd->user_pages[i]);
> -               }
> -       }
> -
>         dma_unmap_sg(&acd->ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, acd->ldev->dir);
> -
> -       for (i = 0 ; i < acd->page_count ; i++) {
> -               put_page(acd->user_pages[i]);
> -       }
> +       put_user_pages_dirty(&acd->user_pages[i], acd->page_count);

Ahem, I typed too quickly. :) Please make that:

    put_user_pages_dirty(acd->user_pages, acd->page_count);

thanks,
-- 
John Hubbard
NVIDIA


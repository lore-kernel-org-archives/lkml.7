Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF77BC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 22:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55C920665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 22:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ou4gJH5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732452AbfGOWBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 18:01:46 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10908 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbfGOWBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 18:01:46 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d2cf7c70001>; Mon, 15 Jul 2019 15:01:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 15 Jul 2019 15:01:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 15 Jul 2019 15:01:43 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Jul
 2019 22:01:43 +0000
Subject: Re: [PATCH] staging: kpc2000: Convert put_page() to put_user_page*()
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
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <82441723-f30e-5811-ab1c-dd9a4993d7df@nvidia.com>
Date:   Mon, 15 Jul 2019 15:01:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <SN6PR02MB4016687B605E3D97D699956EEECF0@SN6PR02MB4016.namprd02.prod.outlook.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563228104; bh=pmH8AOUq8g8XbwlwsJrEBANIpIcymTdRjNl5DWvnpyg=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Ou4gJH5x6FSY3NMqcJQf183vJDxwn7bEzDDasocDjOFBwy0aNrdr53eL2R8CW/9dL
         plCx/M0zxRdPOGuKWIYK8+Mk+vTd387oaFoPbs1kfbjbEugerJ/YR7VoM0OrQ6ApiF
         AtQrkmclnAt7heWlSDgasNxNbDBDFoZjoNNNhky+v8mnwxCXYFCh5qm2bnkUYN62KB
         GI4zsZ3QPdVPX5uwuPO/U4/c//c7BAGS6uNQy9VF/EDvkMmHQOONHfT/s86RYUoMEv
         a+AkY30uLQx3Y/5jA5CFNmO980oPxzh9grMS6V9Hk/wCk+ABXvwJ8kj1Gv/MWNOUez
         14/khGOG4+Ylg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/19 2:47 PM, Matt Sickler wrote:
> It looks like Outlook is going to absolutely trash this email.  Hopefully it comes through okay.
> 
...
>>
>> Because this is a common pattern, and because the code here doesn't likely
>> need to set page dirty before the dma_unmap_sg call, I think the following
>> would be better (it's untested), instead of the above diff hunk:
>>
>> diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c
>> b/drivers/staging/kpc2000/kpc_dma/fileops.c
>> index 48ca88bc6b0b..d486f9866449 100644
>> --- a/drivers/staging/kpc2000/kpc_dma/fileops.c
>> +++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
>> @@ -211,16 +211,13 @@ void  transfer_complete_cb(struct aio_cb_data
>> *acd, size_t xfr_count, u32 flags)
>>        BUG_ON(acd->ldev == NULL);
>>        BUG_ON(acd->ldev->pldev == NULL);
>>
>> -       for (i = 0 ; i < acd->page_count ; i++) {
>> -               if (!PageReserved(acd->user_pages[i])) {
>> -                       set_page_dirty(acd->user_pages[i]);
>> -               }
>> -       }
>> -
>>        dma_unmap_sg(&acd->ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, acd->ldev->dir);
>>
>>        for (i = 0 ; i < acd->page_count ; i++) {
>> -               put_page(acd->user_pages[i]);
>> +               if (!PageReserved(acd->user_pages[i])) {
>> +                       put_user_pages_dirty(&acd->user_pages[i], 1);
>> +               else
>> +                       put_user_page(acd->user_pages[i]);
>>        }
>>
>>        sg_free_table(&acd->sgt);
> 
> I don't think I ever really knew the right way to do this. 
> 
> The changes Bharath suggested look okay to me.  I'm not sure about the check for PageReserved(), though.  At first glance it appears to be equivalent to what was there before, but maybe I should learn what that Reserved page flag really means.
> From [1], the only comment that seems applicable is
> * - MMIO/DMA pages. Some architectures don't allow to ioremap pages that are
>  *   not marked PG_reserved (as they might be in use by somebody else who does
>  *   not respect the caching strategy).
> 
> These pages should be coming from anonymous (RAM, not file backed) memory in userspace.  Sometimes it comes from hugepage backed memory, though I don't think that makes a difference.  I should note that transfer_complete_cb handles both RAM to device and device to RAM DMAs, if that matters.
> 
> [1] https://elixir.bootlin.com/linux/v5.2/source/include/linux/page-flags.h#L17
> 

I agree: the PageReserved check looks unnecessary here, from my outside-the-kpc_2000-team
perspective, anyway. Assuming that your analysis above is correct, you could collapse that
whole think into just:

@@ -211,17 +209,8 @@ void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
        BUG_ON(acd->ldev == NULL);
        BUG_ON(acd->ldev->pldev == NULL);
 
-       for (i = 0 ; i < acd->page_count ; i++) {
-               if (!PageReserved(acd->user_pages[i])) {
-                       set_page_dirty(acd->user_pages[i]);
-               }
-       }
-
        dma_unmap_sg(&acd->ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, acd->ldev->dir);
-
-       for (i = 0 ; i < acd->page_count ; i++) {
-               put_page(acd->user_pages[i]);
-       }
+       put_user_pages_dirty(&acd->user_pages[i], acd->page_count);
 
        sg_free_table(&acd->sgt);
 
(Also, Matt, I failed to Cc: you on a semi-related cleanup that I just sent out for this
driver, as long as I have your attention:

   https://lore.kernel.org/r/20190715212123.432-1-jhubbard@nvidia.com
)

thanks,
-- 
John Hubbard
NVIDIA

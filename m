Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81607C48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 03:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1012070B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 03:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jjX0zTNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfFUDGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 23:06:35 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17833 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFUDGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 23:06:34 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0c49b80000>; Thu, 20 Jun 2019 20:06:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Jun 2019 20:06:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Jun 2019 20:06:33 -0700
Received: from [10.24.70.43] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Jun
 2019 03:06:29 +0000
Subject: Re: [PATCH] dmaengine: tegra210-adma: fix transfer failure
To:     Jon Hunter <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <dan.j.williams@intel.com>
CC:     <thierry.reding@gmail.com>, <ldewangan@nvidia.com>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1561047348-14413-1-git-send-email-spujar@nvidia.com>
 <bf478236-9aa7-68cc-4a56-296db2fc4379@nvidia.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <bcd31292-4caf-19fa-c4ea-d85c5fd77861@nvidia.com>
Date:   Fri, 21 Jun 2019 08:36:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <bf478236-9aa7-68cc-4a56-296db2fc4379@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561086393; bh=40qWngcJ5jntuve/oNsoItdezzKA7yP0XJAN671D/Fc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=jjX0zTNCpWzwZOI5kUCnaO+ziNCoL60UwRp4Gpg10j2KAIp4X1bHHGwRjnvugJeuI
         ppw0PSoFcmoq0amnR8DQeAvCgiQ/9iaYqhiDxDOAoctQWYatWZseJVsGflTjgGGGTc
         Yi2MOXGddTqDzNT7EG7cje5DxIF3K54kGl5iAMJ6HkJqBHlYWqnnGzzsaaSRL2zm58
         cbWNYbc5FVls9IAfYdW3wQ0xcE34FlA0g0X/9JClw6XQSAQ+pT/PR9DRxeNl0vPj40
         VL0EXtnx8Eo2ypZA15xalfJCMrHMQR+pGS1dshOQv21B5525dwEicuM3WZoZ4R9EEs
         Y9UM/nbS9LwcQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/20/2019 10:13 PM, Jon Hunter wrote:
> On 20/06/2019 17:15, Sameer Pujar wrote:
>>  From Tegra186 onwards OUTSTANDING_REQUESTS field is added in channel
>> configuration register (bits 7:4). ADMA allows a maximum of 8 reads
>> to source and that many writes to target memory be outstanding at any
>> given point of time. If this field is not programmed, DMA transfers
>> fail to happen.
> BTW, I am not sure I follow the above. You say a max of 8 reads to the
> source, however, the field we are programming can have a value of up to
> 15. So does that mean this field should only be programmed with a max of 8?
Yes. As per spec. ADMA allows max value of 8.
> Thanks
> Jon
>

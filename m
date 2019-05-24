Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC984C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A028720856
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ba489+Bm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404196AbfEXOrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 10:47:39 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1893 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403911AbfEXOri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 10:47:38 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce804040000>; Fri, 24 May 2019 07:47:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 24 May 2019 07:47:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 24 May 2019 07:47:37 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 May
 2019 14:47:35 +0000
Subject: Re: [PATCH] tegra_wm9712: Fix a memory leaking bug in
 tegra_wm9712_driver_probe()
To:     Gen Zhang <blackgod016574@gmail.com>
CC:     <lgirdwood@gmail.com>, <perex@perex.cz>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190524005014.GA2289@zhanggen-UX430UQ>
 <b2d43dfe-17e5-a975-435b-49f2aa2ad550@nvidia.com>
 <20190524143309.GA8631@zhanggen-UX430UQ>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <e52f4140-a119-a584-40a2-6359d6e1784a@nvidia.com>
Date:   Fri, 24 May 2019 15:47:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524143309.GA8631@zhanggen-UX430UQ>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558709252; bh=0g5JbZfsE+2QT4bUSsZSJoNvEVoG7Gi9MR+1f1C9IVM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ba489+BmxVdebKbeWlKfxGyqR6t2ZwGV7PlsvNZbWbUx1K+CaP9IxltJ86OrzGMPo
         iJHqm+bM3oBOcb1rMgvDxVk0Qq6YVAygJ/6S/Q+k3XnsuEhA3FfXtQRmykLkeD/an9
         YWKWzgUDJpRiperBC8zWFwHoHro8yw8QV/qV2fPFjDMQrRN7npmMVeaYxtctasNBD+
         mtdY8qYqrcH7B+Czei5YYb30TMbVqqD6VLhuV4y31skw06iGAO9ySNf9b5w9/kIc3C
         FfGyj68uI0ciZj9lEbd/e+lAblFBWqdlTBf6PSJIr0zFXdlfUt0CC9/zrrndbbQaZq
         QmIHjBOq1yaNw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/05/2019 15:33, Gen Zhang wrote:
> On Fri, May 24, 2019 at 09:33:13AM +0100, Jon Hunter wrote:
>>
>> On 24/05/2019 01:50, Gen Zhang wrote:
>>> In tegra_wm9712_driver_probe(), 'machine->codec' is allocated by
>>> platform_device_alloc(). When it is NULL, function returns ENOMEM.
>>> However, 'machine' is allocated by devm_kzalloc() before this site.
>>> Thus we should free 'machine' before function ends to prevent memory
>>> leaking.
>>
>> Memory allocated by devm_xxx() is automatically freed on failure so this
>> is not correct.
> Thanks for your comments, Jon. But after I examined the code, I am still
> confused about the usage of devm_kmalloc(). You can kindly refer to 
> hisi_sas_debugfs_init() in drivers/scsi/hisi_sas/hisi_sas_main.c. And
> devm_kfree() is used to free a memory allocated by devm_kmalloc(). And
> I found other situations similar to this in other files.
> 
> So, I hope you can give me some guidance on this. Thanks!

Please refer to the devres documentation [0].

Cheers,
Jon

[0] https://www.kernel.org/doc/Documentation/driver-model/devres.txt

-- 
nvpublic

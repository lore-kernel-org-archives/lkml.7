Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C01C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 09:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32195217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 09:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GDQKpbEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390121AbfEXJaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 05:30:13 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4769 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389582AbfEXJaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 05:30:13 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce7b9a40000>; Fri, 24 May 2019 02:30:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 24 May 2019 02:30:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 24 May 2019 02:30:12 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 May
 2019 09:30:10 +0000
Subject: Re: [PATCH] pcm030-audio-fabric: Fix a memory leaking bug in
 pcm030_fabric_probe()
To:     Gen Zhang <blackgod016574@gmail.com>, <broonie@kernel.org>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20190524021221.GA4753@zhanggen-UX430UQ>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <0fb5b294-99ba-bb73-a972-e1886dc6b792@nvidia.com>
Date:   Fri, 24 May 2019 10:30:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524021221.GA4753@zhanggen-UX430UQ>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558690212; bh=w7pLj2lJsq63RcVDdYEsNgQk2low9PPUZap3YYWNh/g=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=GDQKpbEIpRwC1xcUjvHajuI7CDlbwtFrYQzarWn9yc/JoVLo6g2ETuoiNWO34Cmqt
         aEQ7HHNL3f0qR5fnmTuEHuoDCnV7yzQcB4KedjBSUHjTfcJfFTAIhi80hv3KHuLgHI
         hp+ViKhAU9nAGaPaEbxkg111HDy4eXAo8O/XHqJx4qSCB94TzJwcCaYR+4ZMDWromQ
         tHoe1FpAmaZC+htMSX6vpXsxbhLVRo2NcnUXe3+zox/U1zCTEjEvEBHyuHU/RgjfCc
         K2iS+kIDya/HiZ80DR1rtTWIA76hF0146gtKPQMarw8y6PN521/E1XCg9rlD1A+vKO
         /cjAIXeJRRMKw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/05/2019 03:12, Gen Zhang wrote:
> In pcm030_fabric_probe(), 'pdata->codec_device' is allocated by
> platform_device_alloc(). When this allocation fails, ENOMEM is returned.
> However, 'pdata' is allocated by devm_kzalloc() before this site. We
> should free 'pdata' before function ends to prevent memory leaking.
> 
> Similarly, we should free 'pdata' when 'pdata->codec_device' is NULL.
> And we should free 'pdata->codec_device' and 'pdata' when 'ret' is error
> to prevent memory leaking.
> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

I have seen several of these patches now, and this is not correct. I
think you need to understand how devm_kzalloc() works.

Jon

-- 
nvpublic

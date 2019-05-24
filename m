Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1456BC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 09:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC54820644
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 09:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IrJmjsCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390264AbfEXJm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 05:42:29 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18430 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389677AbfEXJm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 05:42:29 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce7bc850000>; Fri, 24 May 2019 02:42:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 24 May 2019 02:42:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 24 May 2019 02:42:28 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 May
 2019 09:42:26 +0000
Subject: Re: [PATCH] spi: Fix a memory leaking bug in wl1271_probe()
To:     Gen Zhang <blackgod016574@gmail.com>, <kvalo@codeaurora.org>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190523143022.GA26485@zhanggen-UX430UQ>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <279050e0-39e4-173d-ffe8-c1837951f4d1@nvidia.com>
Date:   Fri, 24 May 2019 10:42:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523143022.GA26485@zhanggen-UX430UQ>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558690949; bh=f+gDnXlt84op+cO+SWUow2VW/jdTpsnQIMrQpyyMGgg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=IrJmjsCmpX60wzUFmVgEp/9UJN9UZ8CYieGXNOttBYSl0DHZVc5tniuH7PieaTg0L
         cJXXy8DPE0qVjF1PnDEITchM8yIkJEFsYMapIUL9UsWWd+dMOtabN/lijwIuBZ3Jij
         Mu4J588ig4jERKcaDk7drT7tzEVEzG/U7TNC/zdCjRzUG8L90N+JypogQwWKx55x5Z
         YCxh4Y/K04ckhNUH8R26DDGms6OsVpA1sGDPrUn8bOnFCW9ryGsS0pSgO0b2FBQrKw
         aFumIbRFnHWe6UetgEZ9eC/5jqDNktD2ofYnSpMQWYZXu6qDRfXm4d4LRCN63HLRLc
         oOuMI+pveu4oQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/05/2019 15:30, Gen Zhang wrote:
> In wl1271_probe(), 'glue->core' is allocated by platform_device_alloc(),
> when this allocation fails, ENOMEM is returned. However, 'pdev_data'
> and 'glue' are allocated by devm_kzalloc() before 'glue->core'. When
> platform_device_alloc() returns NULL, we should also free 'pdev_data'
> and 'glue' before wl1271_probe() ends to prevent leaking memory.
> 
> Similarly, we shoulf free 'pdev_data' when 'glue' is NULL. And we should
> free 'pdev_data' and 'glue' when 'glue->reg' is error and when 'ret' is
> error.
> 
> Further, we should free 'glue->core', 'pdev_data' and 'glue' when this 
> function normally ends to prevent leaking memory.
> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
I have seen several of these patches now, and this is not correct. I
think you need to understand how devm_kzalloc() works.

Jon

-- 
nvpublic

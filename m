Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8054AC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 15:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1802187F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 15:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LWgsm1OR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgAGPOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 10:14:01 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17777 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbgAGPN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 10:13:58 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e14a0240000>; Tue, 07 Jan 2020 07:13:40 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 07:13:57 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Jan 2020 07:13:57 -0800
Received: from [10.26.11.139] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jan
 2020 15:13:55 +0000
Subject: Re: [PATCH v3 09/13] dmaengine: tegra-apb: Remove runtime PM usage
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200106011708.7463-1-digetx@gmail.com>
 <20200106011708.7463-10-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f63a68cf-bb9d-0e79-23f3-233fc97ca6f9@nvidia.com>
Date:   Tue, 7 Jan 2020 15:13:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200106011708.7463-10-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578410020; bh=Sf0ckx5pEctxgD10OMRT1lnch6V57nc9NpAJxMakDd4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=LWgsm1ORkmkJ0tg8Uqw2z2plcb298KilPFwVAdMJeRU69ugZwZh+ImPailCMGibXS
         JUK6rBM79/VREU15uTjOVxQZM1NZrJOX/I1psObzTqmy9tI3Ooq7GQVRxT2/sBk+Aj
         7xRZ+D9i1SJ1FHRQeu/RqGbkN1rWuBcAD58EEk9WarnNwNhd658HB7szBeQthZliKn
         1WumM0vQyo0UrNOxIVwBT70Zr4KgxsfRYy9n3j4Umw8cCwaWWQvs8vGdiAmGPwoDEd
         GO4a/jaCc0PgYHNj6j3Po+DybaZZDMPTXwFhnOo41QYQP1I04o7nrJokUaV3RnAg4J
         IrBEPFvyh1P4w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/01/2020 01:17, Dmitry Osipenko wrote:
> There is no benefit from runtime PM usage for the APB DMA driver because
> it enables clock at the time of channel's allocation and thus clock stays
> enabled all the time in practice, secondly there is benefit from manually
> disabled clock because hardware auto-gates it during idle by itself.

This assumes that the channel is allocated during a driver
initialisation. That may not always be the case. I believe audio is one
case where channels are requested at the start of audio playback.

Jon

-- 
nvpublic

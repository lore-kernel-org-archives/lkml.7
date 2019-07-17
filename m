Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BA8C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 13:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F2D21743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 13:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WOeN+a/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfGQNVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 09:21:32 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33384 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQNVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 09:21:32 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6HDL8qN053169;
        Wed, 17 Jul 2019 08:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1563369668;
        bh=OxgZ7MOvt4xRiKGYYeG81gjj0/OIKQv6y5JnxuhZoFs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WOeN+a/NksI2gXRM1SIQMWBRCbkHU4+xz6sNcwoGcsflztrZ8fWvud/ITcx8IMtBZ
         Jqe2MuuqMbWwsADPB7hpQx93ITyiEVQLzAF66bT7TU+2wm8E65D8sYkDzD1OSOLIYM
         iHR73DUXVai/YXFmwNCnUO5tTqu0O2j+IODDAZiw=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6HDL8PI058396
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Jul 2019 08:21:08 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 17
 Jul 2019 08:21:07 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 17 Jul 2019 08:21:07 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6HDL4cF000406;
        Wed, 17 Jul 2019 08:21:05 -0500
Subject: Re: add swiotlb support to arm32
To:     Christoph Hellwig <hch@lst.de>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     Roger Quadros <rogerq@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20190709142011.24984-1-hch@lst.de>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <6a56eacd-d481-de93-e0d8-64d8385de214@ti.com>
Date:   Wed, 17 Jul 2019 18:51:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709142011.24984-1-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/07/19 7:50 PM, Christoph Hellwig wrote:
> Hi Russell,
> 
> This series adds swiotlb support to the 32-bit arm port to ensure
> platforms with LPAE support can support DMA mapping for all devices
> using 32-bit dma masks, just like we do on other ports that support
>> 32-bit physical addressing and don't have an iommu.


This series fixes SATA errors seen on TI platforms with LPAE like DRA7
Rev H EVM.

Tested-by: Vignesh Raghavendra <vigneshr@ti.com>

Thanks for the fix!

-- 
Regards
Vignesh

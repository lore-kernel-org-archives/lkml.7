Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C4BFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D3620854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WJJHxC+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439721AbfJQL3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:29:47 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47870 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439707AbfJQL3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:29:47 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9HBTinB072838;
        Thu, 17 Oct 2019 06:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571311784;
        bh=7ygDIapPNxB3j5FrIGxfjRl+GM5ZgZIeSEYwl/qdNoU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WJJHxC+kH41VpxabPn4rj3jab59mO6nZvu8uJLBA9ffBe+x12sStIkiNn3w74OTVY
         tIgFe4f3tk1PI5LjBs/v40JmvAVNoWb9apLe6hHQ5D7ykSQQ3NmxBlsArxm0xBZzvc
         QFsrzCkmvZ8buU2PfCBvWxIZVt7JgJAiCbmeAlyo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9HBTiVZ070830
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Oct 2019 06:29:44 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 17
 Oct 2019 06:29:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 17 Oct 2019 06:29:36 -0500
Received: from [172.24.190.212] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9HBTgQT121440;
        Thu, 17 Oct 2019 06:29:42 -0500
Subject: Re: [PATCH] ARM: davinci: dm365: Fix McBSP dma_slave_map entry
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <bgolaszewski@baylibre.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190830102202.22317-1-peter.ujfalusi@ti.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <bd3bd211-c558-d4f3-b09b-2c4bc8cc1181@ti.com>
Date:   Thu, 17 Oct 2019 16:59:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830102202.22317-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/19 3:52 PM, Peter Ujfalusi wrote:
> dm365 have only single McBSP, so the device name is without .0
> 
> Fixes: 0c750e1fe481d ("ARM: davinci: dm365: Add dma_slave_map to edma")
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Applied for v5.4

Thanks,
Sekhar

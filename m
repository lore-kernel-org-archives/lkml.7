Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B373C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B222087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UbPMT9XR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbfG3LYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 07:24:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42486 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfG3LYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 07:24:10 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6UBNwSL086590;
        Tue, 30 Jul 2019 06:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564485838;
        bh=bePICY9kNLcLOXhYrJoI3GRMfK4jeDEPCdEecBOuYVk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UbPMT9XRI32A7NfJlQJkwhI/3bf2x6G4IPZOIFWxzr7e2OAOsKEdh2AWsPGcNXTT2
         OKCD8225QykWeITsIkSCv+cqVx3N6I7UhfGXxaGI/w0Oy3nhMD1DPsujkuwphwrwb5
         mvQhBzvAY4UFSqy/rv8nhvCq0svgUNYCaFmV4wlY=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6UBNwmZ057992
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jul 2019 06:23:58 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 30
 Jul 2019 06:23:58 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 30 Jul 2019 06:23:58 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6UBNuKk043545;
        Tue, 30 Jul 2019 06:23:57 -0500
Subject: Re: [PATCH] dma-mapping: remove dma_{alloc,free,mmap}_writecombine
To:     Christoph Hellwig <hch@lst.de>
CC:     <laurent.pinchart@ideasonboard.com>,
        <dri-devel@lists.freedesktop.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20190730061849.29686-1-hch@lst.de>
 <5f73f400-eff2-6c7b-887d-c768642d8df1@ti.com> <20190730102050.GA1663@lst.de>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <f8425921-dc50-0cbd-72cb-b73a1194cfb7@ti.com>
Date:   Tue, 30 Jul 2019 14:23:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730102050.GA1663@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2019 13:20, Christoph Hellwig wrote:
> On Tue, Jul 30, 2019 at 10:50:32AM +0300, Tomi Valkeinen wrote:
>> On 30/07/2019 09:18, Christoph Hellwig wrote:
>>> We can already use DMA_ATTR_WRITE_COMBINE or the _wc prefixed version,
>>> so remove the third way of doing things.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> ---
>>>    drivers/gpu/drm/omapdrm/dss/dispc.c | 11 +++++------
>>>    include/linux/dma-mapping.h         |  9 ---------
>>>    2 files changed, 5 insertions(+), 15 deletions(-)
>>
>> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>
>> Which tree should this be applied to?
> 
> I'd like to add it to the dma-mapping tree if possible.

That's ok for me.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

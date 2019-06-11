Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93E5C0650E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855642173E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uz6bEiYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406222AbfFKRgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:36:24 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49648 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405785AbfFKRgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:36:23 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5BHaGOi016378;
        Tue, 11 Jun 2019 12:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560274576;
        bh=+9areqRVfrK1YDO1ErJT+yPadNyrrPz0UtT91OB9eco=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uz6bEiYTEu+wbM4h0gy9oYVe067KIitfHz1K21YKP7kcGcMa5c7VPBuloz/j0mH43
         7Uvw48L8Q+qOYREeZ2ljw3nKKvyeFAonqhSIhbuHYb1wTSkwaW0GO79+Vnswwx9b9Z
         0Y8adOBK6D+g0AlLq7S5RFjLvyXdcyvBUmfka+24=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5BHaGet064775
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jun 2019 12:36:16 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 11
 Jun 2019 12:36:16 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 11 Jun 2019 12:36:16 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5BHaDYh090017;
        Tue, 11 Jun 2019 12:36:13 -0500
Subject: Re: [PATCH v1.1] firmware: ti_sci: Add resource management APIs for
 ringacc, psi-l and udma
To:     Lokesh Vutla <lokeshvutla@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, <vkoul@kernel.org>,
        <nm@ti.com>, <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>,
        <tony@atomide.com>
References: <20190506123456.6777-2-peter.ujfalusi@ti.com>
 <20190610091856.25502-1-peter.ujfalusi@ti.com>
 <636f599a-cefa-ce70-d0ae-b5244edf14b2@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <2a755211-afd9-070c-954c-f6f2d931455b@ti.com>
Date:   Tue, 11 Jun 2019 20:36:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <636f599a-cefa-ce70-d0ae-b5244edf14b2@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2019 12:41, Lokesh Vutla wrote:
> 
> 
> On 10/06/19 2:48 PM, Peter Ujfalusi wrote:
>> Configuration of NAVSS resource, like rings, UDMAP channels, flows
>> and PSI-L thread management need to be done via TISCI.
>>
>> Add the needed structures and functions for NAVSS resource configuration of
>> the following:
>> Rings from Ring Accelerator
>> PSI-L thread management
>> UDMAP tchan, rchan and rflow configuration.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
> 
> Thanks and regards,
> Lokesh
> 

Thanks, queuing this single patch up for 5.3.

Vinod, I am setting up an immutable branch if you need to pick this 
patch up; basically if you are planning to merge the dma support for 
5.3. Available as a tag here (I'll send a pull-req out for this in a bit):

   git://git.kernel.org/pub/scm/linux/kernel/git/kristo/linux 
tags/ti-sci-for-5.3

It is based on top of clock driver pull-request due to dependencies.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

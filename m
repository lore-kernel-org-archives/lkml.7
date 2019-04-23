Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781BBC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506E5206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfDWNJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:09:49 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:51636 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbfDWNJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:09:48 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hIvB8-0000Ov-55 from Jiada_Wang@mentor.com ; Tue, 23 Apr 2019 06:09:42 -0700
Received: from [172.30.104.65] (147.34.91.1) by svr-orw-mbx-03.mgc.mentorg.com
 (147.34.90.203) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 23 Apr
 2019 06:09:34 -0700
Subject: Re: [PATCH v2 1/2] thermal: rcar_gen3_thermal: fix interrupt type
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
CC:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <daniel.lezcano@linaro.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <joshua_frkuska@mentor.com>,
        <horms+renesas@verge.net.au>,
        <niklas.soderlund+renesas@ragnatech.se>, <geert+renesas@glider.be>,
        <sergei.shtylyov@cogentembedded.com>,
        <marek.vasut+renesas@gmail.com>,
        <kuninori.morimoto.gx@renesas.com>, <hien.dang.eb@renesas.com>,
        <fabrizio.castro@bp.renesas.com>, <dien.pham.ry@renesas.com>,
        <biju.das@bp.renesas.com>, Eugeniu Rosca <rosca.eugeniu@gmail.com>
References: <20190423130724.GA10913@vmlxhi-102.adit-jv.com>
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <f01e4a8e-04da-ac93-1e0f-1999e2670851@mentor.com>
Date:   Tue, 23 Apr 2019 22:09:33 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423130724.GA10913@vmlxhi-102.adit-jv.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SVR-ORW-MBX-07.mgc.mentorg.com (147.34.90.207) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugeniu

On 2019/04/23 22:07, Eugeniu Rosca wrote:
> Hi Jiada,
> 
> On Tue, Apr 23, 2019 at 03:12:17PM +0900, Jiada Wang wrote:
>> Currently IRQF_SHARED type interrupt line is allocated, but it
>> is not appropriate, as the interrupt line isn't shared between
>> different devices, instead IRQF_ONESHOT is the proper type.
>>
>> By changing interrupt type to IRQF_ONESHOT, now irq handler is
>> no longer needed, as clear of interrupt status can be done in
>> threaded interrupt context.
>>
>> Because IRQF_ONESHOT type interrupt line is kept disabled until
>> the threaded handler has been run, so there is no need to protect
>> read/write of REG_GEN3_IRQSTR with lock.
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
>>   drivers/thermal/rcar_gen3_thermal.c | 40 ++++++++---------------------
>>   1 file changed, 10 insertions(+), 30 deletions(-)
>>
> 
> [..]
> 
> I might be doing something wrong, but I couldn't apply this patch on top
Oops, I think I used wrong code base,
I will send out v3 patch-set soon

sorry about that

Thanks,
Jiada
> of v5.1-rc6-4-g7142eaa58b49. All below commands failed (git v2.21.0):
>   - git am this.patch
>   - git apply this.patch
>   - patch -p1 < this.patch
> 

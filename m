Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E136FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B513620643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L2B98ZSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfCKRrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:47:52 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37858 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbfCKRrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:47:51 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2BHlfQA003658;
        Mon, 11 Mar 2019 12:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552326461;
        bh=Yt4S7O/WuklQkEvWX7rUlVTWgy//JAzu5O2rIZIRUl8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=L2B98ZSBHdBHGG+EzScaDZ19KTZFelOUbseY1w8Qyreti4gfbQLmrfVPxWmzDL2xL
         s7Ryc1rfYYkiCK5IJFHJ4FxB4Ive0FMDK0Tj45p/CmQzc8lkGDX0KH9EWcgudp7vaw
         SH3c4vLpR19M0tlz25mmlyr5sUM+8P4I4hcUMrwU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2BHlfOv037556
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Mar 2019 12:47:41 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 11
 Mar 2019 12:47:40 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 11 Mar 2019 12:47:40 -0500
Received: from [172.22.80.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2BHlePU010276;
        Mon, 11 Mar 2019 12:47:40 -0500
Subject: Re: [PATCH 4/4] leds: lm3532: Introduce the lm3532 LED driver
To:     Joe Perches <joe@perches.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <robh+dt@kernel.org>, <pavel@ucw.cz>, <tony@atomide.com>,
        <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20190307220947.20057-1-dmurphy@ti.com>
 <20190307220947.20057-4-dmurphy@ti.com>
 <8ac4d84f-c792-893d-fbae-fac88fac8631@gmail.com>
 <bb621d08-c192-0018-f67e-3f3262a71b6f@ti.com>
 <cf26b351-f2b5-8345-29b7-401153b5f0d7@gmail.com>
 <ee13f836-bd77-22b0-e230-2fc9050afe88@ti.com>
 <09ee942fb7be08c600c989217ad3abfe4b6702fd.camel@perches.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <c3743a0e-9efd-e179-098c-31b1242870b4@ti.com>
Date:   Mon, 11 Mar 2019 12:47:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <09ee942fb7be08c600c989217ad3abfe4b6702fd.camel@perches.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Joe

On 3/11/19 12:30 PM, Joe Perches wrote:
> On Mon, 2019-03-11 at 12:24 -0500, Dan Murphy wrote:
>> checkpatch takes issue with // in headers.
>> Unless they have removed that requirement.
> 
> Awhile ago...
>

I guess I was referring to this SPDX warning
 
WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#1: FILE: drivers/net/can/m_can/m_can.h:1:
+//SPDX-License-Identifier: GPL-2.0

> commit dadf680de3c2eb4cba9840619991eda0cfe98778
> Author: Joe Perches <joe@perches.com>
> Date:   Tue Aug 2 14:04:33 2016 -0700
> 
>     checkpatch: allow c99 style // comments
>     
>     Sanitise the lines that contain c99 comments so that the error doesn't
>     get emitted.
>     
>     Link: http://lkml.kernel.org/r/d4d22c34ad7bcc1bceb52f0742f76b7a6d585235.1468368420.git.joe@perches.com
>     Signed-off-by: Joe Perches <joe@perches.com>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> 


-- 
------------------
Dan Murphy

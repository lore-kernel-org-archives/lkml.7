Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09345C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D9E218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Av0o5wvq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfCOUtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:49:39 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40702 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfCOUtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:49:39 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2FKnGwU106755;
        Fri, 15 Mar 2019 15:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552682956;
        bh=SnkaexqRFSkgm12VGol7qyeN/Tpn2Nx2gpi6j2NTupw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Av0o5wvq3W3VLW6+c2fB1T8QUcgs1ChPSLeV1bx52Jh6idykpUWEtDbVwSQH3qaRU
         zdOuE9AGo5iwodS3MK5kWwpoM8S82GlcCTIrh5Iuv54mFHsqObCFJUWTjSD5mdfu30
         jE42TlVxblDshMPbkOdd4Por5rEIvL3ZURRRv1EI=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2FKnGBK011354
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Mar 2019 15:49:16 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 15
 Mar 2019 15:49:15 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Fri, 15 Mar 2019 15:49:15 -0500
Received: from [128.247.58.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2FKnFeW027285;
        Fri, 15 Mar 2019 15:49:15 -0500
Subject: Re: [RFC][PATCH 1/5 v2] dma-buf: Add dma-buf heaps framework
To:     Laura Abbott <labbott@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
CC:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        <dri-devel@lists.freedesktop.org>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-2-git-send-email-john.stultz@linaro.org>
 <b090063c-86ce-bc7b-4da0-80ca19883a47@redhat.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <786b46cd-d7fe-688f-ce00-24579d36c449@ti.com>
Date:   Fri, 15 Mar 2019 15:49:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <b090063c-86ce-bc7b-4da0-80ca19883a47@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/19 3:18 PM, Laura Abbott wrote:
> On 3/5/19 12:54 PM, John Stultz wrote:
>> +DMA-BUF HEAPS FRAMEWORK
>> +M:    Laura Abbott<labbott@redhat.com>
>> +R:    Liam Mark<lmark@codeaurora.org>
>> +R:    Brian Starkey<Brian.Starkey@arm.com>
>> +R:    "Andrew F. Davis"<afd@ti.com>
>> +R:    John Stultz<john.stultz@linaro.org>
>> +S:    Maintained
>> +L:    linux-media@vger.kernel.org
>> +L:    dri-devel@lists.freedesktop.org
>> +L:    linaro-mm-sig@lists.linaro.org  (moderated for non-subscribers)
>> +F:    include/uapi/linux/dma-heap.h
>> +F:    include/linux/dma-heap.h
>> +F:    drivers/dma-buf/dma-heap.c
>> +F:    drivers/dma-buf/heaps/*
>> +T:    git git://anongit.freedesktop.org/drm/drm-misc
> 
> So I talked about this with Sumit privately but I think
> it might make sense to have me step down as maintainer when
> this goes out of staging. I mostly worked on Ion at my
> previous position and anything I do now is mostly a side
> project. I still want to see it succeed which is why I
> took on the maintainer role but I don't want to become blocking
> for people who have a stronger vision about where this needs
> to go (see also, I'm not working with this on a daily basis).
> 
> If you just want someone to help review or take patches
> to be pulled, I'm happy to do so but I'd hate to become
> the bottleneck on getting things done for people who
> are attempting to do real work.
> 

We could consider this as an "ION inspired" framework, and treat it like
an extension of DMA-BUF. In which case Sumit could become the default
Maintainer if he's up for it.

Andrew

> Thanks,
> Laura

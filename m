Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDF5CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7555222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Prb4MoXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633897AbfJRNzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:55:24 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60160 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505071AbfJRNzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:55:24 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9IDsrP3114107;
        Fri, 18 Oct 2019 08:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571406893;
        bh=gy7n9P0uBhu8M6TfOX+hY8VcIvOtD4Bt1FjdWFdP+lY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Prb4MoXRDxDZQQhH293iBAsVCyrlojpGcQS93wlZlwYmsrOkHkKfpwjYkH0DTx1iH
         1duOV3f3UkvIDIYVymxZz1aTXRGRLp1ZqDhvBHDwKUhIBpOaVMcprD4BlitFSoKcUW
         5MLN47MVbvK5Rh6hgxxPtl5yGkD0LBPZKwe/bSsE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9IDsrNu065857
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Oct 2019 08:54:53 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 18
 Oct 2019 08:54:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 18 Oct 2019 08:54:53 -0500
Received: from [10.250.79.55] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9IDsqJP036329;
        Fri, 18 Oct 2019 08:54:52 -0500
Subject: Re: [PATCH v12 4/5] dma-buf: heaps: Add CMA heap to dmabuf heaps
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Brian Starkey <Brian.Starkey@arm.com>
CC:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Hillf Danton <hdanton@sina.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
References: <20191018052323.21659-1-john.stultz@linaro.org>
 <20191018052323.21659-5-john.stultz@linaro.org>
 <20191018112124.grjgqrn3ckuc7n4v@DESKTOP-E1NTVVP.localdomain>
 <CA+M3ks6KqqXCfqA6VDKnQOsvFLQfaGrUnA+eesnyzMRniFB00A@mail.gmail.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <5a172663-21d5-5f5d-c9d3-f643d8dadc34@ti.com>
Date:   Fri, 18 Oct 2019 09:54:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CA+M3ks6KqqXCfqA6VDKnQOsvFLQfaGrUnA+eesnyzMRniFB00A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/19 8:03 AM, Benjamin Gaignard wrote:
> Le ven. 18 oct. 2019 à 13:21, Brian Starkey <Brian.Starkey@arm.com> a écrit :
>>
>> On Fri, Oct 18, 2019 at 05:23:22AM +0000, John Stultz wrote:
>>> This adds a CMA heap, which allows userspace to allocate
>>> a dma-buf of contiguous memory out of a CMA region.
>>>
>>> This code is an evolution of the Android ION implementation, so
>>> thanks to its original author and maintainters:
>>>   Benjamin Gaignard, Laura Abbott, and others!
>>>
>>> NOTE: This patch only adds the default CMA heap. We will enable
>>> selectively adding other CMA memory regions to the dmabuf heaps
>>> interface with a later patch (which requires a dt binding)
> 
> Maybe we can use "no-map" DT property to trigger that. If set do not expose the
> cma heap.


"no-map" means it can't be used as a regular CMA either, we want some
way to both have it as a device usable CMA but also not be exposed to
userspace if needed.

Andrew

> 
> Benjamin
>>
>> That'll teach me for reading my email in FIFO order.
>>
>> This approach makes sense to me.
>>
>> -Brian
>>

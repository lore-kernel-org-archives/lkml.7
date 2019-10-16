Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B3DFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDC62082C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pmneRVSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389386AbfJPRlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 13:41:01 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54368 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfJPRlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 13:41:00 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9GHeiln054132;
        Wed, 16 Oct 2019 12:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571247644;
        bh=Wc7RR5GvEzErLs8YJE/8azaMJ2X1mI57r2l2h9Hi84s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pmneRVSlMMtJZS9TC6eP4IE7K4BF4wF7y7u3LRIFYqflLA9GQ+VyCckB/roTGGjQw
         NsHrk6pYWjxTBjTGacKt7dAwwErYSyjBlUpNYFQpOjeRQvtwPQEREYsnVH2osls3b/
         9FSc4kYRas+i3s6kdjxbR+T1vorvQ93zuWvWRMD4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9GHeiGq109306
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Oct 2019 12:40:44 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 16
 Oct 2019 12:40:37 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 16 Oct 2019 12:40:44 -0500
Received: from [10.250.79.55] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9GHehq7108884;
        Wed, 16 Oct 2019 12:40:43 -0500
Subject: Re: [RESEND][PATCH v8 0/5] DMA-BUF Heaps (destaging ION)
To:     Brian Starkey <Brian.Starkey@arm.com>
CC:     Ayan Halder <Ayan.Halder@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Hridya Valsaraju <hridya@google.com>, nd <nd@arm.com>,
        Pratik Patel <pratikp@codeaurora.org>
References: <20190906184712.91980-1-john.stultz@linaro.org>
 <CAO_48GFHx4uK6cWwJ4oGdJ8HNZNZYDzdD=yR3VK0EXQ86ya9-g@mail.gmail.com>
 <20190924162217.GA12974@arm.com> <20191009173742.GA2682@arm.com>
 <f4fb09a5-999b-e676-0403-cc0de41be440@ti.com>
 <20191014090729.lwusl5zxa32a7uua@DESKTOP-E1NTVVP.localdomain>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <a213760f-1f41-c4a3-7e38-8619898adecd@ti.com>
Date:   Wed, 16 Oct 2019 13:40:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014090729.lwusl5zxa32a7uua@DESKTOP-E1NTVVP.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/19 5:07 AM, Brian Starkey wrote:
> Hi Andrew,
> 
> On Wed, Oct 09, 2019 at 02:27:15PM -0400, Andrew F. Davis wrote:
>> The CMA driver that registers these nodes will have to be expanded to
>> export them using this framework as needed. We do something similar to
>> export SRAM nodes:
>>
>> https://lkml.org/lkml/2019/3/21/575
>>
>> Unlike the system/default-cma driver which can be centralized in the
>> tree, these extra exporters will probably live out in other subsystems
>> and so are added in later steps.
>>
>> Andrew
> 
> I was under the impression that the "cma_for_each_area" loop in patch
> 4 would do that (add_cma_heaps). Is it not the case?
> 

For these cma nodes yes, I thought you meant reserved memory areas in
general.

Just as a side note, I'm not a huge fan of the cma_for_each_area() to
begin with, it seems a bit out of place when they could be selectively
added as heaps as needed. Not sure how that will work with cma nodes
specifically assigned to devices, seems like we could just steal their
memory space from userspace with this..

Andrew

> Thanks,
> -Brian
> 

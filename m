Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321ABC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07932083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HVJzkpSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfCSPDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:03:40 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34576 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfCSPDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:03:40 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2JF3LUJ038726;
        Tue, 19 Mar 2019 10:03:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553007801;
        bh=G+nIWp/SV6D9jpMOQR7VGAxRHfEloOK7UZ7IgB/GOmE=;
        h=From:Subject:To:CC:References:Date:In-Reply-To;
        b=HVJzkpSf8S+bxmAThLR5NJqeiKEE+Sd1np4mORnvx2F1T9zEhUCMr0YGXv3WLClfn
         t9AUXwxJ3N9W+nx/4iL+5fhA/egbIQO6edl4ToJ/9SlkwwzH02GDOU1cmn2pjWh1uj
         11/QINWg5FhLu1gROPfcOLQ/o4GNlqZSe0tc55Qo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2JF3LQJ041613
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Mar 2019 10:03:21 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 19
 Mar 2019 10:03:21 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Tue, 19 Mar 2019 10:03:21 -0500
Received: from [10.250.67.168] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2JF3K3H006853;
        Tue, 19 Mar 2019 10:03:20 -0500
From:   "Andrew F. Davis" <afd@ti.com>
Subject: Re: [RFC][PATCH 2/5 v2] dma-buf: heaps: Add heap helpers
To:     Christoph Hellwig <hch@infradead.org>,
        John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        <dri-devel@lists.freedesktop.org>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-3-git-send-email-john.stultz@linaro.org>
 <20190315090646.GC4470@infradead.org>
Message-ID: <9feaab47-f2c2-3b85-0c9c-05cd97609beb@ti.com>
Date:   Tue, 19 Mar 2019 10:03:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190315090646.GC4470@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/19 4:06 AM, Christoph Hellwig wrote:
>> +		ret = remap_pfn_range(vma, addr, page_to_pfn(page), len,
>> +				      vma->vm_page_prot);
> 
> So the same chunk could be mapped to userspace and vmap, and later on
> also DMA mapped.  Who is going to take care of cache aliasing as I
> see nothing of that in this series?
> 

We should only have one type of memory per heap so all mappings will
have the same type. That should solve the ARM specific issues, but I'm
guessing you are thinking of more tricky architectures where all
mappings need to be tracked and cleaned/invalidated..

For that I think we will have to track each right? How do others handle
that, we can't be the first to offer cached buffers to userspace.

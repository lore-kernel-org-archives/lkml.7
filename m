Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B1DC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E504721901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aWkhP88S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfGYSzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:55:38 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33368 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfGYSzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:55:38 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6PItKrR068465;
        Thu, 25 Jul 2019 13:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564080920;
        bh=YdD4zfwHqas8CGYaDHj00S3Kucs0PertaKix+qVtXhs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=aWkhP88SJ+JihgtMm+qXvbf7KClTa71shnT1YZAIw2q4EWJRI4ZMnCY1gEzuQ3DXT
         mhSEWSyeceD8dvlPBHscPTGZRkI9wQz245CDz311a/fxMR8qeAM1c8f4zZRvKafssZ
         dkYO6HhX2MyLkLRlpEJTvjE7Jp8CMxM4fDUWKN1s=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6PItKaw062605
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Jul 2019 13:55:20 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 25
 Jul 2019 13:55:20 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 25 Jul 2019 13:55:20 -0500
Received: from [10.250.86.29] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6PItJWc043305;
        Thu, 25 Jul 2019 13:55:19 -0500
Subject: Re: [PATCH v7 3/5] dma-buf: heaps: Add system heap to dmabuf heaps
To:     Christoph Hellwig <hch@infradead.org>,
        John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        <dri-devel@lists.freedesktop.org>
References: <20190724003656.59780-1-john.stultz@linaro.org>
 <20190724003656.59780-4-john.stultz@linaro.org>
 <20190725130204.GG20286@infradead.org>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <e64aae4c-ec54-2507-cc78-a27d5093f793@ti.com>
Date:   Thu, 25 Jul 2019 14:55:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725130204.GG20286@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/19 9:02 AM, Christoph Hellwig wrote:
>> +struct system_heap {
>> +	struct dma_heap *heap;
>> +} sys_heap;
> 
> It seems like this structure could be removed and if would improve
> the code flow.
> 
>> +static struct dma_heap_ops system_heap_ops = {
>> +	.allocate = system_heap_allocate,
>> +};
>> +
>> +static int system_heap_create(void)
>> +{
>> +	struct dma_heap_export_info exp_info;
>> +	int ret = 0;
>> +
>> +	exp_info.name = "system_heap";
>> +	exp_info.ops = &system_heap_ops;
>> +	exp_info.priv = &sys_heap;
>> +
>> +	sys_heap.heap = dma_heap_add(&exp_info);
>> +	if (IS_ERR(sys_heap.heap))
>> +		ret = PTR_ERR(sys_heap.heap);
>> +
>> +	return ret;
> 
> The data structures here seem a little odd.  I think you want to:
> 
>  - mark all dma_heap_ops instanes consts, as we generally do that for
>    all structures containing function pointers
>  - move the name into dma_heap_ops.
>  - remove the dma_heap_export_info structure, which is a bit pointless


The idea here is to keep the struct dma_heap as an opaque pointer for
everyone but the core framework. No one should be touching the guts of
that struct (would be 'private' if we were using C++ but this is the
best we can do with C), exposing it to the exporters or the importers
will break this isolation.

This export style also matches DMA-BUF: you pass in a filled out _export
struct and it passes back a dma_buf handle. DMA-BUF unfortunately made
the internals of that struct public so they are widely used directly
(and abused in some cases) and that prevents the internals from being
easily refactored when needed.

Andrew


>  - don't bother setting a private data, as you don't need it.
>    If other heaps need private data I'd suggest to switch to embedding
>    the dma_heap structure into containing structure insted so that you
>    can use container_of to get at it.
>  - also why is the free callback passed as a callback rather than
>    kept in dma_heap_ops, next to the paired alloc one?
> 

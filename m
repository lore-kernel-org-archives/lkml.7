Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83395C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF5A2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bvQI9jRK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfDYPBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:01:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58470 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDYPBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UHTIv2bYWCMmrceWnwUo0Fh9FKFnrseI4vreb5e9FKc=; b=bvQI9jRKJKedhApGQGL7NC7Us
        ZTmouNizaDjyj/BFyna/0u54CTi/1wmbXgavf7Q+B7ARBQBne4dlXFL2pNCBauGrzvLiU05/W7wOO
        ZyZgJSVDU0U5W9XdFs4Wb9J4Ejlq4ZW+68Te8Szx5Vxz3a37YDHnzmxIsP8S2LU0u4mOmTphrGeiX
        fpuuBC69Gbvs+yjGC1GN/LtJlniccf+WmkfxyOqCoBkGD+nd7IgVYcoY6t0eVf1lEJzjUFCgvUBlc
        yKqIt2ZIREwAPWIdBcF+zvIwaKjYjz1mru5T3SoOoGGh5xd7cYT8bfc/mWtaHP6OfEqFgA01bpSlP
        jWoO65ebw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJfsb-0002iU-TR; Thu, 25 Apr 2019 15:01:41 +0000
Subject: Re: [PATCH] docs/vm: add documentation of memory models
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1556101715-31966-1-git-send-email-rppt@linux.ibm.com>
 <a4def881-1df0-6835-4b9a-dc957c979683@infradead.org>
 <20190425082239.GC10625@rapoport-lnx>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2b97f4db-78c0-1cad-bdf5-948720e8094f@infradead.org>
Date:   Thu, 25 Apr 2019 08:01:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425082239.GC10625@rapoport-lnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/19 1:22 AM, Mike Rapoport wrote:
> Hi Randy,
> 
> On Wed, Apr 24, 2019 at 06:08:46PM -0700, Randy Dunlap wrote:
>> On 4/24/19 3:28 AM, Mike Rapoport wrote:
>>> Describe what {FLAT,DISCONTIG,SPARSE}MEM are and how they manage to
>>> maintain pfn <-> struct page correspondence.
>>>
>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>> ---
>>>  Documentation/vm/index.rst        |   1 +
>>>  Documentation/vm/memory-model.rst | 171 ++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 172 insertions(+)
>>>  create mode 100644 Documentation/vm/memory-model.rst
>>>
>>
>> Hi Mike,
>> I have a few minor edits below...
> 
> I kinda expected those ;-)
> 
>>> diff --git a/Documentation/vm/memory-model.rst b/Documentation/vm/memory-model.rst
>>> new file mode 100644
>>> index 0000000..914c52a
>>> --- /dev/null
>>> +++ b/Documentation/vm/memory-model.rst
> 
> ...
> 
>>> +
>>> +With FLATMEM, the conversion between a PFN and the `struct page` is
>>> +straightforward: `PFN - ARCH_PFN_OFFSET` is an index to the
>>> +`mem_map` array.
>>> +
>>> +The `ARCH_PFN_OFFSET` defines the first page frame number for
>>> +systems that their physical memory does not start at 0.
>>
>> s/that/when/ ?  Seems awkward as is.
> 
> Yeah, it is awkward. How about
> 
> The `ARCH_PFN_OFFSET` defines the first page frame number for
> systems with physical memory starting at address different from 0.

OK.  Thanks.

>>> +
>>> +DISCONTIGMEM
>>> +============
>>> +
>>
>> thanks.
>> -- 
>> ~Randy
>>
> 


-- 
~Randy

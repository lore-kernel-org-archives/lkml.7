Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3FAC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 16:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A48C2081B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 16:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="XynQCoTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbfIMQJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 12:09:14 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:42738 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfIMQJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 12:09:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 894CE3F4EE;
        Fri, 13 Sep 2019 18:09:01 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=XynQCoTb;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id w66xOcqsUdTC; Fri, 13 Sep 2019 18:09:00 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id C1B533F4CE;
        Fri, 13 Sep 2019 18:08:58 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id F2D88360142;
        Fri, 13 Sep 2019 18:08:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1568390938; bh=41MPZF1NeqOE0U6C6W9oOWADl0xCjXwYhj5nNmjRnd8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XynQCoTbU1vNaNOD1qJfXS4/bvLSiIvoX7kfiON1kgTFMwvHHRqAkyaF2qkA+Bi81
         /UnRhY8//LOcCTpf1fBzpEW2/YiDJRAu5Hy1DlO6y36DGIy+BCamkUQNY2Suy7TwWz
         c8zsZT3WgsPGSCU6llPnwjTx8zGiMdiTvmLTKC3Y=
Subject: Re: [RFC PATCH 3/7] drm/ttm: TTM fault handler helpers
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20190913093213.27254-1-thomas_os@shipmail.org>
 <20190913093213.27254-4-thomas_os@shipmail.org>
 <20190913151803.GO29434@bombadil.infradead.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <6d33a9fd-47bb-a041-cd18-d67605edae54@shipmail.org>
Date:   Fri, 13 Sep 2019 18:08:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190913151803.GO29434@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/19 5:18 PM, Matthew Wilcox wrote:
> On Fri, Sep 13, 2019 at 11:32:09AM +0200, Thomas Hellström (VMware) wrote:
>> +vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>> +				    pgprot_t prot,
>> +				    pgoff_t num_prefault)
>> +{
>> +	struct vm_area_struct *vma = vmf->vma;
>> +	struct vm_area_struct cvma = *vma;
>> +	struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
>> +	    vma->vm_private_data;
> It's a void *.  There's no need to cast it.
>
> 	struct ttm_buffer_object *bo = vma->vm_private_data;
>
> conveys exactly the same information to both the reader and the compiler,
> except it's all on one line instead of split over two.

Indeed.

However since this is mostly a restructuring commit and there are a 
couple of these present in the code I'd like to keep cleanups separate.

Thanks,
Thomas



Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F83FC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 16:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AB32084F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 16:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="WVfG9T7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388575AbfIMQX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 12:23:29 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:38754 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388221AbfIMQX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 12:23:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 2B1E23F869;
        Fri, 13 Sep 2019 18:23:27 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="WVfG9T7K";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Oq9M03gjm-GP; Fri, 13 Sep 2019 18:23:26 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 5FB423F269;
        Fri, 13 Sep 2019 18:23:20 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 9FA1E360142;
        Fri, 13 Sep 2019 18:23:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1568391800; bh=mIcuuWQWBmGVqj9JQ0olPW5Gf42nPgrVqWnb6Umawhw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WVfG9T7KRLDYZjuSXF4jaCC4ppRK9FiUWZg8b47LxCpKg18xBbAgrGMcKrBptbrBP
         oed1Qnjig9yN7MwLk4OOfTHs9+IGo9NEM8iVCQEeAIS+aPqVT5h61fgIemKsLhV2fK
         9gefmdS9q3p8cS//LBXfaOASQLqv3VimEnL/uCLQ=
Subject: Re: [RFC PATCH 3/7] drm/ttm: TTM fault handler helpers
To:     Hillf Danton <hdanton@sina.com>,
        Thomas Hellstrom <thellstrom@vmware.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>, jglisse@redhat.com,
        christian.koenig@amd.com, Christoph Hellwig <hch@infradead.org>
References: <20190913093213.27254-1-thomas_os@shipmail.org>
 <20190913134039.3164-1-hdanton@sina.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <b52cd3f4-9d46-8423-29dc-c7f3c2ebd0c5@shipmail.org>
Date:   Fri, 13 Sep 2019 18:23:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190913134039.3164-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/19 3:40 PM, Hillf Danton wrote:
> On Fri, 13 Sep 2019 11:32:09 +0200
>>   	err = ttm_mem_io_lock(man, true);
>> -	if (unlikely(err != 0)) {
>> -		ret = VM_FAULT_NOPAGE;
>> -		goto out_unlock;
>> -	}
>> +	if (unlikely(err != 0))
>> +		return VM_FAULT_NOPAGE;
>>   	err = ttm_mem_io_reserve_vm(bo);
>> -	if (unlikely(err != 0)) {
>> -		ret = VM_FAULT_SIGBUS;
>> -		goto out_io_unlock;
>> -	}
>> +	if (unlikely(err != 0))
>> +		return VM_FAULT_SIGBUS;
>>
> Hehe, no hurry.

Ah. I get the point :) Yes, I'll update. Haven't been looking at these 
patches for a while.

Thanks,

Thomas



Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1D4C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E328420868
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="l/Ej5NzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfEVQJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:09:26 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:33488 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729388AbfEVQJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:09:26 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id DB0422E14B1;
        Wed, 22 May 2019 19:09:23 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id c8metHw3vh-9Np8KpjV;
        Wed, 22 May 2019 19:09:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1558541363; bh=xHyX4E1Hji0iAx9uaJym9J5zgLcAXlnGb5qLA9y3lOY=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=l/Ej5NzVQcufOB3jmlM+euSF3y40LxiUq3TRKaX8JoZx4OfqfO44542FgflQDfSwc
         IMOjz9cFfrQ9s8hvjkfGWJOETXbTRWmJXsb45BibDM62/X3VNsxQAkyZ3sQhLaTdW+
         6GBNP2BcT6L5Jz8gLr38rpDz8CbWPJBJSULfWWlA=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:e47f:4b1d:b053:2762])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 6jbXv3Q5sw-9MdqBFAT;
        Wed, 22 May 2019 19:09:23 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] proc/meminfo: add MemKernel counter
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <155853600919.381.8172097084053782598.stgit@buzz>
 <20190522155220.GB4374@dhcp22.suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <177f56cd-6e10-4d2e-7a3e-23276222ba19@yandex-team.ru>
Date:   Wed, 22 May 2019 19:09:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522155220.GB4374@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.05.2019 18:52, Michal Hocko wrote:
> On Wed 22-05-19 17:40:09, Konstantin Khlebnikov wrote:
>> Some kinds of kernel allocations are not accounted or not show in meminfo.
>> For example vmalloc allocations are tracked but overall size is not shown
>> for performance reasons. There is no information about network buffers.
>>
>> In most cases detailed statistics is not required. At first place we need
>> information about overall kernel memory usage regardless of its structure.
>>
>> This patch estimates kernel memory usage by subtracting known sizes of
>> free, anonymous, hugetlb and caches from total memory size: MemKernel =
>> MemTotal - MemFree - Buffers - Cached - SwapCached - AnonPages - Hugetlb.
> 
> Why do we need to export something that can be calculated in the
> userspace trivially? Also is this really something the number really
> meaningful? Say you have a driver that exports memory to the userspace
> via mmap but that memory is not accounted. Is this really a kernel
> memory?
> 

It may be trivial right now but not fixed.
Adding new kinds of memory may change this definition.
For example hypothetical 'GPU buffers' may be handled as 'userspace' memory.

Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19209ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD52920820
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394299AbfJQRet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:34:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59040 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728639AbfJQRet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:34:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 59D73300C727;
        Thu, 17 Oct 2019 17:34:49 +0000 (UTC)
Received: from [10.36.117.42] (ovpn-117-42.ams2.redhat.com [10.36.117.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE5A25C1D8;
        Thu, 17 Oct 2019 17:34:47 +0000 (UTC)
Subject: Re: [RFC] Memory Tiering
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>
References: <c3d6de4d-f7c3-b505-2e64-8ee5f70b2118@intel.com>
 <0679872d-3d03-2fa3-5bd2-80f694357203@redhat.com>
 <2e193c88-f247-4c8f-f61c-c9b28303d62f@intel.com>
 <655c9d239ee1be425571aa1d71c681314e20984a.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <34ae126d-002b-b773-96c9-a78f7ef671e9@redhat.com>
Date:   Thu, 17 Oct 2019 19:34:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <655c9d239ee1be425571aa1d71c681314e20984a.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 17 Oct 2019 17:34:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.10.19 19:07, Verma, Vishal L wrote:
> 
> On Thu, 2019-10-17 at 07:17 -0700, Dave Hansen wrote:
>> On 10/17/19 1:07 AM, David Hildenbrand wrote:
>>> Very interesting topic. I heard similar demand from HPC folks
>>> (especially involving other memory types ("tiers")). There, I think
>>> you often want to let the application manage that. But of course, for
>>> many applications an automatic management might already be
>>> beneficial.
>>>
>>> Am I correct that you are using PMEM in this area along with
>>> ZONE_DEVICE and not by giving PMEM to the buddy (add_memory())?
>>
>> The PMEM starts out as ZONE_DEVICE, but we unbind it from its original
>> driver and bind it to this stub of a "driver": drivers/dax/kmem.c which
>> uses add_memory() on it.
>>
>> There's some nice tooling inside the daxctl component of ndctl to do all
>> the sysfs magic to make this happen.
>>
> Here is more info about the daxctl command in question:
> 
> https://pmem.io/ndctl/daxctl-reconfigure-device.html
> 

Thanks, yeah I saw the patches back then (I though they were by Pavel 
but they were actually by you :) ) to add the memory to the buddy (via 
add_memory()).

Will explore some more, thanks!

-- 

Thanks,

David / dhildenb

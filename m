Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F98C47E49
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98B721928
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lph5n35/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388454AbfJVIjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:39:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56707 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387692AbfJVIjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571733544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SFYknoKQFMX0hhh6UnVTokInEwZQ4JKZZbG8bKbotuk=;
        b=Lph5n35/UTonyrAqEU3KCWPLIwTecXGsbWJWceOH6YU+VKYMOTg0xqlXXNgHXjMSyRE19Y
        V5CYQxCeVk+ziv2d0azQl1sNSMXm+VLZMvn9C2pMxj0Wfp7DufLKyYj8SAibM5kf6oYwGW
        rqVYTxINQ7KouavQmurM8hGDf3EGY6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-6kCtObFAOMOWzjyIiNI7UA-1; Tue, 22 Oct 2019 04:38:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A85A800D4E;
        Tue, 22 Oct 2019 08:38:57 +0000 (UTC)
Received: from [10.36.117.11] (ovpn-117-11.ams2.redhat.com [10.36.117.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DDFF60856;
        Tue, 22 Oct 2019 08:38:54 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] mm: Memory offlining + page isolation cleanups
From:   David Hildenbrand <david@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>
References: <20191021172353.3056-1-david@redhat.com>
 <25d3f071-3268-298b-e0c8-9c307d1015fe@redhat.com>
 <20191022080835.GZ9379@dhcp22.suse.cz>
 <1f56744d-2c22-6c12-8fe8-4a71e791c467@redhat.com>
 <20191022082131.GC9379@dhcp22.suse.cz>
 <de39873c-ae55-88ed-0b4e-4f67a75ef81c@redhat.com>
Organization: Red Hat GmbH
Message-ID: <72f796fc-b2de-0bbc-b6d9-c5bf5fe62099@redhat.com>
Date:   Tue, 22 Oct 2019 10:38:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <de39873c-ae55-88ed-0b4e-4f67a75ef81c@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 6kCtObFAOMOWzjyIiNI7UA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.19 10:32, David Hildenbrand wrote:
> On 22.10.19 10:21, Michal Hocko wrote:
>> On Tue 22-10-19 10:15:07, David Hildenbrand wrote:
>>> On 22.10.19 10:08, Michal Hocko wrote:
>>>> On Tue 22-10-19 08:52:28, David Hildenbrand wrote:
>>>>> On 21.10.19 19:23, David Hildenbrand wrote:
>>>>>> Two cleanups that popped up while working on (and discussing) virtio=
-mem:
>>>>>>      https://lkml.org/lkml/2019/9/19/463
>>>>>>
>>>>>> Tested with DIMMs on x86.
>>>>>>
>>>>>> As discussed with michal in v1, I'll soon look into removing the use
>>>>>> of PG_reserved during memory onlining completely - most probably
>>>>>> disallowing to offline memory blocks with holes, cleaning up the
>>>>>> onlining+offlining code.
>>>>>
>>>>> BTW, I remember that ZONE_DEVICE pages are still required to be set
>>>>> PG_reserved. That has to be sorted out first.
>>>>
>>>> Do they?
>>>
>>> Yes, especially KVM code :/
>>
>> Details please?
>>

Oh, and I think you might be wondering "how can we have RAM without a=20
memmap in the guest", see

https://lwn.net/Articles/778240/

--=20

Thanks,

David / dhildenb


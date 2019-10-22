Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450BCCA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1993721BE5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGUi+bZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388280AbfJVIPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:15:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42640 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388061AbfJVIPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571732117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8AwgANZ9oDz6D4lqOk6X+wOo3w6oZWgeLO/Mbb7W20g=;
        b=CGUi+bZ+lYOUEzURb/nyM5w0RJ6OGF3sw3EKBu9ZiWGLGnm6NADY274NzG9xjT87gp7h2a
        mGHRqmIhLdAquq9PoB+OiMwfkBiNhnVd8PKoEjyLoEQBcRICRtRuciOKD1j3WxPL/9/LAX
        DUSLKI/oQfy8l8WAUPpfS95kgjMZPpk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-TBXAxhgSMVScSIvfMbhVQQ-1; Tue, 22 Oct 2019 04:15:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79DEB1800D6A;
        Tue, 22 Oct 2019 08:15:11 +0000 (UTC)
Received: from [10.36.117.11] (ovpn-117-11.ams2.redhat.com [10.36.117.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2065819C4F;
        Tue, 22 Oct 2019 08:15:07 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] mm: Memory offlining + page isolation cleanups
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <1f56744d-2c22-6c12-8fe8-4a71e791c467@redhat.com>
Date:   Tue, 22 Oct 2019 10:15:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022080835.GZ9379@dhcp22.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: TBXAxhgSMVScSIvfMbhVQQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.19 10:08, Michal Hocko wrote:
> On Tue 22-10-19 08:52:28, David Hildenbrand wrote:
>> On 21.10.19 19:23, David Hildenbrand wrote:
>>> Two cleanups that popped up while working on (and discussing) virtio-me=
m:
>>>    https://lkml.org/lkml/2019/9/19/463
>>>
>>> Tested with DIMMs on x86.
>>>
>>> As discussed with michal in v1, I'll soon look into removing the use
>>> of PG_reserved during memory onlining completely - most probably
>>> disallowing to offline memory blocks with holes, cleaning up the
>>> onlining+offlining code.
>>
>> BTW, I remember that ZONE_DEVICE pages are still required to be set
>> PG_reserved. That has to be sorted out first.
>=20
> Do they?

Yes, especially KVM code :/

>=20
>> I remember that somebody was
>> working on it a while ago but didn't hear about that again. Will look in=
to
>> that as well - should be as easy as adding a zone check (if there isn't =
a
>> pfn_to_online_page() check already). But of course, there might be speci=
al
>> cases ....
>=20
> I remember Alexander didn't want to change the PageReserved handling
> because he was worried about unforeseeable side effects. I have a vague
> recollection he (or maybe Dan) has promissed some follow up clean ups
> which didn't seem to materialize.

I'm looking into it right now, especially the KVM part.

--=20

Thanks,

David / dhildenb


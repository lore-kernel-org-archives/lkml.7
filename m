Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBF5C47E49
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 06:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E2C2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 06:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4OibaKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387783AbfJVGwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 02:52:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57460 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387768AbfJVGwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 02:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571727159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ReJsDGrBkaCH15KKy6SuSpRTiguWQ4uoygLPUcJ68ms=;
        b=a4OibaKg8EjKZVLno+juy83gmSHAPTTRwgZJT9/0zqaV4v848XDO9BPrqGM3855NesEGB0
        42ikTjwHkA2pdC5Qa/XobvQMC9j8d2hpXp6dxaO/zEwRRt3BBU/a6AkY+0Gr5MLftyWjIn
        mCPGSJ1r9ajRBdYa4HvwWUciHEW+hVk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-FAUUpK-bOYOhQCeXks9y-A-1; Tue, 22 Oct 2019 02:52:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1BB6800D4E;
        Tue, 22 Oct 2019 06:52:33 +0000 (UTC)
Received: from [10.36.117.11] (ovpn-117-11.ams2.redhat.com [10.36.117.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A65EC60C63;
        Tue, 22 Oct 2019 06:52:29 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] mm: Memory offlining + page isolation cleanups
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>
References: <20191021172353.3056-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <25d3f071-3268-298b-e0c8-9c307d1015fe@redhat.com>
Date:   Tue, 22 Oct 2019 08:52:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191021172353.3056-1-david@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: FAUUpK-bOYOhQCeXks9y-A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.19 19:23, David Hildenbrand wrote:
> Two cleanups that popped up while working on (and discussing) virtio-mem:
>   https://lkml.org/lkml/2019/9/19/463
>=20
> Tested with DIMMs on x86.
>=20
> As discussed with michal in v1, I'll soon look into removing the use
> of PG_reserved during memory onlining completely - most probably
> disallowing to offline memory blocks with holes, cleaning up the
> onlining+offlining code.

BTW, I remember that ZONE_DEVICE pages are still required to be set=20
PG_reserved. That has to be sorted out first. I remember that somebody=20
was working on it a while ago but didn't hear about that again. Will=20
look into that as well - should be as easy as adding a zone check (if=20
there isn't a pfn_to_online_page() check already). But of course, there=20
might be special cases ....


--=20

Thanks,

David / dhildenb


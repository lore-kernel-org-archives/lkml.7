Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C65CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC17218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHRI00dN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388479AbfJVJRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:17:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54628 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388006AbfJVJRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571735854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O5z9CMG3C81sifoUf2QQwhHlJPM7DMSGubNkuyFNjik=;
        b=NHRI00dNY2HoF1QPS4xmFjPnxP8d5+dfh/+TkWfPatcv20G1unhvlO6uTrJcPHyzCD4NIb
        VTcSsQAkqEuc9ffLn9eTjrOQuStSqF8Oy370sffKusFmzyIWKMaupUaJ1zZYSRKW8K9f1W
        cE3pTaRjv0zlpx6ie01IEfEdQZv8EC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-sm3pJgPVP2O00wTgL4khMA-1; Tue, 22 Oct 2019 05:17:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEABD107AD31;
        Tue, 22 Oct 2019 09:17:28 +0000 (UTC)
Received: from [10.36.117.11] (ovpn-117-11.ams2.redhat.com [10.36.117.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E60465D6A5;
        Tue, 22 Oct 2019 09:17:24 +0000 (UTC)
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
 <1f56744d-2c22-6c12-8fe8-4a71e791c467@redhat.com>
 <20191022082131.GC9379@dhcp22.suse.cz>
 <de39873c-ae55-88ed-0b4e-4f67a75ef81c@redhat.com>
 <20191022091431.GG9379@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <68d6da35-276c-0491-99ea-8249dee8fd1d@redhat.com>
Date:   Tue, 22 Oct 2019 11:17:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022091431.GG9379@dhcp22.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: sm3pJgPVP2O00wTgL4khMA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.19 11:14, Michal Hocko wrote:
> On Tue 22-10-19 10:32:11, David Hildenbrand wrote:
> [...]
>> E.g., arch/x86/kvm/mmu.c:kvm_is_mmio_pfn()
>=20
> Thanks for these references. I am not really familiar with kvm so I
> cannot really comment on the specific code but I am wondering why
> it simply doesn't check for ZONE_DEVICE explicitly? Also we do care
> about holes in RAM (from the early boot), those should be reserved
> already AFAIR. So we are left with hotplugged memory with holes and
> I am not really sure we should bother with this until there is a clear
> usecase in sight.

Well, checking for ZONE_DEVICE is only possible if you have an=20
initialized memmap. And that is not guaranteed when you start mapping=20
random stuff into your guest via /dev/mem.

I am reworking these patches right now and audit the whole kernel for=20
PageReserved() checks that might affect ZONE_DEVICE. I'll send the=20
collection of patches as RFC.

--=20

Thanks,

David / dhildenb


Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBC5C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764C7206F3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BM9BKnM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfKMSvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:51:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35975 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727582AbfKMSvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 13:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573671103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jPirtsbQkWucUwnMuKe8VCWe61zXQyhvRowbxeAY5IA=;
        b=BM9BKnM9/10+stAYlXfWyGycH2Lnz0gzaNF7Ro7m1Rij0T2ETMugiVKP2cVcL08zLy4Shy
        CVvNBIIUzM97kjanVrkhCHm+sWNlhymhz5ixt5mwaDOByryZzUd0yDVIs5406vzyZILS2t
        xnI4q0A4TDfnvgJ7IaQOOHbCSZbUp1c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-EwpZNYwXM5GafFpVyFCr0g-1; Wed, 13 Nov 2019 13:51:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B658D18A07C2;
        Wed, 13 Nov 2019 18:51:38 +0000 (UTC)
Received: from [10.36.116.48] (ovpn-116-48.ams2.redhat.com [10.36.116.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BAFC5DA70;
        Wed, 13 Nov 2019 18:51:27 +0000 (UTC)
Subject: Re: [PATCH 2/3] mm: Introduce subsection_dev_map
To:     Dan Williams <dan.j.williams@intel.com>,
        Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "longman@redhat.com" <longman@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mst@redhat.com" <mst@redhat.com>, "cai@lca.pw" <cai@lca.pw>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>
References: <20191108000855.25209-1-t-fukasawa@vx.jp.nec.com>
 <20191108000855.25209-3-t-fukasawa@vx.jp.nec.com>
 <CAPcyv4h+++k1VTB2xKWHXjC4LC0N=nvDUMcdbGAsDBmwMob5dw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <163d1d41-19c1-d8cf-6c1c-eec226c34ac1@redhat.com>
Date:   Wed, 13 Nov 2019 19:51:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4h+++k1VTB2xKWHXjC4LC0N=nvDUMcdbGAsDBmwMob5dw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: EwpZNYwXM5GafFpVyFCr0g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.11.19 20:13, Dan Williams wrote:
> On Thu, Nov 7, 2019 at 4:15 PM Toshiki Fukasawa
> <t-fukasawa@vx.jp.nec.com> wrote:
>>
>> Currently, there is no way to identify pfn on ZONE_DEVICE.
>> Identifying pfn on system memory can be done by using a
>> section-level flag. On the other hand, identifying pfn on
>> ZONE_DEVICE requires a subsection-level flag since ZONE_DEVICE
>> can be created in units of subsections.
>>
>> This patch introduces a new bitmap subsection_dev_map so that
>> we can identify pfn on ZONE_DEVICE.
>>
>> Also, subsection_dev_map is used to prove that struct pages
>> included in the subsection have been initialized since it is
>> set after memmap_init_zone_device(). We can avoid accessing
>> pages currently being initialized by checking subsection_dev_map.
>>
>> Signed-off-by: Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
>> ---
>>   include/linux/mmzone.h | 19 +++++++++++++++++++
>>   mm/memremap.c          |  2 ++
>>   mm/sparse.c            | 32 ++++++++++++++++++++++++++++++++
>>   3 files changed, 53 insertions(+)
>>
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index bda2028..11376c4 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -1174,11 +1174,17 @@ static inline unsigned long section_nr_to_pfn(un=
signed long sec)
>>
>>   struct mem_section_usage {
>>          DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
>> +#ifdef CONFIG_ZONE_DEVICE
>> +       DECLARE_BITMAP(subsection_dev_map, SUBSECTIONS_PER_SECTION);
>> +#endif
>=20
> Hi Toshiki,
>=20
> There is currently an effort to remove the PageReserved() flag as some
> code is using that to detect ZONE_DEVICE. In reviewing those patches
> we realized that what many code paths want is to detect online memory.
> So instead of a subsection_dev_map add a subsection_online_map. That
> way pfn_to_online_page() can reliably avoid ZONE_DEVICE ranges. I
> otherwise question the use case for pfn_walkers to return pages for
> ZONE_DEVICE pages, I think the skip behavior when pfn_to_online_page()
> =3D=3D false is the right behavior.

To be more precise, I recommended an subsection_active_map, to indicate=20
which memmaps were fully initialized and can safely be touched (e.g., to=20
read the zone/nid). This map would also be set when the devmem memmaps=20
were initialized (race between adding memory/growing the section and=20
initializing the memmap).

See

https://lkml.org/lkml/2019/10/10/87

and

https://www.spinics.net/lists/linux-driver-devel/msg130012.html

I dislike a map that is specific to ZONE_DEVICE or (currently)=20
!ZONE_DEVICE. I rather want an indication "this memmap is safe to=20
touch". As discussed along the mentioned threads, we can combine this=20
later with RCU to handle some races that are currently possible.

--=20

Thanks,

David / dhildenb


Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C124C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196B120652
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aa43xZK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfCHV1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:27:08 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9699 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfCHV1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:27:08 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c82de2c0000>; Fri, 08 Mar 2019 13:27:08 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 08 Mar 2019 13:27:07 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 08 Mar 2019 13:27:07 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 8 Mar
 2019 21:27:06 +0000
Subject: Re: [PATCH v3 1/1] mm: introduce put_user_page*(), placeholder
 versions
To:     Jerome Glisse <jglisse@redhat.com>, <john.hubbard@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20190306235455.26348-1-jhubbard@nvidia.com>
 <20190306235455.26348-2-jhubbard@nvidia.com>
 <20190308175712.GD3661@redhat.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <2e7ca6e2-70aa-8285-5010-808bb9568e5f@nvidia.com>
Date:   Fri, 8 Mar 2019 13:27:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190308175712.GD3661@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552080428; bh=3tvUY7zeJ4w84IzUd3MSVKGooVlpXF75LlcBQTZLcB4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=aa43xZK68IFXNgycq4yBvet4MIraEeY3y1GqNe4M8SYFF5Mi5c7A8gDJfWYiSkmKD
         jGzeYYcLDYMMF7DIksAJXqoPxPuKM/6b856idCc5eNF/afPlyLPQR+zUfX9eHReeeR
         qF5QXOed6drRl+XcJkFa3TbOa5Feh+Cwo0PEuRXrRzXROoCJM/7kg4w2zwlBZGNhTj
         N0sa7vY3UJcqR3iwZ6QcAtE5LhceFDkYsAPTRWr3W5K0Ne5Kv8DpdJR6/XToXH9WC8
         x0xSAPq6bpTx7v6CE5RNEK0vyS/eEUbpoKNyhGFKFz4nPV1VVPp7d6LDVkFB6KM94U
         KzXgvGYMzvLNw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/19 9:57 AM, Jerome Glisse wrote:
[snip]=20
> Just a small comments below that would help my life :)
>=20
> Reviewed-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>=20

Thanks for the review!=20

>> ---
>>  include/linux/mm.h | 24 ++++++++++++++
>>  mm/swap.c          | 82 ++++++++++++++++++++++++++++++++++++++++++++++
>=20
> Why not putting those functions in gup.c instead of swap.c ?

Yes, gup.c is better for these. And it passes the various cross compiler an=
d
tinyconfig builds locally, so I think I'm not missing any cases. (The swap.=
c=20
location was an artifact of very early approaches, pre-dating the
put_user_pages() name.)=20

[snip]

>>  #define SECTION_IN_PAGE_FLAGS
>>  #endif
>> diff --git a/mm/swap.c b/mm/swap.c
>> index 4d7d37eb3c40..a6b4f693f46d 100644
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -133,6 +133,88 @@ void put_pages_list(struct list_head *pages)
>>  }
>>  EXPORT_SYMBOL(put_pages_list);
>> =20
>> +typedef int (*set_dirty_func)(struct page *page);
>=20
> set_dirty_func_t would be better as it is the rule for typedef to append
> the _t also it make it easier for coccinelle patch.
>=20

Done. I'm posting a v4 in a moment, with both of the above, plus
Christopher's "real filesystems" wording change, and your reviewed-by
tag.


thanks,
--=20
John Hubbard
NVIDIA

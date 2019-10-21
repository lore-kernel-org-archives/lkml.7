Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98B4C47E49
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF7B20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5V+U+3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfJUJks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:40:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33866 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfJUJkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571650846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z/vVU8j60PemoVrVIBHycAhVk2dH8/VFcxDCl6p26Mo=;
        b=T5V+U+3d6ugQXl+hwNj0uSULg7Go2RWj5hg6F7HmBy+2AlGuT25opgDcOktXXe7Juh6a7U
        f90gv5N5Sz2KcPYSLawFXb/miBwljgPXfo05ZCfTop7+BVaQHyMGR9MuSTGMuew5Dz1Rjk
        O0fy8c/qwUr0VoqtXtT5W0ZVEEUtnIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-nJdb8VrPODS3C6pIL_cDKQ-1; Mon, 21 Oct 2019 05:40:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7DD61800D79;
        Mon, 21 Oct 2019 09:40:41 +0000 (UTC)
Received: from [10.36.116.198] (ovpn-116-198.ams2.redhat.com [10.36.116.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 878236012A;
        Mon, 21 Oct 2019 09:40:40 +0000 (UTC)
Subject: Re: [RFC PATCH v2 15/16] mm/hwpoison-inject: Rip off duplicated
 checks
To:     Oscar Salvador <osalvador@suse.de>, n-horiguchi@ah.jp.nec.com
Cc:     mhocko@kernel.org, mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-16-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <1aa1f09a-1210-d0bc-86ac-9674828bff49@redhat.com>
Date:   Mon, 21 Oct 2019 11:40:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017142123.24245-16-osalvador@suse.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: nJdb8VrPODS3C6pIL_cDKQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.10.19 16:21, Oscar Salvador wrote:
> memory_failure() already performs the same checks, so leave it
> to the main routine.
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   mm/hwpoison-inject.c | 33 +++------------------------------
>   1 file changed, 3 insertions(+), 30 deletions(-)
>=20
> diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
> index 0c8cdb80fd7d..fdcca3df4283 100644
> --- a/mm/hwpoison-inject.c
> +++ b/mm/hwpoison-inject.c
> @@ -14,49 +14,22 @@ static struct dentry *hwpoison_dir;
>   static int hwpoison_inject(void *data, u64 val)
>   {
>   =09unsigned long pfn =3D val;
> -=09struct page *p;
> -=09struct page *hpage;
> -=09int err;
>  =20
>   =09if (!capable(CAP_SYS_ADMIN))
>   =09=09return -EPERM;
>  =20
> -=09if (!pfn_valid(pfn))
> -=09=09return -ENXIO;
> -
> -=09p =3D pfn_to_page(pfn);
> -=09hpage =3D compound_head(p);
> -
> -=09if (!hwpoison_filter_enable)
> -=09=09goto inject;
> -
> -=09shake_page(hpage, 0);
> -=09/*
> -=09 * This implies unable to support non-LRU pages.
> -=09 */
> -=09if (!PageLRU(hpage) && !PageHuge(p))
> -=09=09return 0;
> -
> -=09/*
> -=09 * do a racy check to make sure PG_hwpoison will only be set for
> -=09 * the targeted owner (or on a free page).
> -=09 * memory_failure() will redo the check reliably inside page lock.
> -=09 */
> -=09err =3D hwpoison_filter(hpage);
> -=09if (err)
> -=09=09return 0;
> -
> -inject:
>   =09pr_info("Injecting memory failure at pfn %#lx\n", pfn);
>   =09return memory_failure(pfn, 0);
>   }
>  =20

I explored somewhere already why this code was added:


commit 31d3d3484f9bd263925ecaa341500ac2df3a5d9b
Author: Wu Fengguang <fengguang.wu@intel.com>
Date:   Wed Dec 16 12:19:59 2009 +0100

    HWPOISON: limit hwpoison injector to known page types
   =20
    __memory_failure()'s workflow is
   =20
            set PG_hwpoison
            //...
            unset PG_hwpoison if didn't pass hwpoison filter
   =20
    That could kill unrelated process if it happens to page fault on the
    page with the (temporary) PG_hwpoison. The race should be big enough to
    appear in stress tests.
   =20
    Fix it by grabbing the page and checking filter at inject time.  This
    also avoids the very noisy "Injecting memory failure..." messages.
   =20
    - we don't touch madvise() based injection, because the filters are
      generally not necessary for it.
    - if we want to apply the filters to h/w aided injection, we'd better t=
o
      rearrange the logic in __memory_failure() instead of this patch.
   =20
    AK: fix documentation, use drain all, cleanups


You should justify why it is okay to do rip that code out now.
It's not just duplicate checks.

Was the documented race fixed?
Will we fix the race within memory_failure() later?
Don't we care?

Also, you should add that this fixes the access of uninitialized memmaps
now and makes the interface work correctly with devmem.

--=20

Thanks,

David / dhildenb


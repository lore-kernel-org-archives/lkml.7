Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9264AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674A72067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZolmePyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKLTzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 14:55:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29146 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726376AbfKLTzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573588551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G8pVHb78xVK5U18TfjrGEyD9m0xKuu8EIWaDiAwkGmM=;
        b=ZolmePySm/WV397J9MoQ37R5icrJu55/EMjZpzq6ORBZ86vYIeww7v0r0qff2eAc1s3dfc
        TNEylGRguwN6+QEfGcoRnaBe4vsklktTUVQ0YtFb1SbeDqJuf4mkR+YNyqor/hA/Z4CkZ5
        XKsDtcxzw/U5u5ID7WOdyiIL4BkhheE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-fGiM2z01NMe5_WLNumIpVQ-1; Tue, 12 Nov 2019 14:55:50 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23AC1DBF7;
        Tue, 12 Nov 2019 19:55:49 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.225])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A88166018B;
        Tue, 12 Nov 2019 19:55:48 +0000 (UTC)
Date:   Tue, 12 Nov 2019 14:55:47 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/debug: __dump_page() prints an extra line
Message-ID: <20191112195547.GC31272@redhat.com>
References: <20191112012608.16926-1-rcampbell@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20191112012608.16926-1-rcampbell@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: fGiM2z01NMe5_WLNumIpVQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 05:26:08PM -0800, Ralph Campbell wrote:
> When dumping struct page information, __dump_page() prints the page type
> with a trailing blank followed by the page flags on a separate line:
>=20
> anon
> flags: 0x100000000090034(uptodate|lru|active|head|swapbacked)
>=20
> It looks like the intent was to use pr_cont() for printing "flags:"
> but pr_cont() usage is discouraged so fix this by extending the format
> to include the flags into a single line:
>=20
> anon flags: 0x100000000090034(uptodate|lru|active|head|swapbacked)
>=20
> If the page is file backed, the name might be long so use two lines:
>=20
> shmem_aops name:"dev/zero"
> flags: 0x10000000008000c(uptodate|dirty|swapbacked)
>=20
> Eliminate pr_conf() usage as well for appending compound_mapcount.
>=20
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>

Would be nice to have a changed since v1 v2 ... i was reading my
inbox in order and i saw Andrew reply after seeing the v2 ... so
where we at here ?

> ---
>  mm/debug.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>=20
> diff --git a/mm/debug.c b/mm/debug.c
> index 8345bb6e4769..772d4cf0691f 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -67,28 +67,31 @@ void __dump_page(struct page *page, const char *reaso=
n)
>  =09 */
>  =09mapcount =3D PageSlab(page) ? 0 : page_mapcount(page);
> =20
> -=09pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx",
> -=09=09  page, page_ref_count(page), mapcount,
> -=09=09  page->mapping, page_to_pgoff(page));
>  =09if (PageCompound(page))
> -=09=09pr_cont(" compound_mapcount: %d", compound_mapcount(page));
> -=09pr_cont("\n");
> +=09=09pr_warn("page:%px refcount:%d mapcount:%d mapping:%px "
> +=09=09=09"index:%#lx compound_mapcount: %d\n",
> +=09=09=09page, page_ref_count(page), mapcount,
> +=09=09=09page->mapping, page_to_pgoff(page),
> +=09=09=09compound_mapcount(page));
> +=09else
> +=09=09pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx\n=
",
> +=09=09=09page, page_ref_count(page), mapcount,
> +=09=09=09page->mapping, page_to_pgoff(page));
>  =09if (PageAnon(page))
> -=09=09pr_warn("anon ");
> +=09=09pr_warn("anon flags: %#lx(%pGp)\n", page->flags, &page->flags);
>  =09else if (PageKsm(page))
> -=09=09pr_warn("ksm ");
> +=09=09pr_warn("ksm flags: %#lx(%pGp)\n", page->flags, &page->flags);
>  =09else if (mapping) {
> -=09=09pr_warn("%ps ", mapping->a_ops);
>  =09=09if (mapping->host && mapping->host->i_dentry.first) {
>  =09=09=09struct dentry *dentry;
>  =09=09=09dentry =3D container_of(mapping->host->i_dentry.first, struct d=
entry, d_u.d_alias);
> -=09=09=09pr_warn("name:\"%pd\" ", dentry);
> -=09=09}
> +=09=09=09pr_warn("%ps name:\"%pd\"\n", mapping->a_ops, dentry);
> +=09=09} else
> +=09=09=09pr_warn("%ps\n", mapping->a_ops);
> +=09=09pr_warn("flags: %#lx(%pGp)\n", page->flags, &page->flags);
>  =09}
>  =09BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) !=3D __NR_PAGEFLAGS + 1);
> =20
> -=09pr_warn("flags: %#lx(%pGp)\n", page->flags, &page->flags);
> -
>  hex_only:
>  =09print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
>  =09=09=09sizeof(unsigned long), page,
> --=20
> 2.20.1
>=20
>=20


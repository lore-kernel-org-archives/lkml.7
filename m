Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D145C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DE82067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVOh6/f4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfKLTwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 14:52:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51328 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726376AbfKLTwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573588364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pqt6+3OL+HVkzSWOLZR1gcCq624ledyYdP7VW17VDYM=;
        b=BVOh6/f4uwD7SVTmkUiYsEfwSbIuyrMXkigLynVHilNjnVtzDsS1vNMP5fzCdqzqimLLat
        UmmKg8NoO5QjCDSB+fOnBjjJTYc6DG9i91wJUr6690lnALFgQYDImfoZaDal8NMLXhG2iP
        2VVI6LlqytTHnkO5OYdoas030rYBoqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-PNiFmytUMkmrHVWbu61NpA-1; Tue, 12 Nov 2019 14:52:42 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B6BF805C3D;
        Tue, 12 Nov 2019 19:52:39 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.225])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E7A338C5;
        Tue, 12 Nov 2019 19:52:38 +0000 (UTC)
Date:   Tue, 12 Nov 2019 14:52:36 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/debug: __dump_page() prints an extra line
Message-ID: <20191112195236.GB31272@redhat.com>
References: <20191111225559.19657-1-rcampbell@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20191111225559.19657-1-rcampbell@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: PNiFmytUMkmrHVWbu61NpA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 02:55:59PM -0800, Ralph Campbell wrote:
> When dumping struct page information, __dump_page() prints the page type
> with a trailing blank followed by the page flags on a separate line:
>=20
> anon
> flags: 0x100000000090034(uptodate|lru|active|head|swapbacked)
>=20
> Fix this by using pr_cont() instead of pr_warn() to get a single line:
>=20
> anon flags: 0x100000000090034(uptodate|lru|active|head|swapbacked)
>=20
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>

Reviewed-by: J=E9r=F4me Glisse <jglisse@redhat.com>

> ---
>=20
> v1 -> v2:
> Oops, fix the subject line.
>=20
>  mm/debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/mm/debug.c b/mm/debug.c
> index 8345bb6e4769..752c78721ea0 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -87,7 +87,7 @@ void __dump_page(struct page *page, const char *reason)
>  =09}
>  =09BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) !=3D __NR_PAGEFLAGS + 1);
> =20
> -=09pr_warn("flags: %#lx(%pGp)\n", page->flags, &page->flags);
> +=09pr_cont("flags: %#lx(%pGp)\n", page->flags, &page->flags);
> =20
>  hex_only:
>  =09print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
> --=20
> 2.20.1
>=20
>=20


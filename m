Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24581CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9407205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8an5jEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfJ3Pdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:33:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59627 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726255AbfJ3Pdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572449611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jPxLc22m28c+kEUKzIvK5d4SLQMacaKmaA/P7n/BVkA=;
        b=G8an5jEjRdDfAPc2WL7fmf7UNvMfm9f9NeR/sV00rkgEjNaAFonuOeq0Zf/St2ufauUyTt
        FTK0z5XJKQsiFqd9YGHu/2HQOfGzC+iNqgJOXaXCLVOTCMBPpPg2eaRcAKf5eHUcY0wQes
        Byf0do7l1uUENE6DfGyoOLXrmuGulbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-k9J2UT_uPduup4A7VGRLgg-1; Wed, 30 Oct 2019 11:33:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5ACB92F2A;
        Wed, 30 Oct 2019 15:33:27 +0000 (UTC)
Received: from [10.36.116.178] (ovpn-116-178.ams2.redhat.com [10.36.116.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC2ED60BE0;
        Wed, 30 Oct 2019 15:33:25 +0000 (UTC)
Subject: Re: [PATCH v2] mm/sparse.c: mark populate_section_memmap as __meminit
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>
References: <20191030151639.41486-1-iii@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <26d03485-054e-40cc-2a04-151f9d96fdae@redhat.com>
Date:   Wed, 30 Oct 2019 16:33:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191030151639.41486-1-iii@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: k9J2UT_uPduup4A7VGRLgg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.10.19 16:16, Ilya Leoshkevich wrote:
> Building the kernel on s390 with -Og produces the following warning:
>=20
> WARNING: vmlinux.o(.text+0x28dabe): Section mismatch in reference from th=
e function populate_section_memmap() to the function .meminit.text:__popula=
te_section_memmap()
> The function populate_section_memmap() references
> the function __meminit __populate_section_memmap().
> This is often because populate_section_memmap lacks a __meminit
> annotation or the annotation of __populate_section_memmap is wrong.
>=20
> While -Og is not supported, in theory this might still happen with
> another compiler or on another architecture. So fix this by using the
> correct section annotations.
>=20
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>=20
> v1 -> v2: Do not touch mm/sparse.c version of __populate_section_memmap:
> its __init annotation is correct, since it is only called during init
> phase (by sparse_init_nid), and contains the call to another __init
> function. Spotted by kbuild test robot <lkp@intel.com> and Oscar
> Salvador <osalvador@suse.de>.
>=20
> I was notified that v1 has already been included into
> http://ozlabs.org/~akpm/mmots/broken-out. Since this is not a git
> repository, I've decided to send a v2 instead of the fix. Please let me
> know if I should send a fix instead.

That's fine, Andrew will simply replace the patch.

Acked-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb


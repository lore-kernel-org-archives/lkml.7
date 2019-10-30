Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1F2CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F08220856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VAIFwHjD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfJ3Pi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:38:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36651 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726175AbfJ3Pi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572449936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GKUfBqzsWbWpLwq+4AXt80BF3zMIN95jw0nzaAUS1Zs=;
        b=VAIFwHjD4RIaev3zP5Lmmn7I6SxpmvEwFJQmLqgG3Sk+wYeqVc9FyNjtd319D9M6j1pdyz
        GwM1SQbwhQEC4q5Gn2elgqGT63Jx94kTSaL6A+krgRQlEmjsWfy0hPU2HiIfmO86cahBhi
        n4LYQ3h8z0hrvnKEtsDip4mtfi8f3lE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-WZwI5j86PF64TD9j1RtGEg-1; Wed, 30 Oct 2019 11:38:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43BD3107ACC0;
        Wed, 30 Oct 2019 15:38:51 +0000 (UTC)
Received: from [10.36.116.178] (ovpn-116-178.ams2.redhat.com [10.36.116.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C78419488;
        Wed, 30 Oct 2019 15:38:50 +0000 (UTC)
Subject: Re: [PATCH v3] mm: gup: fix comments of __get_user_pages() and
 get_user_pages_remote()
To:     Liu Xiang <liuxiang_1999@126.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, jhubbard@nvidia.com
References: <1572443533-3118-1-git-send-email-liuxiang_1999@126.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <e15d7687-d975-7f9d-f029-d952cdfc969d@redhat.com>
Date:   Wed, 30 Oct 2019 16:38:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1572443533-3118-1-git-send-email-liuxiang_1999@126.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: WZwI5j86PF64TD9j1RtGEg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.10.19 14:52, Liu Xiang wrote:
> Fix comments of __get_user_pages() and get_user_pages_remote(),
> make them more clear.
>=20
> Suggested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Liu Xiang <liuxiang_1999@126.com>
>=20
> ---
>=20
> Changes in v3:
>   as suggested by John, apply the same fix to get_user_pages_remote().
> ---
>   mm/gup.c | 32 ++++++++++++++++++++++----------
>   1 file changed, 22 insertions(+), 10 deletions(-)
>=20
> diff --git a/mm/gup.c b/mm/gup.c
> index 8f236a3..c36c621 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -734,11 +734,17 @@ static int check_vma_flags(struct vm_area_struct *v=
ma, unsigned long gup_flags)
>    *=09=09Or NULL if the caller does not require them.
>    * @nonblocking: whether waiting for disk IO or mmap_sem contention
>    *
> - * Returns number of pages pinned. This may be fewer than the number
> - * requested. If nr_pages is 0 or negative, returns 0. If no pages
> - * were pinned, returns -errno. Each page returned must be released
> - * with a put_page() call when it is finished with. vmas will only
> - * remain valid while mmap_sem is held.
> + * Returns either number of pages pinned (which may be less than the
> + * number requested), or an error. Details about the return value:
> + *
> + * -- If nr_pages is 0, returns 0.
> + * -- If nr_pages is >0, but no pages were pinned, returns -errno.
> + * -- If nr_pages is >0, and some pages were pinned, returns the number =
of
> + *    pages pinned. Again, this may be less than nr_pages.
> + *
> + * The caller is responsible for releasing returned @pages, via put_page=
().
> + *
> + * @vmas are valid only as long as mmap_sem is held.
>    *
>    * Must be called with mmap_sem held.  It may be released.  See below.
>    *
> @@ -1107,11 +1113,17 @@ static __always_inline long __get_user_pages_lock=
ed(struct task_struct *tsk,
>    *=09=09subsequently whether VM_FAULT_RETRY functionality can be
>    *=09=09utilised. Lock must initially be held.
>    *
> - * Returns number of pages pinned. This may be fewer than the number
> - * requested. If nr_pages is 0 or negative, returns 0. If no pages
> - * were pinned, returns -errno. Each page returned must be released
> - * with a put_page() call when it is finished with. vmas will only
> - * remain valid while mmap_sem is held.
> + * Returns either number of pages pinned (which may be less than the
> + * number requested), or an error. Details about the return value:
> + *
> + * -- If nr_pages is 0, returns 0.
> + * -- If nr_pages is >0, but no pages were pinned, returns -errno.
> + * -- If nr_pages is >0, and some pages were pinned, returns the number =
of
> + *    pages pinned. Again, this may be less than nr_pages.
> + *
> + * The caller is responsible for releasing returned @pages, via put_page=
().
> + *
> + * @vmas are valid only as long as mmap_sem is held.
>    *
>    * Must be called with mmap_sem held for read or write.
>    *
>=20

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb


Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE193C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81FD20836
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGX/N+4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLIRs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:48:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43475 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726509AbfLIRsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575913731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lt4hpqX7ZVZhkeNrxUdXUCr9dF2T52+7cfTs1UM8LG0=;
        b=WGX/N+4n8AGH6z+HJ3Z9lJFTBviXiE8dpGYDU5/cp2LCJyalzpTKQFk7khfJAHlxkMloG+
        Ub4CJeKSOJCcwM0PXhKvGPVwgh67AENExJ6BpefrcemTRZlab28GJmtWZWZHveX/eEKSVe
        ipn3gUhZOEJDIUnSyZQxtG5hfZdtC94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-WurNm-wkPmmW_qXyqjEgnA-1; Mon, 09 Dec 2019 12:48:49 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08BAB107ACC9;
        Mon,  9 Dec 2019 17:48:48 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-214.ams2.redhat.com [10.36.116.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD7121001B03;
        Mon,  9 Dec 2019 17:48:45 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 2/3] fs/proc/page.c: allow inspection of last section and fix end detection
Date:   Mon,  9 Dec 2019 18:48:35 +0100
Message-Id: <20191209174836.11063-3-david@redhat.com>
In-Reply-To: <20191209174836.11063-1-david@redhat.com>
References: <20191209174836.11063-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: WurNm-wkPmmW_qXyqjEgnA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If max_pfn does not fall onto a section boundary, it is possible to inspect
PFNs up to max_pfn, and PFNs above max_pfn, however, max_pfn itself can't
be inspected. We can have a valid (and online) memmap at and above max_pfn
if max_pfn is not aligned to a section boundary. The whole early section
has a memmap and is marked online. Being able to inspect the state of these
PFNs is valuable for debugging, especially because max_pfn can change on
memory hotplug and expose these memmaps.

Also, querying page flags via "./page-types -r -a 0x144001,"
(tools/vm/page-types.c) inside a x86-64 guest with 4160MB under QEMU
results in an (almost) endless loop in user space, because the end is
not detected properly when starting after max_pfn.

Instead, let's allow to inspect all pages in the highest section and
return 0 directly if we try to access pages above that section.

While at it, check the count before adjusting it, to avoid masking user
errors.

Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/page.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index e40dbfe1168e..da01d3d9999a 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -29,6 +29,7 @@
 static ssize_t kpagecount_read(struct file *file, char __user *buf,
 =09=09=09     size_t count, loff_t *ppos)
 {
+=09const unsigned long max_dump_pfn =3D round_up(max_pfn, PAGES_PER_SECTIO=
N);
 =09u64 __user *out =3D (u64 __user *)buf;
 =09struct page *ppage;
 =09unsigned long src =3D *ppos;
@@ -37,9 +38,11 @@ static ssize_t kpagecount_read(struct file *file, char _=
_user *buf,
 =09u64 pcount;
=20
 =09pfn =3D src / KPMSIZE;
-=09count =3D min_t(size_t, count, (max_pfn * KPMSIZE) - src);
 =09if (src & KPMMASK || count & KPMMASK)
 =09=09return -EINVAL;
+=09if (src >=3D max_dump_pfn * KPMSIZE)
+=09=09return 0;
+=09count =3D min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
=20
 =09while (count > 0) {
 =09=09/*
@@ -208,6 +211,7 @@ u64 stable_page_flags(struct page *page)
 static ssize_t kpageflags_read(struct file *file, char __user *buf,
 =09=09=09     size_t count, loff_t *ppos)
 {
+=09const unsigned long max_dump_pfn =3D round_up(max_pfn, PAGES_PER_SECTIO=
N);
 =09u64 __user *out =3D (u64 __user *)buf;
 =09struct page *ppage;
 =09unsigned long src =3D *ppos;
@@ -215,9 +219,11 @@ static ssize_t kpageflags_read(struct file *file, char=
 __user *buf,
 =09ssize_t ret =3D 0;
=20
 =09pfn =3D src / KPMSIZE;
-=09count =3D min_t(unsigned long, count, (max_pfn * KPMSIZE) - src);
 =09if (src & KPMMASK || count & KPMMASK)
 =09=09return -EINVAL;
+=09if (src >=3D max_dump_pfn * KPMSIZE)
+=09=09return 0;
+=09count =3D min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
=20
 =09while (count > 0) {
 =09=09/*
@@ -253,6 +259,7 @@ static const struct file_operations proc_kpageflags_ope=
rations =3D {
 static ssize_t kpagecgroup_read(struct file *file, char __user *buf,
 =09=09=09=09size_t count, loff_t *ppos)
 {
+=09const unsigned long max_dump_pfn =3D round_up(max_pfn, PAGES_PER_SECTIO=
N);
 =09u64 __user *out =3D (u64 __user *)buf;
 =09struct page *ppage;
 =09unsigned long src =3D *ppos;
@@ -261,9 +268,11 @@ static ssize_t kpagecgroup_read(struct file *file, cha=
r __user *buf,
 =09u64 ino;
=20
 =09pfn =3D src / KPMSIZE;
-=09count =3D min_t(unsigned long, count, (max_pfn * KPMSIZE) - src);
 =09if (src & KPMMASK || count & KPMMASK)
 =09=09return -EINVAL;
+=09if (src >=3D max_dump_pfn * KPMSIZE)
+=09=09return 0;
+=09count =3D min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
=20
 =09while (count > 0) {
 =09=09/*
--=20
2.21.0


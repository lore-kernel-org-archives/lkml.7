Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFDEC04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685CD20836
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0OaSziR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfLIRsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:48:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37875 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726598AbfLIRst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575913728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=JCwJwup/hRzgIhZKGZMuQ2SMWqtkRFnNSa3fE8jcXRM=;
        b=B0OaSziRfZnokdoLZxC2izfMAZiWCyla/F/ZcEigmXTg0/aqctEK8SQq9W5lpDzcGsF+YH
        ov5KGvpGV1AjSpCbfvOVzySMOuv7mao0tHt2aEkv//xV5TPZgtvsASAN37c7hM9abXq2nr
        EwV7x45DSSdTI/YVMD3gEyOiHr+puq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-J6AlubJ8OhOXKJ4FOeNQtw-1; Mon, 09 Dec 2019 12:48:44 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B114D1005513;
        Mon,  9 Dec 2019 17:48:42 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-214.ams2.redhat.com [10.36.116.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2062F1001B03;
        Mon,  9 Dec 2019 17:48:36 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bob Picco <bob.picco@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Sistare <steven.sistare@oracle.com>
Subject: [PATCH v1 0/3] mm: fix max_pfn not falling on section boundary
Date:   Mon,  9 Dec 2019 18:48:33 +0100
Message-Id: <20191209174836.11063-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: J6AlubJ8OhOXKJ4FOeNQtw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Playing with different memory sizes for a x86-64 guest, I discovered that
some memmaps (highest section if max_mem does not fall on the section
boundary) are marked as being valid and online, but contain garbage. We
have to properly initialize these memmaps.

Looking at /proc/kpageflags and friends, I found some more issues,
partially related to this.

David Hildenbrand (3):
  mm: fix uninitialized memmaps on a partially populated last section
  fs/proc/page.c: allow inspection of last section and fix end detection
  mm: initialize memmap of unavailable memory directly

 fs/proc/page.c     | 15 ++++++++++++---
 include/linux/mm.h |  6 ------
 mm/page_alloc.c    | 43 ++++++++++++++++++++++++++++++++-----------
 3 files changed, 44 insertions(+), 20 deletions(-)

--=20
2.21.0


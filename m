Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B03FC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704DA20726
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hhYnPCAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfLJIo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:44:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49406 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726750AbfLJIo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575967465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=85iuBCTeUInaX84Dg3t6InbKz06LRvBV1i1vwBmGbVM=;
        b=hhYnPCAGLTr8DMa2DXs0f6rdYdtmlwaGe0qfBoDpaFMGB/E2sfS6L1+gM7JvZJlecuM/iv
        pHUF+vaWaEGGUeEnyLSGTU9k9KTunJzaASvRqMTFbA33E9+y1Tb1ehmvEXrXbhrUJ/M5Qq
        n39OSxZiqbIF/2X4UoMbBmkB6yeze6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-kGjaGIe6MWKsbAXT11_fOw-1; Tue, 10 Dec 2019 03:44:22 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88E9A189DF5E;
        Tue, 10 Dec 2019 08:44:20 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-38.pek2.redhat.com [10.72.12.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FD0360BF3;
        Tue, 10 Dec 2019 08:44:14 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, mhocko@kernel.org, david@redhat.com,
        jgross@suse.com, akpm@linux-foundation.org, bhe@redhat.com
Subject: [Patch v2] mm/hotplug: Only respect mem= parameter during boot stage
Date:   Tue, 10 Dec 2019 16:44:13 +0800
Message-Id: <20191210084413.21957-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: kGjaGIe6MWKsbAXT11_fOw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 357b4da50a62 ("x86: respect memory size limiting via mem=3D
parameter") a global varialbe global max_mem_size is added to store
the value parsed from 'mem=3D ', then checked when memory region is
added. This truly stops those DIMM from being added into system memory
during boot-time.

However, it also limits the later memory hotplug functionality. Any
memory board can't be hot added any more if its region is beyond the
max_mem_size. System will print error like below:

[  216.387164] acpi PNP0C80:02: add_memory failed
[  216.389301] acpi PNP0C80:02: acpi_memory_enable_device() error
[  216.392187] acpi PNP0C80:02: Enumeration failure

From document of 'mem=3D ' parameter, it should be a restriction during
boot, but not impact the system memory adding/removing after booting.

  mem=3Dnn[KMG]     [KNL,BOOT] Force usage of a specific amount of memory
=09          ...

So fix it by also checking if it's during boot-time when restrict memory
adding. Otherwise, skip the restriction.

Fixes: 357b4da50a62 ("x86: respect memory size limiting via mem=3D paramete=
r")
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/memory_hotplug.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 55ac23ef11c1..989707295d15 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -105,7 +105,11 @@ static struct resource *register_memory_resource(u64 s=
tart, u64 size)
 =09unsigned long flags =3D  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 =09char *resource_name =3D "System RAM";
=20
-=09if (start + size > max_mem_size)
+=09/*
+=09 * Make sure value parsed from 'mem=3D' only restricts memory adding
+=09 * during boot-time, so that memory hotplug won't be impacted.
+=09 */
+=09if (start + size > max_mem_size && system_state < SYSTEM_RUNNING)
 =09=09return ERR_PTR(-E2BIG);
=20
 =09/*
--=20
2.17.2


Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C126C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7105224670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmH923cU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfLFPFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:05:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32685 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726271AbfLFPFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 10:05:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575644730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IT26lu0TFPeiz/SrRtHKqKnORA0j1r2gxVlANM2MQ98=;
        b=bmH923cU7N3VTxpg+M+ADhwS4h9gw6zj8EsFDaN1RCACS3IwUNfbUTNJtwICJlq6Mti92B
        nk7d6i8r6meBaTXDkEnm74UkkeuHYzG4/a0Gaf/lKMvUBzAlHSOpKs/c5J0edXwmSM02bn
        hQPQfIIpIw5SUGtCavDAEcQHZ3gt9uI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-3D439F-xND6WdlDV68c1NA-1; Fri, 06 Dec 2019 10:05:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0F32800D41;
        Fri,  6 Dec 2019 15:05:27 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-49.pek2.redhat.com [10.72.12.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4F9B5D6C3;
        Fri,  6 Dec 2019 15:05:25 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, jgross@suse.com, william.kucharski@oracle.com,
        mingo@kernel.org, akpm@linux-foundation.org
Subject: [PATCH] mm/hotplug: Only respect mem= parameter during boot stage
Date:   Fri,  6 Dec 2019 23:05:24 +0800
Message-Id: <20191206150524.14687-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 3D439F-xND6WdlDV68c1NA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 357b4da50a62 ("x86: respect memory size limiting via mem=3D
parameter") a global varialbe global max_mem_size is added to store
the value which is parsed from 'mem=3D '. This truly stops those
DIMM from being added into system memory during boot.

However, it also limits the later memory hotplug functionality. Any
memory board can't be hot added any more if its region is beyond the
max_mem_size. System will print error like below:

[  216.387164] acpi PNP0C80:02: add_memory failed
[  216.389301] acpi PNP0C80:02: acpi_memory_enable_device() error
[  216.392187] acpi PNP0C80:02: Enumeration failure

From document of 'mem =3D' parameter, it should be a restriction during
boot, but not impact the system memory adding/removing after booting.

  mem=3Dnn[KMG]     [KNL,BOOT] Force usage of a specific amount of memory

So fix it by also checking if it's during SYSTEM_BOOTING stage when
restrict memory adding. Otherwise, skip the restriction.

Fixes: 357b4da50a62 ("x86: respect memory size limiting via mem=3D paramete=
r")
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 55ac23ef11c1..5466a0a00901 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -105,7 +105,7 @@ static struct resource *register_memory_resource(u64 st=
art, u64 size)
 =09unsigned long flags =3D  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 =09char *resource_name =3D "System RAM";
=20
-=09if (start + size > max_mem_size)
+=09if (start + size > max_mem_size && system_state =3D=3D SYSTEM_BOOTING)
 =09=09return ERR_PTR(-E2BIG);
=20
 =09/*
--=20
2.17.2


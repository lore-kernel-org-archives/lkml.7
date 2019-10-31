Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78943CA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472CE208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ggg2utQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfJaO37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 10:29:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22585 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726741AbfJaO36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572532197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Jild0panmnMryQc3FHdcjwiw1vzd9T+vQ34c5Kbm58=;
        b=Ggg2utQCFgia+P9tlU4INvmVqY0zvgkr/18clPx7EMm/BtAZDgeuYMm91xR3oZ4+Qx7ovf
        a8pjLpOryn6ScLOGYQwClRTGOUsrRIb5XNxldMsfNUGJN2JaNTAacEUFjVLN4XQAfsuud1
        vA05Kgfa6rzwiDOfgvkWOAU62WS0zVI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-9Cg2CvBGO2-gP-TXfq3tzQ-1; Thu, 31 Oct 2019 10:29:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F1F52EDC;
        Thu, 31 Oct 2019 14:29:51 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BB4E63BA9;
        Thu, 31 Oct 2019 14:29:48 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Richard Fontana <rfontana@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arun KS <arunks@codeaurora.org>
Subject: [PATCH v1 02/12] powerpc/pseries: CMM: Report errors when registering notifiers fails
Date:   Thu, 31 Oct 2019 15:29:23 +0100
Message-Id: <20191031142933.10779-3-david@redhat.com>
In-Reply-To: <20191031142933.10779-1-david@redhat.com>
References: <20191031142933.10779-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 9Cg2CvBGO2-gP-TXfq3tzQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we don't set the rc, we will return "0", making it look like we
succeeded.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Richard Fontana <rfontana@redhat.com>
Cc: Allison Randal <allison@lohutok.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arun KS <arunks@codeaurora.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/pseries/cmm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/=
pseries/cmm.c
index 572651a5c87b..fab049d3ea1e 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -683,8 +683,12 @@ static int cmm_init(void)
 =09if ((rc =3D cmm_sysfs_register(&cmm_dev)))
 =09=09goto out_reboot_notifier;
=20
-=09if (register_memory_notifier(&cmm_mem_nb) ||
-=09    register_memory_isolate_notifier(&cmm_mem_isolate_nb))
+=09rc =3D register_memory_notifier(&cmm_mem_nb);
+=09if (rc)
+=09=09goto out_unregister_notifier;
+
+=09rc =3D register_memory_isolate_notifier(&cmm_mem_isolate_nb);
+=09if (rc)
 =09=09goto out_unregister_notifier;
=20
 =09if (cmm_disabled)
--=20
2.21.0


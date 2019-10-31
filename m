Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC41CA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7542087E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8lY82o1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfJaOaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 10:30:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32319 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728119AbfJaOaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572532204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4i7pNEIUUv2S8Imj7zfc/fRy/faa7AuLPBE4V4ZWydE=;
        b=V8lY82o1CQ5BBXNpNBR2iBWY38gOPQhV1Bw+OITecPkcmA1JtouND4j+hpYk0i75SebhHd
        91gxRXDNxERKQMWl0RtClxkQDJexowgVzcAMlfZN40gNa5Xc/JvE//08RP2VDWjvvkMFIT
        Mj3qFt3Uyd0GXcBU4wuV2GpiMtBiApo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-o8F6F3GpNKqm7j3HbswcDg-1; Thu, 31 Oct 2019 10:29:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2204A1800D55;
        Thu, 31 Oct 2019 14:29:56 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C12C5D6D6;
        Thu, 31 Oct 2019 14:29:51 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Arun KS <arunks@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v1 03/12] powerpc/pseries: CMM: Cleanup rc handling in cmm_init()
Date:   Thu, 31 Oct 2019 15:29:24 +0100
Message-Id: <20191031142933.10779-4-david@redhat.com>
In-Reply-To: <20191031142933.10779-1-david@redhat.com>
References: <20191031142933.10779-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: o8F6F3GpNKqm7j3HbswcDg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to initialize rc. Also, let's return 0 directly when succeeding.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arun KS <arunks@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/pseries/cmm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/=
pseries/cmm.c
index fab049d3ea1e..738eb1681d40 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -669,7 +669,7 @@ static struct notifier_block cmm_mem_nb =3D {
  **/
 static int cmm_init(void)
 {
-=09int rc =3D -ENOMEM;
+=09int rc;
=20
 =09if (!firmware_has_feature(FW_FEATURE_CMO))
 =09=09return -EOPNOTSUPP;
@@ -692,7 +692,7 @@ static int cmm_init(void)
 =09=09goto out_unregister_notifier;
=20
 =09if (cmm_disabled)
-=09=09return rc;
+=09=09return 0;
=20
 =09cmm_thread_ptr =3D kthread_run(cmm_thread, NULL, "cmmthread");
 =09if (IS_ERR(cmm_thread_ptr)) {
@@ -700,8 +700,7 @@ static int cmm_init(void)
 =09=09goto out_unregister_notifier;
 =09}
=20
-=09return rc;
-
+=09return 0;
 out_unregister_notifier:
 =09unregister_memory_notifier(&cmm_mem_nb);
 =09unregister_memory_isolate_notifier(&cmm_mem_isolate_nb);
--=20
2.21.0


Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61763C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A62221556
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hK/r0/td"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbfLLUxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 15:53:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27055 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730878AbfLLUxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 15:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576183996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jFsMCkTPVgR+W1Kd3Lf7aWur2abNjkkDZbU5lmEOBvY=;
        b=hK/r0/tdUfUddrypg8CTRgyQQsrs3YRpe8+jY2rzNAv8seUe133HnAINpm6M2BLw4kVEcW
        ffiuO9SV+Z35WQbTpPNMddJa9XY6PXkxR+ykOrxIbYgLRjbMPP/ScT6E7wmEg0FvGCQFx+
        NU7O2+r1NJ9elj20oPGY+JET/Py0E3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-8Vj4gIgUMM2OAurVbZEBGA-1; Thu, 12 Dec 2019 15:53:11 -0500
X-MC-Unique: 8Vj4gIgUMM2OAurVbZEBGA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0B8F100726D;
        Thu, 12 Dec 2019 20:53:06 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7223B60BB1;
        Thu, 12 Dec 2019 20:53:05 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH resend] s390/purgatory: Make sure we fail the build if purgatory has missing symbols
Date:   Thu, 12 Dec 2019 21:53:04 +0100
Message-Id: <20191212205304.191610-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we link purgatory with -r aka we enable "incremental linking"
no checks for unresolved symbols are done while linking the purgatory.

This commit adds an extra check for unresolved symbols by calling ld
without -r before running objcopy to generate purgatory.ro.

This will help us catch missing symbols in the purgatory sooner.

Note this commit also removes --no-undefined from LDFLAGS_purgatory
as that has no effect.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Using 2 if_changed lines under a single rule does not work, then
  1 of the 2 will always execute each build.
  Instead add a new (unused) purgatory.chk intermediate which gets
  linked from purgatory.ro without -r to do the missing symbols check
- This also fixes the check generating an a.out file (oops)
---
 arch/s390/purgatory/.gitignore |  1 +
 arch/s390/purgatory/Makefile   | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/s390/purgatory/.gitignore b/arch/s390/purgatory/.gitign=
ore
index 04a03433c720..c82157f46b18 100644
--- a/arch/s390/purgatory/.gitignore
+++ b/arch/s390/purgatory/.gitignore
@@ -1,3 +1,4 @@
 purgatory
+purgatory.chk
 purgatory.lds
 purgatory.ro
diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index bc0d7a0d0394..13e9a5dc0a07 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -4,7 +4,7 @@ OBJECT_FILES_NON_STANDARD :=3D y
=20
 purgatory-y :=3D head.o purgatory.o string.o sha256.o mem.o
=20
-targets +=3D $(purgatory-y) purgatory.lds purgatory purgatory.ro
+targets +=3D $(purgatory-y) purgatory.lds purgatory purgatory.chk purgat=
ory.ro
 PURGATORY_OBJS =3D $(addprefix $(obj)/,$(purgatory-y))
=20
 $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
@@ -26,15 +26,22 @@ KBUILD_CFLAGS +=3D $(CLANG_FLAGS)
 KBUILD_CFLAGS +=3D $(call cc-option,-fno-PIE)
 KBUILD_AFLAGS :=3D $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
=20
-LDFLAGS_purgatory :=3D -r --no-undefined -nostdlib -z nodefaultlib -T
+# Since we link purgatory with -r unresolved symbols are not checked, so=
 we
+# also link a purgatory.chk binary without -r to check for unresolved sy=
mbols.
+PURGATORY_LDFLAGS :=3D -nostdlib -z nodefaultlib
+LDFLAGS_purgatory :=3D -r $(PURGATORY_LDFLAGS) -T
+LDFLAGS_purgatory.chk :=3D -e purgatory_start $(PURGATORY_LDFLAGS)
 $(obj)/purgatory: $(obj)/purgatory.lds $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)
=20
+$(obj)/purgatory.chk: $(obj)/purgatory FORCE
+		$(call if_changed,ld)
+
 OBJCOPYFLAGS_purgatory.ro :=3D -O elf64-s390
 OBJCOPYFLAGS_purgatory.ro +=3D --remove-section=3D'*debug*'
 OBJCOPYFLAGS_purgatory.ro +=3D --remove-section=3D'.comment'
 OBJCOPYFLAGS_purgatory.ro +=3D --remove-section=3D'.note.*'
-$(obj)/purgatory.ro: $(obj)/purgatory FORCE
+$(obj)/purgatory.ro: $(obj)/purgatory $(obj)/purgatory.chk FORCE
 		$(call if_changed,objcopy)
=20
 $(obj)/kexec-purgatory.o: $(obj)/kexec-purgatory.S $(obj)/purgatory.ro F=
ORCE
--=20
2.23.0


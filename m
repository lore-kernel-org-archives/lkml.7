Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E3EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 03:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD53922317
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 03:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5Lrey3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfKSDBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 22:01:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32990 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727014AbfKSDBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 22:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574132481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HjCpt2Gr6HzKLw7N1LqL9S4fcdyI/ZI8pHUTAOux55Y=;
        b=O5Lrey3yLKspW1i2pCdRHVvGDcH3MczyGDBFhJTW3CtcpNkz4Wa/e1hUKaP7LJjMj842O1
        6xykSyaL8+7dDYFkwEwlcp/na+WD2ZcT2WP+aziZh7RlAaCG80lvxeFfuFprFHIMlUVLHT
        dz4SoCe6I/yttC4LGZI+gY2Q5eAZAso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-iFMyBrpYOr-mmff9ajVmlw-1; Mon, 18 Nov 2019 22:01:19 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76273107ACCC;
        Tue, 19 Nov 2019 03:01:18 +0000 (UTC)
Received: from x230.com (ovpn-112-21.phx2.redhat.com [10.3.112.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7EB36610B0;
        Tue, 19 Nov 2019 03:01:17 +0000 (UTC)
From:   Rafael Aquini <aquini@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mm: kconfig: make Transparent Hugepage Support sysfs defaults to match the documentation
Date:   Mon, 18 Nov 2019 22:01:02 -0500
Message-Id: <20191119030102.27559-1-aquini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: iFMyBrpYOr-mmff9ajVmlw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/admin-guide/mm/transhuge.rst (originally in Documentation/vm/=
transhuge.txt)
states that TRANSPARENT_HUGEPAGE_MADVISE is the default option for THP conf=
ig:

"
madvise
        will enter direct reclaim like ``always`` but only for regions
        that are have used madvise(MADV_HUGEPAGE). This is the default
        behaviour.
"

This patch changes mm/Kconfig to reflect that fact, accordingly.
Besides keeping consistency between documentation and the code behavior,
other reasons to perform this minor adjustment are noted at:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1772133

Signed-off-by: Rafael Aquini <aquini@redhat.com>
---
 mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index a5dae9a7eb51..c12a559aa1e5 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -385,7 +385,7 @@ config TRANSPARENT_HUGEPAGE
 choice
 =09prompt "Transparent Hugepage Support sysfs defaults"
 =09depends on TRANSPARENT_HUGEPAGE
-=09default TRANSPARENT_HUGEPAGE_ALWAYS
+=09default TRANSPARENT_HUGEPAGE_MADVISE
 =09help
 =09  Selects the sysfs defaults for Transparent Hugepage Support.
=20
--=20
2.17.2


Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4777ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A9F206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CouozuWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbfJHMGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:06:44 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:28282 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730719AbfJHMGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:06:43 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x98C6135021176;
        Tue, 8 Oct 2019 21:06:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x98C6135021176
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570536363;
        bh=ky+LkOLJvLz7GQrqNxbqax/IF2ZqOBtCIPZVaij14hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CouozuWhUbGuiISjMHzx2mHgMpE1ijsXTbEu0z88EKiN2NIg+GP4wXu7zejtJufXU
         VdslYdQ6cSgR1rY5hOEVSwTz1Abl5LdojENGoCg79DJjhwL2ni9zz7SlTUYnNdTfql
         ZgO3f+ze824TMw60Msc3GXYj9czZVPev3B1BVTtvqagNORSkHIcsC2nQztuDbU5V2i
         H8rUguRBm7+6f03ywI9FNe2Z1/hNTj0D6aWHZ3PVdHefZ485eX+RPIYh0zveXJlz8L
         SpQwkuXA+wRtsDlrYXJcMuesotxo/q+jFphzS2+7D6eB/u0kMDclL6GSCtgNVcJAqO
         rFFbYC5xduR8w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] kheaders: optimize header copy for in-tree builds
Date:   Tue,  8 Oct 2019 21:05:54 +0900
Message-Id: <20191008120556.4263-3-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008120556.4263-1-yamada.masahiro@socionext.com>
References: <20191008120556.4263-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This script copies headers by the cpio command twice; first from
srctree, and then from objtree. However, when we building in-tree,
we know the srctree and the objtree are the same. That is, all the
headers copied by the first cpio are overwritten by the second one.

Skip the first cpio when we are building in-tree.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 kernel/gen_kheaders.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index 5f8e664977f8..dd40a1b86f96 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -56,14 +56,16 @@ fi
 rm -rf $cpio_dir
 mkdir $cpio_dir
 
-pushd $srctree > /dev/null
-for f in $dir_list;
-	do find "$f" -name "*.h";
-done | cpio --quiet -pd $cpio_dir
-popd > /dev/null
+if [ "$building_out_of_srctree" ]; then
+	pushd $srctree > /dev/null
+	for f in $dir_list
+		do find "$f" -name "*.h";
+	done | cpio --quiet -pd $cpio_dir
+	popd > /dev/null
+fi
 
-# The second CPIO can complain if files already exist which can
-# happen with out of tree builds. Just silence CPIO for now.
+# The second CPIO can complain if files already exist which can happen with out
+# of tree builds having stale headers in srctree. Just silence CPIO for now.
 for f in $dir_list;
 	do find "$f" -name "*.h";
 done | cpio --quiet -pd $cpio_dir >/dev/null 2>&1
-- 
2.17.1


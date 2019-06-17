Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20234C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 06:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E752C2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 06:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfFQGPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 02:15:49 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:34555 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfFQGPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 02:15:48 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=svr-ies-mbx-02.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hckvh-00071l-Df from Cedric_Hombourger@mentor.com ; Sun, 16 Jun 2019 23:15:45 -0700
Received: from FRG-W10-HOMBOUR.world.mentorg.com (137.202.0.90) by
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Mon, 17 Jun 2019 07:15:41 +0100
From:   Cedric Hombourger <Cedric_Hombourger@mentor.com>
CC:     <isar-users@googlegroups.com>,
        Cedric Hombourger <Cedric_Hombourger@mentor.com>,
        <yamada.masahiro@socionext.com>, <michal.lkml@markovi.net>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] builddeb: generate multi-arch friendly linux-libc-dev package
Date:   Mon, 17 Jun 2019 08:14:56 +0200
Message-ID: <1560752096-1323-1-git-send-email-Cedric_Hombourger@mentor.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debian-based distributions place libc header files in a machine
specific directory (/usr/include/<libc-machine>) instead of
/usr/include/asm to support installation of the linux-libc-dev
package from multiple architectures. Move headers installed by
"make headers_install" accordingly.

Signed-off-by: Cedric Hombourger <Cedric_Hombourger@mentor.com>
Reviewed-by: Henning Schild <henning.schild@siemens.com>
---
 scripts/package/builddeb | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index b03dd56a4782..8f7afb3a84e9 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -132,6 +132,11 @@ fi
 if [ "$ARCH" != "um" ]; then
 	$MAKE -f $srctree/Makefile headers_check
 	$MAKE -f $srctree/Makefile headers_install INSTALL_HDR_PATH="$libc_headers_dir/usr"
+	# move asm headers to /usr/include/<libc-machine>/asm to match the structure
+	# used by Debian-based distros (to support multi-arch)
+	libc_mach=$($CC -dumpmachine)
+	mkdir $libc_headers_dir/usr/include/$libc_mach
+	mv $libc_headers_dir/usr/include/asm $libc_headers_dir/usr/include/$libc_mach/
 fi
 
 # Install the maintainer scripts
-- 
2.11.0


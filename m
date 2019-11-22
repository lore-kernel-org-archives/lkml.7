Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BD6C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7872520409
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574404114;
	bh=x5uTloVlZUSZDG2pEyfA9m9Mh/alz08Ac7RdDVqdQwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hqhdsMfcbrAvo9tl94wxdaXHhAtgG5OfWOwzIjz8fWvyRN9S1v434jGt4DaE7VpZ5
	 P5/2JaVnHvhsfCLldeZCIQWOCxeQ01+CYMF5rh0xHjgtluGP9OnCF3r6kqPc+37Lzs
	 Z3/zB+mB1KzZ8zDQWFuQWxgwMVkZcdpQIaN6GzxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfKVG2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:28:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:54664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727544AbfKVFuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:50:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C00920855;
        Fri, 22 Nov 2019 05:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401812;
        bh=x5uTloVlZUSZDG2pEyfA9m9Mh/alz08Ac7RdDVqdQwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0nzabDHo49UGiyzZ/DPJMQGAq64uHqrxfE/02GfD7VkHKOYWvzNg/nid+KtsFCD3s
         al1GO1ACsCACmbJRuhQspFVHqICEZ/XCjx/aE3aWFAewHODHOerewg0hvPseuuNMhC
         yLiQnVoXM1REE+5/wdmtnaQfjMInVCpdfFL24cVU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 056/219] microblaze: adjust the help to the real behavior
Date:   Fri, 22 Nov 2019 00:46:28 -0500
Message-Id: <20191122054911.1750-49-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit bafcc61d998c1ca18f556d92a0e95335ac68c7da ]

"make ARCH=microblaze help" mentions simpleImage.<dt>.unstrip,
but it is not a real Make target. It does not work because Makefile
assumes "system.unstrip" is the name of DT.

$ make ARCH=microblaze CROSS_COMPILE=microblaze-linux- simpleImage.system.unstrip
  [ snip ]
make[1]: *** No rule to make target 'arch/microblaze/boot/dts/system.unstrip.dtb', needed by 'arch/microblaze/boot/dts/system.dtb'.  Stop.
make: *** [Makefile;1060: arch/microblaze/boot/dts] Error 2
make: *** Waiting for unfinished jobs....

simpleImage.<dt> works like a phony target that generates multiple
images. Reflect the real behavior. I removed the DT directory path
information because it is already explained a few lines below.

While I am here, I deleted the redundant *_defconfig explanation.

The top-level Makefile caters to list available defconfig files:

  mmu_defconfig            - Build for mmu
  nommu_defconfig          - Build for nommu

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/microblaze/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
index 4f3ab57072652..eecf37276521c 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -91,11 +91,11 @@ define archhelp
   echo '* linux.bin    - Create raw binary'
   echo '  linux.bin.gz - Create compressed raw binary'
   echo '  linux.bin.ub - Create U-Boot wrapped raw binary'
-  echo '  simpleImage.<dt> - ELF image with $(arch)/boot/dts/<dt>.dts linked in'
-  echo '                   - stripped elf with fdt blob'
-  echo '  simpleImage.<dt>.unstrip - full ELF image with fdt blob'
-  echo '  *_defconfig      - Select default config from arch/microblaze/configs'
-  echo ''
+  echo '  simpleImage.<dt> - Create the following images with <dt>.dtb linked in'
+  echo '                    simpleImage.<dt>        : raw image'
+  echo '                    simpleImage.<dt>.ub     : raw image with U-Boot header'
+  echo '                    simpleImage.<dt>.unstrip: ELF (identical to vmlinux)'
+  echo '                    simpleImage.<dt>.strip  : stripped ELF'
   echo '  Targets with <dt> embed a device tree blob inside the image'
   echo '  These targets support board with firmware that does not'
   echo '  support passing a device tree directly. Replace <dt> with the'
-- 
2.20.1


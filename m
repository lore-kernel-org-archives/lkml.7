Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8D6C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC7920865
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483058;
	bh=ZCOYm7uvTGNlci+Nc06dmUObDmY7JSDWXNomo+BzJS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xMqPKoBbUEKmPI7kPJ+QpXXbJxaShzLy8rSJaOHPxznjD1Nvui1tEwP3z0gO0o99V
	 q5FdaTpxReqQ1zIz2Y5NH7wHo98amz9pf6ZKlhl2u/hik2q968uStt6ybNEcNc1Agr
	 JKlVH/lgwQgoZIUwN8Y+4BD/qZZ9edOmLoLhYcQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbfLDSK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:10:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731337AbfLDSKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:10:53 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B8E52084B;
        Wed,  4 Dec 2019 18:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575483052;
        bh=ZCOYm7uvTGNlci+Nc06dmUObDmY7JSDWXNomo+BzJS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s+d1Bi/yn4L81yP3bVx1HQFoGYdlfe2qQ9ACp2dYcGzToE/A/w35OJXDD5aTonwg7
         XGUMAgfNP4oBiiYLcCaf7+nG6IRla4X4sv5uTFDvXku4iivweKvqq+65vDR7I9tmLU
         fhHK9E+ych7gGmldImMihpLEcj0kQWVc+3Y/xYiE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 031/125] microblaze: adjust the help to the real behavior
Date:   Wed,  4 Dec 2019 18:55:36 +0100
Message-Id: <20191204175320.887612811@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175308.377746305@linuxfoundation.org>
References: <20191204175308.377746305@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 740f2b82a182a..5e1e18540a571 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -83,11 +83,11 @@ define archhelp
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




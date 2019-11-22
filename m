Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C71C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DFB20718
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403208;
	bh=H1WBjtuVHU+q1pByMDCrOf3M0NmQW+pm/fk8+btGKfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KhMFEuCyUQdBs7MtXLRtOQV04fTUedluaMIVIX/0JBfZOVCu2w3XrruUSkwnMNDur
	 2Y4EjyZ/rCMNVTl/aJrdznoUSzNrk/8wGW7xgH0FaAAex2rHiup8TqtEJHXTcYnTDM
	 ol1p4MqRuAsucIbZKDJ6PXik+fxbZ7htYVfeXOzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbfKVGN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:13:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:50580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729269AbfKVGNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:13:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61DF72071C;
        Fri, 22 Nov 2019 06:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574403202;
        bh=H1WBjtuVHU+q1pByMDCrOf3M0NmQW+pm/fk8+btGKfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a5OuuOdpo0zO7jvnGWbusjPegE7OSyx5B6EStl65rAsX3IK4keSoieOUt5HBYSreo
         QCiVh63U+xr4gcdH8d0NfNlZ5tsRyxqAqoq99bnyPs6fuuQPDb1yUfSDQ9ti2Dhyh2
         X/5k0YXXlIDFwQlcaprxYtq3XVWq7oLa7GuKGB0E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 18/68] microblaze: move "... is ready" messages to arch/microblaze/Makefile
Date:   Fri, 22 Nov 2019 01:12:11 -0500
Message-Id: <20191122061301.4947-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122061301.4947-1-sashal@kernel.org>
References: <20191122061301.4947-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 2e14f94cf4bc2f15ca5362e81ca3a987c79e3062 ]

To prepare for more fixes, move this to arch/microblaze/Makefile.
Otherwise, the same "... is ready" would be printed multiple times.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/microblaze/Makefile      | 2 ++
 arch/microblaze/boot/Makefile | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
index 5e1e18540a571..491676a6cde57 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -75,9 +75,11 @@ archclean:
 
 linux.bin linux.bin.gz linux.bin.ub: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+	@echo 'Kernel: $(boot)/$@ is ready' ' (#'`cat .version`')'
 
 simpleImage.%: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+	@echo 'Kernel: $(boot)/$@ is ready' ' (#'`cat .version`')'
 
 define archhelp
   echo '* linux.bin    - Create raw binary'
diff --git a/arch/microblaze/boot/Makefile b/arch/microblaze/boot/Makefile
index 0f3fe6a151dce..22bed08ec7f28 100644
--- a/arch/microblaze/boot/Makefile
+++ b/arch/microblaze/boot/Makefile
@@ -8,15 +8,12 @@ OBJCOPYFLAGS := -R .note -R .comment -R .note.gnu.build-id -O binary
 
 $(obj)/linux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
-	@echo 'Kernel: $@ is ready' ' (#'`cat .version`')'
 
 $(obj)/linux.bin.ub: $(obj)/linux.bin FORCE
 	$(call if_changed,uimage)
-	@echo 'Kernel: $@ is ready' ' (#'`cat .version`')'
 
 $(obj)/linux.bin.gz: $(obj)/linux.bin FORCE
 	$(call if_changed,gzip)
-	@echo 'Kernel: $@ is ready' ' (#'`cat .version`')'
 
 quiet_cmd_cp = CP      $< $@$2
 	cmd_cp = cat $< >$@$2 || (rm -f $@ && echo false)
@@ -34,6 +31,5 @@ $(obj)/simpleImage.%: vmlinux FORCE
 	$(call if_changed,objcopy)
 	$(call if_changed,uimage)
 	$(call if_changed,strip,.strip)
-	@echo 'Kernel: $(UIMAGE_OUT) is ready' ' (#'`cat .version`')'
 
 clean-files += simpleImage.*.unstrip linux.bin.ub dts/*.dtb
-- 
2.20.1


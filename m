Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91EBC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFBE206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569180244;
	bh=0gvZUA48h60mKKSYWnrhZdNt6BCm5e8E96oFj1y1jWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W91KhxjCWMpq3iCCEm5CD1opc6h9CpsyroQVXCQLMTZAxovoK0F/1kqiHbWtd+zFU
	 xaXW8/yPvdi5spzBcVzZkzVrE7Q23phaWb2q5h+8u5zPwINrRURxEczjHehaD4+YcK
	 RPLMppurHsXx7tjNtxrQJj8LDzEn5oQjrhDR5Yss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbfIVTYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:24:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391509AbfIVSxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:53:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFF4121A4A;
        Sun, 22 Sep 2019 18:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178387;
        bh=0gvZUA48h60mKKSYWnrhZdNt6BCm5e8E96oFj1y1jWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oOIj4v8XRUy7Zyp2ubfEh1Bo+3LCJ/0Ls2cWR3CaQdBbNoppsPqyCMWP4GhkaAVnr
         7iSqFPpCinmKa4y5xQWjdk1cloxEmeDLIDaOoU8DIueoyxWnKMJm2kQxM53+Nj+hUh
         5RbrXe/OzDUqqpthEuzpaybIBOvKjFVpUDLgcGis=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 134/185] arm64: lse: Make ARM64_LSE_ATOMICS depend on JUMP_LABEL
Date:   Sun, 22 Sep 2019 14:48:32 -0400
Message-Id: <20190922184924.32534-134-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184924.32534-1-sashal@kernel.org>
References: <20190922184924.32534-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

[ Upstream commit b32baf91f60fb9c7010bff87e68132f2ce31d9a8 ]

Support for LSE atomic instructions (CONFIG_ARM64_LSE_ATOMICS) relies on
a static key to select between the legacy LL/SC implementation which is
available on all arm64 CPUs and the super-duper LSE implementation which
is available on CPUs implementing v8.1 and later.

Unfortunately, when building a kernel with CONFIG_JUMP_LABEL disabled
(e.g. because the toolchain doesn't support 'asm goto'), the static key
inside the atomics code tries to use atomics itself. This results in a
mess of circular includes and a build failure:

In file included from ./arch/arm64/include/asm/lse.h:11,
                 from ./arch/arm64/include/asm/atomic.h:16,
                 from ./include/linux/atomic.h:7,
                 from ./include/asm-generic/bitops/atomic.h:5,
                 from ./arch/arm64/include/asm/bitops.h:26,
                 from ./include/linux/bitops.h:19,
                 from ./include/linux/kernel.h:12,
                 from ./include/asm-generic/bug.h:18,
                 from ./arch/arm64/include/asm/bug.h:26,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/page-flags.h:10,
                 from kernel/bounds.c:10:
./include/linux/jump_label.h: In function ‘static_key_count’:
./include/linux/jump_label.h:254:9: error: implicit declaration of function ‘atomic_read’ [-Werror=implicit-function-declaration]
  return atomic_read(&key->enabled);
         ^~~~~~~~~~~

[ ... more of the same ... ]

Since LSE atomic instructions are not critical to the operation of the
kernel, make them depend on JUMP_LABEL at compile time.

Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cf5f1dafcf74b..885603e5df135 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1261,6 +1261,7 @@ config ARM64_PAN
 
 config ARM64_LSE_ATOMICS
 	bool "Atomic instructions"
+	depends on JUMP_LABEL
 	default y
 	help
 	  As part of the Large System Extensions, ARMv8.1 introduces new
-- 
2.20.1


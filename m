Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86938C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E6E21783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119196;
	bh=gAU5FFtkt4JrXlIGSESoZ5d/KBuNhSLtdre5Bf76G9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hoPTrghHempg5amK84WsoF5nzDXrbWy0sWMVbZwdC7+bP0R+QRfw3WtBmlsMUbLSe
	 SS9OhUKDV1Qjc+OI9KTFACLZkfghfURm0wBjlBhO9RmMUyXphlH0/qe+/AnOQjcubw
	 4zy6fs+H6haSdUmWFCPTxPs9lHqueSaU1yx9elEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388380AbfJCQNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:13:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730414AbfJCQNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:13:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8F3C2054F;
        Thu,  3 Oct 2019 16:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119193;
        bh=gAU5FFtkt4JrXlIGSESoZ5d/KBuNhSLtdre5Bf76G9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pcQ+nfx/cynO8Y+93IDwI0naeoZuQuNdAs2r+iY+N+voC8tBy4X1h+gII23h63Mk7
         fWiH2uKRhMwugGcql0IoBCZmc1V77BAwGba/d5BaG9DC3rC5ixupCzQWVpjV2K5HJD
         /o/kpt/Y60bdC4UTL4aWyuW70Xgcj0+o3yAfhLQ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luis Araneda <luaraneda@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 4.14 159/185] ARM: zynq: Use memcpy_toio instead of memcpy on smp bring-up
Date:   Thu,  3 Oct 2019 17:53:57 +0200
Message-Id: <20191003154515.139543257@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luis Araneda <luaraneda@gmail.com>

commit b7005d4ef4f3aa2dc24019ffba03a322557ac43d upstream.

This fixes a kernel panic on memcpy when
FORTIFY_SOURCE is enabled.

The initial smp implementation on commit aa7eb2bb4e4a
("arm: zynq: Add smp support")
used memcpy, which worked fine until commit ee333554fed5
("ARM: 8749/1: Kconfig: Add ARCH_HAS_FORTIFY_SOURCE")
enabled overflow checks at runtime, producing a read
overflow panic.

The computed size of memcpy args are:
- p_size (dst): 4294967295 = (size_t) -1
- q_size (src): 1
- size (len): 8

Additionally, the memory is marked as __iomem, so one of
the memcpy_* functions should be used for read/write.

Fixes: aa7eb2bb4e4a ("arm: zynq: Add smp support")
Signed-off-by: Luis Araneda <luaraneda@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-zynq/platsmp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/mach-zynq/platsmp.c
+++ b/arch/arm/mach-zynq/platsmp.c
@@ -65,7 +65,7 @@ int zynq_cpun_start(u32 address, int cpu
 			* 0x4: Jump by mov instruction
 			* 0x8: Jumping address
 			*/
-			memcpy((__force void *)zero, &zynq_secondary_trampoline,
+			memcpy_toio(zero, &zynq_secondary_trampoline,
 							trampoline_size);
 			writel(address, zero + trampoline_size);
 



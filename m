Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69B9C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D31F20673
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122503;
	bh=gHBXCwehdpgM+xbkDasC+q/jnyRk+Cs4NobCvALNRa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fo6cY+IBJ9YUkYk9krKOo+MXp7y3gN90KGmFQ+2MQO6E01ur1A81cM9LHZLH+9e+i
	 7q86iIncjsLoLJFDSZ75im5A8L7YGVFH1rFButwk8QhZiBlP0uPqnfnmSAztMnop37
	 MinWoLHOBrNi4CBPIsx1B65L4VQGpqHDD9o5fzAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393414AbfJCRIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:08:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404085AbfJCQfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:35:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF15A2070B;
        Thu,  3 Oct 2019 16:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120524;
        bh=gHBXCwehdpgM+xbkDasC+q/jnyRk+Cs4NobCvALNRa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zBcRh7brZj9TDv1oKvPfxA4WZL3I7vC8C3rVVqtvzWwCDEEd6il3XTqte8i4mFPYs
         vkXNqOpsNt+E5lKFxWzK+lwwB+ra6ayq0znBw/DrAocjlPR9n7GCUulQaiDAZjod+T
         HoTXoXtg5h0KP8maSJyY9R9OmA+QzZMD1ekZioCo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luis Araneda <luaraneda@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 5.2 255/313] ARM: zynq: Use memcpy_toio instead of memcpy on smp bring-up
Date:   Thu,  3 Oct 2019 17:53:53 +0200
Message-Id: <20191003154558.155501339@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
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
@@ -57,7 +57,7 @@ int zynq_cpun_start(u32 address, int cpu
 			* 0x4: Jump by mov instruction
 			* 0x8: Jumping address
 			*/
-			memcpy((__force void *)zero, &zynq_secondary_trampoline,
+			memcpy_toio(zero, &zynq_secondary_trampoline,
 							trampoline_size);
 			writel(address, zero + trampoline_size);
 



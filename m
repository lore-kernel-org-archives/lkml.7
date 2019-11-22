Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC993C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812FC20674
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574404222;
	bh=mlWxuW4QaOp/nmQEFoM+4MUVtpTnW56Eknmzh6voCTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RZGss66uGC8a8JfMCXizLiKB8OKcnNnZ6LuPnqNUsZ4atr0DcrBwEzg4iXiGHANRZ
	 qF70dkfCqaZORC+ExMea6bB0UJzIt6hPnQFUVmx58vU+RDJXzqCiZfO/xTVhvnzdpE
	 rL2jJDp5qmWFZiJYlNexgwyLEBK660o/IL7Y+XHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfKVGaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:30:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:53764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbfKVFth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:49:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26ED820708;
        Fri, 22 Nov 2019 05:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401777;
        bh=mlWxuW4QaOp/nmQEFoM+4MUVtpTnW56Eknmzh6voCTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vSCQ3B79JsvINc2vN9+H2j9/AS5/RPq0eF/O7NkSc+dDORSzAkmnjY8fH0wAYhdjW
         hZ1GpbmBMFFhEGLMNex6pG1RPpOAU3+ItnHZ2DNvdQr6lrX1768xMOhv8SIUKVuuMT
         djrsNucR0mI5NAx1CyEKtyqZuUG+OrrituQMU/8k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 026/219] arm64: smp: Handle errors reported by the firmware
Date:   Fri, 22 Nov 2019 00:45:58 -0500
Message-Id: <20191122054911.1750-19-sashal@kernel.org>
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

From: Suzuki K Poulose <Suzuki.Poulose@arm.com>

[ Upstream commit f357b3a7e17af7736d67d8267edc1ed3d1dd9391 ]

The __cpu_up() routine ignores the errors reported by the firmware
for a CPU bringup operation and looks for the error status set by the
booting CPU. If the CPU never entered the kernel, we could end up
in assuming stale error status, which otherwise would have been
set/cleared appropriately by the booting CPU.

Reported-by: Steve Capper <steve.capper@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 2c31d65bc541b..52aa51f6310b0 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -146,6 +146,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 		}
 	} else {
 		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
+		return ret;
 	}
 
 	secondary_data.task = NULL;
-- 
2.20.1


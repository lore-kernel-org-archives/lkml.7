Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAD7C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B252070A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402501;
	bh=wwf59jvlmgAHxBsSVCN3Drer6FJuWS1VyOrFqmPPIZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cF+wiX7N6CM6wHO+gXSll127f7Prqt+AgRrA0eIifsn2MveGzN6BO6FcklX9CXr/p
	 mBKT5DoYemnm0zt3G+IZEqsgqz3mwtklHsVYGPpucfa7K00IWl5JloqbheW42SmND+
	 6Nzh1Xah6g18g7hbWitfvFpr6cYZPtZnjJlauRTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbfKVGBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:01:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:39836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728981AbfKVGBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:01:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D67D62070A;
        Fri, 22 Nov 2019 06:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402496;
        bh=wwf59jvlmgAHxBsSVCN3Drer6FJuWS1VyOrFqmPPIZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2Nc6RSQgySO43oIBB2SzapfIbfaAkqIct5i9MynHSXbCXFN6YzlqMG9vtzFZOly6
         C0l0Ape/UY6iu6NeC3HXwai0sGtzxHLr6DLMEe4nB7S3tKKogacwzUs8S/m99dYd10
         uQIyvzeO16F2iBhJ1ZeQz4UdTaLErX2rA2iHXdNY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.9 07/91] arm64: smp: Handle errors reported by the firmware
Date:   Fri, 22 Nov 2019 01:00:05 -0500
Message-Id: <20191122060129.4239-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122060129.4239-1-sashal@kernel.org>
References: <20191122060129.4239-1-sashal@kernel.org>
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
index f0c41524b052f..b2d6de9f6f4fb 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -173,6 +173,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 		}
 	} else {
 		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
+		return ret;
 	}
 
 	secondary_data.stack = NULL;
-- 
2.20.1


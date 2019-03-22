Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF944C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFC5218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254293;
	bh=AoRVO3Hkj7uWrZ6QZMaTkwBCSaacD1U+Ao8903tsCGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aBHiJSswYMXItQ7lDdJ8Pxy/y/K8AU4kRnnXotQj9w6YZoWOIILS9ObVq4TPaRttX
	 NrNGDQ8dy5yYFTN1ldL5Ys9HCWeUwh6ra5CTgMD7iQ8OykE6A90+LPJweIbdfEIWsc
	 4ZaLbNLxB3o4vds4HCy/s8xiUVsQo5sEg8hxvvfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbfCVLbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:31:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730028AbfCVLb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:31:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 763A4218B0;
        Fri, 22 Mar 2019 11:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254288;
        bh=AoRVO3Hkj7uWrZ6QZMaTkwBCSaacD1U+Ao8903tsCGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z5IT6VoBsiMHNvY9l7kPdAc9MTObina8JaJgzeD1AA7bsDRGOBhB2mJhQPZGGUvEo
         rRnzX/cGoeEppnX9pb7FAlJVO5gLVGmvh+xBGybvitYsIYqO8491GcXDI8MpjA1ECY
         z3FVJqldZokD22DmwOxg1C/BSxn2S4eoir9NVVHI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 089/230] xtensa: SMP: limit number of possible CPUs by NR_CPUS
Date:   Fri, 22 Mar 2019 12:13:47 +0100
Message-Id: <20190322111242.860156254@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 25384ce5f9530def39421597b1457d9462df6455 ]

This fixes the following warning at boot when the kernel is booted on a
board with more CPU cores than was configured in NR_CPUS:

  smp_init_cpus: Core Count = 8
  smp_init_cpus: Core Id = 0
  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 0 at include/linux/cpumask.h:121 smp_init_cpus+0x54/0x74
  Modules linked in:
  CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc3-00015-g1459333f88a0 #124
  Call Trace:
    __warn$part$3+0x6a/0x7c
    warn_slowpath_null+0x35/0x3c
    smp_init_cpus+0x54/0x74
    setup_arch+0x1c0/0x1d0
    start_kernel+0x44/0x310
    _startup+0x107/0x107

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/kernel/smp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index 0e34c1ed4aa8..54bb8e0473a0 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -93,6 +93,11 @@ void __init smp_init_cpus(void)
 	pr_info("%s: Core Count = %d\n", __func__, ncpus);
 	pr_info("%s: Core Id = %d\n", __func__, core_id);
 
+	if (ncpus > NR_CPUS) {
+		ncpus = NR_CPUS;
+		pr_info("%s: limiting core count by %d\n", __func__, ncpus);
+	}
+
 	for (i = 0; i < ncpus; ++i)
 		set_cpu_possible(i, true);
 }
-- 
2.19.1




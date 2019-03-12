Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9486FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5675C205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413394;
	bh=KyKrsWylEPO864eGTpA5kjKniMH46YQUpP0Q9y6VuzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VkPwIWy/P0bWQASc51BvwwhJZ7Vm078zXxgYILgsjOBqfCX2E9brxL8sZlv3ciaOs
	 ROJ2srfWZ2jDqxFWo4wiw1NUERsOM2BmIQ0kY3wK5wu1XuDr94vTM7Dcddvd07NMBw
	 df5G6ecArE72GyyVSX67hx9RKeKRZIjR3cUzr9bY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfCLR4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:56:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728144AbfCLRNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:55 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18AF1206DF;
        Tue, 12 Mar 2019 17:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410835;
        bh=KyKrsWylEPO864eGTpA5kjKniMH46YQUpP0Q9y6VuzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nbTVzb9rmAkSZuS35oi8l5QPijQXRyU6qjw8Axciw/DvVz53TnXYdzN60B26qt+CY
         JNazqRwIdZVvyrmtQDLOPEYNq34pfDEEx5lr8IC7BHEg7dbbhuQNVcALPwzAQ3Lt43
         oRbqQfhnV6qiFt+Owx+iJbNw1kE8M9comXdOm40s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 024/149] xtensa: SMP: limit number of possible CPUs by NR_CPUS
Date:   Tue, 12 Mar 2019 10:07:22 -0700
Message-Id: <20190312170351.738681810@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 80be6449c497..be1f280c322c 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -96,6 +96,11 @@ void __init smp_init_cpus(void)
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




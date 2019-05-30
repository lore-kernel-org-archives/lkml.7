Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E267C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A2B25E61
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559192037;
	bh=JiHI/TgLk+DcrLr+6I+X2S/Lr18PKHaI8i5a3ZmgMQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ERf+fO38ixGTeBfO4+XEj8ytfvsleg6NIYl4xKvQq46YKMWbETtMlok/XMaRSqN12
	 AbgQfzef8r8hWhX3M4VmP4Tr4NKIKFV+cUQ838sa9/zFv/0oyEempf3hnCLfn/IHPr
	 4BaUq33ABSDhxULrKla+bQF266d6p722XAng8hzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbfE3DKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727882AbfE3DJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:09:59 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6902A24485;
        Thu, 30 May 2019 03:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185799;
        bh=JiHI/TgLk+DcrLr+6I+X2S/Lr18PKHaI8i5a3ZmgMQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CQBaWEO20xAY8ZKRJKTpULp24jiMlLa8o0rLLvtHb61/wvb/m15Ok4uG4/qmZmTvB
         N32jgZaQv/NOgkmo5nIllL6+5TsbV7UnQdfNeZAr8x0r01qYQHmNvhfDt9yXtHk2dJ
         LoWSGhh0+wkeUB7xov0Dxb7KPN9oQ6ceBIKGsfcg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 076/405] powerpc/perf: Fix loop exit condition in nest_imc_event_init
Date:   Wed, 29 May 2019 20:01:14 -0700
Message-Id: <20190530030544.798185296@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 860b7d2286236170a36f94946d03ca9888d32571 ]

The data structure (i.e struct imc_mem_info) to hold the memory address
information for nest imc units is allocated based on the number of nodes
in the system.

nest_imc_event_init() traverse this struct array to calculate the memory
base address for the event-cpu. If we fail to find a match for the event
cpu's chip-id in imc_mem_info struct array, then the do-while loop will
iterate until we crash.

Fix this by changing the loop exit condition based on the number of
non zero vbase elements in the array, since the allocation is done for
nr_chips + 1.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 885dcd709ba91 ("powerpc/perf: Add nest IMC PMU support")
Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/perf/imc-pmu.c               | 2 +-
 arch/powerpc/platforms/powernv/opal-imc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 6159e9edddfd0..2d12f0037e3a5 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -499,7 +499,7 @@ static int nest_imc_event_init(struct perf_event *event)
 			break;
 		}
 		pcni++;
-	} while (pcni);
+	} while (pcni->vbase != 0);
 
 	if (!flag)
 		return -ENODEV;
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index 58a07948c76e7..3d27f02695e41 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -127,7 +127,7 @@ static int imc_get_mem_addr_nest(struct device_node *node,
 								nr_chips))
 		goto error;
 
-	pmu_ptr->mem_info = kcalloc(nr_chips, sizeof(*pmu_ptr->mem_info),
+	pmu_ptr->mem_info = kcalloc(nr_chips + 1, sizeof(*pmu_ptr->mem_info),
 				    GFP_KERNEL);
 	if (!pmu_ptr->mem_info)
 		goto error;
-- 
2.20.1




Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9214CC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5514E21655
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569343869;
	bh=7S9cQcW7htV2m9M+uWzsUFrMxQ5slCUenIdT6l0JSu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FwxzDnwislU43B7MdKMVxt//TsRca4QmrKckjDRrKBqTShpfsRFvEw+EvGKySCBEi
	 nTFmUzFOqhja5L9XBLzgfw4w9VhwbCtZWkAgMFyHn5QPqyBPXlz4LAjNSIkSlnSghF
	 lMKkKSCX4uVRN8x+GCtHCOfhgYT1gHnBBN5hXZjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410845AbfIXQvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:51:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410822AbfIXQvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:51:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 989F32054F;
        Tue, 24 Sep 2019 16:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343864;
        bh=7S9cQcW7htV2m9M+uWzsUFrMxQ5slCUenIdT6l0JSu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cks2AaJaKROcTgZzvADh3xUvYs2lZTwQPD8DicT/JNhYl7gbAAa63Q0nPT3N9BxSK
         mY0kMk9omaiLP4sSd64+TfcHxGs2APB6WQ2ScMx6VIzNlC1xs4v0U/R5Hz02hCc9Qc
         i53pF8lsr/zuZgwSofC63Qrwegz1RqV4kQvtcidI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.14 18/28] powerpc/pseries/mobility: use cond_resched when updating device tree
Date:   Tue, 24 Sep 2019 12:50:21 -0400
Message-Id: <20190924165031.28292-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924165031.28292-1-sashal@kernel.org>
References: <20190924165031.28292-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Lynch <nathanl@linux.ibm.com>

[ Upstream commit ccfb5bd71d3d1228090a8633800ae7cdf42a94ac ]

After a partition migration, pseries_devicetree_update() processes
changes to the device tree communicated from the platform to
Linux. This is a relatively heavyweight operation, with multiple
device tree searches, memory allocations, and conversations with
partition firmware.

There's a few levels of nested loops which are bounded only by
decisions made by the platform, outside of Linux's control, and indeed
we have seen RCU stalls on large systems while executing this call
graph. Use cond_resched() in these loops so that the cpu is yielded
when needed.

Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20190802192926.19277-4-nathanl@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/mobility.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 4addc552eb33d..9739a055e5f7b 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -12,6 +12,7 @@
 #include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/kobject.h>
+#include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/stat.h>
 #include <linux/completion.h>
@@ -208,7 +209,11 @@ static int update_dt_node(__be32 phandle, s32 scope)
 
 				prop_data += vd;
 			}
+
+			cond_resched();
 		}
+
+		cond_resched();
 	} while (rtas_rc == 1);
 
 	of_node_put(dn);
@@ -317,8 +322,12 @@ int pseries_devicetree_update(s32 scope)
 					add_dt_node(phandle, drc_index);
 					break;
 				}
+
+				cond_resched();
 			}
 		}
+
+		cond_resched();
 	} while (rc == 1);
 
 	kfree(rtas_buf);
-- 
2.20.1


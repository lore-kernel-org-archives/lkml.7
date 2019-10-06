Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63C3C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C095520862
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383776;
	bh=7XQOC0wjoY7c2BPKBbSTFXocm95lPkxvVCApuAz0iI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bz+S2sgLaGXEvVuK2yPNYCxm4qwYFk0QoUshfMa6AsxTdscRFGtL0BbLmBW+D6kO0
	 fzLg5O06xmng8WwghTuPZKZ23ZxNBDg1Rvxcoc5EOw4cuXoPA/f8D8IkcfXzS1KxCe
	 p8o63z72FK/XO4ykV9LaSutVj0NZaHMBEIfF1Q/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbfJFRmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:42:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731395AbfJFRmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:42:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A48FE20862;
        Sun,  6 Oct 2019 17:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383768;
        bh=7XQOC0wjoY7c2BPKBbSTFXocm95lPkxvVCApuAz0iI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z268hoyzmukF49LjKSq3Eqm7hc4OyvlM/7/5C8OoOdscRf80b+FbrXZSJtyMHg0Ex
         q0QkrctiW/OCyaZfWwfdo72vvpAQXvtZOEW6MzwkFOKhWZbddiTfkCDd+dGhnA9tth
         vND6BIoPpRkNX8NBLtNB/yR7wy7x4ZuNVae3Y4ug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 044/166] powerpc/pseries/mobility: use cond_resched when updating device tree
Date:   Sun,  6 Oct 2019 19:20:10 +0200
Message-Id: <20191006171216.667406911@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171212.850660298@linuxfoundation.org>
References: <20191006171212.850660298@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index fe812bebdf5e6..b571285f6c149 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -9,6 +9,7 @@
 #include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/kobject.h>
+#include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/stat.h>
 #include <linux/completion.h>
@@ -207,7 +208,11 @@ static int update_dt_node(__be32 phandle, s32 scope)
 
 				prop_data += vd;
 			}
+
+			cond_resched();
 		}
+
+		cond_resched();
 	} while (rtas_rc == 1);
 
 	of_node_put(dn);
@@ -310,8 +315,12 @@ int pseries_devicetree_update(s32 scope)
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




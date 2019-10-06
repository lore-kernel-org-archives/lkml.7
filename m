Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593A1ECE58F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3361720700
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570384832;
	bh=sl7eYppt5JD2Oe9j+O+g6Z0CQlmLnKpi+odQ+86tqXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GdBeloDL30nHjwGckorIDMH+2BMkWzrwnCVVZmTggqNogFOVSeoxSt9t1JTr/D7bG
	 eDbJCVP8L9KhoduElCDVqWrJhJUwirnzm8akPiJn6a49H3QHmCCO1rHk2gvqwqdlTA
	 SLluN1wfsbiQCJ4sJAZYm3LIcqUC0m0CNRjm9nSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfJFR3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:29:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728879AbfJFR24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:28:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F056B2087E;
        Sun,  6 Oct 2019 17:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570382935;
        bh=sl7eYppt5JD2Oe9j+O+g6Z0CQlmLnKpi+odQ+86tqXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CukaWyr1+jZW+3/Sp7qqLA22xNMOPnoibV2GJLbjFbtm4DAZCoTuqkW2L+ci2fpyQ
         StZQNAP58Zo1+9L1BS9mS4yotRZm2B7dhF9iB/H5QJA9sXz+V/6yCt5dVLUcC8P/7v
         vHd8NnHiC5jS9IF7zmxgHuTDGODNRqB+fny893XI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 025/106] powerpc/pseries/mobility: use cond_resched when updating device tree
Date:   Sun,  6 Oct 2019 19:20:31 +0200
Message-Id: <20191006171137.364190930@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171124.641144086@linuxfoundation.org>
References: <20191006171124.641144086@linuxfoundation.org>
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
index 7b60fcf04dc47..e4ea713833832 100644
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
@@ -209,7 +210,11 @@ static int update_dt_node(__be32 phandle, s32 scope)
 
 				prop_data += vd;
 			}
+
+			cond_resched();
 		}
+
+		cond_resched();
 	} while (rtas_rc == 1);
 
 	of_node_put(dn);
@@ -318,8 +323,12 @@ int pseries_devicetree_update(s32 scope)
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




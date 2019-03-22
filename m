Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E15C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9D1218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfCVDHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:07:12 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:39582 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbfCVDHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 23:07:12 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 69DE437EF9822F2DE665;
        Fri, 22 Mar 2019 11:07:10 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x2M35kRq078031;
        Fri, 22 Mar 2019 11:05:46 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019032211062248-5922967 ;
          Fri, 22 Mar 2019 11:06:22 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/5] powerpc/sparse: fix possible object reference leak
Date:   Fri, 22 Mar 2019 11:05:51 +0800
Message-Id: <1553223955-7350-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-03-22 11:06:22,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-03-22 11:05:31,
        Serialize complete at 2019-03-22 11:05:31
X-MAIL: mse01.zte.com.cn x2M35kRq078031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_find_node_by_path returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./arch/powerpc/platforms/pseries/pseries_energy.c:101:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 46, but without a corresponding object release within this function.
./arch/powerpc/platforms/pseries/pseries_energy.c:172:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 111, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
 arch/powerpc/platforms/pseries/pseries_energy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
index 6ed2212..e3913e4 100644
--- a/arch/powerpc/platforms/pseries/pseries_energy.c
+++ b/arch/powerpc/platforms/pseries/pseries_energy.c
@@ -69,7 +69,7 @@ static u32 cpu_to_drc_index(int cpu)
 
 			of_read_drc_info_cell(&info, &value, &drc);
 			if (strncmp(drc.drc_type, "CPU", 3))
-				goto err;
+				goto err_of_node_put;
 
 			if (thread_index < drc.last_drc_index)
 				break;
@@ -131,7 +131,7 @@ static int drc_index_to_cpu(u32 drc_index)
 
 			of_read_drc_info_cell(&info, &value, &drc);
 			if (strncmp(drc.drc_type, "CPU", 3))
-				goto err;
+				goto err_of_node_put;
 
 			if (drc_index > drc.last_drc_index) {
 				cpu += drc.num_sequential_elems;
-- 
2.9.5


Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AE0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE58920661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VSB70xMd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VSB70xMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfCHSW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:22:27 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60164 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfCHSW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:22:27 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id ACD1B6034E; Fri,  8 Mar 2019 18:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552069346;
        bh=OURoWfpHWvN8EdZDSq2mUIEodWPXBk4ki8GJ0CtPU34=;
        h=From:To:Cc:Subject:Date:From;
        b=VSB70xMdslXUuSJBPt2Z4HSKBGPZZUj5bTvYGnj/fK63IP4JPs8zgHESQOAjDov27
         atAu1uNhLt4BLvXcWfoB2SFKQxXjvUBud8w20J+mBrDqRZOdwXHG5Rw4SF7Z731YO6
         QKTmsSaP4heg85eJOQrWwp2Cq9XTCx1PX/k8gDFQ=
Received: from neeraju-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CE4286030B;
        Fri,  8 Mar 2019 18:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552069346;
        bh=OURoWfpHWvN8EdZDSq2mUIEodWPXBk4ki8GJ0CtPU34=;
        h=From:To:Cc:Subject:Date:From;
        b=VSB70xMdslXUuSJBPt2Z4HSKBGPZZUj5bTvYGnj/fK63IP4JPs8zgHESQOAjDov27
         atAu1uNhLt4BLvXcWfoB2SFKQxXjvUBud8w20J+mBrDqRZOdwXHG5Rw4SF7Z731YO6
         QKTmsSaP4heg85eJOQrWwp2Cq9XTCx1PX/k8gDFQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE4286030B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] rcu/tree_plugin: Fix nohz status in stall warning
Date:   Fri,  8 Mar 2019 23:51:49 +0530
Message-Id: <1552069309-24392-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix stall warning, to show correct nohz marker.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 97dba50..93da32c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1659,7 +1659,7 @@ static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
 		rdp->last_accelerate & 0xffff, jiffies & 0xffff,
 		".l"[rdp->all_lazy],
 		".L"[!rcu_segcblist_n_nonlazy_cbs(&rdp->cblist)],
-		".D"[!rdp->tick_nohz_enabled_snap]);
+		".D"[!!rdp->tick_nohz_enabled_snap]);
 }
 
 #else /* #ifdef CONFIG_RCU_FAST_NO_HZ */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation


Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CB2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33BE217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T+eBz0zx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gcN1/smZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfC2L1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:27:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60562 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728832AbfC2L1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 07:27:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 26CD060735; Fri, 29 Mar 2019 11:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553858843;
        bh=JzotjlzlyWGRXiLcOkvkX+OmBD/yYY4D//NL6ta+P3g=;
        h=From:To:Cc:Subject:Date:From;
        b=T+eBz0zxPfKH5/w+wUk+0Z9ReA+7FD7ZbuS+H20oE4lvvHZsuQr4gJmpjt1Nm4PxJ
         8gYaRlhUbA6Ml+UBBD1ilYasG6N7sQna5Sslu7zZayzeYH+EFxU6FNM1V2/zLkD9o1
         dThDA94zxa+Z6d0XcB88TM3rrSnx1Tb9nfdJLoy4=
Received: from neeraju-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8F3F66086B;
        Fri, 29 Mar 2019 11:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553858842;
        bh=JzotjlzlyWGRXiLcOkvkX+OmBD/yYY4D//NL6ta+P3g=;
        h=From:To:Cc:Subject:Date:From;
        b=gcN1/smZILdhkjWTO4XEfPFrM2qO8xwRDytL6CIfTFCnBvKrUlf1RawOuFrI8RqP5
         bgAbexTig6CRovlfRk+wFHBQaZMqfdzqUaXjveF0O9qa7SeU8pq4PJIJ6aqsgpGGtC
         GoutcQsyn8E5+sTeq2gaKxS9NDPK4erJxvWCtdBc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8F3F66086B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] rcu: tree_stall: Correctly unlock root node in rcu_check_gp_start_stall
Date:   Fri, 29 Mar 2019 16:57:08 +0530
Message-Id: <1553858828-23097-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only unlock the root node, if current node (rnp) is not
root node.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/tree_stall.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index f65a73a..0651833 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -630,7 +630,9 @@ static void rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp,
 	    time_before(j, rcu_state.gp_req_activity + gpssdelay) ||
 	    time_before(j, rcu_state.gp_activity + gpssdelay) ||
 	    atomic_xchg(&warned, 1)) {
-		raw_spin_unlock_rcu_node(rnp_root); /* irqs remain disabled. */
+		if (rnp_root != rnp)
+			/* irqs remain disabled. */
+			raw_spin_unlock_rcu_node(rnp_root);
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
 	}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation


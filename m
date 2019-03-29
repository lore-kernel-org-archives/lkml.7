Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D16C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CB220811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nIyDBqpy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Au4jeGKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbfC2J4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:56:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41862 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfC2J4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:56:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5D1F2602BA; Fri, 29 Mar 2019 09:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553853363;
        bh=yqgT1ELylBVMMOQv2UYI/M+F+ZT/PTzEkVX3jgXVsnw=;
        h=From:To:Cc:Subject:Date:From;
        b=nIyDBqpy7d79GXKFFCrS4daGWVPOOO1MUUHt1vYEONkKZucCU4J0z2ONUKQCrsYgN
         tBECxMNJncvTly6sqsdhjY1GjcaXtTUCQ6XTLoeFINGUstNwol5usjt9RdYI4W/TN/
         T8fPV5Om4TdwiftOagTkWyJ2hlFQIDhbe6a+t5mA=
Received: from neeraju-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CD0DE602BA;
        Fri, 29 Mar 2019 09:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553853362;
        bh=yqgT1ELylBVMMOQv2UYI/M+F+ZT/PTzEkVX3jgXVsnw=;
        h=From:To:Cc:Subject:Date:From;
        b=Au4jeGKsj4/Nc1kN0KPcwmortZPJP8jdlSTRwNzDy+39Yffmr6IyaU35SfnszILTH
         HwKiZOcBLobSX7zBkwPaJzHOLiutNXt0ipQZSd7Qq+pQiUZedqlhSBQpLMGbAniWjF
         J/yLnKUS1Nr5h4UgKUL+TOxViOOV3kXwuqR3Z8fE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD0DE602BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] rcu: tree_plugin: Dump specified number of blocked tasks
Date:   Fri, 29 Mar 2019 15:25:52 +0530
Message-Id: <1553853352-14253-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dump_blkd_tasks() uses 10 as the max number of blocked
tasks, which are printed. However, it has an argument
which provides that number. So, use the argument value
instead. As all callers currently pass 10 as the number,
there isn't any impact.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3960294..08bcd87 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -740,7 +740,7 @@ void exit_rcu(void)
 	i = 0;
 	list_for_each(lhp, &rnp->blkd_tasks) {
 		pr_cont(" %p", lhp);
-		if (++i >= 10)
+		if (++i >= ncheck)
 			break;
 	}
 	pr_cont("\n");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation


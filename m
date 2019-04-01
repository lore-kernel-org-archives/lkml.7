Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EF7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2CE2171F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139941;
	bh=e21tnhzIBXTZ/hwcND+cZU1nzaTqWuPe/sQxrkgRaO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZirATBweS0Tie8SaUGpOYagImWQ7+cWwWyTeZaQdgfUi+sf6JCX3ZXwwf1t/32jOB
	 mkPhxIoonOEyNZ9U/iCvmBFUSiE+bY7usLJcHAPs6WQUAe/VapQJZ+oVdIFem14gK6
	 heHl4IOmuHJhk/PKDocHPBAZP/dcZx7OEUDjVYS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387477AbfDARcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:32:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387467AbfDARcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:32:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91BC12171F;
        Mon,  1 Apr 2019 17:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139934;
        bh=e21tnhzIBXTZ/hwcND+cZU1nzaTqWuPe/sQxrkgRaO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HDVPLMjgLwO55iyZTTBHQjzXZm2oLwOFRzxp70pecVkH+TIg/R0xzFg3yMK7ug3GH
         Hefba2vHJ9CU2XFurCZ1Kf4KQ3jkTYtA4NtaY/hQfp3cbMYTg6/5Z3PGNYuuV7wbDW
         LGywZaz481LkFopjLjFkeNJrEaZjQjKuxYsmCdTA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 058/131] stm class: Fix locking in unbinding policy path
Date:   Mon,  1 Apr 2019 19:02:08 +0200
Message-Id: <20190401170057.179898582@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

[ Upstream commit 4c127fd16e6b33ecb7badc091480c84ea9aebeb6 ]

Right now, if stm device removal has to unbind from a policy (that is,
an stm device that has STP policy, gets removed), it will trigger a
nested lock on the stm device's policy mutex.

This patch fixes the problem by moving the locking from the policy
unbinding to policy removal (configfs path), where it's actually needed;
the other caller of the policy unbinding function already takes the
mutex around the call.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/stm/policy.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/stm/policy.c b/drivers/hwtracing/stm/policy.c
index 11ab6d01adf6..94d3abfb737a 100644
--- a/drivers/hwtracing/stm/policy.c
+++ b/drivers/hwtracing/stm/policy.c
@@ -272,13 +272,17 @@ void stp_policy_unbind(struct stp_policy *policy)
 {
 	struct stm_device *stm = policy->stm;
 
+	/*
+	 * stp_policy_release() will not call here if the policy is already
+	 * unbound; other users should not either, as no link exists between
+	 * this policy and anything else in that case
+	 */
 	if (WARN_ON_ONCE(!policy->stm))
 		return;
 
-	mutex_lock(&stm->policy_mutex);
-	stm->policy = NULL;
-	mutex_unlock(&stm->policy_mutex);
+	lockdep_assert_held(&stm->policy_mutex);
 
+	stm->policy = NULL;
 	policy->stm = NULL;
 
 	stm_put_device(stm);
@@ -287,8 +291,16 @@ void stp_policy_unbind(struct stp_policy *policy)
 static void stp_policy_release(struct config_item *item)
 {
 	struct stp_policy *policy = to_stp_policy(item);
+	struct stm_device *stm = policy->stm;
 
+	/* a policy *can* be unbound and still exist in configfs tree */
+	if (!stm)
+		return;
+
+	mutex_lock(&stm->policy_mutex);
 	stp_policy_unbind(policy);
+	mutex_unlock(&stm->policy_mutex);
+
 	kfree(policy);
 }
 
-- 
2.19.1




Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2B6C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AC42064A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907310;
	bh=F2uD/ntOfY+2M09zC8W1N01Bze0wuQsbHlr3vE2LTrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BQUguqzYIkehmiQCLbCit9PFMBMyJSkBiwavfX5ZdKsufWTTtH919aejP0TMwZ6Uz
	 6uNBXVHt+Nx2P1YKw0zTjRi7DM8/eWzK/ldg+4XhOb11yqrtV5d27BAk0q/L7eZMky
	 a98veZTxBslx54ZuNgs35gJc3DTUMQMAKU5N64WE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbfC3AzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:55:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731182AbfC3AzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:55:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A08D2218D8;
        Sat, 30 Mar 2019 00:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907300;
        bh=F2uD/ntOfY+2M09zC8W1N01Bze0wuQsbHlr3vE2LTrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ajXkAIxAW3/DMl9D2j7l0i9dfsOEBrr3Xi3d5qrY0CnXVU1iVCkJpLYWVUETXmFdm
         hkeIkxJnhH09aEC1IedBygF9KlQcD/DzVbw9DDvDHXwyOHE4wdiDqYF1Ql/l4O/NEs
         kqz9ftVA/nrlrqLd/a29uo0UbLA9VK0PyMLnFoPw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 12/37] thermal/intel_powerclamp: fix __percpu declaration of worker_data
Date:   Fri, 29 Mar 2019 20:54:13 -0400
Message-Id: <20190330005441.27540-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005441.27540-1-sashal@kernel.org>
References: <20190330005441.27540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

[ Upstream commit aa36e3616532f82a920b5ebf4e059fbafae63d88 ]

This variable is declared as:
	static struct powerclamp_worker_data * __percpu worker_data;
In other words, a percpu pointer to struct ...

But this variable not used like so but as a pointer to a percpu
struct powerclamp_worker_data.

So fix the declaration as:
	static struct powerclamp_worker_data __percpu *worker_data;

This also quiets Sparse's warnings from __verify_pcpu_ptr(), like:
  494:49: warning: incorrect type in initializer (different address spaces)
  494:49:    expected void const [noderef] <asn:3> *__vpp_verify
  494:49:    got struct powerclamp_worker_data *

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/intel_powerclamp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index d718cd179ddb..45d9840491bd 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -101,7 +101,7 @@ struct powerclamp_worker_data {
 	bool clamping;
 };
 
-static struct powerclamp_worker_data * __percpu worker_data;
+static struct powerclamp_worker_data __percpu *worker_data;
 static struct thermal_cooling_device *cooling_dev;
 static unsigned long *cpu_clamping_mask;  /* bit map for tracking per cpu
 					   * clamping kthread worker
-- 
2.19.1


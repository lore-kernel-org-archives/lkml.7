Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C5BC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031FF24AC4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559187019;
	bh=V+BBz4ewor3VDGhV2wJZv25VePeUO9pa0pnTOtYQyO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hTKhZ2OGcxiRsJYWK65t0ueKP4YSmKkspwbWIaPU1+bnFFMl/oenEJficroLFRq7/
	 Oc7a8PWeqAcuZba/tBTpBjk3Zp50HvdWwyTvRgRcl4YdM1+GJy1BiAeOkYIzYOMeDR
	 9xl5k21DKLgUDuCa5/63ko2nq2vpgLJStLsozHQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388178AbfE3DaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732516AbfE3DVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:21:20 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 569DF24A03;
        Thu, 30 May 2019 03:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186479;
        bh=V+BBz4ewor3VDGhV2wJZv25VePeUO9pa0pnTOtYQyO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e88SioLV11IBmJ6zW1cChHBfa+/jsFgrQUryJFNUaKRjViBtD8DKxGWMIAhaehrgX
         cppMGuXHZSPLcY9CJML7TAIvovtP2GPwV9gMDvxDMjsTiZfxb+QVY7qIHADnRTPk+9
         rqjUEQMMBOHXLIDNgum6+xOeAY4xxkeUlGqB0cMo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <rong.a.chen@intel.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 114/128] rcutorture: Fix cleanup path for invalid torture_type strings
Date:   Wed, 29 May 2019 20:07:26 -0700
Message-Id: <20190530030454.951960906@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030432.977908967@linuxfoundation.org>
References: <20190530030432.977908967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b813afae7ab6a5e91b4e16cc567331d9c2ae1f04 ]

If the specified rcutorture.torture_type is not in the rcu_torture_init()
function's torture_ops[] array, rcutorture prints some console messages
and then invokes rcu_torture_cleanup() to set state so that a future
torture test can run.  However, rcu_torture_cleanup() also attempts to
end the test that didn't actually start, and in doing so relies on the
value of cur_ops, a value that is not particularly relevant in this case.
This can result in confusing output or even follow-on failures due to
attempts to use facilities that have not been properly initialized.

This commit therefore sets the value of cur_ops to NULL in this case
and inserts a check near the beginning of rcu_torture_cleanup(),
thus avoiding relying on an irrelevant cur_ops value.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/rcutorture.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index bf08fee53dc75..5393bbcf3c1ad 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1595,6 +1595,10 @@ rcu_torture_cleanup(void)
 			cur_ops->cb_barrier();
 		return;
 	}
+	if (!cur_ops) {
+		torture_cleanup_end();
+		return;
+	}
 
 	rcu_torture_barrier_cleanup();
 	torture_stop_kthread(rcu_torture_stall, stall_task);
@@ -1730,6 +1734,7 @@ rcu_torture_init(void)
 			pr_alert(" %s", torture_ops[i]->name);
 		pr_alert("\n");
 		firsterr = -EINVAL;
+		cur_ops = NULL;
 		goto unwind;
 	}
 	if (cur_ops->fqs == NULL && fqs_duration != 0) {
-- 
2.20.1




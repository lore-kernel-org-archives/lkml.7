Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADD7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A975D233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566493895;
	bh=k0NJEKzqa1CBSiBvOVHMb37rNO2LtfFkZtZBp8TITlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BO30eLeEDCK9Jgp/BHuHJZYJ8iHQa0jf04Bffvn2xaQKxAeFvLaYAfAx6e+CM8n3k
	 d2rYG6B1QjLh2+qHF+o6mOWoEM44q8CZ2O/HNcSrIHhOycsoAmA/cYw5jQ+6pz9FyP
	 bnKiqQaeEZPN4fvn8rZFNzenhatL7823kQi6fRmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390920AbfHVRLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390714AbfHVRJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:09:16 -0400
Received: from sasha-vm.mshome.net (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8C9023427;
        Thu, 22 Aug 2019 17:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566493755;
        bh=k0NJEKzqa1CBSiBvOVHMb37rNO2LtfFkZtZBp8TITlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JsJOb3iNEHQgMRoGmhmZLykcxgf0Crt9bjKdeBG3NaAXF6uFlE50ZjtlZaQtdDTJO
         RBKqBtQ7hvp0cjQORlLuDddtMePiExOm6/WjHzarg21j/285z9tbbxEaskqDCh0xB+
         NMLr1A5Md3R8g6Jv7OtVjRXLm67TCfuQfOFFXyYw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.2 112/135] net: sched: sch_taprio: fix memleak in error path for sched list parse
Date:   Thu, 22 Aug 2019 13:07:48 -0400
Message-Id: <20190822170811.13303-113-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822170811.13303-1-sashal@kernel.org>
References: <20190822170811.13303-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.2.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.2.10-rc1
X-KernelTest-Deadline: 2019-08-24T17:07+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

[ Upstream commit 51650d33b2771acd505068da669cf85cffac369a ]

In error case, all entries should be freed from the sched list
before deleting it. For simplicity use rcu way.

Fixes: 5a781ccbd19e46 ("tc: Add support for configuring the taprio scheduler")
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_taprio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 9ecfb8f5902a4..8be89aa52b6e8 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -849,7 +849,8 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 	spin_unlock_bh(qdisc_lock(sch));
 
 free_sched:
-	kfree(new_admin);
+	if (new_admin)
+		call_rcu(&new_admin->rcu, taprio_free_sched_cb);
 
 	return err;
 }
-- 
2.20.1


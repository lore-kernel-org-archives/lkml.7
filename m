Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59371C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2776C2053B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567613350;
	bh=WDvQUbKcJHAN78tC7rWq9WCVMyV4U0AuITSfOrmD5UQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rsu0SVeWL7dmnAoKhnGf3M+zv+E0QNicn8BeP1phU0NwQSu+NtCnrKSmPOg2La7Wp
	 niic0LqwK+gOYy9hS9Zh2dR7Nw7TnC36actu8gl7jRe9vWBSBdUllA06UbdvoIG0F/
	 JDV33b9Du6rQ3Ff0tmFf1PFeBJgqeN8BCRGbbA9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbfIDQJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:09:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732963AbfIDQBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:01:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 888812070C;
        Wed,  4 Sep 2019 16:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612878;
        bh=WDvQUbKcJHAN78tC7rWq9WCVMyV4U0AuITSfOrmD5UQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sZAQyUWagJQjEzyFOaTk5w096LV3AJF/eGPTm0wTQtvdCcBDgUuTJJpq9GS4num7Z
         DPcUYQSFu/iisaQQeU7dE6pqIdQez761Stg587safbFodmz4u144ztxV7Gt2kehd9/
         f1AGuMd+DuICZGCtDAWe/hzA+Fda5hh7MF/T3H+I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 51/52] net: aquantia: fix out of memory condition on rx side
Date:   Wed,  4 Sep 2019 12:00:03 -0400
Message-Id: <20190904160004.3671-51-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904160004.3671-1-sashal@kernel.org>
References: <20190904160004.3671-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>

[ Upstream commit be6cef69ba570ebb327eba1ef6438f7af49aaf86 ]

On embedded environments with hard memory limits it is a normal although
rare case when skb can't be allocated on rx part under high traffic.

In such OOM cases napi_complete_done() was not called.
So the napi object became in an invalid state like it is "scheduled".
Kernel do not re-schedules the poll of that napi object.

Consequently, kernel can not remove that object the system hangs on
`ifconfig down` waiting for a poll.

We are fixing this by gracefully closing napi poll routine with correct
invocation of napi_complete_done.

This was reproduced with artificially failing the allocation of skb to
simulate an "out of memory" error case and check that traffic does
not get stuck.

Fixes: 970a2e9864b0 ("net: ethernet: aquantia: Vector operations")
Signed-off-by: Igor Russkikh <igor.russkikh@aquantia.com>
Signed-off-by: Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_vec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
index d335c334fa561..82582fa54d5d2 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
@@ -89,6 +89,7 @@ static int aq_vec_poll(struct napi_struct *napi, int budget)
 			}
 		}
 
+err_exit:
 		if (!was_tx_cleaned)
 			work_done = budget;
 
@@ -98,7 +99,7 @@ static int aq_vec_poll(struct napi_struct *napi, int budget)
 					1U << self->aq_ring_param.vec_idx);
 		}
 	}
-err_exit:
+
 	return work_done;
 }
 
-- 
2.20.1


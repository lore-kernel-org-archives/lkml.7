Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90938C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DA321738
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561595543;
	bh=gmmiuDkbFlzLqd6DkAtNbOiOZKqnv3fzAAXSd+132jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qnwA0jbhSiyFjhJAnjEr035ZZ/CagrZwgsNiEySoBVUaATQ1VBIzQJNL/qcMrhQWR
	 1JV9DtAsvh01nFPTgHxqrGuZWLUpfatYqxKlOZ3z56gGKpREAqefDib1tvxjjbHv6F
	 uuUT9FDw4OTDKCQFT0Vxm53xhm/MDllj9WrWwPcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfF0AcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:32:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbfF0AcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:32:18 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87A6D21726;
        Thu, 27 Jun 2019 00:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595537;
        bh=gmmiuDkbFlzLqd6DkAtNbOiOZKqnv3fzAAXSd+132jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UaNDmPiK30MN7k2mqyc4DKNguM43HTwosR8ruRYRoAcB/xai69FC86gZ8O7HFxS4U
         LEhaymVTuq2f5zq7K0qeczxWuwvS6IDvIkLVOAytvEBzHmaTYtmJKVBXMKIavwsM65
         eUfGak22PRf/or0f2QmJyZ3odaOe2JxvevlCr73U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 34/95] soundwire: stream: fix bad unlock balance
Date:   Wed, 26 Jun 2019 20:29:19 -0400
Message-Id: <20190627003021.19867-34-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003021.19867-1-sashal@kernel.org>
References: <20190627003021.19867-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit 9315d904c7e8f38886e2820fa6cb8d0fa723ea21 ]

the msg lock is taken for multi-link cases only but released
unconditionally, leading to an unlock balance warning for single-link usages
This patch fixes this.

 =====================================
 WARNING: bad unlock balance detected!
 5.1.0-16506-gc1c383a6f0a2-dirty #1523 Tainted: G        W
 -------------------------------------
 aplay/2954 is trying to release lock (&bus->msg_lock) at:
 do_bank_switch+0x21c/0x480
 but there are no more locks to release!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Sanyog Kale <sanyog.r.kale@intel.com>
[vkoul: edited the change log as suggested by Pierre]
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/stream.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 00618de2ee12..794ced434cf2 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -805,7 +805,8 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
 			goto error;
 		}
 
-		mutex_unlock(&bus->msg_lock);
+		if (bus->multi_link)
+			mutex_unlock(&bus->msg_lock);
 	}
 
 	return ret;
-- 
2.20.1


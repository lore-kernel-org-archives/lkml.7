Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08826C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCBBA2742F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559395731;
	bh=hppQ/HvHTQZMWNI9Q433yxzljygMRj4FZgCPLiBCMi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vx0iuNigAwKTi8BTwmtoOcbMcAhQa2mh4XVPeLy4mTRjUmBJcfRusaBQ7+idi8h+w
	 pQq05RUDVNeCOjM2qzmXFED7NOlYvBO0Bv0W5H8MrGUh5XOAhGHF3/69VCrele26t4
	 +Nxjf4R3HP9D/s7h0ZhRHJ32CUrAIFk8O8E1V2gU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbfFAN2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:28:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729789AbfFAN0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:26:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71FCD273DA;
        Sat,  1 Jun 2019 13:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395603;
        bh=hppQ/HvHTQZMWNI9Q433yxzljygMRj4FZgCPLiBCMi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WvMT8VZM3KgZgk6mEl9dnOFpsIUFu2c8HOVDVhTE8G82BlxaG/GvcViZXBBPcUc7I
         IP0Y7KtyMMcwhBU6+hiLRuweggUxrIA3fe1gem7QPdgD53G+tTbB7nqy5sdepvPV18
         cFeOyEnNjS4Hs7QFqs6OdPz0t/WE5QRJTAWmdXrY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 22/56] stm class: Fix channel free in stm output free path
Date:   Sat,  1 Jun 2019 09:25:26 -0400
Message-Id: <20190601132600.27427-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601132600.27427-1-sashal@kernel.org>
References: <20190601132600.27427-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tingwei Zhang <tingwei@codeaurora.org>

[ Upstream commit ee496da4c3915de3232b5f5cd20e21ae3e46fe8d ]

Number of free masters is not set correctly in stm
free path. Fix this by properly adding the number
of output channels before setting them to 0 in
stm_output_disclaim().

Currently it is equivalent to doing nothing since
master->nr_free is incremented by 0.

Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace Module devices")
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: stable@vger.kernel.org # v4.4
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/stm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index b6cc841de79dd..e880702a37840 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -210,8 +210,8 @@ stm_output_disclaim(struct stm_device *stm, struct stm_output *output)
 	bitmap_release_region(&master->chan_map[0], output->channel,
 			      ilog2(output->nr_chans));
 
-	output->nr_chans = 0;
 	master->nr_free += output->nr_chans;
+	output->nr_chans = 0;
 }
 
 /*
-- 
2.20.1


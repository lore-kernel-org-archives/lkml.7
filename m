Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5E5ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D8E21A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948132;
	bh=DNNfLFjNLJirXZGKKwbJVR1o9YeP0aSn2OSCE44mIxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2vvmBaaSIz9I84mjouL++yf9mjSxylpvPTIzUimQja5JLfupFuipAj/mvuoKkjZKX
	 TAz5gzMwy8esSx75ZyA5WN1tTMGXSjK1uYCwXOlR4x56YudYHi+/ncXAp/mr7CARDr
	 kaHIzLWX6oGlqTHA16EsO8aiL5xF7Jy7gkU1fZxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731701AbfJAQmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:42:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfJAQmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:42:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26A4420B7C;
        Tue,  1 Oct 2019 16:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948128;
        bh=DNNfLFjNLJirXZGKKwbJVR1o9YeP0aSn2OSCE44mIxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yBOCxhwaKDjQ4DrAMPNCYrBEN9FcCAQJ2i2kTFYOV4vvrB1zG//moeqUPyG9lS5Er
         1I95Y0k4DUjLxARH+Q0tXLEe7pGl3z2/9d+oUWppCnd7yY7nfwS7zmYiboiaDfLDgc
         1YaKAudzmGWDwhzJwb5sXu9SGXMEbpv9A/4ds9Jc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sanjay R Mehta <sanju.mehta@amd.com>, Jon Mason <jdmason@kudzu.us>,
        Sasha Levin <sashal@kernel.org>, linux-ntb@googlegroups.com
Subject: [PATCH AUTOSEL 5.2 29/63] ntb: point to right memory window index
Date:   Tue,  1 Oct 2019 12:40:51 -0400
Message-Id: <20191001164125.15398-29-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001164125.15398-1-sashal@kernel.org>
References: <20191001164125.15398-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

[ Upstream commit ae89339b08f3fe02457ec9edd512ddc3d246d0f8 ]

second parameter of ntb_peer_mw_get_addr is pointing to wrong memory
window index by passing "peer gidx" instead of "local gidx".

For ex, "local gidx" value is '0' and "peer gidx" value is '1', then

on peer side ntb_mw_set_trans() api is used as below with gidx pointing to
local side gidx which is '0', so memroy window '0' is chosen and XLAT '0'
will be programmed by peer side.

    ntb_mw_set_trans(perf->ntb, peer->pidx, peer->gidx, peer->inbuf_xlat,
                    peer->inbuf_size);

Now, on local side ntb_peer_mw_get_addr() is been used as below with gidx
pointing to "peer gidx" which is '1', so pointing to memory window '1'
instead of memory window '0'.

    ntb_peer_mw_get_addr(perf->ntb,  peer->gidx, &phys_addr,
                        &peer->outbuf_size);

So this patch pass "local gidx" as parameter to ntb_peer_mw_get_addr().

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/test/ntb_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 11a6cd3740049..c6a1dee3c429b 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -1370,7 +1370,7 @@ static int perf_setup_peer_mw(struct perf_peer *peer)
 	int ret;
 
 	/* Get outbound MW parameters and map it */
-	ret = ntb_peer_mw_get_addr(perf->ntb, peer->gidx, &phys_addr,
+	ret = ntb_peer_mw_get_addr(perf->ntb, perf->gidx, &phys_addr,
 				   &peer->outbuf_size);
 	if (ret)
 		return ret;
-- 
2.20.1


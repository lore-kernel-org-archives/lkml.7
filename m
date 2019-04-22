Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C1AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419CF20643
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963726;
	bh=G59UsK25HNTejEb2UTD582OoT4OLE06msFm4ALxDdNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wN3KE1PPEl3O6i1apzXcXS9C2qdmVltXtDWSj5y5tyKHl+uZfdyRCrvu73g/40nOG
	 Rj8r9lBqbKVoHzdlSSvucy9bc4JgeYcJJ7eusinuaAdUK9XHF515nCzOu4ijRjn+Iw
	 3G5SpM4WnijKCywH3vB7nFm2DnETBKWCunehwXOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732471AbfDVUIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:08:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729280AbfDVTnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:43:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06573218DA;
        Mon, 22 Apr 2019 19:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962231;
        bh=G59UsK25HNTejEb2UTD582OoT4OLE06msFm4ALxDdNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DULN569sSc1IjBnEEpdM9o2+l1bQsAoKeqKGHXBBOeVV7NZ/NSEvBK9BqOf4GtgwK
         MdwKydl/CuKPZ71XlrLS/trMJI/KQH7CzpQWLtvSi7rO5AaukP+k7hBnh1lii2M6hp
         qDju099cHy5aaRcNMmvi0q8kgr/vfCDRQZheDzKA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        Douglas Miller <dougmill@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 52/98] net: ibm: fix possible object reference leak
Date:   Mon, 22 Apr 2019 15:41:19 -0400
Message-Id: <20190422194205.10404-52-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

[ Upstream commit be693df3cf9dd113ff1d2c0d8150199efdba37f6 ]

The call to ehea_get_eth_dn returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/net/ethernet/ibm/ehea/ehea_main.c:3163:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 3154, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Douglas Miller <dougmill@linux.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ehea/ehea_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ibm/ehea/ehea_main.c b/drivers/net/ethernet/ibm/ehea/ehea_main.c
index 3baabdc89726..90b62c1412c8 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_main.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_main.c
@@ -3160,6 +3160,7 @@ static ssize_t ehea_probe_port(struct device *dev,
 
 	if (ehea_add_adapter_mr(adapter)) {
 		pr_err("creating MR failed\n");
+		of_node_put(eth_dn);
 		return -EIO;
 	}
 
-- 
2.19.1


Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37340C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A8E206B6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370102;
	bh=wHVyGg601aM8jcC8n7wrdRP6BQnJpBKVAHUIhIzV+Ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zFbACVLBpZQojXLB1iSipxKKcLhTFMUsLfH7xD5AXRFO7V9/tzg0BkuNBUa1709A3
	 RYLfdGNBQw/koaUksYpoziCTUVo+dsnH3w1K+WmArWPpHO7QxDYUbe7eb/k/qK1/Xj
	 p5YCmBLFR+/06sorX/IHBsG3uzI/Cznlwhfn9hck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387633AbfDDJ2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733227AbfDDJLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:11:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A225420652;
        Thu,  4 Apr 2019 09:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369114;
        bh=wHVyGg601aM8jcC8n7wrdRP6BQnJpBKVAHUIhIzV+Ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y+b3PQFSLmVujd+aMbGDI0RsYlpl0GVsfOoDFBDtmU+W+vF7J7jEyJuXiCZJRBLJt
         ir54Y48K7oFtAZyUjzPu04KFD+fAC2BtX1pUgEf6iwQpI0NifFkfSs4L8m3c2uUITA
         +DXYwtbr03eEfOfKzhWL/MuzgFwfIDl90TCyFPZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 089/246] veth: Fix -Wformat-truncation
Date:   Thu,  4 Apr 2019 10:46:29 +0200
Message-Id: <20190404084622.258618587@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit abdf47aab4123ece48877cab4153db44fe4dc340 ]

Provide a precision hint to snprintf() in order to eliminate a
-Wformat-truncation warning provided below. A maximum of 11 characters
is allowed to reach a maximum of 32 - 1 characters given a possible
maximum value of queues using up to UINT_MAX which occupies 10
characters. Incidentally 11 is the number of characters for
"xdp_packets" which is the largest string we append.

drivers/net/veth.c: In function 'veth_get_strings':
drivers/net/veth.c:118:47: warning: '%s' directive output may be
truncated writing up to 31 bytes into a region of size between 12 and 21
[-Wformat-truncation=]
     snprintf(p, ETH_GSTRING_LEN, "rx_queue_%u_%s",
                                               ^~
drivers/net/veth.c:118:5: note: 'snprintf' output between 12 and 52
bytes into a destination of size 32
     snprintf(p, ETH_GSTRING_LEN, "rx_queue_%u_%s",
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       i, veth_rq_stats_desc[j].desc);
       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/veth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index f412ea1cef18..b203d1867959 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -115,7 +115,8 @@ static void veth_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
 		p += sizeof(ethtool_stats_keys);
 		for (i = 0; i < dev->real_num_rx_queues; i++) {
 			for (j = 0; j < VETH_RQ_STATS_LEN; j++) {
-				snprintf(p, ETH_GSTRING_LEN, "rx_queue_%u_%s",
+				snprintf(p, ETH_GSTRING_LEN,
+					 "rx_queue_%u_%.11s",
 					 i, veth_rq_stats_desc[j].desc);
 				p += ETH_GSTRING_LEN;
 			}
-- 
2.19.1




Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFE2CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EFC21D7F
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572095953;
	bh=t+bD9xUWb7jrIouVNMkqMTMrVOZEf1djITUp3ye4Oh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ycoYv1MkR7B0mE+/3Ad4/5GP4FMNsp2H9xsrUxnujQP0R37Pbc4TucKnRglzf8ywx
	 o6XuSvDE5LR45HVmdtD281cPG27Fo0T5+UVvSnjGZAOYOogyb5nEwrzUaxi9aHW5ST
	 Sg+lKT5NC1oFnOk6tmn1GYDWl2FUme+6CqXJUers=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfJZNTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:19:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfJZNTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:19:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AF2D222C3;
        Sat, 26 Oct 2019 13:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572095946;
        bh=t+bD9xUWb7jrIouVNMkqMTMrVOZEf1djITUp3ye4Oh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0JXdeArV8ExN73b2BFur4BhWqt3pKW/CD1HYjx2rwqaRQ9AXCzzNfpSsN4rcY1mV4
         IQ3GF88AX06dxwnZn/jwv7EFPHHMRwvalgcs5087aT0YCMYZnakeRSvlQwblWwXXHJ
         nSVXX6974S87umwv1oFEmewF8hHGY/RUFNA6KhV8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chenwandun <chenwandun@huawei.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 99/99] net: aquantia: add an error handling in aq_nic_set_multicast_list
Date:   Sat, 26 Oct 2019 09:16:00 -0400
Message-Id: <20191026131600.2507-99-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026131600.2507-1-sashal@kernel.org>
References: <20191026131600.2507-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chenwandun <chenwandun@huawei.com>

[ Upstream commit 3d00cf2fbb61212f47a3cf838be51c921366c937 ]

add an error handling in aq_nic_set_multicast_list, it may not
work when hw_multicast_list_set error; and at the same time
it will remove gcc Wunused-but-set-variable warning.

Signed-off-by: Chenwandun <chenwandun@huawei.com>
Reviewed-by: Igor Russkikh <igor.russkikh@aquantia.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index 2a18439b36fbe..137c1de4c6ec0 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -664,6 +664,8 @@ int aq_nic_set_multicast_list(struct aq_nic_s *self, struct net_device *ndev)
 		err = hw_ops->hw_multicast_list_set(self->aq_hw,
 						    self->mc_list.ar,
 						    self->mc_list.count);
+		if (err < 0)
+			return err;
 	}
 	return aq_nic_set_packet_filter(self, packet_filter);
 }
-- 
2.20.1


Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268BDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACCF2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504759;
	bh=gAl9xkksE6tJTEt64xFOKwL2z33z5AD833ugLXHdCwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g+O0WhudKmupQfQIT8p/AW9zPbtUh5Rd7/velrZ+7R3y376GGC2fM48ZT7Hvc8zY3
	 OR3v7SZ+UYtIqK7LGq+i+5P+sPR5+C0pmYuO+oNop/j7kAHHA8l0tOX7or31equR0Q
	 y+fkKwalVWDiNDlpQ9N1kYa8VctAOlfpHqEhjgbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbfCMTTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:19:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729210AbfCMTTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:19:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46C07217F5;
        Wed, 13 Mar 2019 19:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504753;
        bh=gAl9xkksE6tJTEt64xFOKwL2z33z5AD833ugLXHdCwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K9MWUrKvagSHZcgONm1QbqN4IPPgIVYAK/hG8iD+mbe/W0wW2Vo3wTviV+cVcJ26Z
         HFjkNNVjQ9Kt1bxjCypG6IKiV/sDOl8/x+qQxZ32UyEjbgycL+nBwXAlUfjlf5HzZQ
         fVmCv057oceWuZFRJc7wbc1vi6QRLpKhXxZ4ZVmc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mao Wenan <maowenan@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 10/10] net: set static variable an initial value in atl2_probe()
Date:   Wed, 13 Mar 2019 15:18:46 -0400
Message-Id: <20190313191847.160801-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191847.160801-1-sashal@kernel.org>
References: <20190313191847.160801-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Wenan <maowenan@huawei.com>

[ Upstream commit 4593403fa516a5a4cffe6883c5062d60932cbfbe ]

cards_found is a static variable, but when it enters atl2_probe(),
cards_found is set to zero, the value is not consistent with last probe,
so next behavior is not our expect.

Signed-off-by: Mao Wenan <maowenan@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/atheros/atlx/atl2.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atlx/atl2.c b/drivers/net/ethernet/atheros/atlx/atl2.c
index 5086ec9214c3..ceae4d56105d 100644
--- a/drivers/net/ethernet/atheros/atlx/atl2.c
+++ b/drivers/net/ethernet/atheros/atlx/atl2.c
@@ -1338,13 +1338,11 @@ static int atl2_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct net_device *netdev;
 	struct atl2_adapter *adapter;
-	static int cards_found;
+	static int cards_found = 0;
 	unsigned long mmio_start;
 	int mmio_len;
 	int err;
 
-	cards_found = 0;
-
 	err = pci_enable_device(pdev);
 	if (err)
 		return err;
-- 
2.19.1


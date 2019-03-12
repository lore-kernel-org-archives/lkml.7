Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50307C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF3B21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413481;
	bh=pLOwAcR68iIml+uNFJIimloNeCWE/8elS+IkPDvVWh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jKVwa9bQviz5XVguO2qfiEpo+skgiISw4nQhHud7OtOimwTnqUtpCNZiR0WhuX4Z0
	 Gkb5Y2j4klQbh/S3407NaDXlLD6E6l4Y9Rze+tP6QvaS/unwSg4rNDDkiYyS4yF74L
	 DAtgq+QhqtlJBnIddbz9vgZWWu+OVdr+Mfpyc3W8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfCLR57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:57:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728171AbfCLRN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:58 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14135217F9;
        Tue, 12 Mar 2019 17:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410838;
        bh=pLOwAcR68iIml+uNFJIimloNeCWE/8elS+IkPDvVWh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X5uZMOdEGcO4RKCXcjVSnNdfyCKxNXjoKEXnbtriPkWS9H9z/UFzdiq2vcoWqwCWM
         zekvjaR6hytMCPKWq/kJ3j71sAcEfb964TKFazp/zAMgyazA7LZBWac5wnhXB0j8zE
         7Wpt8Oyy1HCoIZnILqGTK6II9jHjZy3SWizLO3BY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 028/149] net: hns: Fix wrong read accesses via Clause 45 MDIO protocol
Date:   Tue, 12 Mar 2019 10:07:26 -0700
Message-Id: <20190312170352.071759509@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit cec8abba13e6a26729dfed41019720068eeeff2b ]

When reading phy registers via Clause 45 MDIO protocol, after write
address operation, the driver use another write address operation, so
can not read the right value of any phy registers. This patch fixes it.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns_mdio.c b/drivers/net/ethernet/hisilicon/hns_mdio.c
index 017e08452d8c..baf5cc251f32 100644
--- a/drivers/net/ethernet/hisilicon/hns_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns_mdio.c
@@ -321,7 +321,7 @@ static int hns_mdio_read(struct mii_bus *bus, int phy_id, int regnum)
 		}
 
 		hns_mdio_cmd_write(mdio_dev, is_c45,
-				   MDIO_C45_WRITE_ADDR, phy_id, devad);
+				   MDIO_C45_READ, phy_id, devad);
 	}
 
 	/* Step 5: waitting for MDIO_COMMAND_REG 's mdio_start==0,*/
-- 
2.19.1




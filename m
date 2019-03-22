Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9988C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0ABD21939
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256062;
	bh=X6LrMqzVwTHZ1SQQh7aYrXRBBu6dFaXm/IdMnZZ9vk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UfhyZG+aDeL9F2bZjKsGbz88YfsN9skfsG9Ld3b1VWE/T7fXLCEPuTbnIGp/FrjyE
	 3fFGdmcJcUPXffooCoEt49rtZkzjNmpKTXUV3ip/j04sveSV4W4zu2bCgA5lj/wM6n
	 GVJ8oUTzrqThnC716LT6VfxqQ7NzdCHxheUW+EwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388149AbfCVMBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388125AbfCVMA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:00:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 599DB21939;
        Fri, 22 Mar 2019 12:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256055;
        bh=X6LrMqzVwTHZ1SQQh7aYrXRBBu6dFaXm/IdMnZZ9vk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BYcRtPxSvqqMBg0TP5a7sM645guAkMeUzSDFYIqph6epnCK0XpNN79PxcwVyuslOz
         TTZYl+lWkB97hN32epPhXi/yAZxx0j+dvy6iEhv0f1cTvoeWYx8PwhHmUBMZBE5R0C
         fap3LqTxqf75KvWJjDwFXpJlc+eT9GdTabdSNgaw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 095/280] ixgbe: fix older devices that do not support IXGBE_MRQC_L3L4TXSWEN
Date:   Fri, 22 Mar 2019 12:14:08 +0100
Message-Id: <20190322111311.844932359@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

[ Upstream commit 156a67a9065e3339be85f811d1b13b920e50d73b ]

The enabling L3/L4 filtering for transmit switched packets for all
devices caused unforeseen issue on older devices when trying to send UDP
traffic in an ordered sequence.  This bit was originally intended for X550
devices, which supported this feature, so limit the scope of this bit to
only X550 devices.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6cdd58d9d461..410d5d3aa393 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3924,8 +3924,11 @@ static void ixgbe_setup_mrqc(struct ixgbe_adapter *adapter)
 			else
 				mrqc = IXGBE_MRQC_VMDQRSS64EN;
 
-			/* Enable L3/L4 for Tx Switched packets */
-			mrqc |= IXGBE_MRQC_L3L4TXSWEN;
+			/* Enable L3/L4 for Tx Switched packets only for X550,
+			 * older devices do not support this feature
+			 */
+			if (hw->mac.type >= ixgbe_mac_X550)
+				mrqc |= IXGBE_MRQC_L3L4TXSWEN;
 		} else {
 			if (tcs > 4)
 				mrqc = IXGBE_MRQC_RTRSS8TCEN;
-- 
2.19.1




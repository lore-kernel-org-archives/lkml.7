Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437F6C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E272082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255389;
	bh=Wg+vfHT8iP47CZiH5R+uRGEtzazSaOCFThm+36j9Vls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lYQXeXTD60XTJ5WQw26dRlfbw8+svM2QawT7rHJqWqbE7NHlae2f3Yg7fA5o4tLP8
	 wZgLYbODuXd26xTAhHwD3SaLyUX/6/WLMWTgyF2kR5jREFSTTMnWqnWKQqpy3pn6BK
	 QJwAhoHa6ixlGCL+LiyzgMPXfZW12XwdDksqXK5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732533AbfCVLts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:49:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731919AbfCVLtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:49:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2409218B0;
        Fri, 22 Mar 2019 11:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255380;
        bh=Wg+vfHT8iP47CZiH5R+uRGEtzazSaOCFThm+36j9Vls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2DwvrJeFAIVmZfA5akF5SRE52Rlol+1mvlVxebYDc5oy0pVyNHvagATdIhgsxZw+Y
         GSUN5CJQIFLOyqzUCUuV+YBSM5o0v0soQD5o43NkK2/P1fBuz0GXpet6gq749pvTLj
         88MlabqeEJ1qi7aSbytcuzjSUdxONiBw32ffjdT8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 055/183] ixgbe: fix older devices that do not support IXGBE_MRQC_L3L4TXSWEN
Date:   Fri, 22 Mar 2019 12:14:43 +0100
Message-Id: <20190322111245.706321600@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 42183a8b649c..01c120d656c5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3827,8 +3827,11 @@ static void ixgbe_setup_mrqc(struct ixgbe_adapter *adapter)
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




Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC23C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6BE2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810818;
	bh=CQdNOpkCUYS+fJWizHJvurWoB2prYbApk3+vaXeZ2gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lIJEmA1D/jnKVLgVdFoPiKvcSqIQo9AqP0BEMBUdGMaEB9naBOHlqYMY5R7WjzXiC
	 2iSGO8AGtQHdvK7F9fYlLpZzxcdKng2mgh/JA/R5mKBs6WmJGRB3SHXL513Dv89y89
	 1EDSiJY2jDJK+YVsMFf8aarF26/Rl3X2x/UcDIok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfEBP05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:26:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727842AbfEBP0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:26:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0752208C4;
        Thu,  2 May 2019 15:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810813;
        bh=CQdNOpkCUYS+fJWizHJvurWoB2prYbApk3+vaXeZ2gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MysQV+TV/kyz3XIGZ+pT9d7TftMhCwGzu8BMfQaOtnJKwjeLlJcClJRk+Jhk/ZxZm
         lhVzAUQ4HfmlWww8wHuqEcfwmbCkjESdnfPiyEivNE3fr5V5GsB2xk2iLd2CTxij+T
         88otB6bqTQsnUf+4Y9an+oBmgj9DDMHtCDclcB0s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Mukesh Ojha <mojha@codeaurora.org>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.19 38/72] staging: rtlwifi: rtl8822b: fix to avoid potential NULL pointer dereference
Date:   Thu,  2 May 2019 17:21:00 +0200
Message-Id: <20190502143336.551166533@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143333.437607839@linuxfoundation.org>
References: <20190502143333.437607839@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d70d70aec9632679dd00dcc1b1e8b2517e2c7da0 ]

skb allocated via dev_alloc_skb can fail and return a NULL pointer.
This patch avoids such a scenario and returns, consistent with other
invocations.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/staging/rtlwifi/rtl8822be/fw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtlwifi/rtl8822be/fw.c b/drivers/staging/rtlwifi/rtl8822be/fw.c
index a40396614814..c1ed52df05f0 100644
--- a/drivers/staging/rtlwifi/rtl8822be/fw.c
+++ b/drivers/staging/rtlwifi/rtl8822be/fw.c
@@ -741,6 +741,8 @@ void rtl8822be_set_fw_rsvdpagepkt(struct ieee80211_hw *hw, bool b_dl_finished)
 		      u1_rsvd_page_loc, 3);
 
 	skb = dev_alloc_skb(totalpacketlen);
+	if (!skb)
+		return;
 	memcpy((u8 *)skb_put(skb, totalpacketlen), &reserved_page_packet,
 	       totalpacketlen);
 
-- 
2.19.1




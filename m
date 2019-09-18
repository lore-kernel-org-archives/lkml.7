Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEDBC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7CA21906
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568787984;
	bh=X5HjemIiXLWVkG183LNBJtiIeOUi2C7TqNhv2fzM6ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CTNRtgT9CnJsXtF6BPEuHAu6Erh0pVOeWDb16Bc2KyaQVyZVV+8I89mV/n45Q/nXK
	 ZQGU+GvR4shitH+OPzwZ0rliip7J4VIVLRnQEZdF0Uu+vyzRbuMqW70rXka/36WPap
	 dq33yLDrwesuwr6WX3WXOJpfuD1J2fseycP7brS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbfIRG0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:26:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730277AbfIRG0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:26:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A52C20644;
        Wed, 18 Sep 2019 06:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787979;
        bh=X5HjemIiXLWVkG183LNBJtiIeOUi2C7TqNhv2fzM6ec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FiCUFHauaOlJ1tKcPNEXyFtxOUzCa2N6xTRPGeM36p08BrR68Ge9W5zpB1p/uIM1I
         SRLeFQ116MAcjcm11NhFLx5W1jpKwYCq5RVkT4uo9wI1oLi39ylYEikriU/2VubJOi
         49aughbLuJSHtOzbfgtvlmjLA+Z7Dn6Bc4wEF8a8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 5.2 56/85] mt76: Fix a signedness bug in mt7615_add_interface()
Date:   Wed, 18 Sep 2019 08:19:14 +0200
Message-Id: <20190918061235.881763984@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061234.107708857@linuxfoundation.org>
References: <20190918061234.107708857@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit b1571a0e77d8cef14227af293c6dda1464a57270 upstream.

The problem is that "mvif->omac_idx" is a u8 so it can't be negative
and the error handling won't work.  The get_omac_idx() function returns
-1 on error.

Fixes: 04b8e65922f6 ("mt76: add mac80211 driver for MT7615 PCIe-based chipsets")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -77,11 +77,12 @@ static int mt7615_add_interface(struct i
 		goto out;
 	}
 
-	mvif->omac_idx = get_omac_idx(vif->type, dev->omac_mask);
-	if (mvif->omac_idx < 0) {
+	idx = get_omac_idx(vif->type, dev->omac_mask);
+	if (idx < 0) {
 		ret = -ENOSPC;
 		goto out;
 	}
+	mvif->omac_idx = idx;
 
 	/* TODO: DBDC support. Use band 0 and wmm 0 for now */
 	mvif->band_idx = 0;



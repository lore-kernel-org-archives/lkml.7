Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF49EC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73452133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640379;
	bh=5UCojV3+1l9pwyt7QHyOjN9adHUxg59F+wBeuWKbW/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ncXrNuLNUfVYXPsgpsvN92Px2rCf8KcNKdJuOoKcvBCJ98ug95a3IlD+l/5nO/Hux
	 bgLmIZ5YIf+oyxaZcNDgonKhypl/QunzE60cZCPcFhVZ0pPjy9qos2yMGqG5Wi7YDQ
	 Z5I6BS8yQWFalnY06XWWM4tPFxfpqx7y5b4FlTW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390926AbfEWTjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:39:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387582AbfEWTV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:21:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DD792184E;
        Thu, 23 May 2019 19:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639317;
        bh=5UCojV3+1l9pwyt7QHyOjN9adHUxg59F+wBeuWKbW/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MzBxNCUhAbq80RvVBy23BEFwkOX1FqInnYCvhQWNRQPvC4qfA8oB+m81Z2UgFoJtv
         IwxUgbpmpgXzo+JkZh2STawjm5dM40xq3VfnsBRC2vjJMDPj6SC2HI6+9ep5wd3qCS
         vy7ys7qcnsEAT98FpHxDIHzO/X4T0xh7zca2q9TY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 5.0 043/139] phy: ti-pipe3: fix missing bit-wise or operator when assigning val
Date:   Thu, 23 May 2019 21:05:31 +0200
Message-Id: <20190523181726.314759313@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit e6577cb5103b7ca7c0204c0c86ef4af8aa6288f6 upstream.

There seems to be a missing bit-wise or operator when setting val,
fix this by adding it in.

Fixes: 2796ceb0c18a ("phy: ti-pipe3: Update pcie phy settings")
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/phy/ti/phy-ti-pipe3.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/phy/ti/phy-ti-pipe3.c
+++ b/drivers/phy/ti/phy-ti-pipe3.c
@@ -303,7 +303,7 @@ static void ti_pipe3_calibrate(struct ti
 
 	val = ti_pipe3_readl(phy->phy_rx, PCIEPHYRX_ANA_PROGRAMMABILITY);
 	val &= ~(INTERFACE_MASK | LOSD_MASK | MEM_PLLDIV);
-	val = (0x1 << INTERFACE_SHIFT | 0xA << LOSD_SHIFT);
+	val |= (0x1 << INTERFACE_SHIFT | 0xA << LOSD_SHIFT);
 	ti_pipe3_writel(phy->phy_rx, PCIEPHYRX_ANA_PROGRAMMABILITY, val);
 
 	val = ti_pipe3_readl(phy->phy_rx, PCIEPHYRX_DIGITAL_MODES);



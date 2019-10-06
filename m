Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2666C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935C820673
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570384262;
	bh=qbJambDLBU2iCC1IS1jCXXoXh7F8TMycRq4h3giH+D8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VQ5zTGRwfLWpCaF46qCNWttTXTgDhefS73P4dccngzakjZfKffLE4OU9e0OrYmFRk
	 yPK8CYclyywOhkiYfOXUA6n05g+Qx8qGnnpUMpCmX05N3MImdaA2wUQk5b50tAn5D1
	 5L5ziPHoCf2xOD9ob5FFnCvBs7HHyq7clyhvrjX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfJFRvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:51:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727321AbfJFRuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:50:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ECA02087E;
        Sun,  6 Oct 2019 17:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383919;
        bh=qbJambDLBU2iCC1IS1jCXXoXh7F8TMycRq4h3giH+D8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jgXzoPUKmb3HK6NcHyUiM9e4xQKZriUFIrflYM+TJrXHZB3MUuHiotCFqCOLrmiFL
         sTIxfYWm/WxWSSWgqtQnXs2suSK8RDbycbYSkHx+8uhOA0ObPaNpYOc+502kBRsuV4
         GXM6eFMLE/DaafD1+0bqrwzkf+cQXlNIZwjPy0UU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 145/166] net: dsa: rtl8366: Check VLAN ID and not ports
Date:   Sun,  6 Oct 2019 19:21:51 +0200
Message-Id: <20191006171225.179123080@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171212.850660298@linuxfoundation.org>
References: <20191006171212.850660298@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit e8521e53cca584ddf8ec4584d3c550a6c65f88c4 ]

There has been some confusion between the port number and
the VLAN ID in this driver. What we need to check for
validity is the VLAN ID, nothing else.

The current confusion came from assigning a few default
VLANs for default routing and we need to rewrite that
properly.

Instead of checking if the port number is a valid VLAN
ID, check the actual VLAN IDs passed in to the callback
one by one as expected.

Fixes: d8652956cf37 ("net: dsa: realtek-smi: Add Realtek SMI driver")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/rtl8366.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/net/dsa/rtl8366.c
+++ b/drivers/net/dsa/rtl8366.c
@@ -339,10 +339,12 @@ int rtl8366_vlan_prepare(struct dsa_swit
 			 const struct switchdev_obj_port_vlan *vlan)
 {
 	struct realtek_smi *smi = ds->priv;
+	u16 vid;
 	int ret;
 
-	if (!smi->ops->is_vlan_valid(smi, port))
-		return -EINVAL;
+	for (vid = vlan->vid_begin; vid < vlan->vid_end; vid++)
+		if (!smi->ops->is_vlan_valid(smi, vid))
+			return -EINVAL;
 
 	dev_info(smi->dev, "prepare VLANs %04x..%04x\n",
 		 vlan->vid_begin, vlan->vid_end);
@@ -370,8 +372,9 @@ void rtl8366_vlan_add(struct dsa_switch
 	u16 vid;
 	int ret;
 
-	if (!smi->ops->is_vlan_valid(smi, port))
-		return;
+	for (vid = vlan->vid_begin; vid < vlan->vid_end; vid++)
+		if (!smi->ops->is_vlan_valid(smi, vid))
+			return;
 
 	dev_info(smi->dev, "add VLAN on port %d, %s, %s\n",
 		 port,



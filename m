Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC33BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DBD21773
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428937;
	bh=m4IhzfkG4WdTewNI3DALy3vQUl8DeziHc2wi2kspGA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L2TqmYc1QDCmhPm48SgFrnnzBJqOgtoaf4HLEYezzSwbFh0NGedI7ENgnS4WfoLfF
	 uIfiufH/BmLZe2L14T9JjBXIVP2LY2g2/PFxoSK3LXsNeVpezIdgVfZQMLn6MbM3Rv
	 51YpfyGVKxHV5VWz7T8p8hR9lihOpKJ64sQ+fX20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbfG2Tff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729229AbfG2Tfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:35:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3167D2171F;
        Mon, 29 Jul 2019 19:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428930;
        bh=m4IhzfkG4WdTewNI3DALy3vQUl8DeziHc2wi2kspGA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hTu4BVLfBMHKL26QabTZrWc5jTplOstZiXKfg9P0O+XfSfY/Y47XdjZqfFoa29MsF
         IkZbCxJ3B850d5LTn+vn9Yn8aZDsXWPhq4KQ7WmxVmh16EKDbWtLSLN0Z870oa5S+M
         YVWlipFjhHfejiQ2OpfE/GJQn++7dHkkTUBtpoMQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        "David S. Miller" <davem@davemloft.net>,
        Marcus Seyfarth <m.seyfarth@gmail.com>
Subject: [PATCH 4.14 192/293] sky2: Disable MSI on ASUS P6T
Date:   Mon, 29 Jul 2019 21:21:23 +0200
Message-Id: <20190729190839.179636066@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit a261e3797506bd561700be643fe1a85bf81e9661 ]

The onboard sky2 NIC on ASUS P6T WS PRO doesn't work after PM resume
due to the infamous IRQ problem.  Disabling MSI works around it, so
let's add it to the blacklist.

Unfortunately the BIOS on the machine doesn't fill the standard
DMI_SYS_* entry, so we pick up DMI_BOARD_* entries instead.

BugLink: https://bugzilla.suse.com/show_bug.cgi?id=1142496
Reported-and-tested-by: Marcus Seyfarth <m.seyfarth@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/sky2.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -4947,6 +4947,13 @@ static const struct dmi_system_id msi_bl
 			DMI_MATCH(DMI_PRODUCT_NAME, "P-79"),
 		},
 	},
+	{
+		.ident = "ASUS P6T",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "P6T"),
+		},
+	},
 	{}
 };
 



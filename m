Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE096C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8900205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564154976;
	bh=iBSRzCIoJ+ShBskL/2vbRiaxpojvCljOleIl0m5Q5iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BVkZ1O3qL5JuiI7HZg/hqCVRpu57ZUW4Tri1s3sDFUuIwIPoXhEOXWZvCIhID9Qsh
	 QrcAIyB5cx7LY7wMkR3bMGd4/1Hmm9K7HM8C3NG5F4qTLavnZ2Sp9c6mXk9FrAyZKh
	 mcH49R6dD9tytZsRr0CiYAxotRdnMQcXlJ+tTpOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388858AbfGZP3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:29:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388842AbfGZP3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:29:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 852AB218D4;
        Fri, 26 Jul 2019 15:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564154973;
        bh=iBSRzCIoJ+ShBskL/2vbRiaxpojvCljOleIl0m5Q5iw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lq2JSOGHgXQefg1Rqy9xk8xZwnYu5EXTPsvdjqv/Qqc3IF+temUTox85W/yZ5vxIF
         vTiauhtraFtqeTO6gvQ3xqyCD1zSPWvIIEklRqhpNAT1ABPmphdtWLpEfM2ffTmMes
         3rM6+4WDq1YWpFy2C2R8Rd+U84jpRq7/Q6psCBus=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        "David S. Miller" <davem@davemloft.net>,
        Marcus Seyfarth <m.seyfarth@gmail.com>
Subject: [PATCH 5.1 22/62] sky2: Disable MSI on ASUS P6T
Date:   Fri, 26 Jul 2019 17:24:34 +0200
Message-Id: <20190726152304.021048612@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152301.720139286@linuxfoundation.org>
References: <20190726152301.720139286@linuxfoundation.org>
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
@@ -4933,6 +4933,13 @@ static const struct dmi_system_id msi_bl
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
 



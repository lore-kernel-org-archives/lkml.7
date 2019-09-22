Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10840C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36C721BE5
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569178704;
	bh=cn6NzZ9VbJI2M0TVHdR5+d1pVaa64iCqsLuPxdNrJMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=In+iDXwJMGcocSelxHc6EOWlKWf7+PIRggDD1ogfcUbyZkJAHALpvt64L6y0vkwzG
	 GJac1qvRpC058/VhXFqJhc/Y7+iQh0x/AFQMvb6nEjwSB5R3e8rAKWGthOIu7mJtBS
	 eQ13DQQTa9saLbl0wk6Tqpr9ErCs4CD54+o/0xdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438774AbfIVS6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:58:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405384AbfIVS6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:58:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D694C208C2;
        Sun, 22 Sep 2019 18:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178696;
        bh=cn6NzZ9VbJI2M0TVHdR5+d1pVaa64iCqsLuPxdNrJMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AR/pHhnUJZFQZJuU10Q4zXTm91VfzMymuNDCndjNmhU23puLDSzjZ/QP/x6Dx5sYp
         YOsXvOyZezPVkBhCZeSlCSgcpniKcxFFkcrbfMmpw9YT5OR+gnefWxViWMoporecKd
         hutPoSqIrybOa8Wo1OV6k3a4D4lTxezR9I5EyO5o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Darius Rad <alpha@area49.net>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 36/89] media: rc: imon: Allow iMON RC protocol for ffdc 7e device
Date:   Sun, 22 Sep 2019 14:56:24 -0400
Message-Id: <20190922185717.3412-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185717.3412-1-sashal@kernel.org>
References: <20190922185717.3412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Darius Rad <alpha@area49.net>

[ Upstream commit b20a6e298bcb8cb8ae18de26baaf462a6418515b ]

Allow selecting the IR protocol, MCE or iMON, for a device that
identifies as follows (with config id 0x7e):

15c2:ffdc SoundGraph Inc. iMON PAD Remote Controller

As the driver is structured to default to iMON when both RC
protocols are supported, existing users of this device (using MCE
protocol) will need to manually switch to MCE (RC-6) protocol from
userspace (with ir-keytable, sysfs).

Signed-off-by: Darius Rad <alpha@area49.net>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/imon.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index 0c46155a8e9da..a7547c88e4c36 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -1963,12 +1963,17 @@ static void imon_get_ffdc_type(struct imon_context *ictx)
 		break;
 	/* iMON VFD, MCE IR */
 	case 0x46:
-	case 0x7e:
 	case 0x9e:
 		dev_info(ictx->dev, "0xffdc iMON VFD, MCE IR");
 		detected_display_type = IMON_DISPLAY_TYPE_VFD;
 		allowed_protos = RC_PROTO_BIT_RC6_MCE;
 		break;
+	/* iMON VFD, iMON or MCE IR */
+	case 0x7e:
+		dev_info(ictx->dev, "0xffdc iMON VFD, iMON or MCE IR");
+		detected_display_type = IMON_DISPLAY_TYPE_VFD;
+		allowed_protos |= RC_PROTO_BIT_RC6_MCE;
+		break;
 	/* iMON LCD, MCE IR */
 	case 0x9f:
 		dev_info(ictx->dev, "0xffdc iMON LCD, MCE IR");
-- 
2.20.1


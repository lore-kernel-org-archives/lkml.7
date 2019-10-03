Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32113C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10672133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570120111;
	bh=/gOo4WZ1NVLy14zDedgsXiyLcv0A5qENps5nn1jtGQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cyz0Gn/+to10X/F3zHSyOehat9ALiSS9kqCTFPtE/RQrfEViLdG2ssI2tJgKm7Yyk
	 LCiX9mmP3/eZe/I1GRhhHU/2wDXv0zbDC5+Liz6BmRQEGwRETFb8dZ7U8iA9kWcUgJ
	 nK3tblFki1GFhbERYuhX2DEeAy8gpuaX4LIXoMag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389281AbfJCQ2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:28:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:32818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403773AbfJCQ21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:28:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07F162133F;
        Thu,  3 Oct 2019 16:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120106;
        bh=/gOo4WZ1NVLy14zDedgsXiyLcv0A5qENps5nn1jtGQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wgz95fSoGQmFwYcrNPnpqOVVDqUtIGjKLCbMTY6P9Qpdp/YH+/V/ZsqV0V8KY6cUo
         qOsnHyhyktuSy34rn4Lg3xeZyIX+m7CZ66RDvrdee6AHO7QjUfWeLPKlRz86z0Dz2P
         9Zcc2ItJ7fiODVzH9KPOzgE2z/zx/muSiUYBS110=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Darius Rad <alpha@area49.net>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 099/313] media: rc: imon: Allow iMON RC protocol for ffdc 7e device
Date:   Thu,  3 Oct 2019 17:51:17 +0200
Message-Id: <20191003154542.652742163@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 7bee72108b0ee..37a850421fbb1 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -1826,12 +1826,17 @@ static void imon_get_ffdc_type(struct imon_context *ictx)
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




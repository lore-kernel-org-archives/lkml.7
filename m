Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4390CC33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 01:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104AD206F0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 01:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578533062;
	bh=esilB2jyCEeS86+aLik9ERl3MCThLWMAf+D0AkfvAL0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Fwd0NYjHrispUh2Vu2BwpjJuQnLW5Q1nE6UGooRIvvLkSqGYz+M4YBBYo9XUEk66N
	 kPw97psEJVhduF8VobgE5rO51ly5TeFG1rlF2UE4g5/o00TpKnu4DuphADetfsC1fw
	 csjNSBh6V/z9SSPciHaP6y7Ww4RdrUe4YxBC0XGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgAIBYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 20:24:21 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:41362 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgAIBYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 20:24:19 -0500
Received: by mail-il1-f193.google.com with SMTP id f10so4327008ils.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 17:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AMPCgfhYpkQsCR1AO9dd0olR/i2MlbInfz4p8Kv9IWo=;
        b=R/EXnxd7TYiBp282XyZUPt74a3/d2V9Qj23iI1WuH2TiexckftNvr9Vf3Cao8Fv+Z0
         8j7T1Jj30JV0gbPII3ET85dpB1jrj65n2LJYqOuC7v82cMHasa5S1US5R7PBZp41UxVR
         W/MWFi8Di4SllFzb4UQurKQy+mzXiCvIXpCL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AMPCgfhYpkQsCR1AO9dd0olR/i2MlbInfz4p8Kv9IWo=;
        b=pIVYEdjms1XoCP2WLzIGz1LE0w8mw984AdlL6G1R/iYU7WyYm0R5gHpmEoiPTDcDSe
         EB0PkhJ4dLdAZKO+OknjycU0ir0zW2SeewCCcLOF5QgVxOjCcVTp5fXEo7ca+f7ZYerx
         U2T/19kAqPxKpFEpIgDvFupTTWfamXsc6vrfbMILsgKn450WhUyfjHI4ORTw7LvOywIe
         bUnNDhh58V7tS2mArDhJs7U6shSH+6BM9Sv18FqvkAnrsMuKl3HDtewnGz9St3Bm8h4l
         EEOOIiCbO8ZC7FT6u33xEUyWM4pHUVdNBr6QWnVffCvy3KigZ/pcIqumAAYKn3zj3+Px
         dgVQ==
X-Gm-Message-State: APjAAAUAuerlC8FnvL9zRPs6qfutNWw4t4VZdYmAGFXFml99oA/TtlF6
        K+r0vnp508f2olBiXBq8csmD7w==
X-Google-Smtp-Source: APXvYqzZUDf0qM6THtQFqkUmJ+hON9CVGL04q0NPXTYtb1FD3B4zT3Alm4Bp0cHoKQWrCfMbSm2fPg==
X-Received: by 2002:a92:8309:: with SMTP id f9mr6764319ild.50.1578533058782;
        Wed, 08 Jan 2020 17:24:18 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r14sm1504357ilg.59.2020.01.08.17.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 17:24:18 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     valentina.manea.m@gmail.com, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usbip: Fix unsafe unaligned pointer usage
Date:   Wed,  8 Jan 2020 18:24:16 -0700
Message-Id: <20200109012416.2875-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix unsafe unaligned pointer usage in usbip network interfaces. usbip tool
build fails with new gcc -Werror=address-of-packed-member checks.

usbip_network.c: In function ‘usbip_net_pack_usb_device’:
usbip_network.c:79:32: error: taking address of packed member of ‘struct usbip_usb_device’ may result in an unaligned pointer value [-Werror=address-of-packed-member]
   79 |  usbip_net_pack_uint32_t(pack, &udev->busnum);

Fix with minor changes to pass by value instead of by address.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/usb/usbip/src/usbip_network.c | 40 +++++++++++++++++------------
 tools/usb/usbip/src/usbip_network.h | 12 +++------
 2 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/tools/usb/usbip/src/usbip_network.c b/tools/usb/usbip/src/usbip_network.c
index d595d72693fb..ed4dc8c14269 100644
--- a/tools/usb/usbip/src/usbip_network.c
+++ b/tools/usb/usbip/src/usbip_network.c
@@ -50,39 +50,39 @@ void usbip_setup_port_number(char *arg)
 	info("using port %d (\"%s\")", usbip_port, usbip_port_string);
 }
 
-void usbip_net_pack_uint32_t(int pack, uint32_t *num)
+uint32_t usbip_net_pack_uint32_t(int pack, uint32_t num)
 {
 	uint32_t i;
 
 	if (pack)
-		i = htonl(*num);
+		i = htonl(num);
 	else
-		i = ntohl(*num);
+		i = ntohl(num);
 
-	*num = i;
+	return i;
 }
 
-void usbip_net_pack_uint16_t(int pack, uint16_t *num)
+uint16_t usbip_net_pack_uint16_t(int pack, uint16_t num)
 {
 	uint16_t i;
 
 	if (pack)
-		i = htons(*num);
+		i = htons(num);
 	else
-		i = ntohs(*num);
+		i = ntohs(num);
 
-	*num = i;
+	return i;
 }
 
 void usbip_net_pack_usb_device(int pack, struct usbip_usb_device *udev)
 {
-	usbip_net_pack_uint32_t(pack, &udev->busnum);
-	usbip_net_pack_uint32_t(pack, &udev->devnum);
-	usbip_net_pack_uint32_t(pack, &udev->speed);
+	udev->busnum = usbip_net_pack_uint32_t(pack, udev->busnum);
+	udev->devnum = usbip_net_pack_uint32_t(pack, udev->devnum);
+	udev->speed = usbip_net_pack_uint32_t(pack, udev->speed);
 
-	usbip_net_pack_uint16_t(pack, &udev->idVendor);
-	usbip_net_pack_uint16_t(pack, &udev->idProduct);
-	usbip_net_pack_uint16_t(pack, &udev->bcdDevice);
+	udev->idVendor = usbip_net_pack_uint16_t(pack, udev->idVendor);
+	udev->idProduct = usbip_net_pack_uint16_t(pack, udev->idProduct);
+	udev->bcdDevice = usbip_net_pack_uint16_t(pack, udev->bcdDevice);
 }
 
 void usbip_net_pack_usb_interface(int pack __attribute__((unused)),
@@ -129,6 +129,14 @@ ssize_t usbip_net_send(int sockfd, void *buff, size_t bufflen)
 	return usbip_net_xmit(sockfd, buff, bufflen, 1);
 }
 
+static inline void usbip_net_pack_op_common(int pack,
+					    struct op_common *op_common)
+{
+	op_common->version = usbip_net_pack_uint16_t(pack, op_common->version);
+	op_common->code = usbip_net_pack_uint16_t(pack, op_common->code);
+	op_common->status = usbip_net_pack_uint32_t(pack, op_common->status);
+}
+
 int usbip_net_send_op_common(int sockfd, uint32_t code, uint32_t status)
 {
 	struct op_common op_common;
@@ -140,7 +148,7 @@ int usbip_net_send_op_common(int sockfd, uint32_t code, uint32_t status)
 	op_common.code    = code;
 	op_common.status  = status;
 
-	PACK_OP_COMMON(1, &op_common);
+	usbip_net_pack_op_common(1, &op_common);
 
 	rc = usbip_net_send(sockfd, &op_common, sizeof(op_common));
 	if (rc < 0) {
@@ -164,7 +172,7 @@ int usbip_net_recv_op_common(int sockfd, uint16_t *code, int *status)
 		goto err;
 	}
 
-	PACK_OP_COMMON(0, &op_common);
+	usbip_net_pack_op_common(0, &op_common);
 
 	if (op_common.version != USBIP_VERSION) {
 		err("USBIP Kernel and tool version mismatch: %d %d:",
diff --git a/tools/usb/usbip/src/usbip_network.h b/tools/usb/usbip/src/usbip_network.h
index 555215eae43e..83b4c5344f72 100644
--- a/tools/usb/usbip/src/usbip_network.h
+++ b/tools/usb/usbip/src/usbip_network.h
@@ -32,12 +32,6 @@ struct op_common {
 
 } __attribute__((packed));
 
-#define PACK_OP_COMMON(pack, op_common)  do {\
-	usbip_net_pack_uint16_t(pack, &(op_common)->version);\
-	usbip_net_pack_uint16_t(pack, &(op_common)->code);\
-	usbip_net_pack_uint32_t(pack, &(op_common)->status);\
-} while (0)
-
 /* ---------------------------------------------------------------------- */
 /* Dummy Code */
 #define OP_UNSPEC	0x00
@@ -163,11 +157,11 @@ struct op_devlist_reply_extra {
 } while (0)
 
 #define PACK_OP_DEVLIST_REPLY(pack, reply)  do {\
-	usbip_net_pack_uint32_t(pack, &(reply)->ndev);\
+	(reply)->ndev = usbip_net_pack_uint32_t(pack, (reply)->ndev);\
 } while (0)
 
-void usbip_net_pack_uint32_t(int pack, uint32_t *num);
-void usbip_net_pack_uint16_t(int pack, uint16_t *num);
+uint32_t usbip_net_pack_uint32_t(int pack, uint32_t num);
+uint16_t usbip_net_pack_uint16_t(int pack, uint16_t num);
 void usbip_net_pack_usb_device(int pack, struct usbip_usb_device *udev);
 void usbip_net_pack_usb_interface(int pack, struct usbip_usb_interface *uinf);
 
-- 
2.20.1


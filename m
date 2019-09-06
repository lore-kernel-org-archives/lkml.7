Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B31C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 02:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5ED52070C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 02:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhFHj1wO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403838AbfIFCgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 22:36:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34407 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391988AbfIFCgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 22:36:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so2597417pgc.1;
        Thu, 05 Sep 2019 19:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ePXAwP/rNBu3eb2hTDPp8xoweMPxOufZFxZtTEYoIiM=;
        b=KhFHj1wOs6NfxYaU6KE5WVurkHI8yrh+fF6wgCdTTbo6+qJyCGcFM1Z8rV18BOwJrn
         Mc3fKxq35i6gEHwZ08mYp9CM9NVWh5iGPe0mFngbJq0+7lSyP73cVsjSmWHKu4yn4FbC
         +1UXBDj1A5wjmAedQqkWYYQFBBdXDerNTTd6jWjw6zqZGYZxqszRxLLabOMfGgX97lP7
         1NrKumt6bPoWW8G70PBpw1BGFYRDghfyRHvYjJedm4lF5liKt8p+WmpoDWmWP1W6ApCy
         0yDqF56tKhkM8uyV29eGuHJ6TiVuhFmrW8AbrNsL6duZjUqxgqZ/fXp78jMSYfKzgd9z
         TGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ePXAwP/rNBu3eb2hTDPp8xoweMPxOufZFxZtTEYoIiM=;
        b=XUPLMdxyQs9/87WKzvlYkFhrioQqmRA8Vk4ZkQmhlQLe2ynKmLcBhPD4diR9EBCl0+
         EpTc3bHrITHHhjF5eftAIUKxGVnvIlRW9RnYgvtHcMD4Ny/Nbu7NPDtQCGn6N4nveUE0
         AwHR/9w9d7lULJ8H58ztXQRxJy1Fe+Pr1wqq70seruuXqDulX08QdloeHHIBXjLckwqV
         vy0wBMshdMTkxJ3faJGFcRMnxOgjkAjd+ktzGRZE6KiCtecVRBOFpIwlLC8eX0ZR86nY
         wCyHhLEp5J5IAioVuyHFLSbcm+cgRBWR3karuoNmIfDMo5EA4l/6KepnBi+rr7Q5VaX4
         2imA==
X-Gm-Message-State: APjAAAXQWjR3JyBEbKTbfVjCvHDhzBdyvLc6fQWpq6oYF6QXIC4XZhwr
        FahwRdJjnHDkvJ9oCZ/BVRQ=
X-Google-Smtp-Source: APXvYqxwDwOBTZ0IPGMkUTK6wkUJwtjxOeDa2nQtaWm5wQqr0Uo79ddmcGaajBceJMjFJwy/Ai5W1A==
X-Received: by 2002:a65:690b:: with SMTP id s11mr5953189pgq.10.1567737407258;
        Thu, 05 Sep 2019 19:36:47 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id v7sm4035747pff.87.2019.09.05.19.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 19:36:46 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Florian Dollinger <dollinger.florian@gmx.de>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2] Bluetooth: Retry configure request if result is L2CAP_CONF_UNKNOWN
Date:   Thu,  5 Sep 2019 19:36:01 -0700
Message-Id: <20190906023601.4378-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to:

 * Current implementation of l2cap_config_rsp() dropping BT
   connection if sender of configuration response replied with unknown
   option failure (Result=0x0003/L2CAP_CONF_UNKNOWN)

 * Current implementation of l2cap_build_conf_req() adding
   L2CAP_CONF_RFC(0x04) option to initial configure request sent by
   the Linux host.

devices that do no recongninze L2CAP_CONF_RFC, such as Xbox One S
controllers, will get stuck in endless connect -> configure ->
disconnect loop, never connect and be generaly unusable.

To avoid this problem add code to do the following:

 1. Parse the body of response L2CAP_CONF_UNKNOWN and, in case of
    unsupported option being RFC, clear L2CAP_FEAT_ERTM and
    L2CAP_FEAT_STREAMING from connection's feature mask (in order to
    prevent RFC option from being added going forward)

 2. Retry configuration step the same way it's done for
    L2CAP_CONF_UNACCEPT

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
Cc: Florian Dollinger <dollinger.florian@gmx.de>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---

Changes since [v1]:

   - Patch simplified to simply clear L2CAP_FEAT_ERTM |
     L2CAP_FEAT_STREAMING from feat_mask when device flags RFC options
     as unknown

[v1] lore.kernel.org/r/20190208025828.30901-1-andrew.smirnov@gmail.com

 net/bluetooth/l2cap_core.c | 58 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index dfc1edb168b7..77b65870b064 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4216,6 +4216,49 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 	return err;
 }
 
+static inline int l2cap_config_rsp_unknown(struct l2cap_conn *conn,
+					   struct l2cap_chan *chan,
+					   const u8 *data,
+					   int len)
+{
+	char req[64];
+
+	if (!len || len > sizeof(req) -  sizeof(struct l2cap_conf_req))
+		return -ECONNRESET;
+
+	while (len--) {
+		const u8 option_type = *data++;
+
+		BT_DBG("chan %p, unknown option type: %u", chan,  option_type);
+
+		/* "...Hints shall not be included in the Response and
+		 * shall not be the sole cause for rejecting the
+		 * Request.."
+		 */
+		if (option_type & L2CAP_CONF_HINT)
+			return -ECONNRESET;
+
+		switch (option_type) {
+		case L2CAP_CONF_RFC:
+			/* Clearing the following feature should
+			 * prevent RFC option from being added next
+			 * connection attempt
+			 */
+			conn->feat_mask &= ~(L2CAP_FEAT_ERTM |
+					     L2CAP_FEAT_STREAMING);
+			break;
+		default:
+			return -ECONNRESET;
+		}
+	}
+
+	len = l2cap_build_conf_req(chan, req, sizeof(req));
+	l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ, len, req);
+	chan->num_conf_req++;
+
+	return 0;
+}
+
 static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 				   struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				   u8 *data)
@@ -4271,6 +4314,21 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 		}
 		goto done;
 
+	case L2CAP_CONF_UNKNOWN:
+		if (chan->num_conf_rsp <= L2CAP_CONF_MAX_CONF_RSP) {
+			if (l2cap_config_rsp_unknown(conn, chan, rsp->data,
+						     len) < 0) {
+				l2cap_send_disconn_req(chan, ECONNRESET);
+				goto done;
+			}
+			break;
+		}
+		/* Once, chan->num_conf_rsp goes above
+		 * L2CAP_CONF_MAX_CONF_RSP we want to go down all the
+		 * way to default label (just like L2CAP_CONF_UNACCEPT
+		 * below)
+		 */
+		/* fall through */
 	case L2CAP_CONF_UNACCEPT:
 		if (chan->num_conf_rsp <= L2CAP_CONF_MAX_CONF_RSP) {
 			char req[64];
-- 
2.21.0


Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD1DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 01:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A904520857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 01:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L92dHW8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfCRBQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 21:16:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35792 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfCRBQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 21:16:35 -0400
Received: by mail-qt1-f195.google.com with SMTP id h39so16195836qte.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 18:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kdOdw244TmaZ9aBN4WS3R4y1sry8pwY8DUX8wbtQ98c=;
        b=L92dHW8F7yo5e9qDvvkBzhIbQTzEoA02ESYTDlZqMlP2jyY5crQ0lQVJwi0I9gIVip
         DNb+svlFYQrckBloXG1nmKgpP4GJTsfmsGTpFbtWu6mQz4rGaFC9OU9FHN5+MTCotNTk
         2YEKgEVV0q2ntAhFDaXxUn9dAo/OFYC7JQ19u+e8CLHIbZ65zcAZr5n8c88jKbwc3vc7
         cPU9h5ydTvoUY9tc2FRLNpJjD1qqPG8lx00+JhBdJ3i0ucuZ7LWH+8d707B1F7fOzE9+
         Gn09ti2XH8S1jLSNFT9q+CSZVJn8XscsXi2uDaVAV02+WbVCtMpz/F6mUiZezUgtTpdX
         Hv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kdOdw244TmaZ9aBN4WS3R4y1sry8pwY8DUX8wbtQ98c=;
        b=iBTU3mvUUrEBNKUMhiR5KoJf05mjAd/Rc2OfC0P6jTajzkxiliX72uPMY9JaJeuqzF
         jsJ8RE2rYPwX4h5bwrFebnO919pmWYMOJ7qxaK3LKobo4vp07ToNBVXlEphdbS+w+Ji+
         vikzx9V9VNxJS8Fpg6q7rTLRsHzl4Gp0i9Cnho7+TyDbIVq5TURo8F4mz4xbl9wYK/Me
         cWhDLgVl28SCpGakFBoYLS8Ya9OFKCE6NAQ7FeFwr3ccvgdIOtJomOSkDBC46AoGB63S
         5tpjXBs/kEpbdbyOXeGukClg0EQGXnVYx4d64eDTTPw2I2NlI2Jh5+NjOC/wL/pwMCIH
         U6cw==
X-Gm-Message-State: APjAAAUq46PUlkgyIniH9isx4KLt0PBzFO+X4E0T3J92/WO5+b7RFZr3
        iU/dZiwT97nrajW+8Q7Jh+c=
X-Google-Smtp-Source: APXvYqyR1zRa7KrTIhHdqUv0yWDuEkICRvVr/50dXzl9lNzLo1UlTJgrhqe7NoEbZvvAK7qyF+58+Q==
X-Received: by 2002:a0c:d6c9:: with SMTP id l9mr11098266qvi.58.1552871794134;
        Sun, 17 Mar 2019 18:16:34 -0700 (PDT)
Received: from localhost.localdomain ([190.19.63.64])
        by smtp.gmail.com with ESMTPSA id x29sm5564245qtm.74.2019.03.17.18.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 18:16:33 -0700 (PDT)
From:   Ignacio Losiggio <iglosiggio@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Ignacio Losiggio <iglosiggio@gmail.com>,
        Ignacio Losiggio <iglosiggio@dc.uba.ar>
Subject: [PATCH v2 1/2] staging: gdm724x: Clean long function calls
Date:   Sun, 17 Mar 2019 22:15:34 -0300
Message-Id: <20190318011534.7400-1-iglosiggio@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ignacio Losiggio <iglosiggio@dc.uba.ar>
---
 drivers/staging/gdm724x/gdm_mux.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_mux.c b/drivers/staging/gdm724x/gdm_mux.c
index e2a050ba6fbb..fa8585ea1572 100644
--- a/drivers/staging/gdm724x/gdm_mux.c
+++ b/drivers/staging/gdm724x/gdm_mux.c
@@ -177,12 +177,8 @@ static int up_to_host(struct mux_rx *r)
 			break;
 		}
 
-		ret = r->callback(mux_header->data,
-				payload_size,
-				index,
-				mux_dev->tty_dev,
-				RECV_PACKET_PROCESS_CONTINUE
-				);
+		ret = r->callback(mux_header->data, payload_size, index,
+				  mux_dev->tty_dev, RECV_PACKET_PROCESS_CONTINUE);
 		if (ret == TO_HOST_BUFFER_REQUEST_FAIL) {
 			r->offset += packet_size_sum;
 			break;
@@ -190,12 +186,8 @@ static int up_to_host(struct mux_rx *r)
 
 		packet_size_sum += total_len;
 		if (len - packet_size_sum <= MUX_HEADER_SIZE + 2) {
-			ret = r->callback(NULL,
-					0,
-					index,
-					mux_dev->tty_dev,
-					RECV_PACKET_PROCESS_COMPLETE
-					);
+			ret = r->callback(NULL, 0, index, mux_dev->tty_dev,
+					  RECV_PACKET_PROCESS_COMPLETE);
 			break;
 		}
 	}
@@ -410,16 +402,8 @@ static int gdm_mux_send_control(void *priv_dev, int request, int value,
 	struct usb_device *usbdev = mux_dev->usbdev;
 	int ret;
 
-	ret = usb_control_msg(usbdev,
-			      usb_sndctrlpipe(usbdev, 0),
-			      request,
-			      USB_RT_ACM,
-			      value,
-			      2,
-			      buf,
-			      len,
-			      5000
-			     );
+	ret = usb_control_msg(usbdev, usb_sndctrlpipe(usbdev, 0), request,
+			      USB_RT_ACM, value, 2, buf, len, 5000);
 
 	if (ret < 0)
 		pr_err("usb_control_msg error: %d\n", ret);
-- 
2.21.0


Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F22CC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DD8222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dUHt+jCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbfJDVoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:44:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39815 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfJDVnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:43:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id e1so4484396pgj.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 14:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kKHG7UTsDPcnCMtVxGV72BXVFFtNiiXVrgsu7N6vxI4=;
        b=dUHt+jCIixU+I2Q5iiGOtz5ZLigFhCMop4kFDCvfXwqMApUQHan0clusE1HE9LZPTr
         kTm1Sf08Dy/4mnp5fIxaCLIYm1CtgcsETkD0e/um/x2SznUJ3BMRFDDQ19Ps0nYJOPri
         f6gEqnwUOTN2RyHZ8d+g5Am+X+uP4NhdPdb68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kKHG7UTsDPcnCMtVxGV72BXVFFtNiiXVrgsu7N6vxI4=;
        b=CKNVQo7C6ciu2xza7DjL1FbB4+T1wV7e9TMCtHNAnYfqnmqOxWn9ck3gbP34R3GBKn
         Ecj7pSszeycCjbPjlv9NMvJH2MuQ+3YRPN40gw31PUlhx2p8rz4yVhCRWgk09RCjm2f8
         s5E3+cqxbFJ5CSshHVDo2K5gr2NRsu2jdVKfSx7WUH54/0WmwRZUCI+Pjb863H0M1OAs
         WyvvHLBaH9wYPUb+9mYHIB12PQ7xJJXxFR5s75udygu7MsT20OQ6i8jVqavJQxbjm4Fz
         D6TKZaAy2dj2LYKFmxN2o5d13i5Re/d06Up8L1sbOC3MVywLemgBGi2DrjqAYe5X55mY
         T5lw==
X-Gm-Message-State: APjAAAXFzGkEjWzAnJ8Z/w41fkORKpN/4Ccvc242pynbmFeLO2lYBBIF
        0jJ3s0TpfMsxay/VwLdPrh6d2ixlhc4=
X-Google-Smtp-Source: APXvYqxRakS5XLryNdBetTMDUVY49wiIkkoe+7l2+YKQd+NSkcecQAoD98r+dwCVJDzmBco1sQvNuA==
X-Received: by 2002:a65:4686:: with SMTP id h6mr18021406pgr.212.1570225422072;
        Fri, 04 Oct 2019 14:43:42 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a11sm10446799pfg.94.2019.10.04.14.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 14:43:41 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Leitner <richard.leitner@skidata.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH 06/10] usb: usb251xb: Use of_device_get_match_data()
Date:   Fri,  4 Oct 2019 14:43:30 -0700
Message-Id: <20191004214334.149976-7-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
In-Reply-To: <20191004214334.149976-1-swboyd@chromium.org>
References: <20191004214334.149976-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the more modern API here instead of using of_match_device() and
avoid casting away const from the returned pointer by pushing the const
type through to the users. This nicely avoids referencing the match
table when it is undefined with configurations where CONFIG_OF=n and
avoids const issues.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Leitner <richard.leitner@skidata.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: <linux-usb@vger.kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please ack or pick for immediate merge so the last patch can be merged.

 drivers/usb/misc/usb251xb.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
index 6ca9111d150a..84f218a6843c 100644
--- a/drivers/usb/misc/usb251xb.c
+++ b/drivers/usb/misc/usb251xb.c
@@ -392,7 +392,7 @@ static void usb251xb_get_ports_field(struct usb251xb *hub,
 }
 
 static int usb251xb_get_ofdata(struct usb251xb *hub,
-			       struct usb251xb_data *data)
+			       const struct usb251xb_data *data)
 {
 	struct device *dev = hub->dev;
 	struct device_node *np = dev->of_node;
@@ -623,7 +623,7 @@ static const struct of_device_id usb251xb_of_match[] = {
 MODULE_DEVICE_TABLE(of, usb251xb_of_match);
 #else /* CONFIG_OF */
 static int usb251xb_get_ofdata(struct usb251xb *hub,
-			       struct usb251xb_data *data)
+			       const struct usb251xb_data *data)
 {
 	return 0;
 }
@@ -633,13 +633,11 @@ static int usb251xb_probe(struct usb251xb *hub)
 {
 	struct device *dev = hub->dev;
 	struct device_node *np = dev->of_node;
-	const struct of_device_id *of_id = of_match_device(usb251xb_of_match,
-							   dev);
+	const struct usb251xb_data *usb_data = of_device_get_match_data(dev);
 	int err;
 
-	if (np && of_id) {
-		err = usb251xb_get_ofdata(hub,
-					  (struct usb251xb_data *)of_id->data);
+	if (np && usb_data) {
+		err = usb251xb_get_ofdata(hub, usb_data);
 		if (err) {
 			dev_err(dev, "failed to get ofdata: %d\n", err);
 			return err;
-- 
Sent by a computer through tubes


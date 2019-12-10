Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF15C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A52920663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575977607;
	bh=lPiY+5yRrktmZ5oorkNKEb1I/fGjcTmLEn0mPG12tQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rT6OpEdKgK4m+rXPhXi3WU4Qdtupmk1c5glw4v71WkYZZTlGEJSuwRPFM5RrBk2Qi
	 Z/mKiqzpLRy6He/oZBbOhG/gRdwKN1PPMgs+QBUyfclfLBMEV+/TtsDcWc3W4gOfIh
	 MvDAeCmt7e+hkB74nNmuG/NwBQVvzdXCIhXtDdLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfLJLd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:33:26 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36124 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfLJLdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:33:13 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so19497582ljg.3;
        Tue, 10 Dec 2019 03:33:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sdMg7GZD86BDFhOalPKQ8m9kUAj6L4CkdcJA8F5jSmg=;
        b=fUDjACyVVa4QFiYFRAVdimnvGoPWdYxNl1mUgggPQkwJMGkPkTkGJPd8k2hWT33DYD
         KfOJ7/anhA6WRwXG2Vtc+mSUbMLjrcN6kXfOLy6MUIzjlpFcK3nF+qiZ/SJdX+zR8EBw
         vr9+SSV9Cv+Q7yHcj9UqgxrjRVB0igEYO/5i+fRFJK0yuPtAh3WxxN51bk47BOOyrJtt
         lYXUUnEInLYpZqzj1AAOfgv1KeMp7vN6oXf/5mU4QW7XCy+Bn3X/+joopNhcw+xy7uGt
         lB171MMuEeyeKYVnqd+F7WzJ4AxiZ/UYiEzv/AJLEbzcgaYPl8qw2HILBXPa71xBs+3z
         wRVA==
X-Gm-Message-State: APjAAAVOfJrtZD+edOQNLzMnvSn50msfe+mHVufNr5MiTaGWP9OLT38i
        DfiQhY7/nZ1D6TaomTQ8hcc=
X-Google-Smtp-Source: APXvYqwrdBxZkGkl3VYse6aA7Haf83fZOat6BiBhn798ugz4TFgmdQC7B11oA3wD4XNH+vQKAhhLnw==
X-Received: by 2002:a2e:961a:: with SMTP id v26mr6001777ljh.185.1575977590895;
        Tue, 10 Dec 2019 03:33:10 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id c12sm1404031lfp.58.2019.12.10.03.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 03:33:09 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1iedlQ-00010O-1Z; Tue, 10 Dec 2019 12:33:12 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Jimmy Assarsson <extja@kvaser.com>,
        Christer Beskow <chbe@kvaser.com>,
        Nicklas Johansson <extnj@kvaser.com>,
        Martin Henriksson <mh@kvaser.com>
Subject: [PATCH 1/2] can: kvaser_usb: fix interface sanity check
Date:   Tue, 10 Dec 2019 12:32:30 +0100
Message-Id: <20191210113231.3797-2-johan@kernel.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210113231.3797-1-johan@kernel.org>
References: <20191210113231.3797-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to use the current alternate setting when verifying the
interface descriptors to avoid binding to an invalid interface.

Failing to do so could cause the driver to misbehave or trigger a WARN()
in usb_submit_urb() that kernels with panic_on_warn set would choke on.

Fixes: aec5fb2268b7 ("can: kvaser_usb: Add support for Kvaser USB hydra family")
Cc: stable <stable@vger.kernel.org>     # 4.19
Cc: Jimmy Assarsson <extja@kvaser.com>
Cc: Christer Beskow <chbe@kvaser.com>
Cc: Nicklas Johansson <extnj@kvaser.com>
Cc: Martin Henriksson <mh@kvaser.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 5fc0be564274..7ab87a758754 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -1590,7 +1590,7 @@ static int kvaser_usb_hydra_setup_endpoints(struct kvaser_usb *dev)
 	struct usb_endpoint_descriptor *ep;
 	int i;
 
-	iface_desc = &dev->intf->altsetting[0];
+	iface_desc = dev->intf->cur_altsetting;
 
 	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
 		ep = &iface_desc->endpoint[i].desc;
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 07d2f3aa2c02..1c794bb443e1 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -1310,7 +1310,7 @@ static int kvaser_usb_leaf_setup_endpoints(struct kvaser_usb *dev)
 	struct usb_endpoint_descriptor *endpoint;
 	int i;
 
-	iface_desc = &dev->intf->altsetting[0];
+	iface_desc = dev->intf->cur_altsetting;
 
 	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
 		endpoint = &iface_desc->endpoint[i].desc;
-- 
2.24.0


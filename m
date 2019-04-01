Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4665BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16AE5206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139167;
	bh=VrLKyxlELaAIB/TtMC7trVk/8u11S9O9QIXmb+sEG2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y6D3+z/t1jo+WSS+KY6cD6WQnhSTKyWsecq27DSnce/+N6/EOjsc1nLtJOswmIGlr
	 O56XMOZiPjejfwBuDq19ElP2zO5eM15jluIKqZfFN02CUtM3uW63aY8MxeANdD9c0+
	 1JU+MDU3GdsHNyK9oOiyenVGuW461wtXWsy6QkYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbfDART0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:19:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731509AbfDARTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:19:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 220B020883;
        Mon,  1 Apr 2019 17:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139162;
        bh=VrLKyxlELaAIB/TtMC7trVk/8u11S9O9QIXmb+sEG2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=13N32b+H8HvpGLEDfAz66FM84s1hAKuDmU8//XcdkuxoIbeDuVr2uApM1ekscPakv
         WsM702dUaF2VYucTXlp227NOqUMyke2MqxKQvSzFXmZKL+N7T9HZB9PGcylxpXzysG
         pOlBUqKeITZbpM3FB71q94qmkxczajrBOERVHjNM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4.19 132/134] platform: x86: intel_cht_int33fe: Add connections for the USB Type-C port
Date:   Mon,  1 Apr 2019 19:02:48 +0200
Message-Id: <20190401170056.520966580@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit 495965a1002a0b301bf4fbfd1aed3233f3e7db1b upstream.

Assigning the mux to the USB Type-C port on top of fusb302.
That will prepare this driver for the change in the USB
Type-C class code, where the class driver will assume the
muxes to be always assigned to the ports and not the
controllers.

Once the USB Type-C class driver has been updated, the
connections between the mux and fusb302 can be dropped.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/intel_cht_int33fe.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -34,7 +34,7 @@ struct cht_int33fe_data {
 	struct i2c_client *fusb302;
 	struct i2c_client *pi3usb30532;
 	/* Contain a list-head must be per device */
-	struct device_connection connections[5];
+	struct device_connection connections[8];
 };
 
 /*
@@ -187,6 +187,16 @@ static int cht_int33fe_probe(struct i2c_
 	data->connections[3].endpoint[1] = "intel_xhci_usb_sw-role-switch";
 	data->connections[3].id = "usb-role-switch";
 
+	data->connections[4].endpoint[0] = "port0";
+	data->connections[4].endpoint[1] = "i2c-pi3usb30532";
+	data->connections[4].id = "typec-switch";
+	data->connections[5].endpoint[0] = "port0";
+	data->connections[5].endpoint[1] = "i2c-pi3usb30532";
+	data->connections[5].id = "typec-mux";
+	data->connections[6].endpoint[0] = "port0";
+	data->connections[6].endpoint[1] = "i2c-pi3usb30532";
+	data->connections[6].id = "idff01m01";
+
 	device_connections_add(data->connections);
 
 	memset(&board_info, 0, sizeof(board_info));



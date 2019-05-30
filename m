Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A0AC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D48E23C5A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559187189;
	bh=8XoDysI2f0WUOlj/hFzAx5CvzR45OQf8+Eh7gXw94jQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HvRKZRTFFB81/1EeD9H4zo6lA6pfeKzblqAWJs+idf8RZkCwoJDfT3zNpOU5JtCOh
	 oAy6GXaVs2Zocvi8d3+yIV+Zf9AUCuOKuvqlULsPn4itr/DhuovI+alVcJrPomoBjU
	 F75oWpAcbLrsOsZUR2r3E8xT3H2PYogm5hDJ+IOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388254AbfE3D24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:28:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730515AbfE3DUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:20:23 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BCC72492F;
        Thu, 30 May 2019 03:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186422;
        bh=8XoDysI2f0WUOlj/hFzAx5CvzR45OQf8+Eh7gXw94jQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OcWrA1ifDfYyCkF4otPbRU3EOaJUZw4qjEEHTG4Zb4w43oR427igp5EIGdAXpRaDk
         ivK3dT78wuk0H6I/wVEwDsbNJnIzuWYQHddxdpcvMBfWPIgY3IM3jlrTBU9+HpUyVg
         2UX2fA48y6m73dy//sMhjrhxULS0TRWsP+1Yntro=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, siliu@redhat.com,
        Pankaj Gupta <pagupta@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 167/193] virtio_console: initialize vtermno value for ports
Date:   Wed, 29 May 2019 20:07:01 -0700
Message-Id: <20190530030511.311708044@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030446.953835040@linuxfoundation.org>
References: <20190530030446.953835040@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 4b0a2c5ff7215206ea6135a405f17c5f6fca7d00 ]

For regular serial ports we do not initialize value of vtermno
variable. A garbage value is assigned for non console ports.
The value can be observed as a random integer with [1].

[1] vim /sys/kernel/debug/virtio-ports/vport*p*

This patch initialize the value of vtermno for console serial
ports to '1' and regular serial ports are initiaized to '0'.

Reported-by: siliu@redhat.com
Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/virtio_console.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index a089474cb046a..65454acd4b974 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -75,7 +75,7 @@ struct ports_driver_data {
 	/* All the console devices handled by this driver */
 	struct list_head consoles;
 };
-static struct ports_driver_data pdrvdata;
+static struct ports_driver_data pdrvdata = { .next_vtermno = 1};
 
 static DEFINE_SPINLOCK(pdrvdata_lock);
 static DECLARE_COMPLETION(early_console_added);
@@ -1422,6 +1422,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 	port->async_queue = NULL;
 
 	port->cons.ws.ws_row = port->cons.ws.ws_col = 0;
+	port->cons.vtermno = 0;
 
 	port->host_connected = port->guest_connected = false;
 	port->stats = (struct port_stats) { 0 };
-- 
2.20.1




Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CE4C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A2E20843
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099799;
	bh=fMtF6+aAcAGG8CmxQdMXRhxL2ZRsH3RGfrlSmREcy9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pfBr7xRp9BX1Y2NwGebvg27lR5M6hQ+RXJ+uq91Ikamv7ihr7o2NHPi5pl5YFXpot
	 kMtzjNbHPNAiv7wiAVVqkO3nFwnpRtEnSfm+ev4g9QCzjqlSLyECEDZhy/Iil9UvBq
	 59gS90nS8saSVo0fH3NQ1Zm7T5L73i0RAPcvkPdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388388AbfFIRDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388371AbfFIRDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:03:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D02792145D;
        Sun,  9 Jun 2019 17:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099794;
        bh=fMtF6+aAcAGG8CmxQdMXRhxL2ZRsH3RGfrlSmREcy9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DybVEg9ushhLcxM1Zfm+qhf45Er7SlMsqS/LLVcqJ5ddLIzPf+mCzNNbyXbjGqdt0
         PpZnWzNAGJyAnH9GxEcZ+JykM7Zzp+735JTx2okBHoFENkydRqm1Gxd7pgpl6PrDw3
         ny9+0liiq6/JjC9klK1WCY4g7Mk5FMbclXaDisHw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, siliu@redhat.com,
        Pankaj Gupta <pagupta@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 167/241] virtio_console: initialize vtermno value for ports
Date:   Sun,  9 Jun 2019 18:41:49 +0200
Message-Id: <20190609164152.596927769@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
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
index 2aca689061e1f..df9eab91c2d25 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -76,7 +76,7 @@ struct ports_driver_data {
 	/* All the console devices handled by this driver */
 	struct list_head consoles;
 };
-static struct ports_driver_data pdrvdata;
+static struct ports_driver_data pdrvdata = { .next_vtermno = 1};
 
 static DEFINE_SPINLOCK(pdrvdata_lock);
 static DECLARE_COMPLETION(early_console_added);
@@ -1419,6 +1419,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 	port->async_queue = NULL;
 
 	port->cons.ws.ws_row = port->cons.ws.ws_col = 0;
+	port->cons.vtermno = 0;
 
 	port->host_connected = port->guest_connected = false;
 	port->stats = (struct port_stats) { 0 };
-- 
2.20.1




Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE0FC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8033218BB
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562230017;
	bh=xGwKWc+XzsSOGlAWoFhYB9Bq0hOeFBHzsB5P7i22CiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SBd55EADOJgDGWDjqNyKCpL0hn3jtdZB5PRTQuLF4hGXU0T0a0qIBqvVbEWI0V6H5
	 cQ+uBXbWdpqcO9ApiCzbqG2eMza40w9NypLVQFnKkRUI/vZvjYDqSss++qvO5mPTAe
	 pl4jMnZZIs2NujEaNwRyqgwtBY2UAESTFKnkPW4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfGDIq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:46:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbfGDIqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:46:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5BB5218A0;
        Thu,  4 Jul 2019 08:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562230011;
        bh=xGwKWc+XzsSOGlAWoFhYB9Bq0hOeFBHzsB5P7i22CiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1pazu0ayU9DFIcP8846lWW/76SH0dMrV4RFmh8jxinTqQuSgvkwyZSNFNkAkwHgiI
         aoRTCdMWpULf+Eu5QzLXkLs8GMeEpeRuqgaGy1NCLup+uMMODqf6wkw50x+pGPX1V5
         8IcQTPEqYBX3+bbox83v/RvcMumYHysQJDDCzT4M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: [PATCH 03/11] serial: sh-sci: use driver core functions, not sysfs ones.
Date:   Thu,  4 Jul 2019 10:46:09 +0200
Message-Id: <20190704084617.3602-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190704084617.3602-1-gregkh@linuxfoundation.org>
References: <20190704084617.3602-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a driver, do not call "raw" sysfs functions, instead call driver
core ones.  Specifically convert the use of sysfs_create_file() and
sysfs_remove_file() to use device_create_file() and device_remove_file()

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sh-sci.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index abc705716aa0..69f9072505f7 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3137,14 +3137,10 @@ static int sci_remove(struct platform_device *dev)
 
 	sci_cleanup_single(port);
 
-	if (port->port.fifosize > 1) {
-		sysfs_remove_file(&dev->dev.kobj,
-				  &dev_attr_rx_fifo_trigger.attr);
-	}
-	if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF) {
-		sysfs_remove_file(&dev->dev.kobj,
-				  &dev_attr_rx_fifo_timeout.attr);
-	}
+	if (port->port.fifosize > 1)
+		device_remove_file(&dev->dev, &dev_attr_rx_fifo_trigger);
+	if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF)
+		device_remove_file(&dev->dev, &dev_attr_rx_fifo_timeout);
 
 	return 0;
 }
@@ -3332,19 +3328,17 @@ static int sci_probe(struct platform_device *dev)
 		return ret;
 
 	if (sp->port.fifosize > 1) {
-		ret = sysfs_create_file(&dev->dev.kobj,
-				&dev_attr_rx_fifo_trigger.attr);
+		ret = device_create_file(&dev->dev, &dev_attr_rx_fifo_trigger);
 		if (ret)
 			return ret;
 	}
 	if (sp->port.type == PORT_SCIFA || sp->port.type == PORT_SCIFB ||
 	    sp->port.type == PORT_HSCIF) {
-		ret = sysfs_create_file(&dev->dev.kobj,
-				&dev_attr_rx_fifo_timeout.attr);
+		ret = device_create_file(&dev->dev, &dev_attr_rx_fifo_timeout);
 		if (ret) {
 			if (sp->port.fifosize > 1) {
-				sysfs_remove_file(&dev->dev.kobj,
-					&dev_attr_rx_fifo_trigger.attr);
+				device_remove_file(&dev->dev,
+						   &dev_attr_rx_fifo_trigger);
 			}
 			return ret;
 		}
-- 
2.22.0


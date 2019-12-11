Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAABC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675432073B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079700;
	bh=Orn8VfWLBuTpWgne0Qxq93LqFLsUbv5C7WvmQvNYOcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mgti5eEFSTYNmIVU4oDsaFABWV+yn/fcgCO/HfYHgRT4aNIAiWKA308NWp4c4a/Bb
	 8YBpDIo0idcBdQZLgW6u+ILQ27jQHgu7vi5vCms/zsciK6yNK1bHM5Rg7jptKn1KZk
	 nvhGPdGJE7nBZLGQBVUU6OYydR6qVAsRP2nByuTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731805AbfLKPQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:16:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:44156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731565AbfLKPQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:16:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 209D320663;
        Wed, 11 Dec 2019 15:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077412;
        bh=Orn8VfWLBuTpWgne0Qxq93LqFLsUbv5C7WvmQvNYOcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nQB/YUPjD3OSJ7L4bNVyY4QknLVTiDuS+zNf40wBG+YSYGqNySAPAOHEdeMuQLiXF
         r9kJHJzZ02Vrl6SLRtDrglmWWLXDf3w0YtW04+kEysPXBXgSZbpNqBk40lTbSFPX7t
         NGjKjqSnARJXipMetY1HI7DGCE+daJM41HEi3CYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Ladislav Michl <ladis@linux-mips.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.19 005/243] usb: gadget: u_serial: add missing port entry locking
Date:   Wed, 11 Dec 2019 16:02:47 +0100
Message-Id: <20191211150339.527661587@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

commit daf82bd24e308c5a83758047aff1bd81edda4f11 upstream.

gserial_alloc_line() misses locking (for a release barrier) while
resetting port entry on TTY allocation failure. Fix this.

Cc: stable@vger.kernel.org
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Tested-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/u_serial.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -1246,8 +1246,10 @@ int gserial_alloc_line(unsigned char *li
 				__func__, port_num, PTR_ERR(tty_dev));
 
 		ret = PTR_ERR(tty_dev);
+		mutex_lock(&ports[port_num].lock);
 		port = ports[port_num].port;
 		ports[port_num].port = NULL;
+		mutex_unlock(&ports[port_num].lock);
 		gserial_free_port(port);
 		goto err;
 	}



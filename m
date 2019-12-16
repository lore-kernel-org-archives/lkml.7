Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77B1C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA4920733
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519310;
	bh=35yKDkiE8KL4FQ6IGuKiSvQsrdEoHklWw7BgukhTtfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kNnYXdaUkYtV8gU4Ii/qlKsDkGWIhtLz7ahVjG8JNXGb3EfVH/ZC3VK8CQthCvF3u
	 i/4yymsT85brGyIp4TS1lvkE5s1LNne35bb2a55Xx5PJgWHA2gS/1NOUa0sXfry+bs
	 w45rxZ5Pv2KPDe+Z/jA6Lb4m78UjdOha6nt35dvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfLPSBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:01:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728756AbfLPSBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:01:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAEC620733;
        Mon, 16 Dec 2019 18:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519306;
        bh=35yKDkiE8KL4FQ6IGuKiSvQsrdEoHklWw7BgukhTtfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jAAgM76/M3z/a5jS+zNbnFYuWuJFPo84D4ETugQu48rDU0O7PuE4stdOHSATtMIJP
         c5+Bwx0ysM3gVuDsntj8mNiDndgWkcf6DQpIbKH0hD6U2Dp/A7rQAvZ19Gm8DVe+9K
         rQf8nYaS+aP/Gkr6vTfN7UyqOCw6CEhgh+v8RA74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.19 005/140] USB: uas: honor flag to avoid CAPACITY16
Date:   Mon, 16 Dec 2019 18:47:53 +0100
Message-Id: <20191216174749.658842089@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174747.111154704@linuxfoundation.org>
References: <20191216174747.111154704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit bff000cae1eec750d62e265c4ba2db9af57b17e1 upstream.

Copy the support over from usb-storage to get feature parity

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191114112758.32747-2-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/uas.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -832,6 +832,10 @@ static int uas_slave_configure(struct sc
 		sdev->wce_default_on = 1;
 	}
 
+	/* Some disks cannot handle READ_CAPACITY_16 */
+	if (devinfo->flags & US_FL_NO_READ_CAPACITY_16)
+		sdev->no_read_capacity_16 = 1;
+
 	/*
 	 * Some disks return the total number of blocks in response
 	 * to READ CAPACITY rather than the highest block number.



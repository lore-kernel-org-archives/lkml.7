Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A4AC04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE342053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557154993;
	bh=WUgK1XaP9CKxLVpil8QiQgTYWULgkduitlNHJqWTq7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s83Hgxg5y9lA/9GQu3W3W3kRD/yTyC4FcRFlhtN6Ju3wLho3xzBYHHNR/by9p/Loz
	 jb2xqeBuq+dmFzfaBYUdKL32fDa0QUnA/zfXmE4cjppPN2+h43GpqgfgGRmXhJhjA1
	 lCO9xCxtScbAPOz7s2unk3aZjnQPE26YROUzKrXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfEFOkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:40:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727911AbfEFOjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:39:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D19020449;
        Mon,  6 May 2019 14:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153594;
        bh=WUgK1XaP9CKxLVpil8QiQgTYWULgkduitlNHJqWTq7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DdkijRLpNdfRRdXftbLVYf0VulmVJzzuy2OYVRhZMb1KZJ4eJ45W3KXfmPcI8L/03
         2xosVCFzAbjhaQHWalZ8QCSIHyeJRBiXjWFWNKQPqg5qToPu7veKHl1JpDIT2V2cxV
         o7eBgapDaGGDBsu6WZso+cw9tUcq4BLj4gAkFv1U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4.19 07/99] i2c: Clear client->irq in i2c_device_remove
Date:   Mon,  6 May 2019 16:31:40 +0200
Message-Id: <20190506143054.531634333@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.899356316@linuxfoundation.org>
References: <20190506143053.899356316@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

commit 6f108dd70d3010c391c1e9f56f3f20d1f9e75450 upstream.

The IRQ will be mapped in i2c_device_probe only if client->irq is zero and
i2c_device_remove does not clear this. When rebinding an I2C device,
whos IRQ provider has also been rebound this means that an IRQ mapping
will never be created, causing the I2C device to fail to acquire its
IRQ. Fix this issue by clearing client->irq in i2c_device_remove,
forcing i2c_device_probe to lookup the mapping again.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/i2c-core-base.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -430,6 +430,8 @@ static int i2c_device_remove(struct devi
 	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, false);
 
+	client->irq = 0;
+
 	return status;
 }
 



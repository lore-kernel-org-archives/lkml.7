Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD00C468BD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA50320693
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100674;
	bh=jONbMhxkr6W4rPbHBLgX21C+FnpnJTZvahlGCIpnRAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=of6PsmKgz0arFlGrJ8w8BwqKYYECMiZrP28A0i4HCnZs13iIvaZ8ULfbKoFTURZDz
	 FLsNNc1QYwE5GxjXAGeIYvz/gb2qWfohvzheWRzsMZPtpael+KMbFHCe+mlHfQ3Dzy
	 S/rHXiDx/GntqFsYKUTOkIGj1S79zyX+O8kO81e8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731925AbfFIQv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:51:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731902AbfFIQvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:51:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08A7B206C3;
        Sun,  9 Jun 2019 16:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099080;
        bh=jONbMhxkr6W4rPbHBLgX21C+FnpnJTZvahlGCIpnRAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TEfFNMUHjlkIXZxg0owQ3TvlZ0PnEIWJad5xcNQVp1vhJtQVg9oTcxAcyRf8c/n2B
         JB3XJf1UMgjRPuDHlOT/RShXMwjX8RQx54LDB49NEwRwqSRC0ALGpxRVKPE+adZZdb
         somTnsuh2P44SQDaFjQwJ1x/tLYW6ujS74oxsjAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Hancock <hancock@sedsystems.ca>,
        Michal Simek <michal.simek@xilinx.com>,
        Wolfram Sang <wsa@the-dreams.de>, stable@kernel.org
Subject: [PATCH 4.14 20/35] i2c: xiic: Add max_read_len quirk
Date:   Sun,  9 Jun 2019 18:42:26 +0200
Message-Id: <20190609164126.695268540@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164125.377368385@linuxfoundation.org>
References: <20190609164125.377368385@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Hancock <hancock@sedsystems.ca>

commit 49b809586730a77b57ce620b2f9689de765d790b upstream.

This driver does not support reading more than 255 bytes at once because
the register for storing the number of bytes to read is only 8 bits. Add
a max_read_len quirk to enforce this.

This was found when using this driver with the SFP driver, which was
previously reading all 256 bytes in the SFP EEPROM in one transaction.
This caused a bunch of hard-to-debug errors in the xiic driver since the
driver/logic was treating the number of bytes to read as zero.
Rejecting transactions that aren't supported at least allows the problem
to be diagnosed more easily.

Signed-off-by: Robert Hancock <hancock@sedsystems.ca>
Reviewed-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-xiic.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -725,11 +725,16 @@ static const struct i2c_algorithm xiic_a
 	.functionality = xiic_func,
 };
 
+static const struct i2c_adapter_quirks xiic_quirks = {
+	.max_read_len = 255,
+};
+
 static const struct i2c_adapter xiic_adapter = {
 	.owner = THIS_MODULE,
 	.name = DRIVER_NAME,
 	.class = I2C_CLASS_DEPRECATED,
 	.algo = &xiic_algorithm,
+	.quirks = &xiic_quirks,
 };
 
 



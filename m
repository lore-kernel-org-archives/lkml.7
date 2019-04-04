Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C0CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A624920882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554367808;
	bh=iouHP23JlbYJcKTO/45ZGEzmwc8akcQetbw1YNNZUgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N93+FEGhyOlnJoaEzxvzoDKAXpGkBYMHKeKjxaW3X46gIO+bZRYbcVMBXk4pGUYTs
	 UgwT+om6N53Yb1Hd+10LAV5Ek2bm0EOMUhQ0aiWX6LzrP1MyNeJgcJRdMVZfPK13Na
	 n0ujOcHPnhBK98WZ+HkpRkLwAKSZlBwgwnvxnmZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbfDDIuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728901AbfDDIuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:50:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E078F20882;
        Thu,  4 Apr 2019 08:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367804;
        bh=iouHP23JlbYJcKTO/45ZGEzmwc8akcQetbw1YNNZUgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qeyOu1nfWLfBdTm3Op8dwfYwoFdFCF1tzb+6LDK6GTHi1iYNJrTVLnBDDVeuofVrX
         GTwDdZYjHZbug1n7DupPXIItiVKxUh56z9FR6+zX6LmqX/FQ2IoaUVExbpdb3Bq6up
         miv4OGUUngXOZBMWyidUHUo2OAWm2mILs/gIxXfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jeremy Compostella <jeremy.compostella@intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, stable@kernel.org,
        Connor OBrien <connoro@google.com>
Subject: [PATCH 4.9 08/91] i2c: core-smbus: prevent stack corruption on read I2C_BLOCK_DATA
Date:   Thu,  4 Apr 2019 10:46:52 +0200
Message-Id: <20190404084535.890179653@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Compostella <jeremy.compostella@intel.com>

commit 89c6efa61f5709327ecfa24bff18e57a4e80c7fa upstream.

On a I2C_SMBUS_I2C_BLOCK_DATA read request, if data->block[0] is
greater than I2C_SMBUS_BLOCK_MAX + 1, the underlying I2C driver writes
data out of the msgbuf1 array boundary.

It is possible from a user application to run into that issue by
calling the I2C_SMBUS ioctl with data.block[0] greater than
I2C_SMBUS_BLOCK_MAX + 1.

This patch makes the code compliant with
Documentation/i2c/dev-interface by raising an error when the requested
size is larger than 32 bytes.

Call Trace:
 [<ffffffff8139f695>] dump_stack+0x67/0x92
 [<ffffffff811802a4>] panic+0xc5/0x1eb
 [<ffffffff810ecb5f>] ? vprintk_default+0x1f/0x30
 [<ffffffff817456d3>] ? i2cdev_ioctl_smbus+0x303/0x320
 [<ffffffff8109a68b>] __stack_chk_fail+0x1b/0x20
 [<ffffffff817456d3>] i2cdev_ioctl_smbus+0x303/0x320
 [<ffffffff81745aed>] i2cdev_ioctl+0x4d/0x1e0
 [<ffffffff811f761a>] do_vfs_ioctl+0x2ba/0x490
 [<ffffffff81336e43>] ? security_file_ioctl+0x43/0x60
 [<ffffffff811f7869>] SyS_ioctl+0x79/0x90
 [<ffffffff81a22e97>] entry_SYSCALL_64_fastpath+0x12/0x6a

Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: stable@kernel.org
[connoro@google.com: 4.9 backport: adjust filename]
Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/i2c-core.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -3250,16 +3250,16 @@ static s32 i2c_smbus_xfer_emulated(struc
 				   the underlying bus driver */
 		break;
 	case I2C_SMBUS_I2C_BLOCK_DATA:
+		if (data->block[0] > I2C_SMBUS_BLOCK_MAX) {
+			dev_err(&adapter->dev, "Invalid block %s size %d\n",
+				read_write == I2C_SMBUS_READ ? "read" : "write",
+				data->block[0]);
+			return -EINVAL;
+		}
 		if (read_write == I2C_SMBUS_READ) {
 			msg[1].len = data->block[0];
 		} else {
 			msg[0].len = data->block[0] + 1;
-			if (msg[0].len > I2C_SMBUS_BLOCK_MAX + 1) {
-				dev_err(&adapter->dev,
-					"Invalid block write size %d\n",
-					data->block[0]);
-				return -EINVAL;
-			}
 			for (i = 1; i <= data->block[0]; i++)
 				msgbuf0[i] = data->block[i];
 		}



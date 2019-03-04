Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF863C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6B221019
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688003;
	bh=tUYBCvQ8NutiJYY8gAvZoQ3AhQL31W+jZ7TS+eJDYzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DSY6oqqSmJNWHD37uuNyQ1n6lsSoGl+moucbSSbwZs5kJ6u87920PIuDs/vvqrMSl
	 dk3KI0a7ipl/wWVG06L91oXWPsy7FCo/ZoJEoZLfOHL4d8MNWz3LdnA41aEFhNPFBr
	 QzWfOsJuw1mCqvzSQuo32KJ1Qh7GUxBH078kQsdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfCDI0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:26:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:48676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbfCDI0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:26:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8B26208E4;
        Mon,  4 Mar 2019 08:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687997;
        bh=tUYBCvQ8NutiJYY8gAvZoQ3AhQL31W+jZ7TS+eJDYzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V1jBApfABqOgihtyTD6VAAoj+ncw890LqUKRlltTqQEMNvyDi8UXPViCxTPzEv8x/
         6LgYwv+PneoR+qWn5KD2IoYkU+AGPlgBSP0h/SWZ876eDQWtQIwqPramxZLLTomKkw
         /+4Wba/fVXOgbkmt3F/LuYU2UO0LU33s2AyIR708=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhang Run <zhang.run@zte.com.cn>,
        Yang Wei <yang.wei9@zte.com.cn>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 36/52] net: usb: asix: ax88772_bind return error when hw_reset fail
Date:   Mon,  4 Mar 2019 09:22:34 +0100
Message-Id: <20190304081619.202542875@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081617.159014799@linuxfoundation.org>
References: <20190304081617.159014799@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 6eea3527e68acc22483f4763c8682f223eb90029 ]

The ax88772_bind() should return error code immediately when the PHY
was not reset properly through ax88772a_hw_reset().
Otherwise, The asix_get_phyid() will block when get the PHY
Identifier from the PHYSID1 MII registers through asix_mdio_read()
due to the PHY isn't ready. Furthermore, it will produce a lot of
error message cause system crash.As follows:
asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to write
 reg index 0x0000: -71
asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to send
 software reset: ffffffb9
asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to write
 reg index 0x0000: -71
asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to enable
 software MII access
asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to read
 reg index 0x0000: -71
asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to write
 reg index 0x0000: -71
asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to enable
 software MII access
asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to read
 reg index 0x0000: -71
...

Signed-off-by: Zhang Run <zhang.run@zte.com.cn>
Reviewed-by: Yang Wei <yang.wei9@zte.com.cn>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/asix_devices.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index b1b3d8f7e67dd..d0c0ac0c3519c 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -731,8 +731,13 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 	asix_read_cmd(dev, AX_CMD_STATMNGSTS_REG, 0, 0, 1, &chipcode, 0);
 	chipcode &= AX_CHIPCODE_MASK;
 
-	(chipcode == AX_AX88772_CHIPCODE) ? ax88772_hw_reset(dev, 0) :
-					    ax88772a_hw_reset(dev, 0);
+	ret = (chipcode == AX_AX88772_CHIPCODE) ? ax88772_hw_reset(dev, 0) :
+						  ax88772a_hw_reset(dev, 0);
+
+	if (ret < 0) {
+		netdev_dbg(dev->net, "Failed to reset AX88772: %d\n", ret);
+		return ret;
+	}
 
 	/* Read PHYID register *AFTER* the PHY was reset properly */
 	phyid = asix_get_phyid(dev);
-- 
2.19.1




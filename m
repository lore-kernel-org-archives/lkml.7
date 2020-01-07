Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA33C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3C72072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431436;
	bh=Du2QUUW3B3tz0fz3NBcjVpXpdDBoPzKjdz0jyzQXXJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hSHdpsZDZyqotusISfoAspD+Yc51JJ+Uq1yqLPibR5T+DEr0nE5IO4sYK0TYe1h9Z
	 w4fJDtu0Tn7GxZ5HLeZIoim/39uwbcCgw/Ds9wMU1SS1YlB9KlNPblKTt2061I9y+G
	 xDgvwiVwlgMKzL6XXhdxLQWlE9eIhyvxFOUsRjXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgAGVKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:10:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729957AbgAGVK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:10:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAEFE208C4;
        Tue,  7 Jan 2020 21:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431427;
        bh=Du2QUUW3B3tz0fz3NBcjVpXpdDBoPzKjdz0jyzQXXJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Res4NANhLiVKS8K5K3ZCnqadVDrCVMfT5DLXCI+S3Od5ptwoLRkAXzgvv8jBDIYoW
         WvZHT0F6/8MAans8d228266ZpC+Y4X/fFNfvLrWW1mSqzssRYPSoEGeNDPYqr2FozI
         c0xjy2IzTRGC+s8oE4cUNE75oaCX96DdkPLJJIbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.14 52/74] Bluetooth: btusb: fix PM leak in error case of setup
Date:   Tue,  7 Jan 2020 21:55:17 +0100
Message-Id: <20200107205218.150605138@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205135.369001641@linuxfoundation.org>
References: <20200107205135.369001641@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit 3d44a6fd0775e6215e836423e27f8eedf8c871ea upstream.

If setup() fails a reference for runtime PM has already
been taken. Proper use of the error handling in btusb_open()is needed.
You cannot just return.

Fixes: ace31982585a3 ("Bluetooth: btusb: Add setup callback for chip init on USB")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/btusb.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1123,7 +1123,7 @@ static int btusb_open(struct hci_dev *hd
 	if (data->setup_on_usb) {
 		err = data->setup_on_usb(hdev);
 		if (err < 0)
-			return err;
+			goto setup_fail;
 	}
 
 	data->intf->needs_remote_wakeup = 1;
@@ -1155,6 +1155,7 @@ done:
 
 failed:
 	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
+setup_fail:
 	usb_autopm_put_interface(data->intf);
 	return err;
 }



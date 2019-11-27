Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16579C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E283921775
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887535;
	bh=mG7tyWKBsFvSSI8JljWLG7ERevr6fOTFUrMhQgCm37o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C3aOqj8cw4MV66qSPhzmC9pGHFQ1iagHGMkUKoS9MYkYr+UHJjF9zEY98WHKZBlOz
	 v6PP4odGx49+1IA6jDpBbV0Ur7f5EUtIJOWojluMoLyfX9/BFVLUu7jm9u/5BwwMGJ
	 mPEYWkoe2S6Jup4zi5ubhnpM15IJGFTrioR7CPEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbfK0Upd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:45:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729258AbfK0Up2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:45:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1FB321741;
        Wed, 27 Nov 2019 20:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887528;
        bh=mG7tyWKBsFvSSI8JljWLG7ERevr6fOTFUrMhQgCm37o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GbSziumenpDxhLR+CukuEFKzPXvi/Q2qYT+KJKiDPmVQY45JL6MpEtdEr6iiSVRLW
         KSJ+1oAAZcgOYD9dtnotkf23B7V/aTa8TIlDuIuuJMEPkpigAkEopbXA13kzmQ5g/Y
         EU2JDTV3lVhWjVAAvDu8N2L1HmdmtpAAf3RfUr6Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 145/151] USB: serial: mos7840: fix remote wakeup
Date:   Wed, 27 Nov 2019 21:32:08 +0100
Message-Id: <20191127203047.366932195@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 92fe35fb9c70a00d8fbbf5bd6172c921dd9c7815 upstream.

The driver was setting the device remote-wakeup feature during probe in
violation of the USB specification (which says it should only be set
just prior to suspending the device). This could potentially waste
power during suspend as well as lead to spurious wakeups.

Note that USB core would clear the remote-wakeup feature at first
resume.

Fixes: 3f5429746d91 ("USB: Moschip 7840 USB-Serial Driver")
Cc: stable <stable@vger.kernel.org>     # 2.6.19
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/mos7840.c |    5 -----
 1 file changed, 5 deletions(-)

--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -2361,11 +2361,6 @@ out:
 			goto error;
 		} else
 			dev_dbg(&port->dev, "ZLP_REG5 Writing success status%d\n", status);
-
-		/* setting configuration feature to one */
-		usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
-				0x03, 0x00, 0x01, 0x00, NULL, 0x00,
-				MOS_WDR_TIMEOUT);
 	}
 	return 0;
 error:



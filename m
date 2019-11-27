Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE92C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E9621555
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887136;
	bh=mG7tyWKBsFvSSI8JljWLG7ERevr6fOTFUrMhQgCm37o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tf7BWgG7Go4t8YZYbumafWVFJV9n33L2MV7ENE4jgUJMpV7Rr9N85dYMDukb+YN8P
	 YEvC/B9/aoochPJDIY5gB8Ag9ZhmhiN+h9RufZSotKWBDMcPY5hydVK5xMtKlXX36g
	 Vkymr5b3Rm+sL5a0a7kSz7VP18xjdj9u3E3xOQXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfK0Uiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:38:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:42812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728822AbfK0Uiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:38:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3648A21555;
        Wed, 27 Nov 2019 20:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887131;
        bh=mG7tyWKBsFvSSI8JljWLG7ERevr6fOTFUrMhQgCm37o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rQ9RXHJGxEQliD4gqYrUHC+Y4mwSRtIbKp47xpOEO+PZVtUKkFqU4joP43X24fvcw
         F4OrTf5m0p9JAjXFxM5MEFmWoKWEcGUMkbr6kA6I3qLbP9102beoN2tQThXbYiOBpC
         6NfZNoRnaReAsLOgz+ujVWr+HEa1Ubo4/nefyva0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 126/132] USB: serial: mos7840: fix remote wakeup
Date:   Wed, 27 Nov 2019 21:31:57 +0100
Message-Id: <20191127203033.459084764@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202857.270233486@linuxfoundation.org>
References: <20191127202857.270233486@linuxfoundation.org>
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



Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F76C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B86F21582
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519409;
	bh=3TWcu9/vsPKBynX4OuH3lh8x9lLJu48NKdQdI7KMP8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IEyCknVESFYFkMrJIPkYkgFa8xb37Cx8auyonVatMTui9sZ+AmmVax/3/+j/+iP2A
	 Y4/KwVCo1It8HmFvRxxZ9gIEjqJ/4A2lkdcruWaLlbheLiOxBS/KlKprCR++D3t8Wp
	 vz4AN2/IjqbgMSPLvUVZys4ZErdx7/bbM5uL3Nos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbfLPSD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:03:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:39824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729459AbfLPSDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:03:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 484472072D;
        Mon, 16 Dec 2019 18:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519394;
        bh=3TWcu9/vsPKBynX4OuH3lh8x9lLJu48NKdQdI7KMP8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j1KRBALCvd68pSdAh22Hm4tq9Xlw1kFGB2KHR+CSNBgyJGN+NefNY3b9mlntXKbjb
         NfYja3LCL6WQLnhxlR0jy3IeaQQ/+EYkmhmHVb1aQEnHoLO0Xn0nXenvSaI8tJn/jU
         mwyOoihO4W3k2BFDh48LmcZTQo6bvL5jFlqMkwTs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+35b1c403a14f5c89eba7@syzkaller.appspotmail.com,
        Hansjoerg Lipp <hjlipp@web.de>,
        Tilman Schmidt <tilman@imap.cc>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 011/140] staging: gigaset: fix general protection fault on probe
Date:   Mon, 16 Dec 2019 18:47:59 +0100
Message-Id: <20191216174752.333002928@linuxfoundation.org>
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

From: Johan Hovold <johan@kernel.org>

commit 53f35a39c3860baac1e5ca80bf052751cfb24a99 upstream.

Fix a general protection fault when accessing the endpoint descriptors
which could be triggered by a malicious device due to missing sanity
checks on the number of endpoints.

Reported-by: syzbot+35b1c403a14f5c89eba7@syzkaller.appspotmail.com
Fixes: 07dc1f9f2f80 ("[PATCH] isdn4linux: Siemens Gigaset drivers - M105 USB DECT adapter")
Cc: stable <stable@vger.kernel.org>     # 2.6.17
Cc: Hansjoerg Lipp <hjlipp@web.de>
Cc: Tilman Schmidt <tilman@imap.cc>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191202085610.12719-2-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/isdn/gigaset/usb-gigaset.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/isdn/gigaset/usb-gigaset.c
+++ b/drivers/isdn/gigaset/usb-gigaset.c
@@ -688,6 +688,11 @@ static int gigaset_probe(struct usb_inte
 		return -ENODEV;
 	}
 
+	if (hostif->desc.bNumEndpoints < 2) {
+		dev_err(&interface->dev, "missing endpoints\n");
+		return -ENODEV;
+	}
+
 	dev_info(&udev->dev, "%s: Device matched ... !\n", __func__);
 
 	/* allocate memory for our device state and initialize it */



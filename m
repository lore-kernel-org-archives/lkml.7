Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C739DC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0A52054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557155360;
	bh=LOD1V+6gL9WXMN4zviTvrNZvb9jMmiuHBYDaYzfhRek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Tr0LDLtUQvfdOYzqekm02oE3GW5+WqIJea6aNVyoVWADlRYP+DMzR5atQq8fRc7t
	 Cbod/0xvXLaSDKGFT7Dd4iH+oMRBqH4klTY8orrT6tezTfFL6ZA40+ic43QTO/u8ZU
	 Omfbot4JJqnksxAvWTBo5ibpXk1k7Jr9qOQw/+R4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfEFPJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:09:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfEFOff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:35:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A698220C01;
        Mon,  6 May 2019 14:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153334;
        bh=LOD1V+6gL9WXMN4zviTvrNZvb9jMmiuHBYDaYzfhRek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x6GM8qOj+f54Nixq14lo2gy6x5dz5Ov865AHuR/alN7Ma+egs/rN0nU6O5YMLz1eQ
         Y3Yz9Hf8tTRTl1CEsv7VPJd7BbtveMAiKMYQkZhAH9HR6OeVQlGL/vht1TmlcyFlsG
         UO7/kFELalUKpgHwxPocpIn2x31C4eq2U4QAYyaU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        syzbot+b75b85111c10b8d680f1@syzkaller.appspotmail.com
Subject: [PATCH 5.0 018/122] USB: core: Fix unterminated string returned by usb_string()
Date:   Mon,  6 May 2019 16:31:16 +0200
Message-Id: <20190506143056.383363240@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

commit c01c348ecdc66085e44912c97368809612231520 upstream.

Some drivers (such as the vub300 MMC driver) expect usb_string() to
return a properly NUL-terminated string, even when an error occurs.
(In fact, vub300's probe routine doesn't bother to check the return
code from usb_string().)  When the driver goes on to use an
unterminated string, it leads to kernel errors such as
stack-out-of-bounds, as found by the syzkaller USB fuzzer.

An out-of-range string index argument is not at all unlikely, given
that some devices don't provide string descriptors and therefore list
0 as the value for their string indexes.  This patch makes
usb_string() return a properly terminated empty string along with the
-EINVAL error code when an out-of-range index is encountered.

And since a USB string index is a single-byte value, indexes >= 256
are just as invalid as values of 0 or below.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-by: syzbot+b75b85111c10b8d680f1@syzkaller.appspotmail.com
CC: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/message.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -820,9 +820,11 @@ int usb_string(struct usb_device *dev, i
 
 	if (dev->state == USB_STATE_SUSPENDED)
 		return -EHOSTUNREACH;
-	if (size <= 0 || !buf || !index)
+	if (size <= 0 || !buf)
 		return -EINVAL;
 	buf[0] = 0;
+	if (index <= 0 || index >= 256)
+		return -EINVAL;
 	tbuf = kmalloc(256, GFP_NOIO);
 	if (!tbuf)
 		return -ENOMEM;



Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF8AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883B62064A
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495065;
	bh=vSAa9ldWykU4vJubWpUyXhNCl9OsKu/vpNTRZRlXdzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1ZBqI0qNnRvIJlU+AaUbOqoLPsKNmXpsG9+R07QANSdW1Ajb5hFaUrPCJglKskdTj
	 +OP+6Fazy2xlaP0T5GI5t4tsy4NeBRZX03xUFjaTGLkRYCYc1FRfPus9eOMicFG+k0
	 BhrcLne9RLdJUwKkvDLC/iLPwTah2I9Jrn8rQRls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392201AbfHVRbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:31:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404569AbfHVR0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:26:01 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9EC12341E;
        Thu, 22 Aug 2019 17:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494760;
        bh=vSAa9ldWykU4vJubWpUyXhNCl9OsKu/vpNTRZRlXdzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GAjsXIIdB2Ffeezb2dzMS9Vqa5PfyQzb5gEQyqZQKeD54N8o6SXl/oODKlD9RBc8T
         hxmtoIGvqfupdANHj+88q0bfvAsFYfnKsGByxFoKXgIaL2SSGP1BmVP016XY29RRus
         oVuus1ZF4mBvBMrOm9UmpQQf+cciTRU0XCz34wg0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+45a53506b65321c1fe91@syzkaller.appspotmail.com,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.19 62/85] USB: CDC: fix sanity checks in CDC union parser
Date:   Thu, 22 Aug 2019 10:19:35 -0700
Message-Id: <20190822171733.916043761@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171731.012687054@linuxfoundation.org>
References: <20190822171731.012687054@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit 54364278fb3cabdea51d6398b07c87415065b3fc upstream.

A few checks checked for the size of the pointer to a structure
instead of the structure itself. Copy & paste issue presumably.

Fixes: e4c6fb7794982 ("usbnet: move the CDC parser into USB core")
Cc: stable <stable@vger.kernel.org>
Reported-by: syzbot+45a53506b65321c1fe91@syzkaller.appspotmail.com
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Link: https://lore.kernel.org/r/20190813093541.18889-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/message.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -2211,14 +2211,14 @@ int cdc_parse_cdc_header(struct usb_cdc_
 				(struct usb_cdc_dmm_desc *)buffer;
 			break;
 		case USB_CDC_MDLM_TYPE:
-			if (elength < sizeof(struct usb_cdc_mdlm_desc *))
+			if (elength < sizeof(struct usb_cdc_mdlm_desc))
 				goto next_desc;
 			if (desc)
 				return -EINVAL;
 			desc = (struct usb_cdc_mdlm_desc *)buffer;
 			break;
 		case USB_CDC_MDLM_DETAIL_TYPE:
-			if (elength < sizeof(struct usb_cdc_mdlm_detail_desc *))
+			if (elength < sizeof(struct usb_cdc_mdlm_detail_desc))
 				goto next_desc;
 			if (detail)
 				return -EINVAL;



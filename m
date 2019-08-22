Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A71AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B771233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566493947;
	bh=vc6ved7MhkKn9nkhraXLQzdIXfaVw920LLml0GtQ7R4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bFh6GZoRIEpaXJ4ZcfdOnnzxV/5wqOa0GfHWczeulkm7EJwSoUzmOaHKgitn8AmET
	 Q07oUHLL4WPcb/QUS53BObBPfD9R79wxuCf0YQ0qK4iiPWdU6GtYw2hiWbIBB4aJmN
	 ctU36z8rXzSIHxNucR6/91ZCsfUgAQgq+byJeWu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390999AbfHVRMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:12:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbfHVRJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:09:08 -0400
Received: from sasha-vm.mshome.net (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AEC32341B;
        Thu, 22 Aug 2019 17:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566493747;
        bh=vc6ved7MhkKn9nkhraXLQzdIXfaVw920LLml0GtQ7R4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KGqcY5+ierglh1qaP1g4Zy7zpxsxu3jkJS97Vh4n52G6RTU0ErZ49ys9k4u1ljV9L
         Dho13NJW50Z9Qckmlf1NGMxuWMSvbzxN1jZi0CUf0pdhnlv9W8DVB7+u1AkY7TSuL2
         d2byJf0tU6mcAU3wUwONVVt2oHNgEdXQRrsbT0sw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>,
        syzbot+45a53506b65321c1fe91@syzkaller.appspotmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.2 098/135] USB: CDC: fix sanity checks in CDC union parser
Date:   Thu, 22 Aug 2019 13:07:34 -0400
Message-Id: <20190822170811.13303-99-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822170811.13303-1-sashal@kernel.org>
References: <20190822170811.13303-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.2.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.2.10-rc1
X-KernelTest-Deadline: 2019-08-24T17:07+00:00
X-stable: review
X-Patchwork-Hint: Ignore
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
 drivers/usb/core/message.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index e844bb7b5676a..5adf489428aad 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -2218,14 +2218,14 @@ int cdc_parse_cdc_header(struct usb_cdc_parsed_header *hdr,
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
-- 
2.20.1


Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C5BFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BA320872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571262750;
	bh=1pWgX6uDTUOH3YJheezI2u1Praf4IWP5+BgBbA3TdN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F0txxoDqllr3Vfjw4EUCMjPUEQANFY35a79Qg5WQksuHX9/aqd9OZz+5nS+zxvunk
	 gSJn6nwNgQlncme8ebc2sXl/cL5DSLEMtK6Ctek9PaCAEFiH3/u7BfVONLCO2v4bIg
	 VANNOGET7u5vhq86roBEtE0GDp+mTFr5B0kMdUy0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394789AbfJPVw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:52:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394765AbfJPVw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:52:28 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A005F218DE;
        Wed, 16 Oct 2019 21:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262747;
        bh=1pWgX6uDTUOH3YJheezI2u1Praf4IWP5+BgBbA3TdN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lUWgP8ZmeakA17yihpJiWULISmUQC9yjkGCusyWPj3BtKVaIZS/oqQESCYvRk42z9
         iYKT8yC1M3/YCPaZui5kY5aygy7Z2+JxZeCw2HFdowIWwcx77P7jzR/dlpTctgOmIA
         g5tgD2dZ37OMJurj0CubIL4ZAZj0gNUvQYGuWz20=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>,
        syzbot+f4509a9138a1472e7e80@syzkaller.appspotmail.com,
        Johan Hovold <johan@kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 4.4 10/79] ieee802154: atusb: fix use-after-free at disconnect
Date:   Wed, 16 Oct 2019 14:49:45 -0700
Message-Id: <20191016214738.771838140@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214729.758892904@linuxfoundation.org>
References: <20191016214729.758892904@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 7fd25e6fc035f4b04b75bca6d7e8daa069603a76 upstream.

The disconnect callback was accessing the hardware-descriptor private
data after having having freed it.

Fixes: 7490b008d123 ("ieee802154: add support for atusb transceiver")
Cc: stable <stable@vger.kernel.org>     # 4.2
Cc: Alexander Aring <alex.aring@gmail.com>
Reported-by: syzbot+f4509a9138a1472e7e80@syzkaller.appspotmail.com
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ieee802154/atusb.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -756,10 +756,11 @@ static void atusb_disconnect(struct usb_
 
 	ieee802154_unregister_hw(atusb->hw);
 
+	usb_put_dev(atusb->usb_dev);
+
 	ieee802154_free_hw(atusb->hw);
 
 	usb_set_intfdata(interface, NULL);
-	usb_put_dev(atusb->usb_dev);
 
 	pr_debug("atusb_disconnect done\n");
 }



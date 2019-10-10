Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA110C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49082064A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697592;
	bh=TqBS6N8JkjqsvgsJ/jI7B4BEZAuyA9Xbhww9WsgX4Bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xT130jsFADRI/SeYx1eWf1/aihSNhqIOLCKU7YDrnAl3fotZfIpQO3g/9Galyl00S
	 A3FmpPQfo3ILmPvDR3lQrvpdNJc/PBwTjPLp+8LZvoBgkrKKlAIKapLMnhoY83VwdS
	 4kcltY694RR3ESWrWLFcMcCrIa2LX3DHe+/eGOSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390174AbfJJIv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:51:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388764AbfJJIvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:51:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1302821929;
        Thu, 10 Oct 2019 08:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697509;
        bh=TqBS6N8JkjqsvgsJ/jI7B4BEZAuyA9Xbhww9WsgX4Bc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jneo9MxQPfLt1DnZtOSMQ7gk4ndLdvNdKxgrjo763o7yh9Oq3HJlZW6DpP6au/wPg
         ck7VC/fH5iVm41UUIZjkJZ27PhoLKxZ6vfgOeqp62w73lBt1sGFu5zExaalvR2wd4V
         dsOwRuxuH/7dbvk7PX0Opz3yETUOWAGRfyiJhAic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>,
        syzbot+f4509a9138a1472e7e80@syzkaller.appspotmail.com,
        Johan Hovold <johan@kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 4.14 26/61] ieee802154: atusb: fix use-after-free at disconnect
Date:   Thu, 10 Oct 2019 10:36:51 +0200
Message-Id: <20191010083505.665292632@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083449.500442342@linuxfoundation.org>
References: <20191010083449.500442342@linuxfoundation.org>
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
@@ -907,10 +907,11 @@ static void atusb_disconnect(struct usb_
 
 	ieee802154_unregister_hw(atusb->hw);
 
+	usb_put_dev(atusb->usb_dev);
+
 	ieee802154_free_hw(atusb->hw);
 
 	usb_set_intfdata(interface, NULL);
-	usb_put_dev(atusb->usb_dev);
 
 	pr_debug("atusb_disconnect done\n");
 }



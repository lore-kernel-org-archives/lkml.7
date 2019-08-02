Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FED6C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFA82064A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564739609;
	bh=Cd2/CtlMzi0MVSdMVDg8CkFE200fT4o/RHRtNoAlWUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W1yWn23JNvv5wx10bdI2rQjNz9kZeb51vrd7bzDkmtvzw9o8MpJ6TIMTAtJgqxSdj
	 zWzTUPFx4lVqwA8ddI0aALmVUsXsTde8dp1Y7/bsQd7wWSRLr2w8BGnlTVwGb32SvI
	 F0Eysn7CoZjLWtvnESS+1c4CVNVLz4Tsc3vrOH4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406246AbfHBJx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:53:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406272AbfHBJx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:53:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47DC82086A;
        Fri,  2 Aug 2019 09:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564739605;
        bh=Cd2/CtlMzi0MVSdMVDg8CkFE200fT4o/RHRtNoAlWUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HTafo1vxJVSJ8G+VRYH3eQ9LxYLXLvP7sIeau/4c8+rOIL4odhwAvpkHw7+s/++5W
         sQasFTauuHSx6y/bavlWGwZYAMzhJ75ricHtCxQbkXviDGMhBShIVJ/hBaV2pcrt4e
         GBXyDhpplBptm+ecY81QjReP0IePhOZ9z69vZH2c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+8750abbc3a46ef47d509@syzkaller.appspotmail.com,
        Phong Tran <tranmanphong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 216/223] ISDN: hfcsusb: checking idx of ep configuration
Date:   Fri,  2 Aug 2019 11:37:21 +0200
Message-Id: <20190802092250.722969575@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092238.692035242@linuxfoundation.org>
References: <20190802092238.692035242@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phong Tran <tranmanphong@gmail.com>

commit f384e62a82ba5d85408405fdd6aeff89354deaa9 upstream.

The syzbot test with random endpoint address which made the idx is
overflow in the table of endpoint configuations.

this adds the checking for fixing the error report from
syzbot

KASAN: stack-out-of-bounds Read in hfcsusb_probe [1]
The patch tested by syzbot [2]

Reported-by: syzbot+8750abbc3a46ef47d509@syzkaller.appspotmail.com

[1]:
https://syzkaller.appspot.com/bug?id=30a04378dac680c5d521304a00a86156bb913522
[2]:
https://groups.google.com/d/msg/syzkaller-bugs/_6HBdge8F3E/OJn7wVNpBAAJ

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/isdn/hardware/mISDN/hfcsusb.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/isdn/hardware/mISDN/hfcsusb.c
+++ b/drivers/isdn/hardware/mISDN/hfcsusb.c
@@ -1963,6 +1963,9 @@ hfcsusb_probe(struct usb_interface *intf
 
 				/* get endpoint base */
 				idx = ((ep_addr & 0x7f) - 1) * 2;
+				if (idx > 15)
+					return -EIO;
+
 				if (ep_addr & 0x80)
 					idx++;
 				attr = ep->desc.bmAttributes;



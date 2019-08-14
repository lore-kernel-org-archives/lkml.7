Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453F6C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6C420679
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565749641;
	bh=ATgu5sVMXu5Bvc2XYr6x+coYMNy3bq3/q+Ll4nIE4aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rt7I9xrDoPIItTUapqwpOy6hTZ7OV/Q6qgpPsiY4YGl60WR20YKOkUoIXosnj/cql
	 9mPprCXzDM+2WP5bv/RhzifLvxoZTHYsvQdBqrasWm9c3Gxbs7ycxmB6pxC337uwmW
	 tqB+msrkC7s4GqPKilq3F88KpfnQc+l7K9NjbM5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbfHNC1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:27:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729521AbfHNC0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:26:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F9C32085A;
        Wed, 14 Aug 2019 02:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565749589;
        bh=ATgu5sVMXu5Bvc2XYr6x+coYMNy3bq3/q+Ll4nIE4aU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dqjTsoy3GsTy7Ckl63yeC6G4JvfTuAImNO5L4Rm0oX1P7/wkSLEbY2/F+umeEeQuO
         3TxtQtmSvfem50+grOkB1eO7patddNbhj7FJ/oU/PWKUqKyKDP1PQaRIzKORidek0G
         Ul0EipEyYX+tvMk88C1IjwnO/TtrA+3i2kbMNOA0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>,
        syzbot+5efc10c005014d061a74@syzkaller.appspotmail.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 22/28] Input: iforce - add sanity checks
Date:   Tue, 13 Aug 2019 22:25:44 -0400
Message-Id: <20190814022550.17463-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814022550.17463-1-sashal@kernel.org>
References: <20190814022550.17463-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit 849f5ae3a513c550cad741c68dd3d7eb2bcc2a2c ]

The endpoint type should also be checked before a device
is accepted.

Reported-by: syzbot+5efc10c005014d061a74@syzkaller.appspotmail.com
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/iforce/iforce-usb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index db64adfbe1aff..3e1ea912b41d1 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -145,7 +145,12 @@ static int iforce_usb_probe(struct usb_interface *intf,
 		return -ENODEV;
 
 	epirq = &interface->endpoint[0].desc;
+	if (!usb_endpoint_is_int_in(epirq))
+		return -ENODEV;
+
 	epout = &interface->endpoint[1].desc;
+	if (!usb_endpoint_is_int_out(epout))
+		return -ENODEV;
 
 	if (!(iforce = kzalloc(sizeof(struct iforce) + 32, GFP_KERNEL)))
 		goto fail;
-- 
2.20.1


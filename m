Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139D9C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E222064A
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495185;
	bh=YHp663y2Rn7vYBF/ewfbNkCms+6M1wcxqfD6Xm8XCzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ovbsyZ1SQRxYADXlpFfwJoZ/S7dCpqQ/7R2PmIGtX2SIGkREEjvpcdp7sojd3dnYg
	 gTM5Nqx/6tMg8ZlTH7jyiOuHKdmUnHY54x1rSAiAIOlcS0yg+GN5yWkOdVl5JXS/PC
	 CqlOmVLzK15ZpICDkTyXhlq6xWGjk6Wgqu5N4t1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403940AbfHVRdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:33:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391845AbfHVRZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:25:32 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89BC923426;
        Thu, 22 Aug 2019 17:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494731;
        bh=YHp663y2Rn7vYBF/ewfbNkCms+6M1wcxqfD6Xm8XCzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aWUtlVoZT+ICeRsJcBYOnBgzi03QKR7mzG19HF1SfQjJ6I2312Pbe+eG9c3eSVJQF
         piXew9lGQLLrZKHTAwVmVTGc/fQSeqR5vWin29EgY1EFgPLvJHsEQkdp7TRq6OITS8
         a9m3mEvNHAC0CJLF9TAy726qF4IO8Xf+0CoWBdRc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+5efc10c005014d061a74@syzkaller.appspotmail.com,
        Oliver Neukum <oneukum@suse.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 22/85] Input: iforce - add sanity checks
Date:   Thu, 22 Aug 2019 10:18:55 -0700
Message-Id: <20190822171732.126961189@linuxfoundation.org>
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

commit 849f5ae3a513c550cad741c68dd3d7eb2bcc2a2c upstream.

The endpoint type should also be checked before a device
is accepted.

Reported-by: syzbot+5efc10c005014d061a74@syzkaller.appspotmail.com
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/joystick/iforce/iforce-usb.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -141,7 +141,12 @@ static int iforce_usb_probe(struct usb_i
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



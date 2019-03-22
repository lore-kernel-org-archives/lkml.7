Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7C8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BD02183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfCVPqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:46:34 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:53763 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbfCVPqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:46:33 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MPGNn-1hLTwE0CPV-00PeTX; Fri, 22 Mar 2019 16:45:47 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Josh Boyer <jwboyer@fedoraproject.org>,
        Ralf Spenneberg <ralf@spenneberg.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.4.y 04/25] USB: iowarrior: fix oops with malicious USB descriptors
Date:   Fri, 22 Mar 2019 16:43:55 +0100
Message-Id: <20190322154425.3852517-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qmHMR6/bLkiLAr6Eh2kVU9pjqymM3CZ//BPIzKS9tQMm0ixAiTF
 UDcP/qFX/IfUNIqGdzDcm3t6cYrK1TzuehVrLBWoIPwmi4QCd79Ub21akCYkHMBqwgaB+ak
 B2e6Y0ZRK1u/4/qljIYX+imdGR6mUAiKfBTsE+mqTpMSXTgyENA5PtP2Ax4XSCgmAfjTTrS
 5tn1Y0+gG5FBJsQHdJNHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cNE/gt7wInI=:X1hTqeX42BmVm0QmBW7HVM
 gVZtXD1fAtJajFgUOweHQIUvZnoZL/bhdW4cs8FRpVwEJ6TmJqm8cylXOp9S1qjIPMjLL5J3z
 Dyu1KubI313MMSs6M/hlMdZRqwcTU8T7T69C2kvNMJFetHZdprrQgerbJF0NT1Q5bPPM5Kkn1
 /9A+c9mX+U06ixiHxSAQqKD9GgCBu0iaATVNsxQswp2o+fBbpEhvZE4gy/T5pjhZuzONeXPsk
 zcT1QaXS+wosEnUdW4K4nQt1iVXrM8GlJBBNnlYJH+9SlQ2BeWY6AKsxSDG0Ng4F4JhH2E946
 r2ZkIgF3eE7VUKjtcgTZ3x66RoToNXULPU3KDh49rXEZMxwhqLvvdC6tGWkAUXrPhFV7cO7YI
 VT5mmijaXuQw8pOuXRsha7wXpuUdqvFZMBYRL7UDVVFIEtMbyn/FAnm6RSSxVyND9gR8XCdgb
 tTelA15LWI0ypLdoAi67uhWOiF7u0wHQ/UXDgI6FfhICF/4EGZYtwCpTSQQMrLi5Jngj8ED01
 Gd5c/KmzwgPlrdv/SAUk0V/i1PCG2X2XQ8azqVLWwriPxA5Klt+h8H+gy5skj4s2TQBayq3yL
 a0k56Yt0kdAaiG5SfXBVw/1hexum9pgLAx2CA51pPLBwoevmtSmWCanKNgYnBE1Xg9l97e93v
 jWiiBcWNmDlDZD2GV2R+ShHRji0HLKHKS0FRWJEv3ZZlDHFxYn1PkoTwvO9AiaDCGcnTpNmYm
 MrqHgTRWq0fHjh/EpZlP2jaxZ9ZbZX2u7tAFNQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Boyer <jwboyer@fedoraproject.org>

The iowarrior driver expects at least one valid endpoint.  If given
malicious descriptors that specify 0 for the number of endpoints,
it will crash in the probe function.  Ensure there is at least
one endpoint on the interface before using it.

The full report of this issue can be found here:
http://seclists.org/bugtraq/2016/Mar/87

Reported-by: Ralf Spenneberg <ralf@spenneberg.net>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 4ec0ef3a82125efc36173062a50624550a900ae0)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/misc/iowarrior.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 5e43fd881a9c..381a92a0ebb6 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -787,6 +787,12 @@ static int iowarrior_probe(struct usb_interface *interface,
 	iface_desc = interface->cur_altsetting;
 	dev->product_id = le16_to_cpu(udev->descriptor.idProduct);
 
+	if (iface_desc->desc.bNumEndpoints < 1) {
+		dev_err(&interface->dev, "Invalid number of endpoints\n");
+		retval = -EINVAL;
+		goto error;
+	}
+
 	/* set up the endpoint information */
 	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
 		endpoint = &iface_desc->endpoint[i].desc;
-- 
2.20.0


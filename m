Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830B1C31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C9421537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560477904;
	bh=GRmU1q+/f+v2wUBdK3nqBNRYS7cbfQRyZe/N2CEZZYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eNOJ7VWBrN7zbrekvqNaBmzod1hQuz32v9Pi9NEXTCrqE9V5Ny6W0o0Ztm6ywUe4w
	 DYqvi4bee7Y6NA6YnDzZ/LE9QzxUqJCfWwQz8WItmw7vb/ZElsqDKSPk7NognpSfIP
	 7NijiPI4dsUPeuwz2hngpLKCUaW2vAgCIyf50aUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfFNCE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 22:04:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52866 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfFNCE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 22:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Rc2kXaDHzHXlwYcsQh5PtjF0ruhHsEakMken3/RrNnY=; b=GGMDoJaE6OWl6bctDCXTS4LfSO
        ZUy/C6ACQv5M0UZ7z/6qGVpnPPkScGexpxl6iPivStuauSVc0qLVzK074htWn+7KXpAMImcIpHc07
        stWNDC6KzkkKON0j1vj4D8mq+GZHbnHJsEAaTyiuMUSo9xGHRDGg0l4S7rZLiFn60fwBrDkkcIG4J
        woZk7qTugH7khupRIfhZAlTj3Evw+zqt0PsOno9UaDeAJRjpOO7g14EgGhwIba3Dp3h15YGHi2Ccg
        DItTqXvP9QT0Lber9BzECrS0VfdjfPbjHAMWWk50SvaZRQiDmMQdARnGsSi2V9GyWYNPzZAFi53Jc
        PXsCMP7w==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbbZr-0000EB-JQ; Fri, 14 Jun 2019 02:04:27 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hbbZn-0002nc-No; Thu, 13 Jun 2019 23:04:23 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 02/14] ABI: sysfs-driver-hid: the "What" field doesn't parse fine
Date:   Thu, 13 Jun 2019 23:04:08 -0300
Message-Id: <dfba2c1063fda7de3e646d021ff914c1418b8305.1560477540.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560477540.git.mchehab+samsung@kernel.org>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

The What: field on this ABI description use a different
syntax than expected, causing it to not be properly parsed
by script.

Fix it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/ABI/testing/sysfs-driver-hid | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid b/Documentation/ABI/testing/sysfs-driver-hid
index 48942cacb0bf..a59533410871 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid
+++ b/Documentation/ABI/testing/sysfs-driver-hid
@@ -1,6 +1,6 @@
-What:		For USB devices	: /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/report_descriptor
-		For BT devices	: /sys/class/bluetooth/hci<addr>/<hid-bus>:<vendor-id>:<product-id>.<num>/report_descriptor
-		Symlink		: /sys/class/hidraw/hidraw<num>/device/report_descriptor
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/report_descriptor
+What:		/sys/class/bluetooth/hci<addr>/<hid-bus>:<vendor-id>:<product-id>.<num>/report_descriptor
+What:		/sys/class/hidraw/hidraw<num>/device/report_descriptor
 Date:		Jan 2011
 KernelVersion:	2.0.39
 Contact:	Alan Ott <alan@signal11.us>
@@ -9,9 +9,9 @@ Description:	When read, this file returns the device's raw binary HID
 		This file cannot be written.
 Users:		HIDAPI library (http://www.signal11.us/oss/hidapi)
 
-What:		For USB devices	: /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/country
-		For BT devices	: /sys/class/bluetooth/hci<addr>/<hid-bus>:<vendor-id>:<product-id>.<num>/country
-		Symlink		: /sys/class/hidraw/hidraw<num>/device/country
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/country
+What:		/sys/class/bluetooth/hci<addr>/<hid-bus>:<vendor-id>:<product-id>.<num>/country
+What:		/sys/class/hidraw/hidraw<num>/device/country
 Date:		February 2015
 KernelVersion:	3.19
 Contact:	Olivier Gay <ogay@logitech.com>
-- 
2.21.0


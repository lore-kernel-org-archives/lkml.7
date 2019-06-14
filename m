Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4B0C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93F02183E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560477877;
	bh=hZXdwpv1NTA2mLJO9a96+dW3dZs+lie0NKla9TZvr4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S52pU7IIOlf1RymtT3tSmedQhvYEczs+3axp6JBwOVSvVRK8dYAMn0u5tCYDCDTCj
	 br0SIDfthbFd4yvZ4LkAEtqQIwZNo3/WCSel0fWHBO8rthrefE5NRyH13MAn2sVQMs
	 Sj3xaqdRU7Sn+Iy3E/RFnIPrfgzSxrudhHwb0ypI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfFNCEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 22:04:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52964 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfFNCEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 22:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1EDYIQPNmsiwyJ2mrEoIP/1S3ndA3wGsYXQv01sTZU4=; b=jDG95pA8CQ/CwTx2/TGGIX8I7+
        Qj32M/UiRvWq36MBiHqz5daVAdCwvCQBuam7CK1UxyvkPfDDkU1PQ4APBbYJOeXGMl9DgrU3RHx0c
        wr7xerJNWy4Sn05CBOeNeNPa2BS6Ozpw0TY1Xo+gCzC5HqoYLy4vKvige0Eb2Q5coEo8z89FfiIaC
        XG/yg64VEQT+DdpNc9lvWAe6wyl9dRIB9eqVpaNuiaNsyhFkRObfjfOePCwGGuB3kX3cW5c7e2PaB
        HR3Q+sIOI8Ptun9atgr5F4rDUnBUqbgxVOB0G9zPhLyRE63euwBiYxUNsNE1FmXxA1QaIDP5wqNRl
        vuf0mrqg==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbbZv-0000EF-5v; Fri, 14 Jun 2019 02:04:31 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hbbZn-0002nk-Pa; Thu, 13 Jun 2019 23:04:23 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stefan Achatz <erazor_de@users.sourceforge.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 04/14] ABI: better identificate tables
Date:   Thu, 13 Jun 2019 23:04:10 -0300
Message-Id: <6bc45c0d5d464d25d4d16eceac48a2f407166944.1560477540.git.mchehab+samsung@kernel.org>
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

When parsing via script, it is important to know if the script
should consider a description as a literal block that should
be displayed as-is, or if the description can be considered
as a normal text.

Change descriptions to ensure that the preceding line of a table
ends with a colon. That makes easy to identify the need of a
literal block.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/ABI/obsolete/sysfs-driver-hid-roccat-pyra   | 2 +-
 .../ABI/testing/sysfs-class-backlight-driver-lm3533       | 6 +++---
 Documentation/ABI/testing/sysfs-class-led-driver-lm3533   | 8 ++++----
 Documentation/ABI/testing/sysfs-class-leds-gt683r         | 4 ++--
 Documentation/ABI/testing/sysfs-driver-hid-roccat-kone    | 2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-pyra b/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-pyra
index 16020b31ae64..5d41ebadf15e 100644
--- a/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-pyra
+++ b/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-pyra
@@ -5,7 +5,7 @@ Description:	It is possible to switch the cpi setting of the mouse with the
 		press of a button.
 		When read, this file returns the raw number of the actual cpi
 		setting reported by the mouse. This number has to be further
-		processed to receive the real dpi value.
+		processed to receive the real dpi value:
 
 		VALUE DPI
 		1     400
diff --git a/Documentation/ABI/testing/sysfs-class-backlight-driver-lm3533 b/Documentation/ABI/testing/sysfs-class-backlight-driver-lm3533
index 77cf7ac949af..c0e0a9ae7b3d 100644
--- a/Documentation/ABI/testing/sysfs-class-backlight-driver-lm3533
+++ b/Documentation/ABI/testing/sysfs-class-backlight-driver-lm3533
@@ -4,7 +4,7 @@ KernelVersion:	3.5
 Contact:	Johan Hovold <jhovold@gmail.com>
 Description:
 		Get the ALS output channel used as input in
-		ALS-current-control mode (0, 1), where
+		ALS-current-control mode (0, 1), where:
 
 		0 - out_current0 (backlight 0)
 		1 - out_current1 (backlight 1)
@@ -28,7 +28,7 @@ Date:		April 2012
 KernelVersion:	3.5
 Contact:	Johan Hovold <jhovold@gmail.com>
 Description:
-		Set the brightness-mapping mode (0, 1), where
+		Set the brightness-mapping mode (0, 1), where:
 
 		0 - exponential mode
 		1 - linear mode
@@ -38,7 +38,7 @@ Date:		April 2012
 KernelVersion:	3.5
 Contact:	Johan Hovold <jhovold@gmail.com>
 Description:
-		Set the PWM-input control mask (5 bits), where
+		Set the PWM-input control mask (5 bits), where:
 
 		bit 5 - PWM-input enabled in Zone 4
 		bit 4 - PWM-input enabled in Zone 3
diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-lm3533 b/Documentation/ABI/testing/sysfs-class-led-driver-lm3533
index 620ebb3b9baa..e4c89b261546 100644
--- a/Documentation/ABI/testing/sysfs-class-led-driver-lm3533
+++ b/Documentation/ABI/testing/sysfs-class-led-driver-lm3533
@@ -4,7 +4,7 @@ KernelVersion:	3.5
 Contact:	Johan Hovold <jhovold@gmail.com>
 Description:
 		Set the ALS output channel to use as input in
-		ALS-current-control mode (1, 2), where
+		ALS-current-control mode (1, 2), where:
 
 		1 - out_current1
 		2 - out_current2
@@ -22,7 +22,7 @@ Date:		April 2012
 KernelVersion:	3.5
 Contact:	Johan Hovold <jhovold@gmail.com>
 Description:
-		Set the pattern generator fall and rise times (0..7), where
+		Set the pattern generator fall and rise times (0..7), where:
 
 		0 - 2048 us
 		1 - 262 ms
@@ -45,7 +45,7 @@ Date:		April 2012
 KernelVersion:	3.5
 Contact:	Johan Hovold <jhovold@gmail.com>
 Description:
-		Set the brightness-mapping mode (0, 1), where
+		Set the brightness-mapping mode (0, 1), where:
 
 		0 - exponential mode
 		1 - linear mode
@@ -55,7 +55,7 @@ Date:		April 2012
 KernelVersion:	3.5
 Contact:	Johan Hovold <jhovold@gmail.com>
 Description:
-		Set the PWM-input control mask (5 bits), where
+		Set the PWM-input control mask (5 bits), where:
 
 		bit 5 - PWM-input enabled in Zone 4
 		bit 4 - PWM-input enabled in Zone 3
diff --git a/Documentation/ABI/testing/sysfs-class-leds-gt683r b/Documentation/ABI/testing/sysfs-class-leds-gt683r
index e4fae6026e79..6adab27f646e 100644
--- a/Documentation/ABI/testing/sysfs-class-leds-gt683r
+++ b/Documentation/ABI/testing/sysfs-class-leds-gt683r
@@ -5,7 +5,7 @@ Contact:	Janne Kanniainen <janne.kanniainen@gmail.com>
 Description:
 		Set the mode of LEDs. You should notice that changing the mode
 		of one LED will update the mode of its two sibling devices as
-		well.
+		well. Possible values are:
 
 		0 - normal
 		1 - audio
@@ -13,4 +13,4 @@ Description:
 
 		Normal: LEDs are fully on when enabled
 		Audio:  LEDs brightness depends on sound level
-		Breathing: LEDs brightness varies at human breathing rate
\ No newline at end of file
+		Breathing: LEDs brightness varies at human breathing rate
diff --git a/Documentation/ABI/testing/sysfs-driver-hid-roccat-kone b/Documentation/ABI/testing/sysfs-driver-hid-roccat-kone
index 3ca3971109bf..8f7982c70d72 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-roccat-kone
+++ b/Documentation/ABI/testing/sysfs-driver-hid-roccat-kone
@@ -5,7 +5,7 @@ Description:	It is possible to switch the dpi setting of the mouse with the
 		press of a button.
 		When read, this file returns the raw number of the actual dpi
 		setting reported by the mouse. This number has to be further
-		processed to receive the real dpi value.
+		processed to receive the real dpi value:
 
 		VALUE DPI
 		1     800
-- 
2.21.0


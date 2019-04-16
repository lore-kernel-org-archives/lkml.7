Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBAEC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C849820656
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383547;
	bh=kBIetTC1Yl5IRnekNreYadLi0Xt5VSa5z0CDFlDWJZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DTzJAbZB5Zh99qLO7567vUjNGfNsmLKsc5Ycr2ytnNcT1YdpSRvL/GFHBc+hKmjqI
	 ZO6UmMg4FpsQ4pleYRJvuBz5MYow+vgY11ufCix/idQpw5GK37TUuL1qFVUdkOX2k9
	 Y+gRRLL1/o9/cFynO0Y1kjLKMBaAhzywiLgTEjlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfDPC7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:59:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44336 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfDPC4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EKiphOA5JLu/7fhR7E9Q5hf4/ZsZYNJ2IBTR3LUVguU=; b=bN0qAVfKewa/UC0oYoF4vCaVI2
        gdwKI0ar7JhOtmqinEEY7AyV3iznEd3tfw29+A5+PzpdYZc3/vHXpYoc/p3S5fxewEeUcfnWUucSf
        jiCnqSr7kCTW7lkgH9nILwYO53sydK/R+3+HyliwyKMkYVk3hN6tmnAs73QXSGHft8IGovV15oDia
        OvEc/Y026jzlrhUo6tuhCm8GUVFzKouNV1llCsSHjAJL2o4MnAh3ToXjzf03BNhFvzzIOc24xRjY+
        fwZFxNy95RxpPSbWXe5qFVBHW68SRhhTZc1jCPIt1jsSIdE1hP1Kl4QRAQPMP/EVp9eaPfA4Fojzq
        BCNYW6Ng==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGu-0007ai-N3; Tue, 16 Apr 2019 02:56:32 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGn-0001nw-KP; Mon, 15 Apr 2019 23:56:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 27/57] docs: pps/pps.txt convert it to ReST and move to API book
Date:   Mon, 15 Apr 2019 23:55:52 -0300
Message-Id: <0d3ebd1dec9baec2f1d6cb08f86623bd5ef13139.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file is already in a good shape: just its title and
adding some literal block markups is needed for it to be
part of the document.

While it has a small chapter with sysfs stuff, most of
the document is focused on driver development.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/pps/pps.txt | 67 ++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 33 deletions(-)

diff --git a/Documentation/pps/pps.txt b/Documentation/pps/pps.txt
index 99f5d8c4c652..262151a6dad5 100644
--- a/Documentation/pps/pps.txt
+++ b/Documentation/pps/pps.txt
@@ -1,8 +1,8 @@
+======================
+PPS - Pulse Per Second
+======================
 
-			PPS - Pulse Per Second
-			----------------------
-
-(C) Copyright 2007 Rodolfo Giometti <giometti@enneenne.com>
+Copyright (C) 2007 Rodolfo Giometti <giometti@enneenne.com>
 
 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
@@ -88,7 +88,7 @@ Coding example
 --------------
 
 To register a PPS source into the kernel you should define a struct
-pps_source_info as follows:
+pps_source_info as follows::
 
     static struct pps_source_info pps_ktimer_info = {
 	    .name         = "ktimer",
@@ -101,12 +101,12 @@ pps_source_info as follows:
     };
 
 and then calling the function pps_register_source() in your
-initialization routine as follows:
+initialization routine as follows::
 
     source = pps_register_source(&pps_ktimer_info,
 			PPS_CAPTUREASSERT | PPS_OFFSETASSERT);
 
-The pps_register_source() prototype is:
+The pps_register_source() prototype is::
 
   int pps_register_source(struct pps_source_info *info, int default_params)
 
@@ -118,7 +118,7 @@ pps_source_info which describe the capabilities of the driver).
 
 Once you have registered a new PPS source into the system you can
 signal an assert event (for example in the interrupt handler routine)
-just using:
+just using::
 
     pps_event(source, &ts, PPS_CAPTUREASSERT, ptr)
 
@@ -134,13 +134,13 @@ Please see the file drivers/pps/clients/pps-ktimer.c for example code.
 SYSFS support
 -------------
 
-If the SYSFS filesystem is enabled in the kernel it provides a new class:
+If the SYSFS filesystem is enabled in the kernel it provides a new class::
 
    $ ls /sys/class/pps/
    pps0/  pps1/  pps2/
 
 Every directory is the ID of a PPS sources defined in the system and
-inside you find several files:
+inside you find several files::
 
    $ ls -F /sys/class/pps/pps0/
    assert     dev        mode       path       subsystem@
@@ -148,7 +148,7 @@ inside you find several files:
 
 
 Inside each "assert" and "clear" file you can find the timestamp and a
-sequence number:
+sequence number::
 
    $ cat /sys/class/pps/pps0/assert
    1170026870.983207967#8
@@ -175,11 +175,11 @@ and the userland tools available in your distribution's pps-tools package,
 http://linuxpps.org , or https://github.com/redlab-i/pps-tools.
 
 Once you have enabled the compilation of pps-ktimer just modprobe it (if
-not statically compiled):
+not statically compiled)::
 
    # modprobe pps-ktimer
 
-and the run ppstest as follow:
+and the run ppstest as follow::
 
    $ ./ppstest /dev/pps1
    trying PPS source "/dev/pps1"
@@ -204,26 +204,27 @@ nor affordable. The cheap way is to load a PPS generator on one of the
 computers (master) and PPS clients on others (slaves), and use very simple
 cables to deliver signals using parallel ports, for example.
 
-Parallel port cable pinout:
-pin	name	master      slave
-1	STROBE	  *------     *
-2	D0	  *     |     *
-3	D1	  *     |     *
-4	D2	  *     |     *
-5	D3	  *     |     *
-6	D4	  *     |     *
-7	D5	  *     |     *
-8	D6	  *     |     *
-9	D7	  *     |     *
-10	ACK	  *     ------*
-11	BUSY	  *           *
-12	PE	  *           *
-13	SEL	  *           *
-14	AUTOFD	  *           *
-15	ERROR	  *           *
-16	INIT	  *           *
-17	SELIN	  *           *
-18-25	GND	  *-----------*
+Parallel port cable pinout::
+
+	pin	name	master      slave
+	1	STROBE	  *------     *
+	2	D0	  *     |     *
+	3	D1	  *     |     *
+	4	D2	  *     |     *
+	5	D3	  *     |     *
+	6	D4	  *     |     *
+	7	D5	  *     |     *
+	8	D6	  *     |     *
+	9	D7	  *     |     *
+	10	ACK	  *     ------*
+	11	BUSY	  *           *
+	12	PE	  *           *
+	13	SEL	  *           *
+	14	AUTOFD	  *           *
+	15	ERROR	  *           *
+	16	INIT	  *           *
+	17	SELIN	  *           *
+	18-25	GND	  *-----------*
 
 Please note that parallel port interrupt occurs only on high->low transition,
 so it is used for PPS assert edge. PPS clear edge can be determined only
-- 
2.20.1


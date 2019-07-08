Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E18C606AA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 10:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F00D20656
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 10:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hIpfqc3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbfGHKgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 06:36:04 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57824 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfGHKgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 06:36:03 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x68AZuJX003329;
        Mon, 8 Jul 2019 05:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1562582156;
        bh=S2OagN/TyZ2TEiU3bu+SsPIK5XLysRm1306Fh61l0tQ=;
        h=From:To:CC:Subject:Date;
        b=hIpfqc3rSqrumuVG4rOSVS7bDA16icSG233TMLoMFUhWladJnI8goiauwYhBpNgcA
         8ka3sKn6diiv7CfxmZI3kCf34sa6d/yQsJkTn/jtr4/Qfrj5yPuVfH1KlvuFdOysxA
         uQkPuTKXXHaLrgkjpiOXqGbG57BKTkJjz0KXHUvE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x68AZu2p020896
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Jul 2019 05:35:56 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 8 Jul
 2019 05:35:56 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 8 Jul 2019 05:35:56 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x68AZtrb040273;
        Mon, 8 Jul 2019 05:35:55 -0500
From:   Jean-Jacques Hiblot <jjhiblot@ti.com>
To:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <daniel.thompson@linaro.org>
CC:     <dmurphy@ti.com>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: [PATCH 0/2] leds: Add control of the voltage/current regulator to the LED core
Date:   Mon, 8 Jul 2019 12:35:45 +0200
Message-ID: <20190708103547.23528-1-jjhiblot@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series makes it possible for the LED core to manage the power supply
of a LED. It uses the regulator API to disable/enable the power if when the
LED is turned on/off.
This is especially useful in situations where the LED driver/controller is
not supplying the power.

Jean-Jacques Hiblot (2):
  leds: Add control of the voltage/current regulator to the LED core
  dt-bindings: leds: document new "power-supply" property

 .../devicetree/bindings/leds/common.txt       |  5 ++
 drivers/leds/led-class.c                      | 10 ++++
 drivers/leds/led-core.c                       | 53 +++++++++++++++++--
 include/linux/leds.h                          |  4 ++
 4 files changed, 69 insertions(+), 3 deletions(-)

-- 
2.17.1


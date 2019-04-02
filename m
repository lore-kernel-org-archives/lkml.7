Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F37AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D062133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CsI3CChv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbfDBNiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:38:01 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60136 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbfDBNiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:38:01 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x32DbvPb023079;
        Tue, 2 Apr 2019 08:37:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554212277;
        bh=PudYYZjCgwrgJqJg7K3tb7KJ/XiRu5ynfb9HaD4Cdjo=;
        h=From:To:CC:Subject:Date;
        b=CsI3CChv0mS3gsiIB4NyKDtDbP4tUBcUKqEybBcG36rlM2HuOY6cNyhJXuq5uH748
         TPK/c+ZxeADPRwPuj2Fm/hXCTZh6oRK6/OOBADHSEGgBY3g3yRkFRndz3bM7K1bEoX
         AyNOXPCaXgJp8MxxdfZbYIaiNCUVxBqEPbyaDNC8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x32Dbvsk098550
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Apr 2019 08:37:57 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Apr
 2019 08:37:56 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Apr 2019 08:37:56 -0500
Received: from lta0400828d.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x32DbsTw051551;
        Tue, 2 Apr 2019 08:37:55 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>
CC:     <nsekhar@ti.com>, <s-anna@ti.com>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [RFC PATCH 0/4] bus: ti-sysc: Add generic enable/disable & PRUSS
Date:   Tue, 2 Apr 2019 16:37:48 +0300
Message-ID: <20190402133752.6912-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

Non legacy modules will rely on generic enable/disable functions.

I had to disable usb_otg_ss3 and 4 on am57xx idk to be able to boot.
It is explicitly stated in TRM to not use USB3 and 4 on AM57xx, and
I haven't seen any dra7 based board using them so let's keep it disabled.

Handle the PRU-ICSS type as it needs some special handling especially
during suspend/resume.

cheers,
-roger

Roger Quadros (4):
  ARM: dts: dra7: Keep usb_otg_ss3 and usb_otg_ss4 disabled
  bus: ti-sysc: Add generic enable/disable functions
  bus: ti-sysc: Add support for PRU-ICSS type
  bus: ti-sysc: Ensure PRU-ICSS doesn't break suspend/resume

 .../devicetree/bindings/bus/ti-sysc.txt       |   1 +
 arch/arm/boot/dts/dra7-l4.dtsi                |   2 +
 drivers/bus/ti-sysc.c                         | 171 ++++++++++++++++++
 include/linux/platform_data/ti-sysc.h         |   7 +-
 4 files changed, 180 insertions(+), 1 deletion(-)

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D710ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAAAB2184C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CL7YX6LQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbfJ1JdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 05:33:13 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52072 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730072AbfJ1JdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:33:10 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9S9Wu9u079260;
        Mon, 28 Oct 2019 04:32:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572255176;
        bh=hAyge84rWryGxV3HLOtnBZ8RTv8u3iheFNZnU6gbwME=;
        h=From:To:CC:Subject:Date;
        b=CL7YX6LQ8p1ei1uMMlD/S9o1mgRgEem5oJ12HZlHGjFGWEWCTfWN4K26hBMXjy9xK
         lokXc99LbhuPi+Z51u+MSUufzXpheuMbS56IimexfP282GMG7iWAwCDcg2sFRj9V+n
         wXxrz4hSm4SzMjV44U5Qq9YPCdZNb/z29L2fqoXc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9S9Wu7B063439
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Oct 2019 04:32:56 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 28
 Oct 2019 04:32:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 28 Oct 2019 04:32:44 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9S9WrLS072531;
        Mon, 28 Oct 2019 04:32:53 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <pawell@cadence.com>, <peter.chen@nxp.com>, <nsekhar@ti.com>,
        <kurahul@cadence.com>, <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 0/2] usb: cdns3: Add TI wrapper
Date:   Mon, 28 Oct 2019 11:32:47 +0200
Message-ID: <20191028093249.22822-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Texas Instruments SoCs have a wrapper module around the Cadence
USB3 core. It takes care of clocking and powering the core and providing
initial configuration to the core.

This series adds the driver for the TI wrapper and associated DT binding
document. This is for -next kernel. Thanks.

cheers,
-roger

Changelog:
v4:
- use devm_platform_ioremap_resource()

v3:
- switch to yaml DT schema
- fix typo in driver header

v2:
- dt-binding fixes to address Rob's comments
	- convert dt-binding document name to DT schema
	- get rid of bootstrap properties
	- fix DT example

Roger Quadros (2):
  dt-bindings: usb: Add binding for the TI wrapper for Cadence USB3
    controller
  usb: cdns3: Add TI specific wrapper driver

 .../devicetree/bindings/usb/ti,j721e-usb.yaml |  86 +++++++
 drivers/usb/cdns3/Kconfig                     |  10 +
 drivers/usb/cdns3/Makefile                    |   1 +
 drivers/usb/cdns3/cdns3-ti.c                  | 236 ++++++++++++++++++
 4 files changed, 333 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
 create mode 100644 drivers/usb/cdns3/cdns3-ti.c

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


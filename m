Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20EACA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796F721872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ux+Gs+j9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439025AbfJXLku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:40:50 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36458 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfJXLkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:40:49 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9OBemZD088997;
        Thu, 24 Oct 2019 06:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571917248;
        bh=y5vv5MyXJRX25aniSxbVw1jtU1e58440UmSrBui2ECI=;
        h=From:To:CC:Subject:Date;
        b=ux+Gs+j9QZGZxLEUvi6/1r3YuacbWW+SyMGzioOL3LeUxcDfM5p9AUBy6D/L6+IvK
         tHo2SAIAxqgyNVZEnKpJrprcnnBKbntuhIINJPvJhlw8hVmsiP3VfHd8w9ptbM718C
         fOoeAUZmsaT0a45R9LIpGa+xTh3YuxJMZRxnRxAY=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9OBemRS128764
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Oct 2019 06:40:48 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 24
 Oct 2019 06:40:36 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 24 Oct 2019 06:40:36 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9OBeiTA044238;
        Thu, 24 Oct 2019 06:40:44 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <aniljoy@cadence.com>, <adouglas@cadence.com>, <nsekhar@ti.com>,
        <jsarha@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 0/3] phy: cadence: j721e-wiz: Add Type-C plug flip support
Date:   Thu, 24 Oct 2019 14:40:39 +0300
Message-ID: <20191024114042.30237-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On J721e platform, the 2 lanes of SERDES PHY are used to achieve
USB Type-C plug flip support without any additional MUX component
by using a lane swap feature.

However, the driver needs to know the Type-C plug orientation before
it can decide whether to swap the lanes or not. This is achieved via a
GPIO named DIR.

Another constraint is that the lane swap must happen only when the PHY
is in inactive state. This is achieved by sampling the GPIO and
programming the lane swap before bringing the PHY out of reset.

This series adds support to read the GPIO and accordingly program
the Lane swap for Type-C plug flip support.

Series must be applied on top of
https://lkml.org/lkml/2019/10/23/589

cheers,
-roger

Changelog:
v3
- Rebase on v2 of PHY series and update DT binding to yaml

v2
- revise commit log of patch 1
- use regmap_field in patch 3

Roger Quadros (3):
  phy: cadence: Sierra: add phy_reset hook
  dt-bindings: phy: ti,phy-j721e-wiz: Add Type-C dir GPIO
  phy: ti: j721e-wiz: Manage typec-gpio-dir

 .../bindings/phy/ti,phy-j721e-wiz.yaml        | 15 ++++++
 drivers/phy/cadence/phy-cadence-sierra.c      | 10 ++++
 drivers/phy/ti/phy-j721e-wiz.c                | 48 +++++++++++++++++++
 3 files changed, 73 insertions(+)

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


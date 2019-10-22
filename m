Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD39CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89F721783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WFSGM0/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387953AbfJVNXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 09:23:12 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42580 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731900AbfJVNXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:23:12 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9MDN92i086982;
        Tue, 22 Oct 2019 08:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571750589;
        bh=959IPe/7SWQE1ma2r3Hx0VuoAIgKUJl/uvGTSglRrsc=;
        h=From:To:CC:Subject:Date;
        b=WFSGM0/V6TqcnEVBMWnHd9yjA1CsWzQVexn9Dwql6jFzaqhnHObk+oVDqh6KylkDS
         SBao+6htLGAj4CbO7sJcq3RnXima0qaekXlFkoYOODcgCXUcrPVY30oMlo7keHiZ8D
         7M+GSVJI2RmbwvZvseo//yoAC8z+OZEEwdFgWE6Y=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9MDN9Xg068061
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Oct 2019 08:23:09 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 22
 Oct 2019 08:23:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 22 Oct 2019 08:22:59 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9MDMplY126427;
        Tue, 22 Oct 2019 08:22:52 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <aniljoy@cadence.com>, <adouglas@cadence.com>, <nsekhar@ti.com>,
        <jsarha@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/3] phy: cadence: j721e-wiz: Add Type-C plug flip support
Date:   Tue, 22 Oct 2019 16:22:46 +0300
Message-ID: <20191022132249.869-1-rogerq@ti.com>
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
https://lkml.org/lkml/2019/10/16/517

cheers,
-roger

Roger Quadros (3):
  phy: cadence: Sierra: add phy_reset hook
  dt-bindings: phy: ti,phy-j721e-wiz: Add Type-C dir GPIO
  phy: ti: j721e-wiz: Manage typec-gpio-dir

 .../bindings/phy/ti,phy-j721e-wiz.txt         |  9 ++++
 drivers/phy/cadence/phy-cadence-sierra.c      | 10 +++++
 drivers/phy/ti/phy-j721e-wiz.c                | 41 +++++++++++++++++++
 3 files changed, 60 insertions(+)

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


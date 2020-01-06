Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68911C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8F62071A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vG0Dwof6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgAFNGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 08:06:30 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34320 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAFNGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 08:06:30 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 006D6TOR036477;
        Mon, 6 Jan 2020 07:06:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578315989;
        bh=FiaiAj6o2ffErboSC3mRjZlAOopJcdK9DwyDXGch9io=;
        h=From:To:CC:Subject:Date;
        b=vG0Dwof68YBBqiw6UkWrJuhzZo/ICr1pJlBAkmyGVd1edDvUKRzubsfZnoCqL87Bd
         vfG/7u495jmNkVq8AOgok7sZbZOGLG6l1zLMC7Ge/7RbC5CQAE3Rlszaq51kWxpgeM
         REHcWUTmX4raodIGjsOL81Lotg4e6LCAMURAL5Z0=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 006D6T7C014300
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Jan 2020 07:06:29 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 6 Jan
 2020 07:06:27 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 6 Jan 2020 07:06:27 -0600
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 006D6PkG089522;
        Mon, 6 Jan 2020 07:06:26 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <aniljoy@cadence.com>, <adouglas@cadence.com>, <nsekhar@ti.com>,
        <jsarha@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 0/3] phy: cadence: j721e-wiz: Add Type-C plug flip support
Date:   Mon, 6 Jan 2020 15:06:19 +0200
Message-ID: <20200106130622.29703-1-rogerq@ti.com>
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
https://patchwork.kernel.org/cover/11293671/

cheers,
-roger

Changelog:
v4
- fixes in dt-binding document
  - fix typo
  - change to typec-dir-debounce-ms and add min/max/default values
  - drop reference to uint32 type
- fixes in driver
  - change to updated typec-dir-debounce-ms property
  - add limit checks and use default value if not specified

v3
- Rebase on v2 of PHY series and update DT binding to yaml

v2
- revise commit log of patch 1
- use regmap_field in patch 3


Roger Quadros (3):
  phy: cadence: Sierra: add phy_reset hook
  dt-bindings: phy: ti,phy-j721e-wiz: Add Type-C dir GPIO
  phy: ti: j721e-wiz: Manage typec-gpio-dir

 .../bindings/phy/ti,phy-j721e-wiz.yaml        | 17 ++++++
 drivers/phy/cadence/phy-cadence-sierra.c      | 10 +++
 drivers/phy/ti/phy-j721e-wiz.c                | 61 +++++++++++++++++++
 3 files changed, 88 insertions(+)

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


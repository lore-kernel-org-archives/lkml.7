Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACAEC28CC1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C5120665
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dDDtLYSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfE2JTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:19:53 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48898 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfE2JTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:19:49 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4T9JZpG094297;
        Wed, 29 May 2019 04:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559121575;
        bh=pD2afg8ofvK0cb0RAbvjzW2bemZQRBl5lxbbNYc8M6A=;
        h=From:To:CC:Subject:Date;
        b=dDDtLYSmu2+5NXhWw1v5uwk8764xa6V5fUSx23k+6TLcnEm9X5MwlguJhGd5If2Uy
         3DdNsNLDtSwtwQZxXifvRQe37A0IrGY8KzVe8qcO9nWBz4JYUZN+L4+5fa25V+s1ii
         wxEmkiHE0hHQ7EyH5oL9iw6gwfhwqYNpJTkaMK0E=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4T9JZ2G049785
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 May 2019 04:19:35 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 29
 May 2019 04:19:35 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 29 May 2019 04:19:35 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4T9JVxN079377;
        Wed, 29 May 2019 04:19:32 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 0/6] AM654: Add PCIe and SERDES DT nodes 
Date:   Wed, 29 May 2019 14:48:06 +0530
Message-ID: <20190529091812.20764-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series adds PCIe and SERDES DT nodes to k3-am65.dtsi and keeps
them disabled in k3-am654-base-board.dts since there are no PCIe
slots in the base board.

PCIe slots are actually present in add on boards. Once overlay support
is merged, I'll add overlay DTS files to enable PCIe.

All the driver patches and binding documentation patches for PCIe and
SERDES are already merged.

Kishon Vijay Abraham I (6):
  arm64: dts: k3-am6: Add "socionext,synquacer-pre-its" property to
    gic_its
  arm64: dts: k3-am6: Add mux-controller DT node required for muxing
    SERDES
  arm64: dts: k3-am6: Add SERDES DT node
  arm64: dts: k3-am6: Add PCIe Root Complex DT node
  arm64: dts: k3-am6: Add PCIe Endpoint DT node
  arm64: dts: ti: am654-base-board: Disable SERDES and PCIe

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 128 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am65.dtsi           |   1 +
 .../arm64/boot/dts/ti/k3-am654-base-board.dts |  24 ++++
 3 files changed, 153 insertions(+)

-- 
2.17.1


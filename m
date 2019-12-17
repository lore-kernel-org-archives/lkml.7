Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFC6C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3250A206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u2nK1G05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfLQKPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:15:12 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60404 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbfLQKPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 05:15:12 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBHAEtIk044796;
        Tue, 17 Dec 2019 04:14:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576577695;
        bh=2QUGTYgZ96oe/K1GDPMSjyUVLllRvww4faZITebRAmY=;
        h=From:To:CC:Subject:Date;
        b=u2nK1G05tJD0nmcLRsprCWm/zdzeygjICZZlsxP0WdqtnK06K9bRVzU2YlRMeuSc7
         KjYQV9/xa5TDiem5+6XsL+E/J0Y+Xv4gUTkTUnhtOrzrYJwr6+wTj4cSQ+AV51CrMn
         KfTaW3zG4v5Kp6ukXMM0uKr9tOBrheX6IdgaYHeQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBHAEt7w042307
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Dec 2019 04:14:55 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 04:14:54 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 04:14:54 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBHAEp6M086932;
        Tue, 17 Dec 2019 04:14:51 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <a.hajda@samsung.com>,
        <narmstrong@baylibre.com>
CC:     <tomi.valkeinen@ti.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>
Subject: [PATCH 0/2] drm/bridge: Support for Toshiba tc358768 RGB to DSI bridge
Date:   Tue, 17 Dec 2019 12:15:04 +0200
Message-ID: <20191217101506.18910-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

TC358768 is a parallel RGB to MIPI DSI bridge.

The initial driver supports MIPI_DSI_MODE_VIDEO, MIPI_DSI_FMT_RGB888 and
only write is implemented for mipi_dsi_host_ops.transfer due to lack of hardware
where other modes can be tested.

Regards,
Peter
---
Peter Ujfalusi (2):
  dt-bindings: display: bridge: Add documentation for Toshiba tc358768
  drm/bridge: Add tc358768 driver

 .../display/bridge/toshiba,tc358768.yaml      | 158 +++
 drivers/gpu/drm/bridge/Kconfig                |  10 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/tc358768.c             | 963 ++++++++++++++++++
 4 files changed, 1132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
 create mode 100644 drivers/gpu/drm/bridge/tc358768.c

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


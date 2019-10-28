Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F3ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E809220B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YfYP3vu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387899AbfJ1Jhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 05:37:41 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41484 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733224AbfJ1Jhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:37:41 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9S9bYrl098528;
        Mon, 28 Oct 2019 04:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572255454;
        bh=YtAxq8vmDcqPRQcPeoAHayL8HjbCgszHi2svGRDTwkQ=;
        h=From:To:CC:Subject:Date;
        b=YfYP3vu+opbSnCR66ZodwrSr10hn5NL3woXvfMV8lX+x8iRQK6t8KiFWw9rfMaGoM
         FcvqD2LxLuKWA9WwjjQAyOXbVK/qbro/lz5p0nnESr9FWMszqAYOUiIu2Rr9R/dIjs
         T5iuBKxJ9PikyVV3N9sI8S6Up8HLnIeUPOpy3YMo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9S9bYkK005857
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Oct 2019 04:37:34 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 28
 Oct 2019 04:37:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 28 Oct 2019 04:37:22 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9S9bW4g027237;
        Mon, 28 Oct 2019 04:37:32 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/2] [PATCH 0/2] arm64: dts: ti: k3-j721e: Add USB ports
Date:   Mon, 28 Oct 2019 11:37:28 +0200
Message-ID: <20191028093730.23094-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series enables USB 2.0 support on j721e-common-proc-board.

The USB0 is available as a type-C port. Although it is super-speed
capable, we limit it to high-speed for now till SERDES PHY
support is added.

USB1 is routed via on-board USB2.0 hub to 2 type-A ports. USB1
is used as high-speed host.

Controller side DT binding is approved [1]. Driver [2] is yet to be
in USB tree. This series is safe to be picked for -next.

[1] https://lkml.org/lkml/2019/10/25/1036
[2] https://lkml.org/lkml/2019/10/24/371

Series is based on top of Tero's ti-k3-next branch.

cheers,
-roger

Roger Quadros (2):
  arm64: dts: ti: k3-j721e-main: add USB controller nodes
  arm64: dts: ti: k3-j721e-common-proc-board: Add USB ports

 .../dts/ti/k3-j721e-common-proc-board.dts     | 35 +++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 60 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          |  2 +
 3 files changed, 97 insertions(+)

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B168FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EACF21873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bl9/7kqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfCVI6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:58:13 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48002 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfCVI6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:58:12 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2M8wC7Y108844
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 03:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553245092;
        bh=Gzk/45QQcTBUUVcyPn9RJXmzH4qvdOH+gatLG+/RW7k=;
        h=From:To:CC:Subject:Date;
        b=bl9/7kqgopBxdE64BsCSmz3BKKSeLVNgjJjvNYmLo86tT4Shoh+UUx+qIy6rYtNhl
         BWHWnP2K/Yn+pOt5kemiWYWUx0MXKTDDmtKNMA63T7/CbqaOoEdrMTN0c6Qkjdq8Cl
         7hs3rdiAuUx3vrfHuyTMi+/KvEajbg402R7xq8VI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2M8wCwO076637
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 03:58:12 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 22
 Mar 2019 03:58:11 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Fri, 22 Mar 2019 03:58:11 -0500
Received: from lta0400828d.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2M8w9b6016866;
        Fri, 22 Mar 2019 03:58:10 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <nsekhar@ti.com>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/4] phy: ti-pipe3: Match TRM sequence & settings
Date:   Fri, 22 Mar 2019 10:58:03 +0200
Message-ID: <20190322085807.30216-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

We need to follow the TRM sequence and settings to ensure
that the DPLL & PHY operates correctly over the entire
temperature range.

Tested for SATA and USB. PCIe not tested.

Since this is a bug fix, please queue this for v5.1-rc. Thanks.

cheers,
-roger

Roger Quadros (4):
  phy: ti-pipe3: Introduce mode property in driver data
  phy: ti-pipe3: improve DPLL stability for SATA & USB
  phy: ti-pipe3: Fix SATA & USB PHY power up sequence
  phy: ti-pipe3: Fix PCIe power up sequence

 drivers/phy/ti/phy-ti-pipe3.c | 362 +++++++++++++++++++++++++---------
 1 file changed, 265 insertions(+), 97 deletions(-)

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


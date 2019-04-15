Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCE6C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366612075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JVRn9nHg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfDOPdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:33:45 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47048 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfDOPdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:33:35 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3FFXTEr019982;
        Mon, 15 Apr 2019 10:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555342410;
        bh=d+Wh0VTJ2VOIWi63QmcKMh7we6eeXuvCOUUqUH5lsoU=;
        h=From:To:Subject:Date;
        b=JVRn9nHgs3cAnHP1wRzpjCIyVUNuhYb+PymPp46zGyPP4z/j5E1Ls60D+WY1uLpED
         8dgJB5MD0RHCXiximON98yNbQTSOgxnAN8UY7/jTyzA/UqUg6/E52oU1I8l5kkHil8
         uoEe6IMg5DSM6XZduhhZtdShQjhJnNTk1jwJE+l0=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3FFXToW017046
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Apr 2019 10:33:29 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 15
 Apr 2019 10:33:29 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 15 Apr 2019 10:33:29 -0500
Received: from uda0868495.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3FFXTjV041063;
        Mon, 15 Apr 2019 10:33:29 -0500
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <arvid.brodin@alten.se>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [net-next PATCH v2 0/3] net: hsr: updates from internal tree
Date:   Mon, 15 Apr 2019 11:36:00 -0400
Message-ID: <20190415153603.23110-1-m-karicheri2@ti.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series picks commit from our internal kernel tree.
Patch 1/3 fixes a file name issue introduced in my previous
series.

History:
  v2: fixed patch 3/3 by moving stats update to inside hsr_forward_skb()

Murali Karicheri (3):
  net: hsr: fix naming of file and functions
  net: hsr: fix debugfs path to support multiple interfaces
  net: hsr: add tx stats for master interface

 net/hsr/Makefile                             |  2 +-
 net/hsr/{hsr_prp_debugfs.c => hsr_debugfs.c} | 43 ++++++++++----------
 net/hsr/hsr_device.c                         |  4 +-
 net/hsr/hsr_forward.c                        |  7 ++++
 net/hsr/hsr_main.h                           |  9 ++--
 5 files changed, 36 insertions(+), 29 deletions(-)
 rename net/hsr/{hsr_prp_debugfs.c => hsr_debugfs.c} (69%)

-- 
2.17.0


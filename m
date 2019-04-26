Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CA2C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EFF2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EDdR4qWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfDZOtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:49:20 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5914 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZOtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:49:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cc31a540000>; Fri, 26 Apr 2019 07:48:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Apr 2019 07:49:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 26 Apr 2019 07:49:19 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Apr
 2019 14:49:18 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Apr
 2019 14:49:13 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Apr 2019 14:49:13 +0000
Received: from jilin-desktop.nvidia.com (Not Verified[10.19.120.158]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cc31a680003>; Fri, 26 Apr 2019 07:49:13 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <linux-usb@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Jim Lin <jilin@nvidia.com>
Subject: [PATCH 0/6] usb: Add Clear_TT_Buffer support for XHCI
Date:   Fri, 26 Apr 2019 22:48:50 +0800
Message-ID: <1556290130-9347-1-git-send-email-jilin@nvidia.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556290132; bh=YzqpUvL51O4n95yCZRL8D+pU+RFggNCEs1Lp2kuNky0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=EDdR4qWsAXXXg0C3TDUD3xecbzPneHe3hjPmeFZd3IhnbxeDStJmSU45A8lNdA5PX
         9LXCN2xXyvnOwkiLy9ghs2eyNOU75jJ6l/W8P5o18pkrMn6EJGIzRmfauvNhBA9ruY
         b0DyQguhz6PVHXZZxjW/CcJOEimjU2MKnnqs95jrhc0aHqt2cRBfQ3mqlMlbtnqd6Z
         JQK2oK4PQaRyMClVMODHrnbGT/0eXXNnyvUy0prJGklQGzIKOF4QnK5o7aRpopPaXK
         FRyTWR5ALNcRcZu4jA0Zc/q8DNW8TJzcg03P8AnbXU1Pqiw+vF3fvYzVVlz39WzHNX
         MrP2jsIDZaALA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Lin (6):
  usb: hub:Extend usb_hub_clear_tt_buffer parameter
  usb: isp1760:Adjusted for usb_hub_clear_tt_buffer
  usb: fotg210:Adjusted for usb_hub_clear_tt_buffer
  usb: ehci: Adjusted for usb_hub_clear_tt_buffer
  usb: dwc2: Adjusted for usb_hub_clear_tt_buffer
  usb: xhci: Add Clear_TT_Buffer

 drivers/usb/core/hub.c            |  5 +++--
 drivers/usb/dwc2/hcd_intr.c       |  2 +-
 drivers/usb/host/ehci-q.c         |  2 +-
 drivers/usb/host/fotg210-hcd.c    |  2 +-
 drivers/usb/host/xhci-ring.c      | 25 +++++++++++++++++++++++++
 drivers/usb/host/xhci.c           |  7 +++++++
 drivers/usb/host/xhci.h           |  3 +++
 drivers/usb/isp1760/isp1760-hcd.c |  5 +++--
 include/linux/usb/hcd.h           |  2 +-
 9 files changed, 45 insertions(+), 8 deletions(-)

-- 
2.1.4


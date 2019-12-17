Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6482CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244DB218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Wbpn/zVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfLQNch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:32:37 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:59273 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfLQNcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:32:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576589555; x=1608125555;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=onLQnvSBL3lNxDnDN4WMJbsPXtOY8gXICW/wG+jHVxA=;
  b=Wbpn/zVSeGDIxNJVGP8raHdYBFEoI4EIkq+OZcGkgFd0nj34JfFyNU+u
   xloKxE3rS7dmvUaC3ZrCo5WffEHrjOcRGERRFwWJYgWLabJwjwFa7NAtO
   pUgMZv/1HzxOxHMmv/mmcLig/VPO//6R6z10e+DebpNFzYjpsj7IWqzsd
   Q=;
IronPort-SDR: wLNC9ZIehASY3f9dI/UiaPPmHOoqvQqvhd83w4KLqwpCJJU/JxA54jXs6vLnq7tEwgK7u4xP8w
 vLdHImIkxGbg==
X-IronPort-AV: E=Sophos;i="5.69,325,1571702400"; 
   d="scan'208";a="15379886"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 17 Dec 2019 13:32:25 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (Postfix) with ESMTPS id 4C13FA16A1;
        Tue, 17 Dec 2019 13:32:24 +0000 (UTC)
Received: from EX13D32EUC001.ant.amazon.com (10.43.164.159) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 17 Dec 2019 13:32:23 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D32EUC001.ant.amazon.com (10.43.164.159) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 17 Dec 2019 13:32:22 +0000
Received: from u2f063a87eabd5f.cbg10.amazon.com (10.125.106.135) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 17 Dec 2019 13:32:20 +0000
From:   Paul Durrant <pdurrant@amazon.com>
To:     <xen-devel@lists.xenproject.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Paul Durrant <pdurrant@amazon.com>
Subject: [PATCH net-next 0/3] xen-netback: clean-up
Date:   Tue, 17 Dec 2019 13:32:15 +0000
Message-ID: <20191217133218.27085-1-pdurrant@amazon.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Durrant (3):
  xen-netback: move netback_probe() and netback_remove() to the end...
  xen-netback: switch state to InitWait at the end of netback_probe()...
  xen-netback: remove 'hotplug-status' once it has served its purpose

 drivers/net/xen-netback/xenbus.c | 350 +++++++++++++++----------------
 1 file changed, 171 insertions(+), 179 deletions(-)

-- 
2.20.1


Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D4AC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 12:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01173206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 12:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgAHMxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 07:53:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:3862 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbgAHMxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 07:53:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 04:53:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="303544485"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 08 Jan 2020 04:53:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1F3FA14B; Wed,  8 Jan 2020 14:53:18 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 1/2] thunderbolt: Fix xhci check in usb4_switch_setup()
Date:   Wed,  8 Jan 2020 15:53:16 +0300
Message-Id: <20200108125317.36444-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108125317.36444-1-mika.westerberg@linux.intel.com>
References: <20200108125317.36444-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code tried to check whether xhci variable has ROUTER_CS_6_HCI bit
set but since xhci type is bool and it already holds true or false based
on that very bit, fix the check to use the variable directly.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: b04079837b20 ("thunderbolt: Add initial support for USB4")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/usb4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index dbe7ecce4505..b341fc60c4ba 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -239,7 +239,7 @@ int usb4_switch_setup(struct tb_switch *sw)
 		 * and the parent does not have any USB3 dowstream
 		 * adapters (so we cannot do USB 3.x tunneling).
 		 */
-		if (xhci & ROUTER_CS_6_HCI)
+		if (xhci)
 			val |= ROUTER_CS_5_HCO;
 	}
 
-- 
2.24.1


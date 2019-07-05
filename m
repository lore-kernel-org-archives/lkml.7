Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2825C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA482147A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfGEJ6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 05:58:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:55406 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728402AbfGEJ6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:58:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 02:58:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,454,1557212400"; 
   d="scan'208";a="164830667"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jul 2019 02:58:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id CAF9681; Fri,  5 Jul 2019 12:58:00 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 1/8] thunderbolt: Correct path indices for PCIe tunnel
Date:   Fri,  5 Jul 2019 12:57:53 +0300
Message-Id: <20190705095800.43534-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705095800.43534-1-mika.westerberg@linux.intel.com>
References: <20190705095800.43534-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCIe tunnel path indices got mixed up when we added support for tunnels
between switches that are not adjacent. This did not affect the
functionality as it is just an index but fix it now nevertheless to make
the code easier to understand.

Reported-by: Rajmohan Mani <rajmohan.mani@intel.com>
Fixes: 8c7acaaf020f ("thunderbolt: Extend tunnel creation to more than 2 adjacent switches")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/tunnel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index 31d0234837e4..5a99234826e7 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -211,7 +211,7 @@ struct tb_tunnel *tb_tunnel_alloc_pci(struct tb *tb, struct tb_port *up,
 		return NULL;
 	}
 	tb_pci_init_path(path);
-	tunnel->paths[TB_PCI_PATH_UP] = path;
+	tunnel->paths[TB_PCI_PATH_DOWN] = path;
 
 	path = tb_path_alloc(tb, up, TB_PCI_HOPID, down, TB_PCI_HOPID, 0,
 			     "PCIe Up");
@@ -220,7 +220,7 @@ struct tb_tunnel *tb_tunnel_alloc_pci(struct tb *tb, struct tb_port *up,
 		return NULL;
 	}
 	tb_pci_init_path(path);
-	tunnel->paths[TB_PCI_PATH_DOWN] = path;
+	tunnel->paths[TB_PCI_PATH_UP] = path;
 
 	return tunnel;
 }
-- 
2.20.1


Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6350C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B42C20820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbfDJNhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:37:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:48802 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731969AbfDJNg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:36:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 06:36:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="134566077"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 10 Apr 2019 06:36:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5B95B73; Wed, 10 Apr 2019 16:36:54 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com, Joe Perches <joe@perches.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        netdev@vger.kernel.org
Subject: [PATCH v4 01/36] net: thunderbolt: Unregister ThunderboltIP protocol handler when suspending
Date:   Wed, 10 Apr 2019 16:36:18 +0300
Message-Id: <20190410133653.88061-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410133653.88061-1-mika.westerberg@linux.intel.com>
References: <20190410133653.88061-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XDomain protocol messages may start as soon as Thunderbolt control
channel is started. This means that if the other host starts sending
ThunderboltIP packets early enough they will be passed to the network
driver which then gets confused because its resume hook is not called
yet.

Fix this by unregistering the ThunderboltIP protocol handler when
suspending and registering it back on resume.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: David S. Miller <davem@davemloft.net>
---
 drivers/net/thunderbolt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/thunderbolt.c b/drivers/net/thunderbolt.c
index c48c3a1eb1f8..fcf31335a8b6 100644
--- a/drivers/net/thunderbolt.c
+++ b/drivers/net/thunderbolt.c
@@ -1282,6 +1282,7 @@ static int __maybe_unused tbnet_suspend(struct device *dev)
 		tbnet_tear_down(net, true);
 	}
 
+	tb_unregister_protocol_handler(&net->handler);
 	return 0;
 }
 
@@ -1290,6 +1291,8 @@ static int __maybe_unused tbnet_resume(struct device *dev)
 	struct tb_service *svc = tb_to_service(dev);
 	struct tbnet *net = tb_service_get_drvdata(svc);
 
+	tb_register_protocol_handler(&net->handler);
+
 	netif_carrier_off(net->dev);
 	if (netif_running(net->dev)) {
 		netif_device_attach(net->dev);
-- 
2.20.1


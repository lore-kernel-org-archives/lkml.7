Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA180C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769A020872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbfDPNjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:39:44 -0400
Received: from shell.v3.sk ([90.176.6.54]:40180 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbfDPNjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:39:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5136F101D74;
        Tue, 16 Apr 2019 15:39:41 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id L0j6f5T2mRsM; Tue, 16 Apr 2019 15:39:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0E977101D78;
        Tue, 16 Apr 2019 15:39:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dmBBQMEss0Ry; Tue, 16 Apr 2019 15:39:37 +0200 (CEST)
Received: from furthur.com (ovpn-brq.redhat.com [213.175.37.11])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 2995F101D74;
        Tue, 16 Apr 2019 15:39:37 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] mmc: core: try to use an id from the devicetree
Date:   Tue, 16 Apr 2019 15:39:30 +0200
Message-Id: <20190416133930.1819-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there's a mmc* alias in the device tree, take the device number from
it, so that we end up with a device name that matches the alias.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/mmc/core/host.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 3a4402a79904..9e2c31b9366e 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -411,7 +411,12 @@ struct mmc_host *mmc_alloc_host(int extra, struct de=
vice *dev)
 	/* scanning will be enabled when we're ready */
 	host->rescan_disable =3D 1;
=20
-	err =3D ida_simple_get(&mmc_host_ida, 0, 0, GFP_KERNEL);
+	/* prefer an alias */
+	err =3D of_alias_get_id(dev->of_node, "mmc");
+	if (err < 0)
+		err =3D 0;
+
+	err =3D ida_simple_get(&mmc_host_ida, err, 0, GFP_KERNEL);
 	if (err < 0) {
 		kfree(host);
 		return NULL;
--=20
2.21.0


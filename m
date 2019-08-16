Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ABFC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 18:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D92206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 18:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfHPSTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 14:19:03 -0400
Received: from shell.v3.sk ([90.176.6.54]:58664 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbfHPSTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 14:19:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A3849D6DCA;
        Fri, 16 Aug 2019 20:19:00 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8xACAA8R7c2M; Fri, 16 Aug 2019 20:18:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id BB7FBD6DCB;
        Fri, 16 Aug 2019 20:18:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dkLWR9CXZMC3; Fri, 16 Aug 2019 20:18:56 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id DF07FD6DCA;
        Fri, 16 Aug 2019 20:18:55 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] irqchip/mmp: do not call irq_set_default_host() on DT platforms
Date:   Fri, 16 Aug 2019 20:18:49 +0200
Message-Id: <20190816181849.522335-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's unnecessary.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/irqchip/irq-mmp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index af9cba4a51c2e..b34d0ccdb1f47 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -395,7 +395,6 @@ static int __init mmp_of_init(struct device_node *nod=
e,
 	icu_data[0].conf_enable =3D mmp_conf.conf_enable;
 	icu_data[0].conf_disable =3D mmp_conf.conf_disable;
 	icu_data[0].conf_mask =3D mmp_conf.conf_mask;
-	irq_set_default_host(icu_data[0].domain);
 	set_handle_irq(mmp_handle_irq);
 	max_icu_nr =3D 1;
 	return 0;
@@ -414,7 +413,6 @@ static int __init mmp2_of_init(struct device_node *no=
de,
 	icu_data[0].conf_enable =3D mmp2_conf.conf_enable;
 	icu_data[0].conf_disable =3D mmp2_conf.conf_disable;
 	icu_data[0].conf_mask =3D mmp2_conf.conf_mask;
-	irq_set_default_host(icu_data[0].domain);
 	set_handle_irq(mmp2_handle_irq);
 	max_icu_nr =3D 1;
 	return 0;
--=20
2.21.0


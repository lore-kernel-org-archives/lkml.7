Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA32C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3691C218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfDXKfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:35:02 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:42655 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbfDXKfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:35:00 -0400
Received: from orion.localdomain ([95.114.95.254]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MvKGv-1gSvZC2CyP-00rHys; Wed, 24 Apr 2019 12:34:51 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, linux-ide@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 2/3] drivers: libata: introduce sysctl directory
Date:   Wed, 24 Apr 2019 12:34:40 +0200
Message-Id: <1556102081-11820-3-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556102081-11820-1-git-send-email-info@metux.net>
References: <1556102081-11820-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:H1/Uq2LSUgMGcAi8IOWYcZdUmY2cjBmhpocX5+nkVqLWDYczkCD
 f5AyOoMlGWLSQl/o3Li9wab/Bke0pRGsFQv5WWNOrUZcM1U2hNlR5vjM23AOZsyzuqmF8Oq
 sKPTF/y9/rtANc+N0aPmCwsG8V8pDoCVXrW5iGd6nCMUKfRT1YvQ2JpiIKxWWl4wwiqE9gH
 9fTD2vYEsX4SUY3AiRAXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MOfYQJ2zZCg=:AoeQ+16JtQ1rs6I7dFYaZT
 NT1E/Y7Fi8HdDMUxtWb8HsZzdlurhSJC+KkQrRgonbLT1VviWxFkDpal7FUHrywGwnffiVOHZ
 CfPh+n7/af94TL8AK/oj+LoAvirH05C42f3cmBMND+KG6OWInZLvJX5llTAMEWYFc4+fwN7GI
 xpir2lu6czLW2PX/kUC6nBlofsnzVPgN15l7z1eu/DNuOMuX48sEyPrAVCM2LhEesO6zdae8Q
 nu7xwqkmUvOQ21RHBWON8Y5VnkDOHwU+WlRzfrZXwEyeGg1dw40GsL9sFCnnNUxzZ8+4BvPll
 cfwdHBbFG4nXY3gmVeHyo0Zz+eMRYcxUQhC4mjn9Sg0zhkE4DJc2MlY3al+5L1qgaaHJ9otu+
 Bc3AhGdviYPQHigVV7D6OG6Ul7nD+8S8U9slZ4+TC9ryxnEdt6vqJUxEZkVf3MjRxdhxNM4lc
 8q1rq2zItXtwFAArrGWAkC67YFpPHTDzHmeJf7X0JrMC1cPY2jlOAUJDR1R4sqcj78Nmigcyd
 K0ef7AMkQYB41ejYZHpxCiXmOk104/Di1S4PVXcsE8RXLOG4UROmKZM31HrFfHS6b5pZ+tWxy
 Z/3Kt03fO8hMSjmbQlC/ObhoftgKHiWazAKvbV06+Qm23VB/nZPNqdGKSFEegnx5iAI+uX6W2
 Rm1ZoIctujsIpP3tmWHIJHsoiRneZ21G0G9eQkvzvZVuWjzd5hS0fF+4ddytdybL6iMlNP4tN
 1eZg0bnXATqUncjQFcPUt/cWeeUfZYLBb74ZUg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register a sysctl directory for libata, so upcoming knobs
can be added here.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ata/libata-core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index adf2878..d3044c9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -176,6 +176,21 @@ struct ata_force_ent {
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
+static struct ctl_table ctl_libata[] = {
+	{}
+};
+
+static struct ctl_table libata_dir_table[] = {
+	{
+		.procname	= "libata",
+		.maxlen		= 0,
+		.mode		= 0555,
+		.child		= ctl_libata,
+	},
+	{ },
+};
+
+static struct ctl_table_header *libata_sysctl_header;
 
 static bool ata_sstatus_online(u32 sstatus)
 {
@@ -7059,6 +7074,8 @@ static int __init ata_init(void)
 		goto err_out;
 	}
 
+	libata_sysctl_header = register_sysctl_table(libata_dir_table);
+
 	printk(KERN_DEBUG "libata version " DRV_VERSION " loaded.\n");
 	return 0;
 
@@ -7072,6 +7089,7 @@ static void __exit ata_exit(void)
 	libata_transport_exit();
 	ata_sff_exit();
 	kfree(ata_force_tbl);
+	unregister_sysctl_table(libata_sysctl_header);
 }
 
 subsys_initcall(ata_init);
-- 
1.9.1


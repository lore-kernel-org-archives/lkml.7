Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80090C46460
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AAB020717
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfFELgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 07:36:36 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:33687 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfFELgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:36:33 -0400
Received: from orion.localdomain ([77.2.1.21]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MPooP-1hBkZ223Dn-00MpA3; Wed, 05 Jun 2019 13:36:31 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, linux-ide@vger.kernel.org
Subject: [PATCH v2 1/2] drivers: libata: introduce sysctl directory
Date:   Wed,  5 Jun 2019 13:36:26 +0200
Message-Id: <1559734587-32596-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559734587-32596-1-git-send-email-info@metux.net>
References: <1559734587-32596-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:Nd1EJE4jg0DRCDK6mozqx2qAeh+vBW+I71rnAj7FO8XVn2fF3uu
 zBYcBIH+fxGt6YGNxayt9YiiTC2E2Qs/+4JNFpsKJ0Atn7AvOfbYzr3JJNkJvuaLbSUyktq
 Kaj3XLQOZc64L5OR3XZRa2Bx5IOz47DzsKWZJYBCqvyNDYnHjvovkJP/qnrkl4zHQtI6Ojy
 wvvAgsbDQ/4MCzFYU45hg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6WAx2DSri1U=:0FUYR8aS4Jrhj2UYxp1F7S
 7d4A73MyjgQ7as9aXRGrSFY3s2P0jBsOw9P9Sz6rEt7o07wKmWriW9KNMe1V0SBdRZ2yZh1rN
 naZXXa5X2z32A9pNMSznRFZVCgc6O7ulZPREcgdcyUe5IgO8Pxm08Z2qbMCDChQAWhL19xSV/
 GdIuXHJzkutoWkgR28/cEbU9LGlOIT0QIOzDmnzTFF23heZ9slK8ixkD2gvd8DH4LHEozQlFd
 n6+BqwewBaw5pvUNItPwx05VkrsOgHh3w85uCYbCdYRzGQtcHpreaGU+y6Wvp0VO8M7Hlm/S4
 DMw4eM71DYZ4OQOtMBcNU2ysmJU30p8niAe6H/3sbmIusOyG85ULPy0qyEQVhXKSD7DYIlfjD
 hWVZOnsXJEerYhySZ1vr5UhFp/LL1uwFxpPOgCRphzAoHdfgED5TaVS7+CC4gGx2JKIXS3LDj
 hZ0UR+hMmD+7gOZ133dhJHYXBpDeai1pMwNO5IymZt5gUCjRW9Kj+EMxtRk8VTCsSL1s7MEAq
 p/ltBAfkjuLYiCMfLruO8bBa+H6z9yXcMaHoWRT/DwHHbszKFEjudYeiOPoeHTGtsWpz/62qt
 flvmHJb/8EU3AkBC3cc5soms68OYjyMHdQBhBLflW3756NhoHgF/gpPVRTbrDjK6o8QfS8RZx
 D8xc/7peUHnLsSTvm1ia6jqC2PsdGikoC1nyMEIJiUHPnfn05IZr4HdmPyCx48D7wLbA9QqPk
 NTi+baT+ffQpmqzG5F36vT8t7DJAohR/jMEfZg==
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
index aaa57e0..2af2470 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -160,6 +160,21 @@ struct ata_force_ent {
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
@@ -7043,6 +7058,8 @@ static int __init ata_init(void)
 		goto err_out;
 	}
 
+	libata_sysctl_header = register_sysctl_table(libata_dir_table);
+
 	printk(KERN_DEBUG "libata version " DRV_VERSION " loaded.\n");
 	return 0;
 
@@ -7056,6 +7073,7 @@ static void __exit ata_exit(void)
 	libata_transport_exit();
 	ata_sff_exit();
 	kfree(ata_force_tbl);
+	unregister_sysctl_table(libata_sysctl_header);
 }
 
 subsys_initcall(ata_init);
-- 
1.9.1


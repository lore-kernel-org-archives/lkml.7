Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0193C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49FA20717
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfFELgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 07:36:35 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:35923 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfFELgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:36:33 -0400
Received: from orion.localdomain ([77.2.1.21]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MkYkC-1gqrir3234-00m7K2; Wed, 05 Jun 2019 13:36:31 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, linux-ide@vger.kernel.org
Subject: [PATCH v2 2/2] drivers: libata: add sysctl: 'libata.allow_tpm' for self-encrypted devices
Date:   Wed,  5 Jun 2019 13:36:27 +0200
Message-Id: <1559734587-32596-3-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559734587-32596-1-git-send-email-info@metux.net>
References: <1559734587-32596-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:IwR76kfF8NbIVzb1DaC9Jlqo/olqobP2qAibfwDa5jwjKWCq6+7
 tAtY2Fg+oEXJOe+FK52GU8eKOGz6NV9N1lhv5JgAD6oEvoIiPqRtBDyONsaTzDbmfS/+Pkc
 riLq9/zMovQdd/nzhSDlVx3NegbL7vRNcHNRSPJ7mVFSYsBhnToy03SfhjDRe9/a91RCOAS
 VBB3T421x/TvR8UxJkRqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kzEWbe+lIeA=:7MPQnCVidjtz8XBMgqA11q
 06l4BsMnxYzmg647U3UqwvNwroUGuNX6XCc6qwrWO6xogshgAVjJ6RIm3roVlPewdK63hdYbJ
 Obnrw2J8aIsMoXq3t0RStAtwO/wqH9gUl1MVwkYBGssCL8p8Ve4kBaQEZ/Ixw40w4qsigssnt
 LAHYCFGJGT0pGNhNe9qmM4K8vTJTQUPUQWfDAJY4e97svDGxoMojGBRVNFjCZC9XiMYxy6jq8
 NeG+9ZNMfjW7gcB0rBjIHqsTgBiC4zC8NpZTBCmY8aygPPvwqnOEmzn4AVux+2LFAEwbiIeGz
 vxO/WXM2ojBUgU36gtFB9kG7rl50ZU6BYWMk+tmt33MQuv0LEsCnehYGtJfn8/dp5lc8Dt96Q
 HypFEISjE8jh5EBfzk/KYGu+ms6n8X6EHLp41OJS/RcNdKeO8LgKy7ZAeT24BrbHBqmgLQrMq
 D/eku2Po/OQhw+TwHcuNJpNj2HLGoXz1D7s/iNh+LlYhtzw7yCbA4q9srGkZ5y79aXCvKGGZ7
 FMxsEUhHDqv9uWLtVjxHDyeCVxLGNazE8Uabi/fA9ytEKKpX1/hSHU/QoL3lJEeJSO7stk2EA
 S3C3zRJICTDJJpmGvr2ZCCUHgUFq37KjILOFtVwESMHsYWqy9WdQ4k4wpiGzn1rZ1zPSrARDf
 S2MBhRiQ2PQ03lxg+YSevyiYb2bk6cuuHU/tfWIVo48Fk3XYe3Yre09vLLs7SEGa7piv3peC+
 DNyKPrxXiD7SuEK5QEuwfY/AQzhrLCaBduZ1mw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

libata tpm functionality, needed for self encrypted devices (OPAL, ...),
is currently disabled per default and needs to be enabled via kernel
command line.

This patch allows enabling it via sysctl.

The implementation might look a bit 'naive', as there aren't any locks
or barriers, etc. As we're dealing just w/ a plain boolean value, that's
only checked when an tpm-related ioctl is called, we're fine w/ that.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ata/libata-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2af2470..f241028 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -161,6 +161,13 @@ struct ata_force_ent {
 MODULE_VERSION(DRV_VERSION);
 
 static struct ctl_table ctl_libata[] = {
+	{
+		.procname	= "allow_tpm",
+		.data		= &libata_allow_tpm,
+		.maxlen		= sizeof(libata_allow_tpm),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
 	{}
 };
 
-- 
1.9.1


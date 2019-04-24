Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FED4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696EF218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfDXKfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:35:09 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:43711 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbfDXKfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:35:00 -0400
Received: from orion.localdomain ([95.114.95.254]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MqK2d-1gy9Zw3L63-00nQ5I; Wed, 24 Apr 2019 12:34:51 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, linux-ide@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 3/3] drivers: libata: add sysctl: 'libata.allow_tpm' for self-encrypted devices
Date:   Wed, 24 Apr 2019 12:34:41 +0200
Message-Id: <1556102081-11820-4-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556102081-11820-1-git-send-email-info@metux.net>
References: <1556102081-11820-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:bxkFNe0yRwaU7KT04kyF25rMDgtNFYUHppCXAJGr+VQhYhKBSbJ
 l7r3PUUVlq3PupkEUBPvM6RCm4GUZUFu4TY5StEoIqBPlKjmc64guEnarjJ6iHFQpjX3l47
 ccTEzeRk26lowPFHUQCtvX0kvuavY7Of1YWgw4utnxBbrLOlzJ3RYJhjIx+/I56r0ph7SzY
 FagBGA+p6yF1AQdUgRQ3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NF0ll/bu/ms=:sbSo5mO83/pXu8S4DfB6C9
 d1t6vScaKu4Cm+UkxFoJx9ZU1ptsrn6kfg5ocjfnGPtTO983bCn/Dq5S+HGxWVdD7e27ri65l
 531kjZKwbMsrfiQzVOQ+35bZ8gwQ1TCjFPYCDJkDYgzCoZC8ZFt9gA3080jSvIg9hlLxQbWLz
 gqPc3wI4ZGnYHzznjWJdeez8UyKD6YWWwZuEefbE+GGEermvs7liLwgXJL6PHXsCVPsSOBBKI
 XZyqN7frg3HRr6+kJuetM9/96tx3TmHscJaiAc4JP38oX6Ks7Mh0RDZdEg7VJkvKNbBp4bIfI
 6/SxDISiFULwigqm4YYnJheElnUsKpV41bTf56csFPaFB8u+gOo4tNQCLfNetJbw/E5crQqsC
 oBKCR+5oskJSRAMutFAoaqktnEG/8m5aWQ72dOGHMzRgf4pb4n7HK66fGRyv2bQJEVsInkD4k
 JxmD0sY0aHmVFDg73D1hGdjqIV8ZPpIs3J2WEIRyxCzrzedbKDAqTXl+7unDsMitmxHukmnMy
 OkjXV/tcTaNCe3iKtdW53NsjHWuJo0sE0+N4uSGw+6L2jSoaSr4tQ5mUXHJpt2X5cu4RvfFGp
 e+AWQhVrnQyzy4Aw1UQfxUdIOMdwmZ5pTYEJE2NnQmEGrtxBo6tM/iW4VSwkJyrO0Sp+/sKl9
 GiVAWf3V5YKzGYZFBIVBI1c9Gi2U5gwu+3I7KdG20tjxvokbTUAYR3/K52hR4pvpR8YusD8xQ
 fpqXg2p9jFL3y901X/HLps7vFMwdOBaAhd2ejw==
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
index d3044c9..80ba844 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -177,6 +177,13 @@ struct ata_force_ent {
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


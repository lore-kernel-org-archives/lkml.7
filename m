Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC4DC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 15:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E3A208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 15:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfDMPSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 11:18:25 -0400
Received: from mail5.windriver.com ([192.103.53.11]:33006 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbfDMPSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 11:18:25 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x3DFGKdZ009759
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sat, 13 Apr 2019 08:16:30 -0700
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.439.0; Sat, 13 Apr 2019
 08:16:09 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] sound: soc-acpi: fix implicit header use of module.h/export.h
Date:   Sat, 13 Apr 2019 11:15:18 -0400
Message-ID: <1555168518-15287-1-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file is implicitly relying on an instance of including
module.h from <linux/acpi.h>.

Ideally, header files under include/linux shouldn't be adding
includes of other headers, in anticipation of their consumers,
but just the headers needed for the header itself to pass
parsing with CPP.

The module.h is particularly bad in this sense, as it itself does
include a whole bunch of other headers, due to the complexity of
module support.

Here, we make the include explicit, in order to allow the future
removal of module.h from linux/acpi.h without causing build breakage.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/sound/soc/soc-acpi.c b/sound/soc/soc-acpi.c
index 4fb29f0e561e..444ce0602f76 100644
--- a/sound/soc/soc-acpi.c
+++ b/sound/soc/soc-acpi.c
@@ -4,6 +4,8 @@
 //
 // Copyright (c) 2013-15, Intel Corporation.
 
+#include <linux/export.h>
+#include <linux/module.h>
 #include <sound/soc-acpi.h>
 
 struct snd_soc_acpi_mach *
-- 
2.11.0


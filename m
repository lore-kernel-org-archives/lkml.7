Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72AAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4112147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfCMVTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:19:24 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:38717 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbfCMVTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:19:20 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M7v18-1h96xg2oHy-0053RH; Wed, 13 Mar 2019 22:19:02 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: physmap_of_gemini: remove extranous __xipram annotation
Date:   Wed, 13 Mar 2019 22:18:41 +0100
Message-Id: <20190313211901.607575-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PSiCUDZrfAOmXzVkNHBWpcVsfSrPq6bcIJ4o6GeithrHVOrDjf/
 zlnwuy1TjXlDCOdwkRBsZ8Jbb6jpzL/eKsw/Nb1LkRBLGkJ4UIMcbZYmH2CFWR7hjAEXnFK
 0ux9dYucnTSy+vDBcR3yn2bFmAwt8rBoZMr42aiPCP8DSBzXMIrgqTOlA4NxK687yK4lELn
 hMCwKT1d61ax3tsBIvljQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GN4jpDl2SIM=:RI5QiI4aPz+acogZfiVqwH
 hZEPFnPy6G+FsyzVnYHPnnJUEr8AlhYH9SG+p4G41ThhhrpkBicoSTR3SwtxVvSV6ANjislPz
 jgKr/FZLLHMPfM4XO7Ev84UzAUNs45p68/ifl/s6IoULkg1/0MjOUMROahKVolyquWE2TFcv9
 cEsrKqgVeYPuomZCpZtw+Xe+NnYmyC2eu5GkNSRKKrozCBz3Jpm3d2QHaRI9v0pMvSmT3vVon
 zJBp6l2TA4sBr834XIyu9yZdXBqwhbOav9Xmk88DmfrdcPfbPUPE87N5teAqH9iFPkjvjcy6t
 ng8Wrd+FeaG+cNH4ufPGb6MOKtrYtGbHwM4+xiXbJzRUI0cwXWAlm8JAwY2lFNshIuhhlEuyh
 HP1lcP+NhK2qe1tgCE85OjjPKl5HQHA4xrQtWN/ofb+YtDEz9Gzonn1s0DbBiaKZqrvc3lsWa
 UsYH40K8Z461FL+720+HWB1ySDjMmEqPMR8uwDJlpomnPgR7DSWjeUtyamKkh8YzUe9ZvM/pk
 kG8HEO8c94rUfVj2fQrA8etuglddtTnxODQH9fe+06wRFVD7owNPJMbFRhyuuMSiBqAi7k97S
 nEK8lgI2jRjzVhQCtYqpdoJvXuh8YEk5Cpe57AADa2mC0gnQ7A030otPtHWhu7WljLAUwJSeb
 bdzkDPVBqLgE4qSnE01Dl7uUwDuitgNEUrmq2e9W2dG5YWdf89jsD6Jtqv+Qwslq7JuqdxgeJ
 wNLQsj7tb2SC0fuzgDNGCg/pquYE/X3JMnjtew==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marking a local variable as __xipram causes a warning because of the
noinline attribute:

drivers/mtd/maps/physmap-gemini.c:89:11: error: '__noinline__' attribute only applies to functions [-Werror,-Wignored-attributes]
        map_word __xipram ret;
                 ^
include/linux/mtd/xip.h:34:18: note: expanded from macro '__xipram'
 #define __xipram noinline __attribute__ ((__section__ (".xiptext")))

I can't see any reason for the anotation anyway, so just remove it here.

Fixes: 9d3b5086f6d4 ("mtd: physmap_of_gemini: Handle pin control")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/maps/physmap-gemini.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/maps/physmap-gemini.c b/drivers/mtd/maps/physmap-gemini.c
index 60775b208fc9..a289c8b5cabf 100644
--- a/drivers/mtd/maps/physmap-gemini.c
+++ b/drivers/mtd/maps/physmap-gemini.c
@@ -86,7 +86,7 @@ static void gemini_flash_disable_pins(void)
 static map_word __xipram gemini_flash_map_read(struct map_info *map,
 					       unsigned long ofs)
 {
-	map_word __xipram ret;
+	map_word ret;
 
 	gemini_flash_enable_pins();
 	ret = inline_map_read(map, ofs);
-- 
2.20.0


Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F85C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4EB21921
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbfGVMTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:19:38 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:45339 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfGVMTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:19:38 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MSLAe-1i0YpZ2WrY-00SbIZ; Mon, 22 Jul 2019 14:19:25 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Ondrej Zary <linux@zary.sk>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH B] scsi: fdomain: fix building pcmcia front-end
Date:   Mon, 22 Jul 2019 14:19:08 +0200
Message-Id: <20190722121908.163702-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190722121908.163702-1-arnd@arndb.de>
References: <20190722121908.163702-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:flKylvzW2wOzNuafHtEWkBrlX2qqw38BrmypUrvBcO+aDqKDEeo
 IYPbXQMgi7zo+F8+2R6Hut7ZOrNp50It5mKdjzETkaR240X603UzrOaeTQ8/t+Sz/VljLBi
 OU3l/kXLABBpNRiatRSSWKDHA4N6IdRxwWOig+fEVFEI3cIHnFOglgdRh+piYW6+3j6bEGx
 MRH3ryY2ZA2fOharWc+UQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Oat9ais7Pyk=:UQWbkGhQZpbGitOngwUmji
 uygJrDj00W7mdTVjzEPpDpsLUU8lp6EL42rZ2xTc7UTgqGC7R+N479gurykXiU/8kNA+SYI89
 OOMieQXSQAyvjD+Qwcij0LseYWu6xDcqvdmJilMa4mdPWOrYNJ2+IAN9FJye8rYpxgBgs2wnB
 uH2+Z6137KXwQTaJeWuCy2VseN1vFVb5i0zalV3Hjr5rMR9XMcQRvVdDQR/YhcEC/aavDp9Wk
 GPddCbCpGxU2QxE55mnkPDTqit24HUtqtO5iPa4Ycy5AzIHxosU5MeDfmuZVK+615RPs0j6gL
 XSwU7poJo9oWGKtRy7AMsTm8mklM9ux/ZauWx1AGc7a1z2whenNf1qQ18wa2aEvMhKnRNeERT
 vOStwr9vi5MeJn+Tj9jOj9XHkTtpTH3t1Y6mBXmLgLwn05dl7Y1WiLKUjF9crLJO/cCCSmCMT
 3G4J89Cy9HMcYdgn7hCfwgaz0SSdeBBJPflzgGn8Lx4X1G4p7T03XH4VC1ng3/T2xrHyC08my
 qndj0rY02L+OBV+06COC5WDlMglPEDTlM1oQtlTbwu61nu3FjD3UQXP0ustTMTBXDTCfnkRge
 l+DiTt/FLamlGq5HWIxBc/g15Etogo+4kiBBNiuQ31wSImwL+Ko1vJMd3MoRJQR2RTjMAMdu4
 mCAF/kOJBk99UT5abdP0fP+VaFnAIy7kws7Zs/fNLM0IT6HFYOStqdbvnv98bUPgiH3FUoBbo
 nrGPPDoMPxELe3EXPb3dLlt0vRTpAu2B9sdmbw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get a warning when CONFIG_SCSI_LOWLEVEL is disabled here:

WARNING: unmet direct dependencies detected for SCSI_FDOMAIN
  Depends on [n]: SCSI_LOWLEVEL [=n] && SCSI [=y]
  Selected by [m]:
  - PCMCIA_FDOMAIN [=m] && SCSI_LOWLEVEL_PCMCIA [=y] && SCSI [=y] && PCMCIA [=y] && m && MODULES [=y]

Move all of SCSI_LOWLEVEL_PCMCIA inside of the existing
SCSI_LOWLEVEL section. Very few people use the PCMCIA support
these days, and they likely don't mind having to turn on
SCSI_LOWLEVEL as well. This way we avoid the link error
and get a more sensible structure.

Fixes: 7d47fa065e62 ("scsi: fdomain: Add PCMCIA support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
One of two ways to fix the problem, please pick either

 drivers/scsi/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 75f66f8ad3ea..1b92f3c19ff3 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -1523,10 +1523,10 @@ config SCSI_VIRTIO
 
 source "drivers/scsi/csiostor/Kconfig"
 
-endif # SCSI_LOWLEVEL
-
 source "drivers/scsi/pcmcia/Kconfig"
 
+endif # SCSI_LOWLEVEL
+
 source "drivers/scsi/device_handler/Kconfig"
 
 endmenu
-- 
2.20.0


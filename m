Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EFCC004EF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D0920844
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfGIL1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 07:27:01 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:17110 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfGIL1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:27:01 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id BF05A3D636B270877121;
        Tue,  9 Jul 2019 19:26:58 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id x69BEa6q016939;
        Tue, 9 Jul 2019 19:14:36 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019070919144868-2212253 ;
          Tue, 9 Jul 2019 19:14:48 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Scott Wood <oss@buserror.net>,
        Kumar Gala <galak@kernel.crashing.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Markus Elfring <Markus.Elfring@web.de>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/83xx: cleanup error paths in mpc831x_usb_cfg()
Date:   Tue, 9 Jul 2019 19:12:48 +0800
Message-Id: <1562670768-23178-3-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562670768-23178-1-git-send-email-wen.yang99@zte.com.cn>
References: <1562670768-23178-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-07-09 19:14:48,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-07-09 19:14:39,
        Serialize complete at 2019-07-09 19:14:39
X-MAIL: mse-fl1.zte.com.cn x69BEa6q016939
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the jump labels according to the cleanup they perform,
and move reference handling to simplify cleanup.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Scott Wood <oss@buserror.net>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Markus Elfring <Markus.Elfring@web.de>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
 arch/powerpc/platforms/83xx/usb.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/usb.c b/arch/powerpc/platforms/83xx/usb.c
index 19dcef5..56b36fa 100644
--- a/arch/powerpc/platforms/83xx/usb.c
+++ b/arch/powerpc/platforms/83xx/usb.c
@@ -160,11 +160,9 @@ int mpc831x_usb_cfg(void)
 
 	/* Map USB SOC space */
 	ret = of_address_to_resource(np, 0, &res);
-	if (ret) {
-		of_node_put(immr_node);
-		of_node_put(np);
-		return ret;
-	}
+	if (ret)
+		goto out_put_node;
+
 	usb_regs = ioremap(res.start, resource_size(&res));
 
 	/* Using on-chip PHY */
@@ -173,7 +171,7 @@ int mpc831x_usb_cfg(void)
 		u32 refsel;
 
 		if (of_device_is_compatible(immr_node, "fsl,mpc8308-immr"))
-			goto out;
+			goto out_unmap;
 
 		if (of_device_is_compatible(immr_node, "fsl,mpc8315-immr"))
 			refsel = CONTROL_REFSEL_24MHZ;
@@ -200,8 +198,9 @@ int mpc831x_usb_cfg(void)
 		ret = -EINVAL;
 	}
 
-out:
+out_unmap:
 	iounmap(usb_regs);
+out_put_node:
 	of_node_put(immr_node);
 	of_node_put(np);
 	return ret;
-- 
2.9.5


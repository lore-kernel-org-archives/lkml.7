Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A7FC5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E1B218CA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfGEJBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 05:01:53 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:12960 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbfGEJBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:01:52 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id DF928AA3DFE30716F390;
        Fri,  5 Jul 2019 17:01:50 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id x658xd1n029870;
        Fri, 5 Jul 2019 16:59:39 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019070517001669-2109207 ;
          Fri, 5 Jul 2019 17:00:16 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Scott Wood <oss@buserror.net>,
        Kumar Gala <galak@kernel.crashing.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/83xx: fix use-after-free on mpc831x_usb_cfg()
Date:   Fri, 5 Jul 2019 16:58:04 +0800
Message-Id: <1562317084-13140-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-07-05 17:00:16,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-07-05 16:59:45,
        Serialize complete at 2019-07-05 16:59:45
X-MAIL: mse-fl1.zte.com.cn x658xd1n029870
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The np variable is still being used after the of_node_put() call,
which may result in use-after-free.
We fix this issue by calling of_node_put() after the last usage.
This patatch also do some cleanup.

Fixes: fd066e850351 ("powerpc/mpc8308: fix USB DR controller initialization")
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Scott Wood <oss@buserror.net>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
 arch/powerpc/platforms/83xx/usb.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/usb.c b/arch/powerpc/platforms/83xx/usb.c
index 3d247d7..56b36fa 100644
--- a/arch/powerpc/platforms/83xx/usb.c
+++ b/arch/powerpc/platforms/83xx/usb.c
@@ -158,14 +158,11 @@ int mpc831x_usb_cfg(void)
 
 	iounmap(immap);
 
-	of_node_put(immr_node);
-
 	/* Map USB SOC space */
 	ret = of_address_to_resource(np, 0, &res);
-	if (ret) {
-		of_node_put(np);
-		return ret;
-	}
+	if (ret)
+		goto out_put_node;
+
 	usb_regs = ioremap(res.start, resource_size(&res));
 
 	/* Using on-chip PHY */
@@ -174,7 +171,7 @@ int mpc831x_usb_cfg(void)
 		u32 refsel;
 
 		if (of_device_is_compatible(immr_node, "fsl,mpc8308-immr"))
-			goto out;
+			goto out_unmap;
 
 		if (of_device_is_compatible(immr_node, "fsl,mpc8315-immr"))
 			refsel = CONTROL_REFSEL_24MHZ;
@@ -201,8 +198,10 @@ int mpc831x_usb_cfg(void)
 		ret = -EINVAL;
 	}
 
-out:
+out_unmap:
 	iounmap(usb_regs);
+out_put_node:
+	of_node_put(immr_node);
 	of_node_put(np);
 	return ret;
 }
-- 
2.9.5


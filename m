Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7830C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CF22184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfCNWey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:34:54 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:39833 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfCNWey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:34:54 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N49Qd-1gvrll0h97-0103fB; Thu, 14 Mar 2019 23:34:36 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, eric@anholt.net,
        stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        matthias.bgg@gmail.com, yamada.masahiro@socionext.com,
        tklauser@distanz.ch, richard.genoud@gmail.com,
        macro@linux-mips.org, u.kleine-koenig@pengutronix.de,
        kernel@pengutronix.de, slemieux.tyco@gmail.com,
        andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 04/45] drivers: tty: serial: amba-pl010: use devm_ioremap_resource()
Date:   Thu, 14 Mar 2019 23:33:34 +0100
Message-Id: <1552602855-26086-5-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:XGcErtNSwWbhM+beVJp8GQkXmsSFvICpTIBZTEUMjOcPXLBAOv+
 l716gkPOIJ0e+QeD8Gj1jW5G07RPO1qxMpGqSJbcy3aRueTrUuay98zHFd8GCY+gQzva6m8
 A6AFNq6qnlIV+GRpKljpQsmVfieEgmLhngunKTALWxW8iiVuTwWuq+TIqJlaSkMHzV4Qgts
 K8/3FfQdltczAXhNmC/cg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sxm4ECCau3k=:3785J5G44DXyydNBfDVjSo
 tpeYCAMfZ2borS2pu12mU87uosWzvvaFmm6sEB7ESXqQhuOP2li8t5rIeMNrEtyh/PfoEuL4W
 /NNb0rv4F6ngJPsyJVibLgKJoa16T9nBI+MjRMDnHJ8WQ9aYHJ+qWtaWEOzQbqVncmwGRfXEf
 mfwTq8gnmCYdCO743ECT41xlCrlWmQWfQVPwamXrUd58AWLYBA+yHDb5rYjNM1XojvEWmSx9J
 rJdo/v0pv53DTbaxmM+evTDPx6i1ZTqqW3tyPt+V0Eh/QBRZTrDbDENSMoh/zsmdU9kr3WqTh
 aUiIKymQIgDCzql7cN7b0rD1nNW8iurNTnaySdaQNs54KW15sYJb2sQGHPKKGNpL3SF6EaNpH
 Q/2BwKrjvZWMEd9mkrRr793wvVYsugyo/lzy1blxIH2R2qynvCYVft1c+p0J8Ll8LGqRaqoZt
 SJZHGjVMnvjm6hY4YPbdRpv9h+86BfQ8X94vmhbruZdgJqOv4sK03QfA9xbWDNNCmhLydh6B5
 PCNB2LoTRHqIpiBEBcUjnLMF0IgtZyhNfRHYm0Gx6RbE2Af0B5TqAx6P2Yg77hkJDoJQIjKea
 jWzLpyJpdMxu5/h4g3XyCgH2Lmh48ddtJsI7E7uqVxPNDOvew006CWQ71+6JiQmhgfo/NzOS+
 eZ/ABW7mZxmnuUUj2TbgN09HDdHhCUXpR6J6CWD7n8tZgogUYrPlhDaPqfcu6vhe4Ez6g8T8U
 QMEERNASPBo7Lg6LRITMTGfUikyeYXXrB1RkYA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of fetching out data from a struct resource for passing
it to devm_ioremap(), directly use devm_ioremap_resource()

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/amba-pl010.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index 2c37d11..109b8df 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -713,8 +713,7 @@ static int pl010_probe(struct amba_device *dev, const struct amba_id *id)
 	if (!uap)
 		return -ENOMEM;
 
-	base = devm_ioremap(&dev->dev, dev->res.start,
-			    resource_size(&dev->res));
+	base = devm_ioremap_resource(&dev->dev, &dev->res);
 	if (!base)
 		return -ENOMEM;
 
-- 
1.9.1


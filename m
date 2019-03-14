Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076ADC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7C221874
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfCNWfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:35:44 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:59709 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbfCNWfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:37 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MwxNF-1gofgK3Mlv-00yNe3; Thu, 14 Mar 2019 23:34:55 +0100
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
Subject: [PATCH v2 25/45] drivers: tty: serial: pxa: use devm_* functions
Date:   Thu, 14 Mar 2019 23:33:55 +0100
Message-Id: <1552602855-26086-26-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:60DXqGwgLJWFsCZvkpoZ3QggwHDJ/uIXy3f3YRehQJVpABewDLA
 ylyhjLr11n1jRWmWSPHY0KZvNvYOy7/B/iK7E5CLy7CWtnbBNqpZPPVTBN0HsMrX2JZItkf
 kroXRWFISEFKkKHcnW5EdUqpCB9J7LhdY0VKPKSUvvM6UGSs0wivkYluza0oSYAOQjx0Xef
 Bm61uIHV7LjqLzXIPW3zQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZRIyEBXFwnc=:HsxSCYTw/8ygyJGvvU80oQ
 WvIWS7VKBoXxJOJRJUWIy9KQypD+pfl44cHF3itWQOstlwhfD/1oxH6GyvMH0YijrHTR/mbM8
 livCI212ZOvJQY16hufv5f8ZgDhhZV0+IFORb5OOJNNtm3dlT9e25aFfpL0gKcZVHk9qOph6w
 RxxvXGM6iMnJs9AXuSfWdz3U3/s39Na2BD2M1SKanlu1wfqqF0w49lxV0pJx85X9QiBXoSy59
 2fZ5IE54UuF/F7Y286Tt0CODS/XpBkhFxj+lz+rpPqOYvVoCxcqXZ41iMoqesXWD2+wLmeBUf
 7J76PEvVE9ZyGT7tWraCoMYR+hTI/5SeOH90VVd3EF0fXcT+dU2Q7AZc2c04/++yH+Zv7px/q
 fwr8hsrz+5LNaoTD+NOIq43yV7zDuLGmCToIFDRz0faG+lL/S3P0dh0Vy2LIusPdI59FmJnJH
 ivF1IY/ufh7swv9XhLmjoQD4qCgD5auqkL9SCI6CE2BtTpOdC10o0O0AQN9HRzDqJHeGlTbLW
 1RgVR4ooBTCPXbtjdTrrqs1/kllX0o4szDnZ3rA2no9LhT9GUjUaUHFnbk+Xd5ubDm7B0mA/+
 wF35dkPdZ3X4kSupeAY96h+s/SFuvMWmFYCKRc+PbaOH7haewcOP5D7uPZdsuzuwSzppqZZrt
 H30NY/YNkr0C2FPZjkeiraom8yecxHrtzqYaDCjMgh0pMD43+fyjeOyESzwQHL3chodCaDyB6
 xsaY4CgCjgVNDpIYmSQsd/r50qoFGeZ0KNTQjw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/pxa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 4932b67..9512a9f 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -892,7 +892,7 @@ static int serial_pxa_probe(struct platform_device *dev)
 	}
 	snprintf(sport->name, PXA_NAME_LEN - 1, "UART%d", sport->port.line + 1);
 
-	sport->port.membase = ioremap(mmres->start, resource_size(mmres));
+	sport->port.membase = devm_ioremap_resource(sport->port.dev, mmres);
 	if (!sport->port.membase) {
 		ret = -ENOMEM;
 		goto err_clk;
-- 
1.9.1


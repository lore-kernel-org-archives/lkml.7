Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C2EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463E52075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfCLO6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:58:16 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:36065 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLO6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:58:15 -0400
Received: from orion.localdomain ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mlvr3-1gcOm42jjP-00ixwJ; Tue, 12 Mar 2019 15:57:59 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] drivers: tty: serial: 8250_dw: use devm_ioremap_resource()
Date:   Tue, 12 Mar 2019 15:57:34 +0100
Message-Id: <1552402660-31730-3-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552402660-31730-1-git-send-email-info@metux.net>
References: <1552402660-31730-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:mblMkNuTecTkcBpGhvzB/G8Sk1bC4DqKonb3sLDp/4DfNJxR35u
 cK4yRFymAJnxJLErND3a/aPH6H0ZTErTeCDLgP15drtSpo2fpcswotHbzp3lMw0H6qLYGIQ
 CQrflMoSdU16it7leRGVq+92zEQMtoaC7Ty/hzGi+t6Wt6sQwoIlDJcZnQ14of3WT+HPkle
 5pJ+4Jxp3pFqQwZNWZHZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uW7in9wQNQU=:MKgYyqK+jJYkWf25kW5Abk
 uGHWWUBfkCjTGZ6jkRHf6OlWVATMFzNlp26+Pi+hZKc5slZQHBDPURq3gCspTsPKtL6I0ZdVz
 mieM4+7V/btnCl4moqXHlQab4HQXyQK6Az+5v01gnSPh6+nVQuxuVKWu2ZytM8fwkmI57V0Tq
 kMT5eftojsHK1frEjeStlfHbfrCQ6/JJ7A2Jw5wunU8WSiv5sMQsB0VsEsxNaOYu2l1z0T45G
 1geW1+YzhWampbWH0RKdpDHfvGNMWWxzxelWZrxua6FC/8eiwzzkIXrCDW9CLtTA92jdJ7cXm
 I3qlg8L8Bg5Iu03n8RBskIUoJy64/Kehu8heLangBn8Q5n/HyuK5+GO9Hh5D4gN/OaXHAEQIK
 GqIXN6Wp4HBLK4haqBgnshaf9yDLigC4uQGTfB55sXobL6DOkFkYigxX4eu3SuaQhqIdh0diB
 EdS5NNijDUPYrAkq/rWrNDaEG1rRol/W/K9Rvqxw7VhjlJpmO+JrL1Hf4YbIAiAl3+YV4eYOU
 m5M+yXANZViuJwjTeyxa2Gcj4ZPXxQ7raaimIIldsMxHRONYPfcRfAREkk3xPTLHdDw3a+xrm
 vDcPNu+KfZcHmS7qOEL7LVWBMiAfxaiLaFJASpa5l8jDScJSe1TEoAMp9bzaYaVou95/vsRt0
 rTUVa2LlI9tyw8mPThWFpubyqopJv5rnccb1BCq7r5NG0rrsUfKsnKzQLMDjCGzMFeilsnS2/
 oJE4gs+8MJPuVcdNfDEs9910Iff5IrrNp5iF0g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use helper devm_ioremap_resource() to make the code a little bit
shorter and easier to read.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/8250/8250_dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index d31b975..f0a294d 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -526,7 +526,7 @@ static int dw8250_probe(struct platform_device *pdev)
 	p->set_ldisc	= dw8250_set_ldisc;
 	p->set_termios	= dw8250_set_termios;
 
-	p->membase = devm_ioremap(dev, regs->start, resource_size(regs));
+	p->membase = devm_ioremap_resource(dev, regs);
 	if (!p->membase)
 		return -ENOMEM;
 
-- 
1.9.1


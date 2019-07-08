Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4399C606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D602064A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbfGHMxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 08:53:24 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:60113 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfGHMxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 08:53:23 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MJmbB-1i43Qd0J8D-00K92h; Mon, 08 Jul 2019 14:53:10 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tony Xie <tony.xie@rock-chips.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: rk808: mark pm functions __maybe_unused
Date:   Mon,  8 Jul 2019 14:53:02 +0200
Message-Id: <20190708125308.3778575-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3KRIFevbqTtrEsWrlEjpXsuKrDf0Nf3vQwnIJIvRrKwNGyC8A2j
 AtRjoqSP98QNKNcphLrJ2TvJyij7uO+BXRIIszAMtlqJpXWJSC12fADFXZ2aM2azQmEYgpt
 ngU3A+b/UFUOtWQ+Z/aRLZ4HFIV/xESE43Qs3YhJwhwwpJ7Bag/JcBZDP/9ycgUjUDtPZfE
 C4jEJf2mgl4aQ0TyzXOOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TXTT9pdMoRc=:2vF7s1LMO5yoIjJdCua9jD
 /wQZTzbF5NUN3Dc/DGyiYJFY+k1C0wGcOJGiAK5m9290ftkBmG/m6fbVUREtG2m1q9r32EzBA
 MBUnpSfJuyRpN9jgpqW5BVzg9NrMAWAsvPWPlScGrs47+vcpwhUvbucVxHpu9xxGYaylgp+6K
 B4jqntQd7MxCFN6A+sb5ziOd7/gFdJtZPpOcu3wDIveNrK+3v8A55CYfDocdNLcuaf/ZRLIIM
 qOPiLYAMx+Kn/lbm/A9TMPK4cLVwGtyNIqaDXOH4iMqks20jP+w7YFrpbbQbjlBabz6eUMLYM
 XwiUkJLyIjHLEL8yAE9JRSQ9mho5g/093zUBhDgVIjI3iogiRtoYaxl4VMZGa1Sv3igs3sui3
 9+B8++ZMc+l5tthOloM3Ux0P86mTj1cBUtN2YK5FPXno2rBS/q50U7c67pniuG2odEzHhL/+J
 8BMyQGsazp4T95XnOouQ4kXiGyaAn2T+0LxZRRpLAmcvko8+6qr6gsive0Uais/AZy1d4S+xy
 jhfjLAi1zG0WzusQD1JPU9mG/Y2jSDDDfFtYL8WYvQxQS98LT4worhQmjN61QD45wJ7Xj7AgX
 bgDB/06RGaIRX/t1HrIjftyY3mUFiWTSNi4c9iueWi0OeA1Ob9j8G2r6LG0/smmT76n4VbFL9
 zjUVBBVfQIIgQE+0COLdW/7tDAUqOSXql6B4pDpH6O5Z824KPwWWkz9onBZGyoxa9ZDz1G2JD
 L0w9S4qjDsRUnUBQclEk1DVuMmfZBODG75jaJA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added suspend/resume functions are only used if CONFIG_PM
is enabled:

drivers/mfd/rk808.c:752:12: error: 'rk8xx_resume' defined but not used [-Werror=unused-function]
drivers/mfd/rk808.c:732:12: error: 'rk8xx_suspend' defined but not used [-Werror=unused-function]

Mark them as __maybe_unused so the compiler can silently drop them
when they are not needed.

Fixes: 586c1b4125b3 ("mfd: rk808: Add RK817 and RK809 support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/rk808.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 601cefb5c9d8..9a9e6315ba46 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -729,7 +729,7 @@ static int rk808_remove(struct i2c_client *client)
 	return 0;
 }
 
-static int rk8xx_suspend(struct device *dev)
+static int __maybe_unused rk8xx_suspend(struct device *dev)
 {
 	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
 	int ret = 0;
@@ -749,7 +749,7 @@ static int rk8xx_suspend(struct device *dev)
 	return ret;
 }
 
-static int rk8xx_resume(struct device *dev)
+static int __maybe_unused rk8xx_resume(struct device *dev)
 {
 	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
 	int ret = 0;
-- 
2.20.0


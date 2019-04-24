Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3821C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D9D2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfDXLI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:08:57 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:59817 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfDXLI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:08:56 -0400
Received: from orion.localdomain ([95.114.95.254]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MvbO4-1gUB2T0Rp0-00sfZK; Wed, 24 Apr 2019 13:08:03 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        heikki.krogerus@linux.intel.com, f.fainelli@gmail.com,
        rpjday@crashcourse.ca, dvhart@infradead.org
Subject: [PATCH] mod_devicetable: helper macro for declaring oftree module device table
Date:   Wed, 24 Apr 2019 13:08:01 +0200
Message-Id: <1556104081-16217-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:xNhYnH8wYQsF+KSIw+gZMihhQaUQpq9H4YXJS4uLCnEYoLvzWDV
 w/3BEZxE8+b0xO0p8XIWf/EftK3IAD2EUoO1J8JWgl3lthZpfHossHpHx2nHs14ISHnmIbT
 UJ9mPdaFu8OFvDJHznSd6sgjOtg+wOaFjnuDdoxbU3k+DLToxa+Yt7yM7t1dr6WdfjyeSN1
 wNFNR8zRt/t7fSb28/2Yg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dlw6A/Xv5vg=:V1HU7LwvQe9wFZVKKQo20I
 DOzJ1ByvbvkU37VIaOKqsyurNTHN1znoBrVb++6zHeyXP8PItUEAm4oUn+o0qMHgjPF3E6c9z
 G7jYOuLKGPPzISOftjiA2EeGzyZgCrlIAJ793gZx9EuALopMrTChR9Kjyre8N2XAt7x/cmv2K
 Sszo1X9uKPLGXB+kgmZNQOGxsfFm7rQNC4q8lf7f0FOcJNLSyCP0YIESdmp0M5qntetWMbWTk
 dVATSLVTrubLeXtJ87grPO1hxxeV0MZ37vr7DzPgC8nHmjShXl29DgW7A99dYRZYvg/N92h3y
 fsDDjSgoJC+AbzYRLp7I812vPshB9EDUu0enCVHMgn5Vrd4Z4IVWYP7EYCc2otbRemy3JbSy5
 sdSQwzlljS7juORbHqFxgu3kT9ok7buNc9g9mtmSqOkM0lSP+oNtQSzO6+hBTYUv0ogs2gNGv
 P5xFzTXJ2MrOb4RvUz7OOzKts+X+QJObYOr+Z26ubsegvvq4ceGall4rC1ulJEXHuTDz/Tj9F
 lDXpI4RtnhMb3E8XupNwUoGP7633XuQjTxpovbYea1sZDbW7zaFgmdjgiI1E15Bjbm6J3fle3
 8q7zdCfN74iOF9DpAFBEhJUOuNYfvoNjEjJxln2YtYcZfl+UH51jkarNjSf4fKwPCgswkInO3
 lwvN2435t3KnFr3qe7sZev7G1YYFdAFqNDkOdU/mxQ0kA97HFXNKnTkH/PGJjuJOwLTqW6wVc
 uUV3ZVqhWwi0LOtWWqMCQYirtiX+KigFgK33aQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Little helper macro that declares an oftree module device table,
if CONFIG_OF is enabled. Otherwise it's just noop.

This is also helpful if some drivers can be built w/ or w/o
oftree support.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 include/linux/mod_devicetable.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 448621c..853e301 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -245,6 +245,15 @@ struct of_device_id {
 	const void *data;
 };
 
+/*
+ * macro for adding the of module device table only if CONFIG_OF enabled
+ */
+#ifdef CONFIG_OF
+#define MODULE_DEVICE_TABLE_OF(name)	MODULE_DEVICE_TABLE(of,name)
+#else
+#define MODULE_DEVICE_TABLE_OF(name)
+#endif /* CONFIG_OF */
+
 /* VIO */
 struct vio_device_id {
 	char type[32];
-- 
1.9.1


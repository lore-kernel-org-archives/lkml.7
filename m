Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F4DC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFEFD214AE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfFFWnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 18:43:18 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:47213 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfFFWnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 18:43:17 -0400
Received: from orion.localdomain ([77.9.2.22]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N9dkB-1gVn2k3xbh-015ZTP; Fri, 07 Jun 2019 00:43:16 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: [PATCH] input: keyboard: gpio-keys-polled: use input name from pdata if available
Date:   Fri,  7 Jun 2019 00:43:09 +0200
Message-Id: <1559860989-7723-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559860989-7723-1-git-send-email-info@metux.net>
References: <1559860989-7723-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:rj6GDMwqiKm5/b17CGsaT+tO6TwxhLD2G1fBUVpVJflXGOZT80Q
 ZscPkiAUdcGXXpoqth/7B+DGLad4zf9anaLLS+/I0tmIgaaGXfIgeAqECFtCHVnV8ZPatOF
 Iaa4jzRFBy4mZGvuK+WDjLMKwM0Tj5uN5+T6ygQfpMrHpuzd04dYsG/QpJ1uV7fbDbKQ5l5
 OGNDlj5tedMukDVX8mVSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ODZG1KUtwoI=:eHH5GbpWdYbWvqmgwtqfJF
 TR07yfABECf54s1N4APXBrpEltXBBMpxW+OH0cEngMIIUoI+xHTFdMxgqADVfgVxSM5vuUazh
 /SLFXoRZ1far2bkBJY1LwX2bDY/+Y6RBYkHjTZRkbbgG8rnCl/QyNB1pcLvPHemB6khrGuY9s
 HDoBsPlrBhUBLHi+Q4r86bj2vnpkl9al1jBuPZQx9fwQzKceyGyoY61vkCb4kr9TZI1MaV3QY
 zUjlxb1s6lm/k2GtlFgcvjr4EVc0/3+FjFyfFsLeR4phiFHtTDXD9x4XJkbzBOTii1c9fsyo+
 oz/kPEfQawZZiEAghMMXg7V5sjgyQ8mLjfgUmn8dIqEQkrYHpLkhJbMeY6Sx+LRblp4mZOev0
 m+WIYoOwWHxv4frkVxb+4DY+Uy2opGpF3TioNDiB8OgXIlvwSxk3PgXOXln6ckNe/RCvLEVXm
 I3MGU468YbohkcmV/g3Px2wKSDiuXC0/VpKRPspXSyktsu0xxn8H0+DUc1PqbEXOuDsva1SL2
 lRkH2kxlONvcfpNkKbuBNPAAHVNy4fxx2hyU2xO12fe8vYDim20gm7p2oezZxRpylp2ieTHPA
 UOixFoD9Au5ZuLw/4UmOJrHNGi0zGDGZt1anUguuzzQiloquRz6+eZLUJ7WEPj6Xm7OMMS3df
 ToL5h14Jjn6bq7X6XdGafONrFiaptlUYWpFPUtoikzNt20f3+XMDJzBUSIsBwsxu/nnuXf97n
 gB2+Sbf/JXMtCd0DmFad6oRY6+v8q4vsRAMOsg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of hardcoding the input name to the driver name
('gpio-keys-polled'), allow the passing a name via platform data
('name' field was already present), but default to old behaviour
in case of NULL.

Even though the general tendency is moving from pdata structs,
towards oftree/acpi/fwnode, pdata structs still have their valid
use cases, when the mentioned mechanisms aren't available or don't
provide the necessary data and so driver setup still needs to be
done explicitly.

An example use case is keys+led support for the APUv2/3 boards.
Here a board specific platform driver probes the board and then
instantiates the individual devices using classic pdata.

The gpio-keys-polled currently lacks support for specifying
input device name, which is fixed by this patch.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/input/keyboard/gpio_keys_polled.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index edc7262..3312186 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -272,7 +272,7 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
 	input = poll_dev->input;
 
-	input->name = pdev->name;
+	input->name = (pdata->name ? pdata->name : pdev->name);
 	input->phys = DRV_NAME"/input0";
 
 	input->id.bustype = BUS_HOST;
-- 
1.9.1


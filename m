Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DB7C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619A72073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbfDPT6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:58:05 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:50773 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbfDPT5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:57:42 -0400
Received: from orion.localdomain ([95.117.99.70]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MmD6U-1gYajk25yK-00iCtf; Tue, 16 Apr 2019 21:57:40 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: [PATCH 2/4] input: keyboard: gpio-keys-polled: use input name from pdata if available
Date:   Tue, 16 Apr 2019 21:57:23 +0200
Message-Id: <1555444645-15156-3-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1555444645-15156-1-git-send-email-info@metux.net>
References: <1555444645-15156-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:0DjkhHxOiFXi9RwcCtGVebMjbGBDQAXetXZ/02Cpb8UJVwVwjUc
 b8WlFsvndVedmgZ5nDNDafHW/9P4s6yPwTJIME4auQc7GVPdMRcaZWVQPHHj8IhR3Cfk1Nx
 0Bgkqo3g3AJt0ITVxK+XJ1Q+Vn0n7zuNA9ai3ffk5TyIApb+c7tlZtC3gnzt+MzK+TOTgYL
 aZPakNf1FtnEL7BNrKcxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:noHrulkyL9o=:slB9iUIkJWEvps+FZvLYO2
 VbZxFKY76FPruywCbLaZhf3e0DC44PqqNRJiMFV1D7BlIigoLmmqU/i+H+/oDjMDnSCqmg4/4
 YLCQ3TZfIynv8WUl5LxxifkRtIhatj5/48kmRlUyYaSpl//WOaVPWOrWntUocQySTtuF42GYA
 1VPR7YnMrXsV7eu0F2i05mBN0BtPRp1Wi1Asf5pcX6NdFmJAIv9RkaXgUJ07K/A/t7Nt80e8/
 TLl78M4jRjMLXlvqTCldghRh59PoXk8sqg6Pu0V2iz7D32gpyVSdDHh1jAL2uzR27gL7fpG5d
 LGk3xaanqPUylM29687wIkitb5Vps4a3YuEBvMlHZGOI+OTedXwJ7SsreLVcoQldbWItgB6su
 JyLzhIf4rlo0+WYOV48MLv6SFIRLFr+cAXIJCEdYE2a260Aym1dpkXoa5JlehjjcnjUboYze3
 LWV5uUDjBi3WDI+g6TGwHfXHbgy4I1nh1LjUbvB9fuMKh14zmoIcdwtAJJ0ImMyAkiuXJDpSs
 RljoUclNwkG6b9MK3amy1f4d6YKiptwiLbebvN6Oxfhd/vgExntZxLZfgXWsC089EEztA/ZRY
 FKZoZYhyjJj0JkdZ9gcsGzqKjCJfWe/gn+3lJJmvZ71iMLv/TeSvmZ+/4eFLoT7UBb/IyRuy6
 Y+8AONR0CtEKtlv/ZSA6DrTb23jJGiEu49u3ZK1Z0M1bmL1avpKFjaLN6VbzFy220YK2WsdN/
 LFIip4zgVJ+afxSwGCGoRb+n/iBLNyMbVCaxEw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of hardcoding the input name to the driver name
('gpio-keys-polled'), allow the passing a name via platform data
('name' field was already present), but default to old behaviour
in case of NULL.

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


Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C01AC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA68208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfDZTB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:01:29 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:45181 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfDZTB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:01:28 -0400
Received: from orion.localdomain ([95.117.100.117]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MFba4-1ha4Pg3DsE-00H8CU; Fri, 26 Apr 2019 21:01:26 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: [PATCH v2 1/3] input: keyboard: gpio-keys-polled: use input name from pdata if available
Date:   Fri, 26 Apr 2019 21:01:20 +0200
Message-Id: <1556305282-24148-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556305282-24148-1-git-send-email-info@metux.net>
References: <1556305282-24148-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:x9esqpp3YBoaywpKAmNa3WAv0fJsnks4rGipocXG8ZQ6SLT9il4
 wfvOzoDudWr5vANpA7cF8SwCKAAiawtsRODabU2P6w6vQF9DC/TuWUFUdaAPDPt685StXaR
 vMZACk8pA2yyt5oj/FYgsx69kZkj9vA85BO0LnIIF1uMKdiK4c6ou0/yd23XGzyXRNJndNB
 hnZl9XoAAjDpHf81++5mQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wUl3hgMiD4M=:yPxs61zJI6iGX8zPqWsyV8
 1ewUy/lWrlngGFXWtT3sY1hDzruvsF9VyPamN+W0w1KXRnRsqkwMkaxIcqweBatGH/dOhAtPK
 eFZ2ksNL/DWt48AvDksdyjHDSFOpQRoHjjeMUiovkd0sVWY4Js5RsA4IJiLjLEzKphmW9WpYx
 ZxgfWkIxKwsRZ4+OrqjYM3QsHJoYmykB7gOg1j8nxWs1dH0sfM5EdkeP6yJtjxhiawgTUTlW3
 Nk/odBDdOPehKt3yeCp9KAb67albXT8lM6e47M6TVArdMm3OTUycujLFj/kVDMBnMLwEwin3L
 EQ6FNA3UQcTw8YLUTbCGuIofb9jqrsAKy0VURiJRD99s3KyEUm9CBwmAifRrhSxDrJpvqTr4q
 rKbscGvwtSH2KX54UxIGUav0fvc0Cs0tDvmEI4SLVfPS+KffePmRTSOKwJMkTLIhiqgWGDtrz
 PP/zkb//Skcp0fdJ8w+nQnrhWTgszSugIrKfnwjzanvA1yj5xvE3Mt8Qbg/20t9+PmDKGUdTB
 ZZWxw5d/NWR4wBNbGD6dRwKGbI5rjKZdCvOWqil8BfTPIVXB2sMoKdV/6JQQI/tP51p57uagn
 SlSYtOKlPwlsdNXyeO0mWAxu20CLS+EhfyOMSmESWYf0mFY8/RJJs13t2fCI03tr/+3hOZ72X
 TGmWgZ0WdXWO6HT/E3KKDnure1ILlF7DMW3A4nEkKrQNSC3lFiz0t6NLH3kWmWQKOwlviKvlD
 2mPm989ioixqSK7HPiG8E159UshSh/McvJeptw==
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


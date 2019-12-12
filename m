Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41445C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3C72173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfLLLPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:15:38 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:56963 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbfLLLPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 06:15:37 -0500
Received: from orion.localdomain ([77.9.34.244]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MAxLT-1iZ0ev044X-00BOiC; Thu, 12 Dec 2019 12:15:36 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     info@metux.net, platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86: pcengines-apu2: fix simswap gpio assignment
Date:   Thu, 12 Dec 2019 12:15:07 +0100
Message-Id: <20191212111507.14365-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:V1Saik6Dq+VQNBC8ix5ah6wHx0KOYSzmu6tS9ECL1lNFBVQy8YA
 EkGB25WSVG5I/5JuQ5FmC5KVRPEkK38wtYNZY6wl8n6zQO3qabJWYlgFE993oRslxgXzjz1
 76d2QBr75dUm0bj8MV8wkee+mqgJKt0Bks8nO7F2YJMslEfafw1VZe/YGKHWxFWSUzJrsyD
 xCuqNqExSLt09dkBp+H0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M2bPAAyHAJU=:fftKP6nTrbbjZqOqWf7xUw
 GqU5LKvKKc4RF8XNN4lsuaiRysxTfVMZTI7TWBE7GL5WKJeQtu/sKIoM0ctSfPJ4DbmEb0rz7
 xZYO/d/vhn26Q+9CP8Nt3X+6O9JEKK4NnfslFTPPPbILyYIRqkxVQF8MOanliFpDq3e722qVE
 RE9Um8fjyVJS4YWPqEU25vw1LhXL1x2fWYIyF7G+XLgnmYDleuWerEAZy6WtrNIywvSLc0WbY
 2St0AwGXObds++yr5lcXS/VU0SkdZpG5sNJ3RuhhKpUqap5d2M5L3jtLHduD0QXXe+oP/9iHA
 l5voR3GshDe1aiSMlAoiaqPhEJJ54uUMs6DOXUeXtb037JzqN7qL8JwGQWh/8P1Ce6MAuOawb
 bZEkNfRL01nvfMwwLoFRdmgOL1VmThaAe6FA7BPij2ldC0GDxiavuBjLMITaM1NX8UJfXSUGq
 5ZnuK1uTlogyVKL7APNUCsVvfE2xqUN7vIBCcRsAKt6+EueSnGI+URobf0bUB2atDIwzOD1cf
 zAFHeD707RVQnImNWsBYfcrB/ucGi9j2BZSxTnQTcMnV3CD3IU7S33LgXEDixFVWqkuhCJLrU
 z9Adq62qAL7xGB8eazq3MN0GOScqCPOftISK/Rw8ZqA9JhVhYq3WkRWGFgO/3xsJfIVo0fLqk
 RaZT+aI2EGoS5MvVqjFqTF1nqDVNAYJgLIhuyiEvd5Ej8xpq4DWfBnsmSnPpn/gikCx9wEYeX
 Y41bT6PCq4IvgHsIfUJqnFv3Zw5WkECUQj5HvBz8iq7aba6oNQ0n/e/lgHzTDggDehTXjV5O8
 ytrun2zAuaWDtdTm3CXxUuIyODQYU8ATKBkE9yr9WI7ThY+Kxx6mjipG3r+z6K6X17IYZwhLv
 BduCr0SdBxZ46vmmbzuQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mapping entry has to hold the gpio line index instead of
controller's register number.

Fixes: 5037d4ddda31c2dbbb018109655f61054b1756dc

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/platform/x86/pcengines-apuv2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
index 48b112b4f0b0..c32daf087640 100644
--- a/drivers/platform/x86/pcengines-apuv2.c
+++ b/drivers/platform/x86/pcengines-apuv2.c
@@ -95,7 +95,7 @@ static struct gpiod_lookup_table gpios_led_table = {
 				NULL, 1, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_LINE_LED3,
 				NULL, 2, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_REG_SIMSWAP,
+		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_LINE_SIMSWAP,
 				NULL, 3, GPIO_ACTIVE_LOW),
 	}
 };
-- 
2.11.0


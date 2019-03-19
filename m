Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DC0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124562175B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfCSOyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:54:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33127 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbfCSOyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:54:21 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h6G89-0007eH-6d; Tue, 19 Mar 2019 15:54:17 +0100
Date:   Tue, 19 Mar 2019 15:54:16 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Enrico Weigelt <info@metux.net>
cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH V2] gpio: amd-fch: Fix bogus SPDX identifier
In-Reply-To: <alpine.DEB.2.21.1903191513170.2537@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1903191552550.2537@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1903191513170.2537@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spdxcheck.py complains:

 include/linux/platform_data/gpio/gpio-amd-fch.h: 1:28 Invalid License ID: GPL+

which is correct because GPL+ is not a valid identifier. Of course this
could have been caught by checkpatch.pl _before_ submitting or merging the
patch.

 WARNING: 'SPDX-License-Identifier: GPL+ */' is not supported in LICENSES/...
 #271: FILE: include/linux/platform_data/gpio/gpio-amd-fch.h:1:
 +/* SPDX-License-Identifier: GPL+ */

Fix it under the assumption that the author meant GPL-2.0+, which makes
sense as the corresponding C file is using that identifier.

Fixes: e09d168f13f0 ("gpio: AMD G-Series PCH gpio driver")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
Stupid me should refresh patches before sending them. Blush!
---
diff --git a/include/linux/platform_data/gpio/gpio-amd-fch.h b/include/linux/platform_data/gpio/gpio-amd-fch.h
index a867637e172d..7290ec40a71e 100644
--- a/include/linux/platform_data/gpio/gpio-amd-fch.h
+++ b/include/linux/platform_data/gpio/gpio-amd-fch.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL+ */
+/* SPDX-License-Identifier: GPL-2.0+ */
 
 /*
  * AMD FCH gpio driver platform-data


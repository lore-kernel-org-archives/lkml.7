Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9D8C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3609021670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405857AbfIFPrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:47:22 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:38231 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405844AbfIFPrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:47:21 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MiaLn-1ic0673Twl-00fnCZ; Fri, 06 Sep 2019 17:47:08 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: don't export unused return_address()
Date:   Fri,  6 Sep 2019 17:46:55 +0200
Message-Id: <20190906154706.2449696-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KxXBdm+ZdB2njEOuHI0sI2x2LTlMTwa/9hKBgBDFyvjWMqurBar
 1eeQnRx0c2Ox7iIBg3bLDT3e+A5wv8//Hw8vhKUVdHCQTetfQSdrjrsU4gUPPAVUYMq8iZT
 KWgNizZG8M5JX8N3+1xp6Vcd4jLYGRQ83Jo27tXlyvYsVLbkW7W6om1aPaGGEKSRE9rkBZj
 QoIsM81fh05SMxn2RkQuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vdoyMlLfLcU=:2DVor/2vufbs+2xiNNaRoY
 fWU05+ahmmEOb9gMmRI4XWFn9VIEylv0+DmficJNI3Krbstw87f3wOIrlEFkWOCdWdG/YRvnS
 EfZPjYBJQAsFo5UkRNXPQDFrwKcCOcZGJI56UApZdhCAysBgKjHEHx6mFAagdxE4/0MprqVsr
 rKFOPTuBJO2JtHEXCAHRQg8X2Ihiy7pvRV9AvOgm3OhbCzC87ZVsqJdqCVaQdxheA5hBRvSA6
 EGZuy18hFF2+RyjHnFKf0Gj65cAdfGMbkh9S83qBMI26tBaEV0UmjELm3sgXfv0t2D7aiA0xH
 HjwNLRQATNkk+YjodkxGlK4Jez+3kgbFtFHXLEkl4u0+zZFouJJ7K8gBrvaNXTVQUeYes5nQs
 vxi6Pn5vXCsFjGbL/Syj9H+9jI548oYiMo4IGvb7TwV5CjKQnJ473bKpWcXxEGhfm5I1wdOEq
 fe+G5UgO+xo7nfXQymwg+GugThSksgQKEp6nScmJq7dwoGb2yYASvI3IxRPLu3NMshjgpFan8
 6RqnYGncFrUL0qfG/sdsAbuCnt2h+XwfSHIrotMJGF7XBex2CmX9x9oXFQH832A8U7RQc30sY
 DiWK9WZn2kQsl6Vw8NTd9bADyW6qob4mDnQtJkrHSbMO8qxY4TPYCgLk9TA1fHggPxk6C5FJR
 1blQiqgk244xS49SOFkqL94iruf3zffktlDkzjDwKq5jP3KBQlf8ZvXDLt5BXO2gQKqhdaM0n
 zNCKzIdwQvS3SDWlGgbtA9XQuvo7yXs2lXMToBNNodcqmUfc0uQfgfCZ5EapqjXq8YVFCWxiV
 +JNrPBbpP6nuUpksqgzACYDRugBpQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without the frame pointer enabled, return_address() is an inline
function and does not need to be exported, as shown by this warning:

WARNING: "return_address" [vmlinux] is a static EXPORT_SYMBOL_GPL

Move the EXPORT_SYMBOL_GPL() into the #ifdef as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/return_address.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/return_address.c b/arch/arm/kernel/return_address.c
index b0d2f1fe891d..fb0fc1910102 100644
--- a/arch/arm/kernel/return_address.c
+++ b/arch/arm/kernel/return_address.c
@@ -53,6 +53,7 @@ void *return_address(unsigned int level)
 		return NULL;
 }
 
+EXPORT_SYMBOL_GPL(return_address);
+
 #endif /* if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND) */
 
-EXPORT_SYMBOL_GPL(return_address);
-- 
2.20.0


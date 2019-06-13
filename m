Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031F2C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D654D2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389274AbfFMPYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:24:05 -0400
Received: from ns.iliad.fr ([212.27.33.1]:45158 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731738AbfFMMQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 08:16:44 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 8603020A7E;
        Thu, 13 Jun 2019 14:16:42 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 6D38B20732;
        Thu, 13 Jun 2019 14:16:42 +0200 (CEST)
To:     Matt Wagantall <mattw@codeaurora.org>,
        Mitchel Humpherys <mitchelh@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH v1] iopoll: Tweak readx_poll_timeout sleep range
Message-ID: <c2e6af51-5676-3715-6666-c3f18df7b992@free.fr>
Date:   Thu, 13 Jun 2019 14:16:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Jun 13 14:16:42 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chopping max delay in 4 seems excessive. Let's just cut it in half.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
When max_us=100, old_min was 26 us; new_min would be 50 us
Was there a good reason for the 1/4th?
Is new_min=0 a problem? (for max=1)
---
 include/linux/iopoll.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index 3908353deec6..24a00d923c15 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -47,7 +47,7 @@
 			break; \
 		} \
 		if (__sleep_us) \
-			usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
+			usleep_range(__sleep_us / 2, __sleep_us); \
 	} \
 	(cond) ? 0 : -ETIMEDOUT; \
 })
-- 
2.17.1

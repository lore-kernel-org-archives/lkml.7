Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CE8C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A945120675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfCGKW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:22:59 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:36543 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCGKW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:22:58 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Msqty-1gmF880kfY-00t8aF; Thu, 07 Mar 2019 11:22:52 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: pxa2xx: remove incorrect __init annotation
Date:   Thu,  7 Mar 2019 11:22:41 +0100
Message-Id: <20190307102250.1140038-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GFp2DqL8FXuUvcKe0yWcXG5+XsoseIiCwvXuV3Mvf2ukE5U/jNW
 lI1KOI9xB2VRUk6FBsIBLdyAXbhZuOzJc2nhBUCRddoevt/OHN7W3JZssQrNxF1nUCws248
 ry9jAd8DiWoM10ahPdjbRIHxv6GOrA2f0Kl0fbn+eqyeU5dlmJhdyIpqD4fK9p00+8f58rS
 n42O1rjlfb5LEK6e0QmBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zeNpyMM1Anw=:CwbjhtkXlDj0GVda/2JC0n
 lOLXz7UXSnjreXyIYYlfAbBvBChGV6nggcSXvodyol++u7rNKfG+iduBH+vYWgUiysabqSWy2
 2j0L9u1O2t14Mpl3Pbf3AQCzLuPSUCTPyIhfMWpiAShM1TDT0Bt52MJuiVlTrRJYBziNH9aIA
 mjDOOpQ039WxaDZF8PJpfn+WJwhSWYEtbM4jopy7f+OtFTIfi2RJCfjKbkTJUZcKIZJ7BtFBC
 /RSGptIwW7HM4tVqobfxqADGVIQjiyFBRGwBhqyVYzgmAlBtV3PFO3LhJ8FvxRANBm9+qMOR8
 G2ZxIPtjhaux03P4wrBG8d8ZUybTjOvgZQmZgiXCetcUl+jg3CU2HMjS6Cwc3RXMg/6F0HHVJ
 tTktqB2xYG6yQEAWRrxYx2zccXGU8DVaWzb1E67yxJrbzxbklv8o0HEVuWEhqPDLfcLXRV4KE
 nSEtLf6WiIr1eQ51Fy1GnvHKysatfaw1mSo+MQuG3rGvBwmlbQ9egsJaEKqOhGsU36xH4lMbJ
 Dms8Iw6h+LiO74BRibeprU6ut3F3IvWVudpQzPP9qUxL+ox+sX5mJjAax9DmlEELK5my8C9b6
 I0myY1MavMWCccxa7Of6Iu1knxcjWnlVdnMzXLBPcn4d//NVltPfxmAsZwHhdF2liT1+2EhRP
 Axw8uQP2+mXrOpAE6T8phYE5ZJ8RczbjqpttABO8j6oFpGtwiN9sMoGBruWTCKxH76VSiYE3i
 /ATy9yKTH7SmzIHtIs0iPlErlV2M2Bs368sIgg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pxa_cpufreq_init_voltages() is marked __init but usually inlined into
the non-__init pxa_cpufreq_init() function. When building with clang,
it can stay as a standalone function in a discarded section, and produce
this warning:

WARNING: vmlinux.o(.text+0x616a00): Section mismatch in reference from the function pxa_cpufreq_init() to the function .init.text:pxa_cpufreq_init_voltages()
The function pxa_cpufreq_init() references
the function __init pxa_cpufreq_init_voltages().
This is often because pxa_cpufreq_init lacks a __init
annotation or the annotation of pxa_cpufreq_init_voltages is wrong.

Fixes: 50e77fcd790e ("ARM: pxa: remove __init from cpufreq_driver->init()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/pxa2xx-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c b/drivers/cpufreq/pxa2xx-cpufreq.c
index 46254e583982..74e0e0c20c46 100644
--- a/drivers/cpufreq/pxa2xx-cpufreq.c
+++ b/drivers/cpufreq/pxa2xx-cpufreq.c
@@ -143,7 +143,7 @@ static int pxa_cpufreq_change_voltage(const struct pxa_freqs *pxa_freq)
 	return ret;
 }
 
-static void __init pxa_cpufreq_init_voltages(void)
+static void pxa_cpufreq_init_voltages(void)
 {
 	vcc_core = regulator_get(NULL, "vcc_core");
 	if (IS_ERR(vcc_core)) {
@@ -159,7 +159,7 @@ static int pxa_cpufreq_change_voltage(const struct pxa_freqs *pxa_freq)
 	return 0;
 }
 
-static void __init pxa_cpufreq_init_voltages(void) { }
+static void pxa_cpufreq_init_voltages(void) { }
 #endif
 
 static void find_freq_tables(struct cpufreq_frequency_table **freq_table,
-- 
2.20.0


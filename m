Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B30C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9431E2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbfCVQSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:18:17 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:52975 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbfCVQSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:18:12 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MV6Bs-1hXK040iVq-00SBOO; Fri, 22 Mar 2019 17:18:02 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.14.y 5/8] rtc: Fix overflow when converting time64_t to rtc_time
Date:   Fri, 22 Mar 2019 17:17:20 +0100
Message-Id: <20190322161727.1153278-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322161727.1153278-1-arnd@arndb.de>
References: <20190322161727.1153278-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:r0URZeN4gl7747nPXhOIAmjtBlm93At/wCEX35OJL/3fdk1//D1
 feA/Fk2kPW6TKH/ldm6agj9lgaUknzZrsXCYPUuJiw4KxzSxdu+2KaKXiktyqmlcukX10Pq
 +QBEDSo+WLP9BxfDB0b3BldcwiI+rHtMakaIkvtb3NkDEwjC4RfqCQZcAaEy27j+RVfz7o/
 pv0OauMAob0C7nkOJlrBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F4pSOYgaiOY=:PNleV7UoPK6PrajcUklQi3
 Tn4AHogzTixryXzYMkLtR5rpIHwhOPG05W22vny5Stg/9DQbKVlEgWQ/IpCE9ugBanXqk69Lm
 Wu9/vlbODPiIzxjv5Eer+aLoqDFJTXQpTgbd3dQK3N8VExArKncAGsrKTGiNR5zxyPpf0wjqB
 0UHVaAmSvBUfb+sNxn1R8QRx3dl7Q3UVPTRmt+btDU+N5O4iIwJrAti//wZ/PjRiu3NpDKKqs
 NpfPFxJ7YH3TG2aHJY+/MImdk0cOeVLDbEftrWd9Z9t15FPNIGqq2tQzF9c1+j4d2Q4pP/zRw
 cGLnFxZtEEp1MUcw4RH+gmfnEgM9Vn0d9ZPWEv/9IzbXjo3qOQmn4znm04cSOklCNVJ+Y1hCr
 vI8poW694uAEHAPv3jqLlMJ1u4TfwzfskKz5b8rctNwXhOh3+QlbrvKCFq7cLbH6YHMs8qAYP
 dJq/jVWTzu9I8JjSw3w1Dkhv8ksdFGPs6Oqk7AfI+qfGRN3yM9gX6QRJupGMEV9KVc0FgSwiA
 uZGIoZUTYnFtQjzKovR4Z8hU6pHEApNrz6AHOVXo5jzti4ffCvodN2OoPkex6Rr3hc9OAgsQk
 q+F+sVFUqeqdDBDHC5/QdOueHY5eL/00fbqUfFrwkQRrudMVWodeSnUXKEDD0VkbV+lMNtVGZ
 dF9l33uCCPv26R4lwHgdgtGp3BDoctkOKjw0AU8a4EENsBpwQXDam6s5TCYyeJT3zvzcMmzdR
 mcoxmo/LRDhjGtPjOuVmzAdp3SlyTJIFZVvD3Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

If we convert one large time values to rtc_time, in the original formula
'days * 86400' can be overflowed in 'unsigned int' type to make the formula
get one incorrect remain seconds value. Thus we can use div_s64_rem()
function to avoid this situation.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
(cherry picked from commit 36d46cdb43efea74043e29e2a62b13e9aca31452)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-lib.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-lib.c b/drivers/rtc/rtc-lib.c
index 1ae7da5cfc60..ad5bb21908e5 100644
--- a/drivers/rtc/rtc-lib.c
+++ b/drivers/rtc/rtc-lib.c
@@ -52,13 +52,11 @@ EXPORT_SYMBOL(rtc_year_days);
  */
 void rtc_time64_to_tm(time64_t time, struct rtc_time *tm)
 {
-	unsigned int month, year;
-	unsigned long secs;
+	unsigned int month, year, secs;
 	int days;
 
 	/* time must be positive */
-	days = div_s64(time, 86400);
-	secs = time - (unsigned int) days * 86400;
+	days = div_s64_rem(time, 86400, &secs);
 
 	/* day of the week, 1970-01-01 was a Thursday */
 	tm->tm_wday = (days + 4) % 7;
-- 
2.20.0


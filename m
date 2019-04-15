Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE90C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568EE20825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfDOPz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:55:26 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:57835 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfDOPzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:55:25 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MYvLi-1hKVup0f3I-00Uonv; Mon, 15 Apr 2019 17:55:11 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Corey Minyard <minyard@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ipmi: avoid atomic_inc in exit function
Date:   Mon, 15 Apr 2019 17:55:00 +0200
Message-Id: <20190415155509.3565087-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yT5pRj1gEeKNHvX+QSSDe1YcoCPQ/mYdkbY06sbVOQPRdm3tdJR
 c4dsDP/p/bGLUbCpToY4coCkxWjyEGExWboznimdUtIQ2XrZeLu8JvOou0fC7jZfS+s9KQ9
 LZIVNrUPgYHtCiU+914HS21/mjKoSQY62YQW1BXT8cTAkvmCqY3iE5nO/DF2gcE7F9KL8wJ
 TKmq8196/pridrG/t4UyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AZSHc6nS8fI=:ZfSwKGZsGAAhSzusOlnvk/
 qGtMhxHiDFOOYHnrH8QKwI6Izx16uMUlQeGWhdUHYMzb+XXL/ZDGNf9jijJGkoYJqbxr+LdfF
 l1H9n1kqzNSn20tRdp+K2jDhwqsPsbWHb4Ftbqt9AMXdtIIwDm0HB6mj9TbXzmyfnFrQlX1JE
 vQ3nVnwSKKinD7vmR9UQOvqTgc5vh1NzmYRmHu0A1xVBAolLdUg/uctv4qRUnGL1w7JumTeIQ
 6y7BPb6jHAsGP475ZCMg1R+tmpxZtdrTD31d2ZaSrjm9pwZCOKt+eekhTewreZKh095yE4SI3
 X5RtQdguB/Yrz201Ycu6j5o4huqz5oLaNLaWZ+Mu2RQWoFxD7dZLAKOj/xU6ZFtf2LOB+6GFH
 EPqLCzXMlEdCqhOaywvp30FIY2MGPhB0jkonaHAg+Bh2XBr9uhjCThD9EHm426uZmyi7VMXTy
 kRSx196fy/dkra9kI7fwPXawQIjAiuVFBR6NpzBTcOOJYd8TeDrh+fQUzzOw5Gtk/9kj4gHi2
 SuWQLHU1ltRySpwf8Sx37MEeNrg5a6fN3FI4UMCgSKJSCzXY0LVj8/8EFU1rl5SeR4FoFdiP7
 GPzV4KovxyHu/0q9LBG69csaCm98jQ53Cv2m1WdsFE4ErNd1MsxQQkorhetkP8erMJ76/FvKF
 rhZa2g25oiyodCV01m1xeTI1LBBBREonvd8PpSAXfD6/3q8CUZcrm5dus8ITpcDdERyTJwVn/
 NjKFqVw1Uq4dKN30U+ZwNKtuCtWQds1fxhPjhQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This causes a link failure on ARM in certain configurations,
when we reference each atomic operation from .alt.smp.init in
order to patch out atomics on non-SMP systems:

`.exit.text' referenced in section `.alt.smp.init' of drivers/char/ipmi/ipmi_msghandler.o: defined in discarded section `.exit.text' of drivers/char/ipmi/ipmi_msghandler.o

In this case, we can trivially replace the atomic_inc() with
an atomic_set() that has the same effect and does not require
a fixup.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/ipmi/ipmi_msghandler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index e8ba67834746..c48198eef510 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -5164,7 +5164,7 @@ static void __exit cleanup_ipmi(void)
 		 * avoids problems with race conditions removing the timer
 		 * here.
 		 */
-		atomic_inc(&stop_operation);
+		atomic_set(&stop_operation, 1);
 		del_timer_sync(&ipmi_timer);
 
 		initialized = false;
-- 
2.20.0


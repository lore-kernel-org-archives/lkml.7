Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED7FC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8520820857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfDHV23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:28:29 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:58909 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfDHV22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:28:28 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N79hs-1gqNNw0cE0-017YVU; Mon, 08 Apr 2019 23:28:20 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] s390: ctcm: fix ctcm_new_device error return code
Date:   Mon,  8 Apr 2019 23:26:19 +0200
Message-Id: <20190408212648.2407234-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190408212648.2407234-1-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:o4R0ZM0QUffv2XWKmjETaIeLqeahjXhDfv7LnT6n8YxTPA6S0NM
 x7CLrqCeb4qpGvtBxSnGTMcLPtSuDa+P2z2FL836RfO4MafPSwAHpbZZjjI1x51B9ZlYZJQ
 RdDHPJYS6m/aa/D8Mz/PmOCbCDmQXxaR+rK46VHS3juby+nsLVwskD927zSappRIJz8lO3J
 SjC2UXvYJ0dFoEQH9FOUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:okQOMoYWVSc=:E34AXOjUs0wa8pGzQKmvBs
 9dtOmo/DWp1yFX1osWQSMjnJ4HeW7wUnkzHPo5imd7E9wn1efEIZqihcbOc9+WJ38NC0rzBBR
 Cy0S/w1syvbZxu+0QzyTcR8Ed+Q2jnpQtje6YeSqLEU5nNGj4/BrLgs7o8t4ssNiLWdpE+GSu
 9CVw/jO8mBYzb7RnDJLgM5I/IVaghN88J+/x7VGJq2psD/0HceZnKN0k0fUGBw3ZbSaS2zumS
 sCAKHvET91+k28LkEFP26ve5o7jsnmYzByIu3mt+nLfjfwDIgx5K/rxntKaGAXYnvkt1g3ts4
 0NmazKY+WWpRMzmFOAAJ6pjkCP0vNXe6Kll4dBzDhoxUFD8oIP+dwk6C22pR/AQN3RUgWABss
 rW3ua+0i+Jada21l1mvg9MicG0E0/ZTBQ4/eN3Cp6HQ/a8jHym6xUJRlk743H1HNilsEOCgnm
 c6UilGcO5QwgoBJlTIs0CHfwBQpaFJlL6KWxvNXgET1F7x7T36nSJZMBXBRdixfnsIrJBmtVw
 qs61b0dj49tVa1jMegFFSx/yxTeQG8mZRtfk80XkWIp1W9mGEhsWVrXAsHQXJ0qaTYRimDjtn
 FSTPEJgxvTqPQtjXpFTOl3EUtZ2MHv4U1M8B07O6QGPt1icGcCjporwPEjmp8TNDW6RLJiPTh
 4JcHuz27tKUg20D3kEEUhfY4Q4ryouabhPSgqriZWc96Zj3H6JnC7awh3+W2/tAaD6OyMk+YY
 9LXpNiDqzzwOEt6jmWnRcYTgedN1XfumL7Fs9A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang points out that the return code from this function is
undefined for one of the error paths:

../drivers/s390/net/ctcm_main.c:1595:7: warning: variable 'result' is used uninitialized whenever 'if' condition is true
      [-Wsometimes-uninitialized]
                if (priv->channel[direction] == NULL) {
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/s390/net/ctcm_main.c:1638:9: note: uninitialized use occurs here
        return result;
               ^~~~~~
../drivers/s390/net/ctcm_main.c:1595:3: note: remove the 'if' if its condition is always false
                if (priv->channel[direction] == NULL) {
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/s390/net/ctcm_main.c:1539:12: note: initialize the variable 'result' to silence this warning
        int result;
                  ^

Make it return -ENODEV here, as in the related failure cases.
gcc has a known bug in underreporting some of these warnings
when it has already eliminated the assignment of the return code
based on some earlier optimization step.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/s390/net/ctcm_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index 7617d21cb296..f63c5c871d3d 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -1595,6 +1595,7 @@ static int ctcm_new_device(struct ccwgroup_device *cgdev)
 		if (priv->channel[direction] == NULL) {
 			if (direction == CTCM_WRITE)
 				channel_free(priv->channel[CTCM_READ]);
+			result = -ENODEV;
 			goto out_dev;
 		}
 		priv->channel[direction]->netdev = dev;
-- 
2.20.0


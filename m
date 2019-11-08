Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC0EFC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80F5215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732685AbfKHVdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:33:40 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:42255 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731601AbfKHVdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:33:40 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MOzCW-1iGzco0Bwa-00PKzo; Fri, 08 Nov 2019 22:33:26 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        devel@driverdev.osuosl.org
Subject: [PATCH 01/16] staging: exfat: use prandom_u32() for i_generation
Date:   Fri,  8 Nov 2019 22:32:39 +0100
Message-Id: <20191108213257.3097633-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108213257.3097633-1-arnd@arndb.de>
References: <20191108213257.3097633-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0MSwPuOaQAzghrJEDyZlqv05bI/+SpkvfIU+MJ9BeKiWSPaHd0p
 392UEHTrotwvsLO4OcIt/xO0Z3OGprQKX5WHtFKLoQAQpDv6I2mmSdje+gQQz74ZSiHGY0F
 KijxNkEpHfi8XdJMia3y2N6RpdjFbm5OKxME6GlH17dMSMZEG8jO22jb9ol3SgxZaSltt/b
 vN8t1LsHzkSgZ06ObIKEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oLz/LL5df3I=:aBRiyUF0lSDKUtt5Gjjqhy
 xYbnz9RoFaI1jbfsYk63+qmbpstnTAeqese/D2MfJDQTwJLcosbmet6dHm2Y2Gpctt6tZyasb
 Bhr6nFPe9HkBTxappYvULm/0UpzYIgfIoxW8ckQ0I8aL51oGwTCkvNucbRoZnj/wswSgOlSbQ
 GjWfMQFQGusbttCDtzK3ZwhozndLBxXca8ZY1usyNDycBG52rvqlCrG2526j3lriF4AXeJ9Gh
 vzHmF49hdGwXkqao+mG8gcyhP43N/2pSgNFuMmpyyASRYkELYohIOdIfXTcS6xcsQNyXhnDJi
 qEedgfwOXmQvuwLS24iB23AmHuSU3KcvqCssypdHni1Zfxp4MXrjn7emneRwS94DhYebw9q3K
 sdOJCZI6NOvHYQiTFYmrdMnuZeRrVu36nhH8O+xrGq0yNwk/UfIXyWGEg92hka5tIAdymYD9u
 du0CGF/HkHtQbpdyOxGNqxvLQHON4K1S0gcux63cdOENL+nMJmiKHxXfvZxloRvt6dLeo5XLQ
 lJ+cy+eklRnJhQXpPs0w1MsZY0FQYbExvxDgxEgW1rJuScpZA8450rwmGSfuIR0kKfPkm3Co/
 rXk+z59Y9aHOu96JhZEI2At6n83c5rlB821oHQSjI1U045WyyPsyDd4H46clT5qMYOSpatAql
 ihzR2AzCw0jsMQYX7hTqKEjTAGTqM+caI5lMwkcIfnJckOsEWyRorU98zrLQmtBGGJ2WV2o+s
 PYevsMCDYkCC0XIRPm9KGB54XUFkkjLT4Xtt+n5P8G65pFRs9SjJ6F2j//N/I3WvejnHSRpPA
 kh2fSiEEPVK6jq0xaEBm5MOd58/oEayTLsEJme3KiY+oaRMngbP8kPsf2NJ1tf5MHOVVyw91I
 tMBd12T9KRLgVow+HOSg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit 46c9a946d766 ("shmem: use monotonic time for i_generation")
we should not use the deprecated get_seconds() interface for i_generation.

prandom_u32() is the replacement used in other file systems.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/exfat/exfat_super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 3b2b0ceb7297..da76c607f589 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -26,7 +26,7 @@
 #include <linux/sched.h>
 #include <linux/fs_struct.h>
 #include <linux/namei.h>
-
+#include <linux/random.h>
 #include <linux/string.h>
 #include <linux/nls.h>
 #include <linux/mutex.h>
@@ -3314,7 +3314,7 @@ static int exfat_fill_inode(struct inode *inode, struct file_id_t *fid)
 	inode->i_uid = sbi->options.fs_uid;
 	inode->i_gid = sbi->options.fs_gid;
 	INC_IVERSION(inode);
-	inode->i_generation = get_seconds();
+	inode->i_generation = prandom_u32();
 
 	if (info.Attr & ATTR_SUBDIR) { /* directory */
 		inode->i_generation &= ~1;
-- 
2.20.0


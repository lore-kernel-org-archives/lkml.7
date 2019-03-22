Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A943C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594ED218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfCVOTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:19:37 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:41881 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbfCVOTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:19:36 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MbC5g-1gaC3Q0f7o-00be3v; Fri, 22 Mar 2019 15:19:24 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Dave Kleikamp <shaggy@kernel.org>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] jfs: fix bogus variable self-initialization
Date:   Fri, 22 Mar 2019 15:19:16 +0100
Message-Id: <20190322141922.691391-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dysjoZs9F1yYd4bEUKZjlYJHOG/zqeHpWBN2qk3C0cUEDSJ8r5k
 wa6GbZZmD9w0kz2k62HbylXr9lYFOYWl9/+PCNlAl7KkFneGn4f5KuHgamgOhCpXOL9zvL6
 cwUfLmErtjgHISJn4k8qu/7QGTe7HZNvMDF7YEzvKUS63rG1+n8xOBMVnmYyLjx6XAIYKsT
 s0ZFZcwJbI9JRT2zzPcZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qZ6m3ZQ2kR4=:vqm0S1vREvvyZpw8Ni+LY9
 Ay8XYgGF4XRJXUHEv08GA24/NysH4u5OJB2vbdlVtgT5aM0NmrWP8YU6huXCcqaVs4WMAEkxz
 lfluPWHEuu2oZRi35Hwdu/kPN2KgLy7vaOI9Jy+WiEuE+pu7joS0IBrJeEYvxpor1ckUeJQf2
 d7UlHbshgAZ1hSqXpnoTi/sM4GZFejBh5GiOIGdBCcSVa85SSniMYqsbQ2JoWBhNB7BgXEmS2
 o94XIP8HJOdN1Ym4UZRLC4mQqA5dHmRq573ogIAHZM46TvhnzsY/mVD0TR3RwztuB+VbFsK6F
 IoErIfzvScEuHMkxwWpgIl01suQYTz4p9iebPaQw8QNl+P8XLowCPpcvHdj12kWqiwC0593HI
 BkPMFQTYKqGAmZ/St84ERWL/u7rPUwJ3AtPGo+oIJ8asH6J4nEF7nUFzBRtDIEWUrDIgNX2WQ
 RzweZKy9lGz2BbiQjVenlRUfp74upS95QlxqmnbEc3sYkm8ZYAhx6AKQEQVchYKkm4mXu96jm
 k4PpieMtWCIx8jW1rtvYnXAU2NgBwmJBSc4M5EuRSW8+TUlB0TZUnI1M4Cibwi9vsQUY/x4fB
 q/s1EYEMl573dL1uDefnxhaqxaIsfUJRAN9X9PeANbEH2Yzx6N/dstPqL2uDx+6mjQZX2HxUC
 H1G+tTtmsdTDhXK9Njxt3ZJNmkVUHEnZkUvNe9/kzRYtQhz/ln1xy2SI9pVZpWsR338OIjHuK
 8zhz3qO+8+eU9sAwFrgY+YEa7vJuzDc6eCfcuA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A statement was originally added in 2006 to shut up a gcc warning,
now but now clang warns about it:

fs/jfs/jfs_txnmgr.c:1932:15: error: variable 'pxd' is uninitialized when used within its own initialization
      [-Werror,-Wuninitialized]
                pxd_t pxd = pxd;        /* truncated extent of xad */
                      ~~~   ^~~

Modern versions of gcc are fine without the silly assignment, so just
drop it. Tested with gcc-4.6 (released 2011), 4.7, 4.8, and 4.9.

Fixes: c9e3ad6021e5 ("JFS: Get rid of "may be used uninitialized" warnings")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/jfs/jfs_txnmgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index a5663cb621d8..78789c5ed36b 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -1928,8 +1928,7 @@ static void xtLog(struct jfs_log * log, struct tblock * tblk, struct lrd * lrd,
 	 * header ?
 	 */
 	if (tlck->type & tlckTRUNCATE) {
-		/* This odd declaration suppresses a bogus gcc warning */
-		pxd_t pxd = pxd;	/* truncated extent of xad */
+		pxd_t pxd;	/* truncated extent of xad */
 		int twm;
 
 		/*
-- 
2.20.0


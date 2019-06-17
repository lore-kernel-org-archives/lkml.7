Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B3CC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7342720861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfFQMsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:48:24 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:35837 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfFQMsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:48:23 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M5PyX-1hbTbo3fxl-001Ome; Mon, 17 Jun 2019 14:48:01 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mike Marshall <hubcap@omnibond.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: pvr2fb: fix compile-testing as module
Date:   Mon, 17 Jun 2019 14:47:36 +0200
Message-Id: <20190617124758.1252449-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fQtLcNbtFadlnuLEAq66p6lty3m3sCianAYbjFY5chYptpALFcP
 4TxA6KG53CIq6rdVgC2Kw5nD2IaMXJ9u2BJNWuVDUJEgJ1UZ7GJu0qTunRJs6pVBchRVHN4
 6/SGL8y9THk7xyJslKbKJ5xTKGBxXsBnkJr8gaAoXGZvwc1iK9Xywo/doP/QGHF3pzhceof
 kh4RdN+3fsW0iy/E4G7aQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NPqdFaKRhec=:lkKoHx6wdLb5r5g14ioiy1
 uwH9a3rmaAwmHLYZGcFd7m67zqtsWFr6xzqJAXKqkl0T1laFSLypRhCug/yHZbNyO6xuGYPMj
 liNdVhD4poaIJSkG5UsQfXvYfLUNGtOk2G23+cjDJhhsdFXgyE3uswykw4yMedtlojfb6fjot
 hZ9qYQuXhQzAje+Lf1iY6rf6k9npIa7e9LQukSn76TWe9gCvOeqefKSKW1vCEqqu2OELO3ZkL
 du4t2tjwc12ZyMGfT5pvlO41awVTRrpuxRlNbfgtM1g9LQyNkhF9/dAV8iM5QLuKYGi7/2TQV
 k4AathpPl5Fty7Er23WgsVkLjT47mEGB4EDYly6mYWxfB9y7q2VwjsFTH0mX4UYlwZuQQdHFC
 3sYlbZVzHpKdsXe+LEHdI+cOFr/OVL3I7f+C20gayOOfRSEXw0IB7xMZnUoNfd5UglXL2D2A9
 JWJj4fPdpB2IcxUKjOo4VSWXi2kTYBVYgym6AX4+MZwGKP/89gBG8dq5T8sRqiBiV+yTgUR94
 Tq2jvVXyaaQUznlxOVi1gE5zu68cZ1IqPSBaPadTunaM4dTsZCDAeOZNXHSR3p2ad0LcgBOjk
 mGAYcQVb1d64vwwAd8eGIZP2+adfBBedct4G2WfAWWW91BiweyqFd4dRbtwm1r1nb+nEyY6Rd
 lzDOEX4sxeTU62xDnO99nVuRvGLgHlz8Cmz1stGzayK8+xWfvIaOkCru5mvDpX1utmzdpk7oi
 ejdZRUC4AlthUaR6bdgaY5kj0z1rHqVauKxVaA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building an allmodconfig kernel now produces a harmless warning:

drivers/video/fbdev/pvr2fb.c:726:12: error: unused function 'pvr2_get_param_val' [-Werror,-Wunused-function]

Shut this up the same way as we do for other unused functions
in the same file, using the __maybe_unused attribute.

Fixes: 0f5a5712ad1e ("video: fbdev: pvr2fb: add COMPILE_TEST support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/pvr2fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index 59c59b3a67cb..cf9cfdc5e685 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -723,8 +723,8 @@ static struct fb_ops pvr2fb_ops = {
 	.fb_imageblit	= cfb_imageblit,
 };
 
-static int pvr2_get_param_val(const struct pvr2_params *p, const char *s,
-			      int size)
+static int __maybe_unused pvr2_get_param_val(const struct pvr2_params *p,
+					     const char *s, int size)
 {
 	int i;
 
-- 
2.20.0


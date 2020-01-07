Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60450C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317BB20880
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgAGVZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:25:36 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:45677 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbgAGVZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:25:34 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MYedH-1jBdkj2AHz-00Vh2O; Tue, 07 Jan 2020 22:25:10 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Oleksandr Natalenko <oleksandr@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Wenwen Wang <wenwen@cs.uga.edu>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: sm_ftl: fix NULL pointer warning
Date:   Tue,  7 Jan 2020 22:24:52 +0100
Message-Id: <20200107212509.4004137-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ncIFui4ErDAl4vN/oGEZXMNgEj4j+k+9hJ4pY48nu5RbLc25IKy
 wvT+1dVpVSXAjxr8JMNEH6BWU5nmzh0RpjqzFua0sIzGAqz6fYLPTHVL9cy70ikbrSVcjVS
 5ifk2tLrlvqrjRbvrxX+6Li7G68QFpqz3mBI7ar3+fzpkJgnJB3GeyN8ryWzz59jxNB3CQA
 JD2S+j3ILJZXPHyrGrhqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K+zk6N/AoxE=:gW0Osoe5f1+X5N4GWTz8yH
 w09mbUEW7a5i6/6NjJMJXCa3EaTI4K+XKu60VSsNh3oCxpvYc5dJItw4A8U2/7wlRMJolwvq8
 Sx3lwS/7mYRyca1pMXr+uTcxrv95i4po1Gl4qEsdSVy5GLG+zE+JsZEtIwhYcIGzvOE6iAk7F
 CFEQlXNoSsBmTl5TNyVZxi5ezNux8js1DQ5kCXW1QZPTjjrXUg+yZr5bTA9RkP2/UwhH4oWuC
 lNeoYSyqvSi9t2h8Ry/YIJlccaM1SoRjOWZmAFOBpJTvF956eLJx+giGcTt5pltxzKmzuUtJ5
 LWvm0k4eC6+5bQ08yQLBisDHsavX8aeI3z/N0ZHehgDxIlfvba3YnA2pQY4K+70UBxJbRO5BG
 GNHkur5QivKFDnuXo18fT8SpSAG3DbUblO3fp1/XLBP6nlvJLHW0gaN+ThkdFJG1KBTNkLky8
 M4P1QWVLqAIcKFN6qzUXnr+R57zNY35+ljt/n9WSpFqR1Q1FkFo9XK7thUoEvpOzkOouYQP5s
 VDitBCjgwQ3ipLT8/CpG6WpWrps/mn0TJPP8wW/wr0uvD6/ODlh4Zhj1/ZEbYn/1FN8R9RT/Q
 WPIhTMJ5wGle5WysYqUEm86bxoAY5ZpnQ36ObV930La/Y5Q92keUnr+9i7dlYCWAjNgctD0mx
 5a5lB5+BhjHFAE5JfoBUuj14CvXWphSOEX2lej0HRD9Wd8h4aw26i+IkdxRhuERYNm5UamKRh
 nLFMu2zHexaw77cpJAm1xuo15mZxG502vpIbapME1JyHcku4fnkIHIIbPvQffE5eMv9X/p3EZ
 oSNfpG3/DNr74QuMpnFvFXO2c7hbxRWbiBzhGI1agyoi3bfEUBD+IhnNY3AltaaXpdfA7/Cia
 DTWUY+bxhNAo7K10gfww==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc -O3, we get a new warning:

In file included from arch/arm64/include/asm/processor.h:28,
                 from drivers/mtd/sm_ftl.c:8:
In function 'memset',
    inlined from 'sm_read_sector.constprop' at drivers/mtd/sm_ftl.c:250:3:
include/linux/string.h:411:9: error: argument 1 null where non-null expected [-Werror=nonnull]
  return __builtin_memset(p, c, size);

From all I can tell, this cannot happen (the function is called
either with a NULL buffer or with a -1 block number but not both),
but adding a check makes it more robust and avoids the warning.

Fixes: mmtom ("init/Kconfig: enable -O3 for all arches")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/sm_ftl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/sm_ftl.c b/drivers/mtd/sm_ftl.c
index 4744bf94ad9a..b9f272408c4d 100644
--- a/drivers/mtd/sm_ftl.c
+++ b/drivers/mtd/sm_ftl.c
@@ -247,7 +247,8 @@ static int sm_read_sector(struct sm_ftl *ftl,
 
 	/* FTL can contain -1 entries that are by default filled with bits */
 	if (block == -1) {
-		memset(buffer, 0xFF, SM_SECTOR_SIZE);
+		if (buffer)
+			memset(buffer, 0xFF, SM_SECTOR_SIZE);
 		return 0;
 	}
 
-- 
2.20.0


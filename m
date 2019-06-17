Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E38C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4618C2082C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfFQNQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:16:49 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:41529 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfFQNQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:16:48 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MrPVJ-1iNDSv3rCJ-00oWs2; Mon, 17 Jun 2019 15:16:27 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, YueHaibing <yuehaibing@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: pvr2fb: fix link error for pvr2fb_pci_exit
Date:   Mon, 17 Jun 2019 15:16:12 +0200
Message-Id: <20190617131624.2382303-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Qe2+Mxqk7UNlW2kImG4dBpHk395qN3F7QKua6gNeiC02qC4dv/0
 KyGHOwqMvARphB1xFvw1ZRVnRDGdoympCDhOCPbmLGZJ65qH0XZlGS8W5o8zpfeTn8G0p+j
 U9ORexC2jg0VRUZbYphRu24L2mh7wPWzgPsqGF1zvefqLjoNciY31NbZSG5iTrZbcLPIGOz
 abWHduBRPpuRTmnm5s9lA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H9A3Z1xLXVI=:eEoA67w9aBjQBcOJXDFqN9
 /iPd9cib0USpQoPAxAgbr+tggKDwCqcHbtEd/RLlOqzgrcZg5La4xZ5LdT1EfW25hW9Ph4Xw6
 RuC7sLlSXHw6P1f6UIJTz3bzlpt51WmCGjmd149e4GOZzD20TGerjeo2jUM0OHJiw8D7zO+1y
 QyisIco/v5yYKC6aWgfujquqXdoSONt/L2UseizZ9xDAoXV2IQViMJGjZSogVb2YDOSgphU3U
 SNU7fWESOViEn+FgCQSyC6IzDt4OZ19kcga4I/J3Em4FTUo6ibpWArH8fuwf4+287IbBU6A4c
 +3EPuAjBwvDY1chWV0mxutSdWWw5780fYoYj0LtRkodIQ3E2aZew6zz5zaMvos49Hlj7Pp54B
 U8WoS3QGbiytFpUlWHXAJJFdu7ms4neA11pQ76qMJuYVQbslqm1UpW1XPG2AdgIVafv/ty9ai
 BY8maX8WzpyIfziRRvzQF6IsmZNgO/9v/DqCfUbpZLvs5kcnO7w6yyNNPqS3daxKosKAi+eIR
 K5EsGbyK28TR6BORQzhdEMSa8iNDiIahXXWRh3QQSSmKxRmMuq6LMMs7U+AVDdzxe1SQ6nTPb
 b8STQpqH9i6DejA9h00x5u3iDuxumt9mZQw+QGVQjqVu6z4Z2I4pLn0kgaYbRzdZGSJUDmqnU
 IzFDQ2E0jWnqGNw5TzI9Aijz/2EyccZ8ugOgnnCK1Eg9IGF03w0MsLD9r4rZfxJfz/3YKfQnZ
 anbQI8kXmNSznPe3mn5FG6wHjRu4hxB9lGjAfw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver is built-in for PCI, we reference the exit function
after discarding it:

`pvr2fb_pci_exit' referenced in section `.ref.data' of drivers/video/fbdev/pvr2fb.o: defined in discarded section `.exit.text' of drivers/video/fbdev/pvr2fb.o

Just remove the __exit annotation as the easiest workaround.

Fixes: 0f5a5712ad1e ("video: fbdev: pvr2fb: add COMPILE_TEST support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/pvr2fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index 299ea7db9220..cf9cfdc5e685 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -990,7 +990,7 @@ static int __init pvr2fb_pci_init(void)
 	return pci_register_driver(&pvr2fb_pci_driver);
 }
 
-static void __exit pvr2fb_pci_exit(void)
+static void pvr2fb_pci_exit(void)
 {
 	pci_unregister_driver(&pvr2fb_pci_driver);
 }
-- 
2.20.0


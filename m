Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E80C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A28C2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="mB77gwpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfC1Bsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 21:48:47 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41469 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfC1Bsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 21:48:47 -0400
Received: by mail-qk1-f194.google.com with SMTP id o129so11194162qke.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 18:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OfC1wVNQx5KkSjkgc1GXGV9UVQqSz9seeLXuh6KqFw0=;
        b=mB77gwpz8A6DKLGze1z20091l6OUFgG9+u9nhQ+cNT8IO7XbmEFrm59GNKE7jOYkDb
         n6dL7a3jfqL4tZf3I5YPh1vwRpyZYLrg+kMYUNGyVoAxDOGTWfiiURwBXBboQFFYc29v
         c7WSf5Sc0yncP4ERqiZ5HEC/GsA8yE23x7AaPdxAUaF/6LqNizTHQivjJ3DAU4ozmx7v
         PXdmzsRwYHjHcRjwHjLvjKuRpFP6nJ/OMpQrZ5l6mEZ7Okbrsx+UhhkVVRiBZlVbPAHr
         JekAV+c6kNd859ErZW+8YUDu/zqw7jaDff12QWmcodNKyLinaWFpTkaKyGDoBMFhtnoY
         kCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OfC1wVNQx5KkSjkgc1GXGV9UVQqSz9seeLXuh6KqFw0=;
        b=Sn2vfc8U6iYVFWxqppBYBLHCyQl0+1nrUS5dhZgyKUeAr2IwMJKuN6Qddi+3K8oyVe
         yiAPigorTta0Ubcu6ohmB8sWArXy8mZ01G+0dc9IJa/LI+wmw9xxqfV8Iz6TfoYL0Q0r
         EiA2CqOTlWXLOkIfh4vhF/Gg0Db9YL22OK63XckZH5BQIu1UkDl7h3MtfSwFbFJSQHrP
         YiApd/xwHKAXTXPLDU5PRFMynJnkgElR6ohQ/ziPDdCJXTsrCPfu2YiNVVbfBBFejREB
         ccQ5ssrmKX5FDKGjmv+Z94xd72KQ/qf4P53y//PxNETq9e9D4rZDWongKBOAgQboKG4o
         tZzg==
X-Gm-Message-State: APjAAAXcIMnbuhr6ZXASHPvn3vegsZbCujv1dWNJ66DQVNh0baJvrG8+
        TYSaz4sjBCCuFtUnuC72/JT5Y3SL960=
X-Google-Smtp-Source: APXvYqw9JdQgFyIA9SqKRjKAPiZn1kMFNi6QX34OCBUxq2XNGbenZUjn/JSoqwomUyldd0IK54xfNA==
X-Received: by 2002:a37:650c:: with SMTP id z12mr32431643qkb.115.1553737726267;
        Wed, 27 Mar 2019 18:48:46 -0700 (PDT)
Received: from ovpn-120-94.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s12sm3801511qke.36.2019.03.27.18.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 18:48:45 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     hch@lst.de, rppt@linux.ibm.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -mmots] initramfs: fix a compilation error
Date:   Wed, 27 Mar 2019 21:48:06 -0400
Message-Id: <20190328014806.36375-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 754006569c54 ("initramfs: cleanup populate_rootfs")
introduced a compilation error with CONFIG_BLK_DEV_RAM != y due to
clean_rootfs() is only declared with CONFIG_BLK_DEV_RAM=y.

init/initramfs.c: In function 'populate_rootfs':
init/initramfs.c:659:3: error: implicit declaration of function
'clean_rootfs'; did you mean 'clean_path'?
[-Werror=implicit-function-declaration]
   clean_rootfs();
   ^~~~~~~~~~~~
   clean_path

Signed-off-by: Qian Cai <cai@lca.pw>
---
 init/initramfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 000e88ca08b7..435a428c2af1 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -610,7 +610,11 @@ static void __init clean_rootfs(void)
 	ksys_close(fd);
 	kfree(buf);
 }
-#endif
+#else
+static inline void clean_rootfs(void)
+{
+}
+#endif /* CONFIG_BLK_DEV_RAM */
 
 #ifdef CONFIG_BLK_DEV_RAM
 static void populate_initrd_image(char *err)
-- 
2.17.2 (Apple Git-113)


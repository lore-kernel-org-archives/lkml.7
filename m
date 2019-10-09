Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E83CC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4D1218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732523AbfJITOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 15:14:32 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:48645 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731827AbfJITLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:16 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MUY9w-1iiiBO2Rnc-00QSut; Wed, 09 Oct 2019 21:11:14 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 23/43] compat_ioctl: remove /dev/random commands
Date:   Wed,  9 Oct 2019 21:10:23 +0200
Message-Id: <20191009191044.308087-23-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ch73ytSgkS4oO2S41UnNXUn/KSJkmlRmqTVkiyababZ9lcd2HmZ
 l18W6SmPMr4W7U9DWKyd3pxDD1nj9yEj1Ou4wqNRLKtzbDLLCXdXpAoeBb1eYQODVbRCd25
 7kh75HGXTVxdLptZI8IsTTBoPfgxqkZx/APabZcPCZimckfmVFsY7EwOgC2AuzpQimd9Pzv
 iGnWmE0DSKNq074mPIXiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mp88p1QWiEE=:vZ9uVfiRDQJSgHqzjVRZzC
 BLZy+JtpG647XofXSYFHsX58YjMhiQy0tlW9NM2tYEjhWuHmmFUNEGNFEb0IXxI0xS9gZCsLC
 dTYqJ+6UktTYxrBJz6hprK++ur0WUla5FN6ejzfosIH4SGGpaE5qOxB937769UxopXr+jRqeZ
 +HgZ+pYPJ9MqrccH28mt5dVlVQJN5nDef0horNZ5Cn5JGQPTy8oBqzaLZp8vkgbrqOojs4/bx
 XRpswMQDTVp0+ohB82I7JbcIAzk2o1KHYyZ/qsWOwJz9Rzt65fd1GdHN1sm1vnY6A6DEv9F+U
 Vm80fKI8uSDF7hd+TUdZOQh9bMLvon9DTrQyEvVznhN0rgXfZiAy7Di8M2bnv0O2cytW6UhPI
 p14zadmbezGpIQSYg4yJJlyMMob8QkE3eZNlQyRJXvprX19Y8LiwbRatlZwN13GqDt4eFGfsB
 SMMi5u0/zmyK0r5c9B5ZjWoxTr+lKqFHZnvSRmN2m+gxGD/yApL8t5wy9QMIKGwqFvbO+MSU0
 GMPrFqGhiByU8cl+x4jiS2fTXS1C+WfSBmMMCkDz1ivvO+CbMVOYBbhdMdDh1GXxLuADVb+yP
 hOV3v7t/WLNHAAGVEoGs/71LHQjOqOUOnyNte6npQvWkNFf5lx6qf3EHOBSLuTOCokg3OSTX5
 dlqto6yy8strq2ogrPAoj9rSYmd2Ld3BlqXu6VHBsj6+r1wJgDHKF5BaGG6CP+LlkrH9VIT+g
 z3MuEy3tSsAiZOJ1A2PExwAfl+q041oJkdcbkl+fQ8OH+5SkoPG4fLwl5sCdhSXTrzOnZp6Mk
 WHIbNwY3Xl7IEht+6Q1OCvj7AJrDRWmZPBviXYXm99FxtTxtiBnh0EyVXbNOeUNqbcpVHAwr/
 RetjiPXaFCl2b+MblZIw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are all handled by the random driver, so instead of listing
each ioctl, we can use the generic compat_ptr_ioctl() helper.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/random.c | 1 +
 fs/compat_ioctl.c     | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index de434feb873a..46afd14facb7 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2167,6 +2167,7 @@ const struct file_operations random_fops = {
 	.write = random_write,
 	.poll  = random_poll,
 	.unlocked_ioctl = random_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
 };
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 10dfe4d80bbd..398268604ab7 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -439,13 +439,6 @@ COMPATIBLE_IOCTL(WDIOC_SETTIMEOUT)
 COMPATIBLE_IOCTL(WDIOC_GETTIMEOUT)
 COMPATIBLE_IOCTL(WDIOC_SETPRETIMEOUT)
 COMPATIBLE_IOCTL(WDIOC_GETPRETIMEOUT)
-/* Big R */
-COMPATIBLE_IOCTL(RNDGETENTCNT)
-COMPATIBLE_IOCTL(RNDADDTOENTCNT)
-COMPATIBLE_IOCTL(RNDGETPOOL)
-COMPATIBLE_IOCTL(RNDADDENTROPY)
-COMPATIBLE_IOCTL(RNDZAPENTCNT)
-COMPATIBLE_IOCTL(RNDCLEARPOOL)
 /* Misc. */
 COMPATIBLE_IOCTL(PCIIOC_CONTROLLER)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_IO)
-- 
2.20.0


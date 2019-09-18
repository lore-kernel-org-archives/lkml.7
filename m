Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33A8C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CC1222D1
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389114AbfIRT6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 15:58:32 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:51523 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389099AbfIRT6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 15:58:31 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MhDN4-1hfDDh3bTG-00eJBE; Wed, 18 Sep 2019 21:58:24 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Smelkov <kirr@nexedi.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: unexport fuse_put_request
Date:   Wed, 18 Sep 2019 21:58:16 +0200
Message-Id: <20190918195822.2172687-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aZxKUK3JTH0fyFK7KFMxUFxerV6cXmaaVj60LXyUF7W4ep0GFSP
 i0cIPYK+C0J3asHoHzYYJNXzp8uN4MjZ6jSdpaBjh6NQxwhppJRR9y/QotpsjVXoXUjoHCZ
 OGsiWOue3oRHdc32GJ/105e+IOXqA1d/ehm0TPDAgNctUPDUcqRfbNfm9QNIbYLN73JbINN
 X4DqxBYlhm+wnO/a1Fzhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nvmg6C1/Dmw=:UaquQwaWhHljTnDxMH2bQQ
 ddus6SBgYP+7dEgDcDrqK/z7n0mklCmoG1CrHi3AU0lBSdLwbfdXiJ8tbPG6NJ3Y2JvOkxFNr
 FEm+IdPDbTKCmZRuKHFBu/qg8HOn09nVO3DS0SYxBk7BJj2uaresnbXCSYe2FhL+p8banqWxP
 +PFNo2PKcMjDfQAHEEzQBOaQSU6RvghXSKVmxjPqXqr09Ut3fVgKZSVTsm75Gs3eROYYDH47r
 SDVxycHQXJ3v08JPrDJg21iPXVBkabQiRzvhl3g6mRRLiZ2VEnA/LiE6uoWMZscZZ67DUPmMJ
 5/1Zhx4GUsWUnw9yxkJgcLlj0/1WNSXQ+ZlkBf+968EIk3ucOIRcak6DnIX5iGd0K4nNveu4e
 ZIwGzH4z+t3v5cqBk3O+XW6qt5dxqUNgA67NUuZqEb2j/xhOAkXaVUQgGQS63SIC0s5CWV6gF
 Q+oaNSDPIGj8qA6a/fbrAACW3Lv7HebRF/f4O2gutaPMPPJrywnOgj9ExdTxVEOn0vjnCRD/O
 DREmOdntCF5Zt9hulgHtpCLvarTcg8koeYR8Qpn3ACd12ss3+xDAekLTRqY9/i4H7inZjodkG
 T4jvfFERJJryL7g2ocCdAM9iYXxZJFFv8J2kjsEuaKimax0b6hjzvV65koWgLTZaVWkeuPahV
 nPJtSJ8BzKq+tAtXqkHyZB5NxI3AhfilDiH8BI34UcchhtFy0bRYRBoPKZke+KXmDqd9BpLQl
 XMStkwyivCMjcy3pK/vkYK2VO1aJw86Z1sBfh3drz6VpHuYp59pBvDDJ/3BTqyjdIA9Fbjxlt
 dDVSG8mHpY1lJWGP2dJZcmYiqb2DZNDGbX9hmbZapcJiHC1FwAikf92FMFBTSbnvTqpQUGUcX
 DciNlhDXVwfmUD3fk0HA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function has been made static, which now causes
a compile-time warning:

WARNING: "fuse_put_request" [vmlinux] is a static EXPORT_SYMBOL_GPL

Remove the unneeded export.

Fixes: 66abc3599c3c ("fuse: unexport request ops")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/fuse/dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 46d68d439c41..e367c639bb2b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -175,7 +175,6 @@ static void fuse_put_request(struct fuse_conn *fc, struct fuse_req *req)
 		fuse_request_free(req);
 	}
 }
-EXPORT_SYMBOL_GPL(fuse_put_request);
 
 unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args)
 {
-- 
2.20.0


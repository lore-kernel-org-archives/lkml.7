Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EBCC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D04320663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbfDPUVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:21:02 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:56043 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbfDPUVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:21:02 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mth79-1gzvE91hD5-00vAld; Tue, 16 Apr 2019 22:20:54 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Guillaume Nault <g.nault@alphalink.fr>,
        Michal Ostrowski <mostrows@earthlink.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH v3 01/26] compat_ioctl: pppoe: fix PPPOEIOCSFWD handling
Date:   Tue, 16 Apr 2019 22:19:39 +0200
Message-Id: <20190416202013.4034148-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190416202013.4034148-1-arnd@arndb.de>
References: <20190416202013.4034148-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UuSKur4F/zpzv8/eUkggQkLgvKUCGCMbUy0fxaAopYsiULgmb0c
 qlnZoZgjR/ezQ7Spy4ZN8C/7bmXf60fsXDeVZXie5xCW8GkPOWC/swEQrEZhQ2BrZID3LFg
 YAF/jJFfN2ZZ1wopD1LVQM/5A1sh3o/vpRajLiVX/PDCoPQrSoWG9IATr48/4XihimF5Evw
 TyxDLdga7kpS0I99zc5mQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z9NglIFDkPA=:C3G4KtI7zzz1v9AiqvsBsd
 rBE7SmHIb/6xeCTExVcPaMzzciCrpm1AI36SmWGqbC8Gh+w/nKAutdEiO/E91OKGOwxUMDegT
 wkm+G4Wc01TaCtLl30UL7kVeKRyU8ysqCJT5bgU23IbvPhb1SogpS6cbHYR8qavgy04u7xNW5
 RsexMsxEnlpAmtmgLAF90x1rGFG5Vgl0r6sKv8YxatBfc9gdHsLsQVhUqkQOiToi8qKYyhEKQ
 9PvjE70D0P7jinET35uWvXRFf2IsVC/w49QDmWTzTc7FtkfRESOkZwmhrFKzzijFRiEh7grmo
 PYY26WUIJY2jtUtatjxS0biEVoNkK7iNtC/pzV3xzkqdslFGY52aie1+S3Y2nIPZeCTVKNP7a
 vgIet4flLDINyW2zmi2SCC4YE/bAhMpqhjzk/WMG1UoPY9S84ghupHhFnQZWcB66xw/LiWurA
 AkBFFOZwxXIUG9LJadtBJJeT2pE3hBu3WNMtj9bzLDmGgjp6QIYqwKOFFJaze383zD3o31Iqx
 G1gBbCXTUZBojIQGw0NnzYe39vkipQazZGN2nV25M5w90Ln5LzX8nYhYIgkzyGBmlHytX9cjg
 4l7ENTgcxR6WCX+8zbs02SEwq1fc4zaAVPowCi8aEp2qKLTvJK6F+WAvmbbOFBSdLUNPXYJAT
 JZIqZV9MbxahUpMwwAToGJsfV3rxS1ccw4wb6VA0PYUwz9YXP5H/v7JWD7O8Hbqk0rwu0vsvZ
 wOzHEpbMzF0ZUYEiKptTk3cUA9AK8x1sg27xMg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for handling the PPPOEIOCSFWD ioctl in compat mode was added in
linux-2.5.69 along with hundreds of other commands, but was always broken
sincen only the structure is compatible, but the command number is not,
due to the size being sizeof(size_t), or at first sizeof(sizeof((struct
sockaddr_pppox)), which is different on 64-bit architectures.

Guillaume Nault adds:

  And the implementation was broken until 2016 (see 29e73269aa4d ("pppoe:
  fix reference counting in PPPoE proxy")), and nobody ever noticed. I
  should probably have removed this ioctl entirely instead of fixing it.
  Clearly, it has never been used.

Fix it by defining a separate command code that matches the 32-bit
version, and marking that one as compatible. As long as we keep the
native ioctl, it seems best to also have the compat version working.

This should apply to all stable kernels.

Acked-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ppp/pppoe.c  | 4 ++++
 fs/compat_ioctl.c        | 2 +-
 include/linux/if_pppox.h | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index f22639f0116a..c5e7435db86c 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -57,6 +57,7 @@
  *
  */
 
+#include <linux/compat.h>
 #include <linux/string.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -784,6 +785,9 @@ static int pppoe_ioctl(struct socket *sock, unsigned int cmd,
 		err = 0;
 		break;
 
+#ifdef CONFIG_COMPAT
+	case PPPOEIOCSFWD32:
+#endif
 	case PPPOEIOCSFWD:
 	{
 		struct pppox_sock *relay_po;
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 6e30949d9f77..f1065d116b55 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -639,7 +639,7 @@ COMPATIBLE_IOCTL(PPPIOCATTCHAN)
 COMPATIBLE_IOCTL(PPPIOCGCHAN)
 COMPATIBLE_IOCTL(PPPIOCGL2TPSTATS)
 /* PPPOX */
-COMPATIBLE_IOCTL(PPPOEIOCSFWD)
+COMPATIBLE_IOCTL(PPPOEIOCSFWD32)
 COMPATIBLE_IOCTL(PPPOEIOCDFWD)
 /* Big A */
 /* sparc only */
diff --git a/include/linux/if_pppox.h b/include/linux/if_pppox.h
index ba7a9b0c7c57..d221f1465f41 100644
--- a/include/linux/if_pppox.h
+++ b/include/linux/if_pppox.h
@@ -85,6 +85,8 @@ extern void unregister_pppox_proto(int proto_num);
 extern void pppox_unbind_sock(struct sock *sk);/* delete ppp-channel binding */
 extern int pppox_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
 
+#define PPPOEIOCSFWD32    _IOW(0xB1 ,0, compat_size_t)
+
 /* PPPoX socket states */
 enum {
     PPPOX_NONE		= 0,  /* initial state */
-- 
2.20.0


Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FA1C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBB720663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbfDPU3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:29:01 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:41833 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730866AbfDPU26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:28:58 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N9MYu-1gkkwe3aUu-015EvX; Tue, 16 Apr 2019 22:28:56 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 26/26] compat_ioctl: remove last RAID handling code
Date:   Tue, 16 Apr 2019 22:28:11 +0200
Message-Id: <20190416202839.248216-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190416202839.248216-1-arnd@arndb.de>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202839.248216-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kr37GgGf+FAvlT+Ih2yyYppWJzyd/T1IQq+sLtn8CWkKCuJB+ij
 t97YwUJguLn7fO+Zf/mVSeKYHREnqFvby2c7c6IXVZKxbaS8DDfMooioaV+RL6PmOTQVCHq
 tacD6C/ufvXWISqaCW1G7KJd5YRWhQN6QbHYvoRL3jyRJv6PlFkAOxHQill0qp/PkF+Bksa
 OgEQSEGZKEJhaQRrMYxSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Xx3458CozM=:XO71Q29thOiOAQO99iAITx
 l2IGPASdz//mh80V+XhBLN621DKXjYp+XM3OZsFtQb6ZZIH6eJOGOqbkRLqzZfwE4bQONDqRl
 QCiuyirtlX79abZ/cipVNyKhKOuYXK9w1No19Bu41FAzEiPd2uMpCk1xn4YHno4Wrp2t24PRq
 VYqOkIcj2wdCroQrCaG+nrtaXc/SRYJaCphRUoC6KS6q40RKNJwhMoOFHFaPEKlErKxBLHuej
 sOYRewgvOu/OKW5XconPDWRZSkKGyQDEK4In9x1WQB1sz/HJZpKQPAqXtmbRjoC1ilLzx8ASn
 ZnCj3tl+DK4ve8vLuGd7QHn3SI8a/jyDJqmubRmzNdYjGnLQl5QoZ5LSUHFLXYHCzf8Yba4Nk
 ePCNE0rPiI1Mwf0KD8X856s41h1fh4GRoQXVRfhGWCW7xsLrZLrq6NtlB17T7KOibwr8khooK
 kHi9vlmS31z8PiUaVDdZt0uRV163VxXPsWpsrI/vDKI+QhjYOqwmZ1lwv6ORgUUHKuktN1nS2
 A3Oq6k0nfil5cLpGlZxGW2lpWjpLG1te2mhW/Hp0LE31nmhgln2MuUV3d9LR+G7yhMkq4iJSM
 0moPEoSgI+6Pg2cgU5Y28qdQEEs/WnvkOsNTqgyHpAKd2QmkzxFgAEbgkMMGBRtgCzZml6JsG
 t9mtSIzfuktyYOPTdgICO758slYUXYA2boXcDp++xCkpD7zOx8IvfU6LvGBlF+FyNlz4GsSCd
 6uSKeMooEH516yYNrdU2kimgp95z1VnfEG4XlA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit aa98aa31987a ("md: move compat_ioctl handling into md.c")
already removed the COMPATIBLE_IOCTL() table entries and added
a complete implementation, but a few lines got left behind and
should also be removed here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 63de00cc85df..09f42e0585b7 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -394,19 +394,6 @@ static long do_ioctl_trans(unsigned int cmd,
 #endif
 	}
 
-	/*
-	 * These take an integer instead of a pointer as 'arg',
-	 * so we must not do a compat_ptr() translation.
-	 */
-	switch (cmd) {
-	/* RAID */
-	case HOT_REMOVE_DISK:
-	case HOT_ADD_DISK:
-	case SET_DISK_FAULTY:
-	case SET_BITMAP_FILE:
-		return vfs_ioctl(file, cmd, arg);
-	}
-
 	return -ENOIOCTLCMD;
 }
 
-- 
2.20.0


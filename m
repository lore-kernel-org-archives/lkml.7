Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE23C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 18:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E52B24673
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 18:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfLGS7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 13:59:06 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:35795 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfLGS7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 13:59:06 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MhUDj-1i7t2W2CQd-00ecPC; Sat, 07 Dec 2019 19:58:59 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Theodore Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     youling 257 <youling257@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] char: random: fix urandom ioctl support
Date:   Sat,  7 Dec 2019 19:58:20 +0100
Message-Id: <20191207185837.4030699-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8CwiCrTP/p6MJDsdA8rUtahJe11dgA3jWUvuqhYyaGBhbsLMeuX
 9/TAY4wNzh4ZcUBMkSFOmzhMfFI+STet46uHpit1NvYfcnOcX0UdFzAI6UEutAfP7rxr6Ev
 AyZnKJZ0UF4hsyuu6ops+X9g429XbJhaeAb4yd7U2oo/YF+dWneW6uufkJwAO8llX/1Puzj
 ishS4bsB/1nhipk8z+YyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WTPxP5nxjXw=:d1Q8mps8ui51i/dZdzQb8X
 GAHoroG9bmhNGAh6kXsavuNzLmwP65PkDY500dDOAmhu8+k6WdFoc2qDAUReeeBqy/BHKKOba
 DUuAXBoAglJbxMx+TYEs1TIIGZkhxomPc0/TkyOznPrIBXp2G+qGG/1iuWVno0+Uppkekb90S
 fOGAz4/jhIsYma0m/Shv6zwobgMwUrYYKy2JJI2JKPHkiNEwEn6QLa4wgNp+Dl2GeKMXUKaXR
 QSrJc5F+l++tEh+U8bzpereo4l1nVpu8ph5yoJL3mDpLK8FaJub44+KMM40SuL4tDn2A3d4Lf
 YYCxflL5OZSmgGa+DdapDmBgMip4i9XDBqOtlGyKxJfH4TpKGwk9XOHGDt/Mct0+28UCHu8yI
 U7K+fhIqpHg/qcL7npEDDtxFzIiAP9kAskgVeafiZDLW+w/OyUXrqGn0WkDfbr4x6HMXahfiZ
 SwghYuviSF5Q7c80F99+7JJkuy83oNs5tcXYVB5bFlVk5GClEo4Qz1yG9FVauk2KmAu9rkf2s
 TPZ+Ke3mvsWEpWmpqYv7O2UkZO9oI8WRhPVL8FAMKMEdWYqWTae33XAX3b347QVgBlU9vaQ60
 KeA/SBo9wMT1+lzma1OfnUFo+HalwjJFk+sK9Q2+xbgLW7dKDZ/GdQWpFXZJ4HQ+3zGkQHhjZ
 3T81NyYt1qn9vBLuHUNGL1fVKbflgN8OZbJFa5WtaOcnp3CJitmPjXZDZwp9O8U8l//tDPjgl
 QbiamouWT8/1duQRPdPJgQi1uWRcGkzG3+z5WHM34+KRXAIn7ybax2DEnF/8sLI0NeUTeFZZO
 JzJ5DWhIvuHcol460ChVSfxBGd73XOlDC0ZcIzjEEwV6WKC0DdaDI3GesHwtzyz9ouv0AdgmT
 CFtA6Ra/z3w3LDkeX/Tg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My patch to move the /dev/random compat handling from
fs/compat_ioctl.c int drivers missed the corresponding
/dev/urandom support.

Use the same compat_ptr_ioctl() in both devices.

Fixes: 507e4e2b430b ("compat_ioctl: remove /dev/random commands")
Reported-by: youling 257 <youling257@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/random.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 46afd14facb7..9280ca4d85c0 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2176,6 +2176,7 @@ const struct file_operations urandom_fops = {
 	.read  = urandom_read,
 	.write = random_write,
 	.unlocked_ioctl = random_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
 };
-- 
2.20.0


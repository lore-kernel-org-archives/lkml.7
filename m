Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CDEC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13222217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfIZKNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 06:13:18 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:50882 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfIZKNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 06:13:17 -0400
Received: from ramsan ([84.194.98.4])
        by albert.telenet-ops.be with bizsmtp
        id 6ADF2100505gfCL06ADF4l; Thu, 26 Sep 2019 12:13:15 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iDQlu-0001q2-Ar; Thu, 26 Sep 2019 12:13:14 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iDQlu-0008ON-8M; Thu, 26 Sep 2019 12:13:14 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH -next] fbdev: c2p: Fix link failure on non-inlining
Date:   Thu, 26 Sep 2019 12:13:12 +0200
Message-Id: <20190926101312.32218-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the compiler decides not to inline the Chunky-to-Planar core
functions, the build fails with:

    c2p_planar.c:(.text+0xd6): undefined reference to `c2p_unsupported'
    c2p_planar.c:(.text+0x1dc): undefined reference to `c2p_unsupported'
    c2p_iplan2.c:(.text+0xc4): undefined reference to `c2p_unsupported'
    c2p_iplan2.c:(.text+0x150): undefined reference to `c2p_unsupported'

Fix this by marking the functions __always_inline.

Reported-by: noreply@ellerman.id.au
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Fixes: 025f072e5823947c ("compiler: enable CONFIG_OPTIMIZE_INLINING forcibly")

As this is a patch in akpm's tree, the commit ID in the Fixes tag is not
stable.
---
 drivers/video/fbdev/c2p_core.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/c2p_core.h b/drivers/video/fbdev/c2p_core.h
index e1035a865fb945f0..45a6d895a7d7208e 100644
--- a/drivers/video/fbdev/c2p_core.h
+++ b/drivers/video/fbdev/c2p_core.h
@@ -29,7 +29,7 @@ static inline void _transp(u32 d[], unsigned int i1, unsigned int i2,
 
 extern void c2p_unsupported(void);
 
-static inline u32 get_mask(unsigned int n)
+static __always_inline u32 get_mask(unsigned int n)
 {
 	switch (n) {
 	case 1:
@@ -57,7 +57,7 @@ static inline u32 get_mask(unsigned int n)
      *  Transpose operations on 8 32-bit words
      */
 
-static inline void transp8(u32 d[], unsigned int n, unsigned int m)
+static __always_inline void transp8(u32 d[], unsigned int n, unsigned int m)
 {
 	u32 mask = get_mask(n);
 
@@ -99,7 +99,7 @@ static inline void transp8(u32 d[], unsigned int n, unsigned int m)
      *  Transpose operations on 4 32-bit words
      */
 
-static inline void transp4(u32 d[], unsigned int n, unsigned int m)
+static __always_inline void transp4(u32 d[], unsigned int n, unsigned int m)
 {
 	u32 mask = get_mask(n);
 
@@ -126,7 +126,7 @@ static inline void transp4(u32 d[], unsigned int n, unsigned int m)
      *  Transpose operations on 4 32-bit words (reverse order)
      */
 
-static inline void transp4x(u32 d[], unsigned int n, unsigned int m)
+static __always_inline void transp4x(u32 d[], unsigned int n, unsigned int m)
 {
 	u32 mask = get_mask(n);
 
-- 
2.17.1


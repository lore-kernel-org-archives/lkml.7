Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C47C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 01:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0080216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 01:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="woXdxnVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbfG3Bt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 21:49:57 -0400
Received: from gateway30.websitewelcome.com ([192.185.148.2]:31268 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730736AbfG3Btr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:49:47 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 135482EA4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 20:49:46 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id sHGshkSpX4FKpsHGshuErR; Mon, 29 Jul 2019 20:49:46 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=THMhZ3Z9UJJLl14GwuPwJ19Y8ZFPT6dx5E0Ehq+rKsk=; b=woXdxnVNQCm+KQCOv+3gvr4h7D
        6d4HVNgIHdRa43w/l7B3jIgUjpKSz6SBRm15c29pVGlCR6fwZ41WLTXkfEZOObhXKE7O79DiPFJ49
        3cYYXGFmc/r3Agl6S48wB7SbjFfIwjCYLJXgSjKpNbidaA1CDcaWyKSjykwwneaOgW3P2F+LPoZGk
        paap30gIBvJ9EbKG2siWyQC2ctXSFKq9IkY1acbAbFT1XChWs4n0K89seG+8sxEzOTvAJEzFgquHw
        GCWB/4FTHLImorxUQ1mHMU8wpauRWabn/BWFPKE43IupzPv85nGioNW11g7BqJ2fyQrc/iB/DbKxp
        UL/H3d/Q==;
Received: from [187.192.11.120] (port=37264 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hsHGq-003dAx-V6; Mon, 29 Jul 2019 20:49:45 -0500
Date:   Mon, 29 Jul 2019 20:49:44 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] ALSA: sparc: Mark expected switch fall-throughs
Message-ID: <20190730014944.GA31900@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hsHGq-003dAx-V6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:37264
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warnings (Building: sparc64):

sound/sparc/dbri.c: In function ‘reverse_bytes’:
sound/sparc/dbri.c:582:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
   b = ((b & 0xffff0000) >> 16) | ((b & 0x0000ffff) << 16);
   ~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/sparc/dbri.c:583:2: note: here
  case 16:
  ^~~~
sound/sparc/dbri.c:584:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
   b = ((b & 0xff00ff00) >> 8) | ((b & 0x00ff00ff) << 8);
   ~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/sparc/dbri.c:585:2: note: here
  case 8:
  ^~~~
sound/sparc/dbri.c:586:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
   b = ((b & 0xf0f0f0f0) >> 4) | ((b & 0x0f0f0f0f) << 4);
   ~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/sparc/dbri.c:587:2: note: here
  case 4:
  ^~~~
sound/sparc/dbri.c:588:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
   b = ((b & 0xcccccccc) >> 2) | ((b & 0x33333333) << 2);
   ~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/sparc/dbri.c:589:2: note: here
  case 2:
  ^~~~

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/sparc/dbri.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index 010113156239..6e065d44060e 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -580,12 +580,16 @@ static __u32 reverse_bytes(__u32 b, int len)
 	switch (len) {
 	case 32:
 		b = ((b & 0xffff0000) >> 16) | ((b & 0x0000ffff) << 16);
+		/* fall through */
 	case 16:
 		b = ((b & 0xff00ff00) >> 8) | ((b & 0x00ff00ff) << 8);
+		/* fall through */
 	case 8:
 		b = ((b & 0xf0f0f0f0) >> 4) | ((b & 0x0f0f0f0f) << 4);
+		/* fall through */
 	case 4:
 		b = ((b & 0xcccccccc) >> 2) | ((b & 0x33333333) << 2);
+		/* fall through */
 	case 2:
 		b = ((b & 0xaaaaaaaa) >> 1) | ((b & 0x55555555) << 1);
 	case 1:
-- 
2.22.0


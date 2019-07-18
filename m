Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8742EC76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C0620818
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419505;
	bh=/Mz1oNXA8X6erDLO019vWFgA0YET6BevJNaheOkykF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NtAIEWsrYao1+efW9WjHjLRLlOAKZMoGDdP7hOmA6Im9YTNvCzzozsi+8h2+vHg7k
	 csRgCpu85KEPiZXk705eZWwlfM2BCfVq5bsZHl9d05azLIEJskG4CMNEurRQXY0LWN
	 yWCwtymEFGSos0mgERYs2m0pyDdxa9a3AvBsRqlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391474AbfGRDLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:11:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391344AbfGRDLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:11:23 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1535B205F4;
        Thu, 18 Jul 2019 03:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419482;
        bh=/Mz1oNXA8X6erDLO019vWFgA0YET6BevJNaheOkykF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lebyn2sBG4NircCul110Ng6BzzvdbtTLxEFYXehf83nlEncOVKx/wZSpPDwXLBhUx
         0VI8OfJ1FWtPZpa29yQbRH27DGGRulRYmYy3Elg4WbDi4beDyZKwKyfFh9r2uKTxk0
         v2JKKUrOuFE01WOV9+A+ZAoKFddoXsf0ZDyPe6z0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Young <sean@mess.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4.14 61/80] MIPS: Remove superfluous check for __linux__
Date:   Thu, 18 Jul 2019 12:01:52 +0900
Message-Id: <20190718030103.224775635@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030058.615992480@linuxfoundation.org>
References: <20190718030058.615992480@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Young <sean@mess.org>

commit 1287533d3d95d5ad8b02773733044500b1be06bc upstream.

When building BPF code using "clang -target bpf -c", clang does not
define __linux__.

To build BPF IR decoders the include linux/lirc.h is needed which
includes linux/types.h. Currently this workaround is needed:

https://git.linuxtv.org/v4l-utils.git/commit/?id=dd3ff81f58c4e1e6f33765dc61ad33c48ae6bb07

This check might otherwise be useful to stop users from using a non-linux
compiler, but if you're doing that you are going to have a lot more
trouble anyway.

Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/21149/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/uapi/asm/sgidefs.h |    8 --------
 1 file changed, 8 deletions(-)

--- a/arch/mips/include/uapi/asm/sgidefs.h
+++ b/arch/mips/include/uapi/asm/sgidefs.h
@@ -12,14 +12,6 @@
 #define __ASM_SGIDEFS_H
 
 /*
- * Using a Linux compiler for building Linux seems logic but not to
- * everybody.
- */
-#ifndef __linux__
-#error Use a Linux compiler or give up.
-#endif
-
-/*
  * Definitions for the ISA levels
  *
  * With the introduction of MIPS32 / MIPS64 instruction sets definitions



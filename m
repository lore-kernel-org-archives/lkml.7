Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9771C04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 04:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAAB52084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 04:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="R0deHWNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfEOEjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 00:39:46 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:24238 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfEOEjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 00:39:46 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x4F4c7cJ027504;
        Wed, 15 May 2019 13:38:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x4F4c7cJ027504
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557895089;
        bh=iE+vnhBUmohMYwyQNvfDgRKTtO/iv446MrZ818sQrfg=;
        h=From:To:Cc:Subject:Date:From;
        b=R0deHWNCr8I/DXB/MhqjIvColCojk6Y7goEygOJC5ejAgxWyLBiiPJOm//+HtBCl1
         TjVp4QFaqbx0jr0j8pdIpfN10N1/XiIo4+rQOcgPEZlhuB6ScN0FWtKWmCGfODSMoB
         gZUg7rz2k0/wDpxuUF9Ucwj0+uo1jc7NunXGXLr55iAaYqVIbnbLbG8wuGXq2pEIe8
         6Bn1EJIrazZmarw8BcPdSQhJD0EYinFIQZ1S8rH+g3nSImYLnspcC7I+8HlvDXsQHW
         oLolUTueapGrO3nEa+E/Ha1/M4EjRrGgDSeN4u8Yxpmec/vqseQ60PMsbvukstYryd
         Y8m+89dOpKZUg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Cc:     Dave Airlie <airlied@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/i915: drop unneeded -Wall addition
Date:   Wed, 15 May 2019 13:37:53 +0900
Message-Id: <20190515043753.9853-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The top level Makefile adds -Wall globally:

  KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \

I see two "-Wall" added for compiling under drivers/gpu/drm/i915/.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

BTW, I have a question in the comment:

 "Note the danger in using -Wall -Wextra is that when CI updates gcc we
  will most likely get a sudden build breakage... Hopefully we will fix
  new warnings before CI updates!"

Enabling whatever warning options does not cause build breakage.
-Werror does.

So, I think the correct statement is:

 "Note the danger in using -Werror is that when CI updates gcc we ...
                           ^^^^^^^


 drivers/gpu/drm/i915/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index fbcb0904f4a8..4a4f60c7edfc 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -12,7 +12,7 @@
 # Note the danger in using -Wall -Wextra is that when CI updates gcc we
 # will most likely get a sudden build breakage... Hopefully we will fix
 # new warnings before CI updates!
-subdir-ccflags-y := -Wall -Wextra
+subdir-ccflags-y := -Wextra
 subdir-ccflags-y += $(call cc-disable-warning, unused-parameter)
 subdir-ccflags-y += $(call cc-disable-warning, type-limits)
 subdir-ccflags-y += $(call cc-disable-warning, missing-field-initializers)
-- 
2.17.1


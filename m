Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2BAC32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7B520848
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578298478;
	bh=yXPZEzyEe2lxjvA9yBEPFaWlEE97rNZigqPuHXUfQhI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FHjfxapQG0nQDeSjHXDoL7AdzfYFE/f5vJsx6+N2ojXVzmyMtuhBRe9Zco/JBPJ9r
	 JhyrWJ1NS2/hTLq86s1E3NOUopRHg8XBrO09WOm1SoT1OBFZARU4flRrj6BAWYfoqY
	 gZ9xF43S0j0WycdLgWMGLXlUm6LnhLKC8OJ2Dzq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgAFIOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:14:37 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:65323 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgAFIOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:14:37 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 0068E04v010428;
        Mon, 6 Jan 2020 17:14:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 0068E04v010428
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578298441;
        bh=LH1doj3R4Ug6XaJ/DgmUbm4M2ESZKsoWMh5zD0tz1YE=;
        h=From:To:Cc:Subject:Date:From;
        b=m26R16tOyel28hSLnHaltw9doTTzbohPc9gFdR4ojFcp63lK7CBwrnXxTICgQ6cCY
         qdyG/vNNUeJu1cOmuzWAAhHw3+HbAlKACSx3BKSxH4sQ+Uim46VfYmy1jxXIKKXLWr
         +P/DIgceu3vdICR1pJ0Md3xpbMnCNk0i/m3NfPumPn+3cOM29/tNVyrAR4nwp8gnYV
         yHJKIzTG7T8mnusCZMX9IWxfwENUszPu2C/5gWSjeTVm1H3X2CTfJUyZaEXWj/tZ+o
         4f55/w1tWDd/PCFwSdReMbwOzNvE6frXOM7fwduZPUiNyWl5cZWhU7xCrvoZ2VCXxc
         stNI/eUNF7fYw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: remove object duplication in Makefile
Date:   Mon,  6 Jan 2020 17:13:52 +0900
Message-Id: <20200106081352.27730-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The objects in $(fb-objs) $(fb-y) $(fb-m) are linked to fb.ko .

This line adds $(fb-y) to fb-objs, so the objects from $(fb-y) are
listed twice as the dependency of the module.

It works because Kbuild trims the duplicated objects from linking,
but there is no good reason to have this line.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/video/fbdev/core/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/core/Makefile b/drivers/video/fbdev/core/Makefile
index 37710316a680..26cbc965497c 100644
--- a/drivers/video/fbdev/core/Makefile
+++ b/drivers/video/fbdev/core/Makefile
@@ -16,7 +16,6 @@ fb-y				  += fbcon_rotate.o fbcon_cw.o fbcon_ud.o \
 				     fbcon_ccw.o
 endif
 endif
-fb-objs                           := $(fb-y)
 
 obj-$(CONFIG_FB_CFB_FILLRECT)  += cfbfillrect.o
 obj-$(CONFIG_FB_CFB_COPYAREA)  += cfbcopyarea.o
-- 
2.17.1


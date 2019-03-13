Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D663FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A021121019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505609;
	bh=FAh9FTW39BvyGUxUJ2rnEWSoxjdHdfKlx6XFqU0GV3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PolYrPAwqjq1T1R4LnDaWdp7tA9eWI70GP8GdPfX3EriioJsmBMFRXtYV8G+S2AFo
	 742dZ0orW9m98p4T9NWFnHKPfz4joJNm9Ks7iBPYX3/TEJz1Syl++A45mwcC181tt7
	 vIbbFXfcUd1alzVZ4rosqYK9omfDeE73DjSdf2dM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfCMTKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:10:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbfCMTKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:10:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2107C2173C;
        Wed, 13 Mar 2019 19:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504243;
        bh=FAh9FTW39BvyGUxUJ2rnEWSoxjdHdfKlx6XFqU0GV3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QJEbKmRsP8qXg3pHoQxAY0b7lB2KiYEzNVgD7nyUd2yqZemNbn0FWrGQu2QpNZNrB
         m3ut4Yg97A52+acGnjVKvMiqYpoXzZotHp+4v0roT67NlVJKVnnwdychBZsQ1eD1fU
         HR8nMv65f9jACiPS8PK22N5653oHjku6gjAiopZA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 11/60] sh: fix build error for invisible CONFIG_BUILTIN_DTB_SOURCE
Date:   Wed, 13 Mar 2019 15:09:32 -0400
Message-Id: <20190313191021.158171-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 207a369e3c085799e7836221f64e7a7329985fb6 ]

I fixed a similar build error in commit 1b1e4ee86e00 ("sh: fix build
error for empty CONFIG_BUILTIN_DTB_SOURCE"), but it came back again.

Since commit 37c8a5fafa3b ("kbuild: consolidate Devicetree dtb
build rules"), the combination of CONFIG_OF_EARLY_FLATTREE=y and
CONFIG_USE_BUILTIN_DTB=n results in the following build error:

  make[1]: *** No rule to make target 'arch/sh/boot/dts/.dtb.o',
  needed by 'arch/sh/boot/dts/built-in.a'.  Stop.

Prior to that commit, there was only one path to descend into
arch/sh/boot/dts/, and arch/sh/Makefile correctly guards it with
CONFIG_USE_BUILTIN_DTB:

  core-$(CONFIG_USE_BUILTIN_DTB)  += arch/sh/boot/dts/

Now, there is another path to descend there from the top Makefile
when CONFIG_OF_EARLY_FLATTREE=y. If CONFIG_USE_BUILTIN_DTB is disabled,
CONFIG_BUILTIN_DTB_SOURCE is invisible instead of defined as "".

Add obj-$(CONFIG_USE_BUILTIN_DTB) guard to avoid the attempt to build
the non-existing file.

Fixes: 37c8a5fafa3b ("kbuild: consolidate Devicetree dtb build rules")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sh/boot/dts/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boot/dts/Makefile b/arch/sh/boot/dts/Makefile
index 01d0f7fb14cc..2563d1e532e2 100644
--- a/arch/sh/boot/dts/Makefile
+++ b/arch/sh/boot/dts/Makefile
@@ -1,3 +1,3 @@
 ifneq ($(CONFIG_BUILTIN_DTB_SOURCE),"")
-obj-y += $(patsubst "%",%,$(CONFIG_BUILTIN_DTB_SOURCE)).dtb.o
+obj-$(CONFIG_USE_BUILTIN_DTB) += $(patsubst "%",%,$(CONFIG_BUILTIN_DTB_SOURCE)).dtb.o
 endif
-- 
2.19.1


Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43C5C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C752084D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZX6h/m/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfFMRBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:01:54 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:37525 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729555AbfFLXZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 19:25:43 -0400
Received: by mail-yw1-f74.google.com with SMTP id j68so19167108ywj.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 16:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=c4y2pZiaN2WhmN/OxTBjUr2bY3qKhiFt2vrnSnjnBeU=;
        b=ZX6h/m/Ccz3D08OR8zobi4ldZ1jS6PwWzVR/t+WFD6v0/Fss+beVWhFf3zeZ82ESbD
         JnDV0SUioVotRseLuOCQjBJLHc6Uk0pBrTXhoZGSLVaiSZdExpDDf2i2/rIyMYZlsF70
         qFSP5TrwsByiyXtw3w02BWlG1wBzSWk/vy0A0IrFOW0FYgFOCrryf7dyHBTlBJtuaKKG
         ERMoWPBQK1FwgW7tltk/GtzR+Be390NfVB6tt1uV6i3acZq1aasmD19TVthHF8qX8Rml
         6a5JDLxHclFpku0vjZ4XD/CW1AMslRend4jJ1Ln+Ot1bhEXU2bNv+/yI4qPlSB866sPf
         QLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=c4y2pZiaN2WhmN/OxTBjUr2bY3qKhiFt2vrnSnjnBeU=;
        b=Rm/xTZcgR8tiK8Mx4+0zBqnRsDzz/OIhQPa+BTtO2PlJhjR0a/ec6GvV3zwOfrRlS4
         IaRPbF/FNwyXEAtmDKhneqdbz1GrRi5B/nM4Ih9aril/ShRHAUUyMi7Idr7uoW5+mLSK
         LmHl2uA9qQv1oJwsamq/FJKxCXx2wxMFKIcK89tqHIw01ysOMUyPju7HpdNV359IKbuS
         MGE9g06bmy2Dx6ZQYyNp9E1zE8/8wxYOqEfySl5sTOV5/hn8FFJqY3IifR3tejj71mhc
         5MAmL5c8wQnrlUQqlzk1dXWr990XHYAxxVhrMn7g93wZJpT4ifnBym/c8qQ7locy68T8
         QIww==
X-Gm-Message-State: APjAAAXzPVc5OLk9MGj9FD6nL/CksypizC/HiMZxN+5+JUY7HCRHNwQd
        40t2qjR6vFcug/QGwppjHybAT8OPzw==
X-Google-Smtp-Source: APXvYqzXnzX8wpDiqygjRAk3N1+TcIw2/ksV0H9K5MlzkDv4+dJxv87avsDznM1QwBlHmYu3EINw3LGE/A==
X-Received: by 2002:a25:ef10:: with SMTP id g16mr40616532ybd.510.1560381942993;
 Wed, 12 Jun 2019 16:25:42 -0700 (PDT)
Date:   Wed, 12 Jun 2019 16:25:02 -0700
Message-Id: <20190612232502.256846-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH] ASoC: tas571x: Fix -Wunused-const-variable
From:   Nathan Huckleberry <nhuck@google.com>
To:     cernekee@chromium.org, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang produces the following warning

sound/soc/codecs/tas571x.c:666:38: warning: unused variable
'tas5721_controls' [-Wunused-const-variable]

In the chip struct definition tas5711_controls is used rather than
tac5712_controls. Looks like a typo was made in the original commit.

Since tac5711_controls is identical to tas5721_controls we can just swap
them

Cc: clang-built-linux@googlegroups.com
Link: https://github.com/ClangBuiltLinux/linux/issues/522
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 sound/soc/codecs/tas571x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index 20798fa2988a..1554631cb397 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -721,8 +721,8 @@ static const struct regmap_config tas5721_regmap_config = {
 static const struct tas571x_chip tas5721_chip = {
 	.supply_names			= tas5721_supply_names,
 	.num_supply_names		= ARRAY_SIZE(tas5721_supply_names),
-	.controls			= tas5711_controls,
-	.num_controls			= ARRAY_SIZE(tas5711_controls),
+	.controls			= tas5721_controls,
+	.num_controls			= ARRAY_SIZE(tas5721_controls),
 	.regmap_config			= &tas5721_regmap_config,
 	.vol_reg_size			= 1,
 };
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog


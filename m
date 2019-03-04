Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555A0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8E820661
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3WX7l5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfCDMzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:55:36 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37615 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfCDMzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:55:36 -0500
Received: by mail-ed1-f66.google.com with SMTP id m12so4156103edv.4;
        Mon, 04 Mar 2019 04:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rOYlsNG4ezPhps2OtjBdzW9V5jmolZL70hiEnVXMExE=;
        b=V3WX7l5Cwym8530VLg4A7HgIrN/XCfyV+ye01yk0NbLjFYjW0lp1DsxdaINhfgyU7W
         fdp7ZUt/Xvaq4i2r+sZGN2UY/whG27T/MuVWvo49epoN7Mava6oenbyx7PdTO8Mr0snU
         TNwSbO2xkpkw53bpQDFJNbQOpiZdhiNcDFFqhnSer8LIcxS5vxAP9Q0otQ2GMXMVBhPL
         gh9h/QM7odIw6nuAuZRQRjxU98NABX/jOJYpZR9xwnAoB8Zr7wv5qb3PE5YHmm7/T7FI
         iAPg22jf5FmPPHYhdM2AANDBZtPsEoD0b2P50/pP+F/ZS9+BydC1FZIH+N2k4pX6qG+W
         DHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rOYlsNG4ezPhps2OtjBdzW9V5jmolZL70hiEnVXMExE=;
        b=L+Xj1stfuSHnn1prIbt/4zUWLUW5HccnyfQg69lJui2+Wm7w1N2kMeAXrWS787tW1x
         bmqPdXp84F57boUzqRH9onuJwSmWJDb73mBwXWmwNPmfz6FfoRBxhZ34oPLswYjYubwZ
         BJ3vblmm3v5oUjJ3mg9MAwP/s+WrA0nOqYd/4MbIydwIngWJy2ZmeTfCcV/HCkgbb2S2
         8Xrx+LZvkPF//DAoKDy0RhoOi/7VqvBEfFbpVeqvFWvvBhaBTcrNL/zIko8mIfbEVWLR
         gZ34QeATLG+PjfhxTLt7DNufo0VHu6CqzbFG2oqO7OHY8VzM3dnBn/RVSaHe6CWN2Cp0
         W+hw==
X-Gm-Message-State: APjAAAWefF2KciemB9ar4teYOWMj+TA+XP9J7/cSlPdgiEfh99pPGJ+5
        XZGP82F+ppWjxCD+/wOuDudrk2Jv
X-Google-Smtp-Source: APXvYqzkEehZst+pC+18/zqEEXz3MU3fsi3sCR1gyzBaqRLLfFeSmAnPKUzoSRXfGtR4q4j8tWau0w==
X-Received: by 2002:a50:9235:: with SMTP id i50mr15113839eda.20.1551704134198;
        Mon, 04 Mar 2019 04:55:34 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:4034:3c00:d125:9f50:8119:d83e])
        by smtp.gmail.com with ESMTPSA id f5sm1166550ejf.25.2019.03.04.04.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 04:55:33 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] kbuild: use -Werror=implicit-... instead of -Werror-implicit-...
Date:   Mon,  4 Mar 2019 13:55:20 +0100
Message-Id: <20190304125520.17794-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flag '-Werror-implicit-function-declaration', present in GCC 2.95,
stopped to be documented in GCC 4.3, replaced by the more generic
'-Werror=...' form.

So, use the equivalent '-Werror=implicit-function-declaration' instead.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d5713e7b1e50..253e5ede92e7 100644
--- a/Makefile
+++ b/Makefile
@@ -429,7 +429,7 @@ LINUXINCLUDE    := \
 KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
 KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
-		   -Werror-implicit-function-declaration -Werror=implicit-int \
+		   -Werror=implicit-function-declaration -Werror=implicit-int \
 		   -Wno-format-security \
 		   -std=gnu89
 KBUILD_CPPFLAGS := -D__KERNEL__
-- 
2.21.0


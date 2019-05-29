Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BF6C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7926521019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOOYO5ux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfE2IQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 04:16:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36774 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfE2IQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 04:16:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id v22so889203wml.1;
        Wed, 29 May 2019 01:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JAIjeJA5pieWYxedW2lPGCUTsVd6pWQMhlBtAouoTmQ=;
        b=GOOYO5uxivJVRh/xk/zr0iCasF7ir02JitV4OIzRYgS2Mvgz4coRAmdpVbInb20CRf
         43Sj5TCBKfQh9HR2oZYLwvJCkYIacSXUXi5vnr/SpyXHAVfG2ybeO0cCe5army09C4lw
         d38abLP1xrz04F2l0qoNPbRJaAsQdMgEDZZGlK4Mc1nFYT76y6ZAgIdhXztHzKxzL5xe
         D73qocAYJYNAGTxRMjTQJb49EfiHPCGJX+NyJJ9OWfkubEpP6s5AaDRJ9oljYeujvBEn
         mg7VD+bz9flVOTlK7amOgK0czkoqp43b475SEw17dZ8zvicKUVM+azDVdeIAkalYA4nC
         CmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=JAIjeJA5pieWYxedW2lPGCUTsVd6pWQMhlBtAouoTmQ=;
        b=noNs/ViL3I9gMqmuir42sidDL2joAoSLD9oMO9jbeba3NqXG+0uzpV5H/W21DnnC6/
         ELHQp5EQ7UmoauSkAeEABOi3qRAeMWFmuot9gqjj3027HYc51YOdlW2yJ1dbT2RNGRI4
         Z+uL2cUvsNawPKbCN6cDySzypNOIa0kahA/JyEYOTdCXyXB4KDVuQEW7A0O9UUtrEiSP
         g2Q6GaRwly35lvtE8UpGxtJCa1XtChEQxHhvOmaeiWVC0hjOapI6c3IJ4GZhB72tWPkX
         3blnupyIlwORNdzJ03BIuufX8xpKOyf0N3nw0uSR0ycTJiTW3DozEroGr8XxSoSF4hwc
         yd5g==
X-Gm-Message-State: APjAAAW4+XKMAonhqBPTzbIpjIzkjETEPyLDMgQpJ0GZE4+xlhP6y3zo
        jgf4rLaV1TeFfRdi7vEHyE4=
X-Google-Smtp-Source: APXvYqyGSyvhN3/M/wGK1MB8/Loq9okLbB2YGmJmemOMF44S8TGMYvvgIgxWRGkea3U9lPFoDBk+Qg==
X-Received: by 2002:a7b:c8c1:: with SMTP id f1mr5472410wml.159.1559117773340;
        Wed, 29 May 2019 01:16:13 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id k13sm3308997wmj.10.2019.05.29.01.16.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 01:16:11 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 7776211402E3; Wed, 29 May 2019 10:04:40 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: Remove -Waggregate-return from scripts/Makefile.extrawarn
Date:   Wed, 29 May 2019 10:04:34 +0200
Message-Id: <20190529080434.1409-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes little sense to pass -Waggregate-return these days since large
part of the linux kernel rely on returning struct(s). For instance:

  ../include/linux/timekeeping.h: In function 'show_uptime':
  ../include/linux/ktime.h:91:34: error: function call has aggregate value [-Werror=aggregate-return]
   #define ktime_to_timespec64(kt)  ns_to_timespec64((kt))
                                    ^~~~~~~~~~~~~~~~~~~~~~
  ../include/linux/timekeeping.h:166:8: note: in expansion of macro 'ktime_to_timespec64'
    *ts = ktime_to_timespec64(ktime_get_coarse_boottime());

Remove this warning from W=2 completely.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 scripts/Makefile.extrawarn | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 3ab8d1a303cd..98081ab300e5 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -34,7 +34,6 @@ warning-1 += $(call cc-option, -Wstringop-truncation)
 warning-1 += -Wno-missing-field-initializers
 warning-1 += -Wno-sign-compare
 
-warning-2 := -Waggregate-return
 warning-2 += -Wcast-align
 warning-2 += -Wdisabled-optimization
 warning-2 += -Wnested-externs
-- 
2.20.1


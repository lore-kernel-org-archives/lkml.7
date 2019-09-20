Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70814C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 17:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5B6207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 17:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UTCz5T9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404866AbfITRpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 13:45:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41947 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390815AbfITRpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 13:45:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id q7so4974203pfh.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 10:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mMjUKUF3cIfdwdDd6wOmWCRURy4vMFjlEXHfVSbHKE0=;
        b=UTCz5T9pTipG2ai3Jg0Q2nLrumMBsZhbBYDBqQeWIwPKw467MxwPADbkU5ZxAPXYak
         gGE21KA0GUnOPMfpGHJpRyhexqtvhqj0uJOLTqERkxIRPfJMYpNTm/TmON/hiroMJHZK
         ApBSGFBG7cqHEJ3fNcDkvNO9VtiV+V0XGfwSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mMjUKUF3cIfdwdDd6wOmWCRURy4vMFjlEXHfVSbHKE0=;
        b=V6ymIw8goTPKEWcMR7C76hliH0YSalYUVlEKQiSx9B897psI7mc33ZbWT6DL+Xjqha
         H1w32Yiqr5hpv7LVPGueCpqMekmLAQzWihtWFexxm0/xLsn16Atzn/ch76O9V/lAeunF
         qb7XYHIQvYpatIJj6S3CeOD3Pmlsjtjvg5A/I/MYjOMGffn+1FwXzy4njKFl92IKGLLe
         saUatWLJBHeI0Ldm0lVaBJj3b0w+DtTOg1DP2UBIvDkc7eKPLB74yk20ichFHGJzE9zd
         9hCriWW3rPlKFGsg4SD37+Xtc/hRH4F/3aZE/PSh7Bc1WiuaGP4s0d7pW25bkzcMWxYK
         RLRw==
X-Gm-Message-State: APjAAAWiwfcGdI5GzprwQr4dN1QM1xIyKRoyVCrMuiQadaDvRONvtiee
        Bl4CA3h8blAB6hLZ+GY7hjby6Q==
X-Google-Smtp-Source: APXvYqw7hLLTq624hJAfLh5Bf90XWkrLIfcdhQSjveXlcb9vAIQZKYDDx0Gne0UGshnbMBfiEZFPRg==
X-Received: by 2002:a17:90a:d0c4:: with SMTP id y4mr6213248pjw.116.1569001531394;
        Fri, 20 Sep 2019 10:45:31 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id p189sm2492672pga.2.2019.09.20.10.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 10:45:30 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Will Deacon <will@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Douglas Anderson <dianders@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH] MAINTAINERS: kgdb: Add myself as a reviewer for kgdb/kdb
Date:   Fri, 20 Sep 2019 10:44:47 -0700
Message-Id: <20190920104404.1.I237e68e8825e2d6ac26f8e847f521fe2fcc3705a@changeid>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm interested in kdb / kgdb and have sent various fixes over the
years.  I'd like to get CCed on patches so I can be aware of them and
also help review.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c740cf3f93ef..d243c70fc8ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9052,6 +9052,7 @@ F:	security/keys/
 KGDB / KDB /debug_core
 M:	Jason Wessel <jason.wessel@windriver.com>
 M:	Daniel Thompson <daniel.thompson@linaro.org>
+R:	Douglas Anderson <dianders@chromium.org>
 W:	http://kgdb.wiki.kernel.org/
 L:	kgdb-bugreport@lists.sourceforge.net
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jwessel/kgdb.git
-- 
2.23.0.351.gc4317032e6-goog


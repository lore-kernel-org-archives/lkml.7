Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1827FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 23:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D592087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 23:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JOtNPZID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfCNXmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 19:42:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41420 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfCNXmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 19:42:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id k11so5052102pgb.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 16:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+cLFu1OLr7HAquwI//OHn+9FZY+L0BqbhOfx0COGRiM=;
        b=JOtNPZIDoK/pex8ISPGv4Fehdi58rEZt79hu6C2Nmh19qNvAfaqJ5IOlleljIAvBs1
         XQLFrlZ03aPUU4Eo0QKuNp/gNYs8/iNvTUs+HvrHwP+PJgyvXzvNixkMjyLqgnvDjIB2
         PpetQL6fWQX4P8fpNoiLeTfSYmouv7se5cYk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+cLFu1OLr7HAquwI//OHn+9FZY+L0BqbhOfx0COGRiM=;
        b=a4jd0vmkZxPcomdG7DHoyQg1Afbr4noaMEGgI+DKsla9gc2OvS6DNW1tjoaSZPU2xn
         6cf2u2S5PCPSzkLCdspAj3tXUfRrZYIxmqn10TLR+kH9TaFmJsYu1LirLzvNtc5KWCkg
         8ibH3mOuiH5+4L1lBQ6kyT1Fw8q4+YIc7kLNYWY3ZZUMbaeOD03YAp/6nP5g1FNKHvML
         uW7Os0ue4Ch0+gZoO9uhOHjIyWS6icpM/kTnXx3cWfPP3jgyrORKF+Voo6VaK7JtoFuX
         6c9h4TATQA29RXaotPuZ6OUVfTKGKFNwRj7EOIqEbmblmbf4hPrDubBYojuC3MBljeQz
         EZgw==
X-Gm-Message-State: APjAAAVWfnYMGTB32QSNjxt4UoVZVrLXNm3QIckGqTFwcebUjzsCpMes
        WF4pr32ME52+wZIev7Lyoa6gcA==
X-Google-Smtp-Source: APXvYqwc5xdYGSrsQ07ayzL5Y9/TViO1X94RDNHcRJrWzxNbOyx7Ppou2jXyy/T1IeDFfovGPutItw==
X-Received: by 2002:a63:fd03:: with SMTP id d3mr430058pgh.359.1552606956251;
        Thu, 14 Mar 2019 16:42:36 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id j9sm270379pfc.67.2019.03.14.16.42.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 16:42:35 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH] kbuild: Make NOSTDINC_FLAGS a simply expanded variable
Date:   Thu, 14 Mar 2019 16:41:59 -0700
Message-Id: <20190314234159.191745-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During a simple no-op (nothing changed) build I saw 39 invocations of
the C compiler with the argument "-print-file-name=include".  We don't
need to call the C compiler 39 times for this--one time will suffice.

Let's change NOSTDINC_FLAGS to a simply expanded variable to avoid
this since there doesn't appear to be any reason it should be
recursively expanded.

On my build this shaved ~400 ms off my "no-op" build.

Note that the recursive expansion seems to date back to the (really
old) commit e8f5bdb02ce0 ("[PATCH] Makefile include path ordering").
It's a little unclear to me if the point of that patch was to switch
the variable to be recursively expanded (which it did) or to avoid
directly assigning to NOSTDINC_FLAGS (AKA to switch to +=) because
someone else (out of tree?) was setting it.  I presume later since if
the only goal was to switch to recursive expansion the patch would
have just removed the ":".

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9ef547fc7ffe..3034ba66ad51 100644
--- a/Makefile
+++ b/Makefile
@@ -402,7 +402,7 @@ CHECK		= sparse
 
 CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
 		  -Wbitwise -Wno-return-void -Wno-unknown-attribute $(CF)
-NOSTDINC_FLAGS  =
+NOSTDINC_FLAGS :=
 CFLAGS_MODULE   =
 AFLAGS_MODULE   =
 LDFLAGS_MODULE  =
-- 
2.21.0.360.g471c308f928-goog


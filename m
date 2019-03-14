Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EB4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9805B2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jls7RE7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfCNR7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:59:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39749 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfCNR7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 13:59:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id i20so4363742pfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 10:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o5V2IGfvFmkGe9nrhEJ/yWrbDVoIrNz8HD+S+k+/BmQ=;
        b=Jls7RE7in5/SSKdOe0Df4SiMH54nComjLI7tbXoh5eyNAUOq+5+tvQPB0qk8bduxL0
         srQ99DWv3sJDN0vlW+v3sKWRiCZFdzv+mG2Ki4y9pCwXhcAgxdaeu39z46zSb4gxGLSP
         yQzteIO4UIhD84vpyJwMy/3pZ+YpScqQ+iA2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o5V2IGfvFmkGe9nrhEJ/yWrbDVoIrNz8HD+S+k+/BmQ=;
        b=f3YMkGmny6FheyRFVeFWi4t4cC/cY4Q2M7oa/pbKMgG7inCJCTFEnWxmnt8N7m+FV9
         edBQr/qJLhMOpo6eJsFtYXtGoLH4v2VWs1L1vL8avuo7/GlHtZw5yA16oUAZSsXQz8q8
         nhWbCaf2Ove8LDt5XWebW61AoDzwb3f6sjgZGkUop5+MgOE/RxUtGxVfVwPTM/6RCZgr
         D8USu+E/LqefJAWAGft/R29c+b/dJk+Gvq2+CYUkfw12CQnZqxphU4kzuG/vfdixGQw1
         g6rFPvySyXCNSwOw9D5G8aNT03vvB2pqHChwHEuxdR9cKNi5HcBDLr+PaceqNZMSgeix
         iXyQ==
X-Gm-Message-State: APjAAAW6Oxh9YWibNO+q+SPL57hUYfQwuXX3S9pz4hqKPS4Blwi+7nKi
        pndLdrbdFu9Bv41pSvJ5Obwygg==
X-Google-Smtp-Source: APXvYqxr5vzQQBeN9z3DsXTMTkWwTI6fb/uV9RF0XtApbize+IqqOmG25SgaAfxwkvRw2mAK+oE6Mw==
X-Received: by 2002:a17:902:e784:: with SMTP id cp4mr16310349plb.135.1552586351296;
        Thu, 14 Mar 2019 10:59:11 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id q62sm28387213pga.32.2019.03.14.10.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 10:59:10 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH] kbuild: If the module stripping command fails the build should abort
Date:   Thu, 14 Mar 2019 10:57:05 -0700
Message-Id: <20190314175705.11671-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the call to strip returns an error code then it makes sense for the
build to fail.  Currently we'll just chug along and ship unstripped
modules.

Fixes: e2a666d52b48 ("kbuild: sign the modules at install time")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 scripts/Makefile.modinst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index ff5ca9817a85..5d05c43c6f31 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -22,7 +22,7 @@ quiet_cmd_modules_install = INSTALL $@
       cmd_modules_install = \
     mkdir -p $(2) ; \
     cp $@ $(2) ; \
-    $(mod_strip_cmd) $(2)/$(notdir $@) ; \
+    $(mod_strip_cmd) $(2)/$(notdir $@) && \
     $(mod_sign_cmd) $(2)/$(notdir $@) $(patsubst %,|| true,$(KBUILD_EXTMOD)) && \
     $(mod_compress_cmd) $(2)/$(notdir $@)
 
-- 
2.21.0.360.g471c308f928-goog


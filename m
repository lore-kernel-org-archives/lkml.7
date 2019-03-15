Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BD2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77593218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RrInFBRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbfCOQZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:25:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40492 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbfCOQZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:25:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id y124so6689492pfy.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 09:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rN3A7buDQlB9c4mtpZDNlco/0biGjElcizq2wWkAk70=;
        b=RrInFBRc3LDUi0w3VL3MZVhUEhaTvJ3THS8BvO5nKS/q2gPmF7HF1ISslwSKQ8eDsp
         bFf64XMTTNS3IJfc2NKa4LwvCysVdfiUx0RlskZs03nhvfMTq3zqG7EEJih0SlytSq9N
         fcfdS3lAezv6py/k0AXgu3EbZhTxChSEPwAvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rN3A7buDQlB9c4mtpZDNlco/0biGjElcizq2wWkAk70=;
        b=uGvajlXK4qOJ5ooK0vOmbc6q6QE17dhQhSUHUZb/GqYbdrvnlo+DyLn9WLOsymu4l3
         cLuRZzYKa+MmkwdlbUloOe/ByFuFDlTva0QK1F8bvJH7gjZc2YbSd4ibKVq2H0AWJ9zp
         wEzhKEOZc8z7b5ICHmYiYN+/IQB9qphVtQmRlMA1S/Wy3zT5zUSTwFqsn9eEp7WnO0qD
         IPlhtbWA6tYLeY5RqVfFu1csLYTvHE+4rYaxJ4TbmPIY/oox5xa2mwmk/OhjwS2+1kn3
         eSN6rqHOUbUvJBT7CT81iR82tX1Md1aKmu3ZK8zo7+svwzIG1Ourio/2LobHZheyJG49
         TkGQ==
X-Gm-Message-State: APjAAAXABwY/5sj1DSfYA4sl7NaSw5C+anORrD2Yde7WgOu8nZoNDx1o
        +ODnELodyUDELidCw1SY5GWS3Q==
X-Google-Smtp-Source: APXvYqz7sCiD7RhJ/hNAHL75l3C1ucOJ6Z65qYTLJVabRSJgMGfuUWEz5aDAbiHi2mWX8PJrTLUoXw==
X-Received: by 2002:a63:d209:: with SMTP id a9mr4218554pgg.341.1552667132413;
        Fri, 15 Mar 2019 09:25:32 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 138sm1664080pfx.93.2019.03.15.09.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 09:25:31 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH] Revert "modsign: Abort modules_install when signing fails"
Date:   Fri, 15 Mar 2019 09:25:03 -0700
Message-Id: <20190315162503.131510-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit caf6fe91ddf62a96401e21e9b7a07227440f4185.

The commit was fine but is no longer needed as of commit 3a2429e1faf4
("kbuild: change if_changed_rule for multi-line recipe").  Let's go
back to using ";" to be consistent.

For some discussion, see:

https://lkml.kernel.org/r/CAK7LNASde0Q9S5GKeQiWhArfER4S4wL1=R_FW8q0++_X3T5=hQ@mail.gmail.com

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 scripts/Makefile.modinst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index ff5ca9817a85..0dae402661f3 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -23,7 +23,7 @@ quiet_cmd_modules_install = INSTALL $@
     mkdir -p $(2) ; \
     cp $@ $(2) ; \
     $(mod_strip_cmd) $(2)/$(notdir $@) ; \
-    $(mod_sign_cmd) $(2)/$(notdir $@) $(patsubst %,|| true,$(KBUILD_EXTMOD)) && \
+    $(mod_sign_cmd) $(2)/$(notdir $@) $(patsubst %,|| true,$(KBUILD_EXTMOD)) ; \
     $(mod_compress_cmd) $(2)/$(notdir $@)
 
 # Modules built outside the kernel source tree go into extra by default
-- 
2.21.0.360.g471c308f928-goog


Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07486C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD45208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prEg84b3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405741AbfHIHKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 03:10:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42620 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfHIHKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 03:10:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so45526382pff.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 00:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gHnPOS8Pm8ZeyA7Uap/VGmk8/SCT3qez5bm05fI/Eqw=;
        b=prEg84b3JShuJLqsV9dW/+P4oSDBYOxR5bB92u+ngwNZSS7zuFYv1AwkKKkjxA3nwE
         83uNgiJ7dEccJcRec7gye36J2u/8CXKE0qp8/YC7ZPKg1avZ2exp/va7iJFp8dPlwDuH
         G+pURNTYyDVTZrPo2Qy320dJVSDKrpmefK2ocXr8QIbeuCixmXL1gpOMsuKWGi1U/Xic
         ewYPER4JIbbXHiIPfLdm1gQK2CmuBIL8vP7h/NcNtI28C9xv6vahwgxDYszjD13YcTL/
         aCcc5Lu7up6gaeFEbXjqdGdcLSZIGDfgxxBvyKFIWLBCOnhw/Qchmby95BN7KhOBKMvm
         Kkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gHnPOS8Pm8ZeyA7Uap/VGmk8/SCT3qez5bm05fI/Eqw=;
        b=N9u0fcFOrbWMDauDzOA5OyC7FaGqMMGLx0VIKC1iQ5a6HMDOzcyLGBKElDw0+0rcVm
         2ivKLYdS2DgDb2+6ycranwkvHkB4s4iYrym7nBBXXaU96PnJm3pnyf55aED3sFtDaEhH
         JS32L9krLJl850eikJZCKkRlZ7sKMf9o8z6FxkQnIvbs2Y7dLDKGPyRW2MJjnJXfQfaI
         QEeJEalG/uuVTo1VNT8VmdelF4rF4BgO0Nqeqm82/eBmrvcUOhDh68Hqt5veAxHe7iRI
         GV8R3riNiCN/RArWmqYYbUXYDoJNRftVOgfL0VwpNHh7sbCY5fv+synFL1Xlaylvy4sX
         BnSw==
X-Gm-Message-State: APjAAAVdX1zDJi3SlHHcWa+8/sB3hUy1WZpwbEL845ykbLizBFPrWWog
        tyF7u+4HQeyT2kjMBFyXrUQ=
X-Google-Smtp-Source: APXvYqyzFdggpxqtU2zXLf2i37Yizxc6eiLcSf5S1ldAFK8pRtfqycMCmU3h2btvg2QMbGdaQIStCA==
X-Received: by 2002:a63:550e:: with SMTP id j14mr14561266pgb.302.1565334622328;
        Fri, 09 Aug 2019 00:10:22 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id h129sm92145915pfb.110.2019.08.09.00.10.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 00:10:21 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v4 2/8] module: Replace strncmp with str_has_prefix
Date:   Fri,  9 Aug 2019 15:10:17 +0800
Message-Id: <20190809071017.17170-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncmp(str, const, len) is error-prone because len
is easy to have typo.
The example is the hard-coded len has counting error
or sizeof(const) forgets - 1.
So we prefer using newly introduced str_has_prefix()
to substitute such strncmp to make code better.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index 5933395af9a0..7defa2a4a701 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2251,7 +2251,7 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
 		switch (sym[i].st_shndx) {
 		case SHN_COMMON:
 			/* Ignore common symbols */
-			if (!strncmp(name, "__gnu_lto", 9))
+			if (str_has_prefix(name, "__gnu_lto"))
 				break;
 
 			/* We compiled with -fno-common.  These are not
-- 
2.20.1


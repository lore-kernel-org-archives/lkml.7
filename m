Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA27C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35F92075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j73/bSqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfE1Kd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:33:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38919 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfE1Kd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:33:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id z26so11221926pfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 03:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oZJXceOR5W0OlGeQCN6F076N25o2fhcQ2i3vvRm5pYQ=;
        b=j73/bSqTARkKzpyaHo658WBMkNeKS2Uq6/daFmIqDaBU8Rcls6CL8GyGnIkySCee56
         +PFpipWQu6/5P7GK7nxeAflyOogl1vd5rnbN9uK5cdSjU2srqi1hKq2mPXY1pDi9QisH
         cFM/0AywS+cE6J9vT9kmEKY4jIEOB9i1CbKMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oZJXceOR5W0OlGeQCN6F076N25o2fhcQ2i3vvRm5pYQ=;
        b=bdqZ+ix6nJrmBA1/LfqemU0Q4kQLxCMTOf4gGOssRxjCQZ2pWwxQUy3+H3lOw4kuM9
         w0wtLqARoFjyqhU80lPCEZGl4QW7G1MlaqnvY7iSEOAqKUdxVsiDoYdhnv3Sbb69SBKO
         maVR2FKPzcNy6ttkWPigsvSgE7QIYkOHcMvIIUVqHGre0O2uEo8yxQtC8go6YL6Zdr79
         tgFqfbNXYs6Zqh/YweR72MBCRiUovgj4krD3I1G7i9xEHXdMzaowOC7+lDec8ZAGc2YW
         n4JA5QYh+SYuDqtFQMpkAwd1TvPPCAhXkEi4oBCtpfaiyUaVA8rSVdSYblXUg+0xix87
         w9jA==
X-Gm-Message-State: APjAAAVxO+Qb8Rr55Td6mCwKZhcJxQ0VF79gnsX74kikItGCd0EXQR9i
        +xO1wJc8SrlnrHuaQyfg+bLXCA==
X-Google-Smtp-Source: APXvYqwjAYybK8CE6Z+agRuvX91b1q3sME9mMt2hwQOPWam0Yo1jRMDlUb37dmMc5E1LEC+bzuRaWQ==
X-Received: by 2002:a65:6382:: with SMTP id h2mr22163968pgv.355.1559039637870;
        Tue, 28 May 2019 03:33:57 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id k63sm2234969pje.2.2019.05.28.03.33.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 03:33:57 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] scripts/decode_stacktrace: Look for modules with .ko.debug extension
Date:   Tue, 28 May 2019 18:33:46 +0800
Message-Id: <20190528103346.42720-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Chromium OS kernel builds, we split the debug information as
.ko.debug files, and that's what decode_stacktrace.sh needs to use.

Relax objfile matching rule to allow any .ko* file to be matched.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

Changes since v1:
 - Added quotes around name pattern.

(note that the line in 81 chars now, but there is a precedent below, that
does not split a much longer line in $(), so hopefully this is ok)

akpm: To replace the existing patch in mmotm, thanks!

 scripts/decode_stacktrace.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index bcdd45df3f5127a..d88554dc0eec9e7 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -28,7 +28,7 @@ parse_symbol() {
 		local objfile=${modcache[$module]}
 	else
 		[[ $modpath == "" ]] && return
-		local objfile=$(find "$modpath" -name $module.ko -print -quit)
+		local objfile=$(find "$modpath" -name "$module.ko*" -print -quit)
 		[[ $objfile == "" ]] && return
 		modcache[$module]=$objfile
 	fi
-- 
2.22.0.rc1.257.g3120a18244-goog


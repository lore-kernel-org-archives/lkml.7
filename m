Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7583AC072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 23:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419A9217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 23:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EwtB56xP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfEUXl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 19:41:57 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:40267 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfEUXl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 19:41:56 -0400
Received: by mail-pg1-f180.google.com with SMTP id d30so293730pgm.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 16:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UIVbNO6kM29eP8tdUg5nALQrURuRgSVSPOc4rYESuyA=;
        b=EwtB56xPBXef1Scj4BOm6zW0gz/V1ykUnA5UYLd+ex1NQqm1IKwGZoRzXdw9BJrcm3
         TwDmIy4RKrnpi03f+smdwJsf8FUQikr9sylnvl3MQv/mAGm7836ow4q0A8ZDpnKe9EYR
         ZX3mnzUT+ayn7G6uSqOJk+2WxVhcEY7qosLnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UIVbNO6kM29eP8tdUg5nALQrURuRgSVSPOc4rYESuyA=;
        b=I+WqztsW35ukHEBpmsx3KjjPwd0ciY3nOtSPchx2EMR3n5oVE+a+pwcBjvpDccKfiV
         2PFB/MkEOybnyCE/U8bYHp7vzJcBZ5GuiqrYppID18yX4nuf4mEj1qPwEDrD3FwWrudb
         a20t5TU4qRBMzXK7NZZzWoMGUL4wPYUhFQHIF4Q265wg6afUh0JWGLsJm+aidVkxuDjO
         hVzoBQRxPAWrGTx/iCb2Mj7wHtkBRitXsl6hO/6HefoPTjjdZ87AHLHS/KxAWyD2wpCN
         KRnZKrYFVkbI1oOm2pzRYHwHgUBWnl/K/gkqfhLZt/x7TkxGYMsdNxr+79lrgbLqYxkD
         HD0A==
X-Gm-Message-State: APjAAAU9jV4arV/OuE0G/85pSRDT/o1K2AIYHhT69snyGq1ESGSWF/R/
        4E7bc9vMhLiNXcYuamyir4pAjQ==
X-Google-Smtp-Source: APXvYqyY2ppUrAcaTZTMttZ9jki2HrpraquhdPxHFsma5+6jAUayb6QNLSEp9HANijofl2KGe0wk8A==
X-Received: by 2002:aa7:9e9a:: with SMTP id p26mr59469609pfq.176.1558482116033;
        Tue, 21 May 2019 16:41:56 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id s77sm44111026pfa.63.2019.05.21.16.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 16:41:55 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/decode_stacktrace: Look for modules with .ko.debug extension
Date:   Wed, 22 May 2019 07:41:48 +0800
Message-Id: <20190521234148.64060-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
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
 scripts/decode_stacktrace.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index bcdd45df3f5127a..c851c1eb16f9cf7 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -28,7 +28,7 @@ parse_symbol() {
 		local objfile=${modcache[$module]}
 	else
 		[[ $modpath == "" ]] && return
-		local objfile=$(find "$modpath" -name $module.ko -print -quit)
+		local objfile=$(find "$modpath" -name $module.ko* -print -quit)
 		[[ $objfile == "" ]] && return
 		modcache[$module]=$objfile
 	fi
-- 
2.21.0.1020.gf2820cf01a-goog


Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F61DC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B6A22BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xG8ocYYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfGZL1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:27:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38784 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfGZL1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:27:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id h28so36808336lfj.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 04:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WJ4oeV5ZLHJeESLEdUy9aN7H7bQ/Va6Qh1QrIFzI99g=;
        b=xG8ocYYAMVyrT+fps7Ci3OpR1wI6YXEKPlizWNxS60+b9FbANZFGs/wC2hhclrgCmv
         55v4U/Zf+1LhEPq7LC1Y1cEQQHtwFwuUvCj5CNmzqYyzQct5/fVjkoTGnd10sSfnC5V0
         Hf+hL1vZACofkVZT/824XWihTsoLfe4Thp+o/40y9kSdsqD/HUVj++MnnfFRl7qYzdvF
         +5ExUCQXug6wUu6+Z3l6cuXe+29DSYpXZRRB9Zrfg69tWctJwzzxCBftUTTRdBIa8MhL
         bg/B/cPhoW0/TOldXnTgHzrzw5FfOpbMXBFcTYGl9OaxoQgUc7kD+JzWlPamB6tU+ytk
         0Kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WJ4oeV5ZLHJeESLEdUy9aN7H7bQ/Va6Qh1QrIFzI99g=;
        b=WhOqkpiLNQs81EN+LjdRyNBaU7beeTxrc2PtiQ3M88E6Ur3jn4WzpkYDJ+AjlcMOSm
         prj2xfRssYWbmyY/aPljCHO1jIUzylwkdyUvhvR/lSM6EKEstoQfZVZdts7SBgRbW1ie
         6BRC6rAL3X7egPuq+LTpZu9YDAA9lPleCfB2OAxe+7lXxk6f5Wu5OKMIejVSYz8IhSfd
         fRg+An3L+WUD0SpokcC5IS+vOY2599qAyQeDzW0veTcvpRqRlwHqFIYcVAQdbwxqp7Sz
         UheeuHPCq5M8Nx4nRhyPQL5M8h9TTJd6KdVxYjbhQ9Td+nuuLY6mDoS0bBzvKiGbPcQR
         LUFg==
X-Gm-Message-State: APjAAAW3NbwLBuEQGtIA+GfOXAS0AFXvKG2iCuRoJpZFOAn4DRcvWKba
        TPVvK5+UhtV8SNFmJyUK7XmXXg==
X-Google-Smtp-Source: APXvYqy19sSMEhoiwI1rduoX5SnYPS74HR9JH6CK0bVMOr3rdq3xpST/Q6wPbjIyPh4IZqzaDa1XzA==
X-Received: by 2002:ac2:518d:: with SMTP id u13mr9418914lfi.40.1564140456984;
        Fri, 26 Jul 2019 04:27:36 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id c1sm8257268lfh.13.2019.07.26.04.27.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 04:27:36 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     will@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] arm: perf: Mark expected switch fall-through
Date:   Fri, 26 Jul 2019 13:27:32 +0200
Message-Id: <20190726112732.19257-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fall-through warnings was enabled by default, d93512ef0f0e
("Makefile: Globally enable fall-through warning"), we could see the
following warnings was starting to show up. However, this was originally
introduced in commit 6ee33c2712fc ("ARM: hw_breakpoint: correct and
simplify alignment fixup code"). Commit d968d2b801d8 ("ARM: 7497/1:
hw_breakpoint: allow single-byte watchpoints on all addresses") was
written with the intent to allow single-byte watchpoints on all
addresses but forgot to move 'case 1:' down below 'case 2:'.

../arch/arm/kernel/hw_breakpoint.c: In function ‘hw_breakpoint_arch_parse’:
../arch/arm/kernel/hw_breakpoint.c:609:7: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
    if (hw->ctrl.len == ARM_BREAKPOINT_LEN_2)
       ^
../arch/arm/kernel/hw_breakpoint.c:611:3: note: here
   case 3:
   ^~~~
../arch/arm/kernel/hw_breakpoint.c:613:7: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
    if (hw->ctrl.len == ARM_BREAKPOINT_LEN_1)
       ^
../arch/arm/kernel/hw_breakpoint.c:615:3: note: here
   default:
   ^~~~~~~

Rework so 'case 1:' are next to 'case 3:' and also add '/* Fall through
*/' so that the compiler doesn't warn about fall-through.

Cc: stable@vger.kernel.org # v3.16
Fixes: 6ee33c2712fc ("ARM: hw_breakpoint: correct and simplify alignment fixup code")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm/kernel/hw_breakpoint.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index af8b8e15f589..c14d506969ba 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -603,15 +603,17 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 	case 0:
 		/* Aligned */
 		break;
-	case 1:
 	case 2:
 		/* Allow halfword watchpoints and breakpoints. */
 		if (hw->ctrl.len == ARM_BREAKPOINT_LEN_2)
 			break;
+		/* Fall through */
+	case 1:
 	case 3:
 		/* Allow single byte watchpoint. */
 		if (hw->ctrl.len == ARM_BREAKPOINT_LEN_1)
 			break;
+		/* Fall through */
 	default:
 		ret = -EINVAL;
 		goto out;
-- 
2.20.1


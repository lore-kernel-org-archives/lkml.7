Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21327C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6C722BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tEZoMFkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfGZL1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:27:23 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35424 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfGZL1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:27:23 -0400
Received: by mail-lf1-f65.google.com with SMTP id p197so36819080lfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 04:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g0nLERSg4u07PeLcbnJNifTNV6Ww1N/l/brHYj7jzWs=;
        b=tEZoMFkZNgKAf/ALc17jFdnG9AJ4QvVybihHJF/c2D6S8n5SsN+L+0XjTStbuw6X3M
         bhiLIFDVRKQDJwMjvY2YSPQW6Z18SiYmYS/N8UJts90hythAR+0+zfg+jIGnVVW2J+rP
         8qs/GJBVLpPG9EnfUtu3StUmEO0+4fVONMAQaypVDPNuMax6SLKkNRDcIq3OFdqbtPzf
         Bzga0dDpWlbFfGCELpmpkhKsiNExxgIJHjumwcK/j5zDry2aUVodOsIv/Y0GsUrnIZOY
         dk6ZmzAJmE/wTwCzcPDS8Gbt0fcwWyQ/djnGDjygEEDWDm/NHJI6XyPIxmmU41YyBfip
         K++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g0nLERSg4u07PeLcbnJNifTNV6Ww1N/l/brHYj7jzWs=;
        b=dLPehG9GVZHHxaUu1WxN7vx2qZF0Riww8gcj5R7OGtHgAuaT3F+Pw1yoTq7EZDiOxa
         /GnnrMUZBk3KmZh4HfpJsMCM0ifYM0a6PjAcqRvfGp1ZsyKJjLvJiWuNZ5QEJliQXYwu
         0pFnJw5VufVKdLlTGUvjyOeq1WzB6f2pvaSIWz0VQcdKSavgyhqZ1ZEUTztaXe08s8PS
         /o+n/1F6xGA9mM8qf/S+fODzpDETcCOXv5zdUoSdBzLsW3iRaFMNr5Fp0hfDjwHJOoQz
         1nfBB5R8Y9ggfNCF+0+BwPyMBP2xvnro0tLFYJvPR5Xy0JU+DC8uQ7YNs8MiNqTmeTU+
         mhlw==
X-Gm-Message-State: APjAAAVJc+AdmjW8fJNiZln2YuoGtIhnrJUvI6WzYaOkD7+MkBLO+hUq
        V7XXKvP6V623+DnJS2xJZPvohA==
X-Google-Smtp-Source: APXvYqzA4M9X20guHIBIplEQvEBB6Y95fjhGaemXWIsOmXfspEG/yh8Z8jnFK4oopjvXljlNC+Uf6w==
X-Received: by 2002:a19:234c:: with SMTP id j73mr1078425lfj.96.1564140441031;
        Fri, 26 Jul 2019 04:27:21 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id l22sm9910671ljc.4.2019.07.26.04.27.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 04:27:20 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     will@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 1/3] arm64: perf: Mark expected switch fall-through
Date:   Fri, 26 Jul 2019 13:27:16 +0200
Message-Id: <20190726112716.19104-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fall-through warnings was enabled by default, commit d93512ef0f0e
("Makefile: Globally enable fall-through warning"), the following
warnings was starting to show up:

../arch/arm64/kernel/hw_breakpoint.c: In function ‘hw_breakpoint_arch_parse’:
../arch/arm64/kernel/hw_breakpoint.c:540:7: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
    if (hw->ctrl.len == ARM_BREAKPOINT_LEN_1)
       ^
../arch/arm64/kernel/hw_breakpoint.c:542:3: note: here
   case 2:
   ^~~~
../arch/arm64/kernel/hw_breakpoint.c:544:7: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
    if (hw->ctrl.len == ARM_BREAKPOINT_LEN_2)
       ^
../arch/arm64/kernel/hw_breakpoint.c:546:3: note: here
   default:
   ^~~~~~~

Rework so that the compiler doesn't warn about fall-through. Rework so
the code looks like the arm code. Since the comment in the function
indicates taht this is supposed to behave the same way as arm32 because
it handles 32-bit tasks also.

Cc: stable@vger.kernel.org # v3.16+
Fixes: 6ee33c2712fc ("ARM: hw_breakpoint: correct and simplify alignment fixup code")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/kernel/hw_breakpoint.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index dceb84520948..ea616adf1cf1 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -535,14 +535,17 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 		case 0:
 			/* Aligned */
 			break;
-		case 1:
-			/* Allow single byte watchpoint. */
-			if (hw->ctrl.len == ARM_BREAKPOINT_LEN_1)
-				break;
 		case 2:
 			/* Allow halfword watchpoints and breakpoints. */
 			if (hw->ctrl.len == ARM_BREAKPOINT_LEN_2)
 				break;
+			/* Fall through */
+		case 1:
+		case 3:
+			/* Allow single byte watchpoint. */
+			if (hw->ctrl.len == ARM_BREAKPOINT_LEN_1)
+				break;
+			/* Fall through */
 		default:
 			return -EINVAL;
 		}
-- 
2.20.1


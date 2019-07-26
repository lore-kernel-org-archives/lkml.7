Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1305EC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BDE22BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c91SAV8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfGZL1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:27:19 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40482 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfGZL1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:27:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id b17so36864385lff.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 04:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z9HY70wJXKPs0Bv25UYCD9x0V9nBKcfnlqiIvTFUOZc=;
        b=c91SAV8uhLOcljWjQ8Ab9ri7kVRPcfAovbVniOu6W3Y7+7Si7G3ZkkP7PwDPvbwwZO
         tXE9mCuBPj28+YfwZhE9ZBUX0mlLJ2ZhgHnb9RoKMsj9lqK6gzK9osC9DQ1o3CBtbldM
         THIcpaGSet5VHt7d07KdP9xi4rTQVkmqyt5Q4dRIphqGXVuJvxTFnVBLNL7Ln/5KT/79
         KN/XJg9iOqLN/Ht9Lmb0TwwZ6uPeZjdsSlivfBcZSR5tO3redUCcob0WqfNxyx/iHSOh
         ZlUePfMRzln5doV68I92erwnugKUcHqGY/U+5iwOMomiq5Tco6Z3dJtXLTcJ/2JbF9ru
         d+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z9HY70wJXKPs0Bv25UYCD9x0V9nBKcfnlqiIvTFUOZc=;
        b=WnxDWWfP2KyVqRVSTnjM74izqzXS19QU9PqEKZWyd14KiBvoBhQaGpZsGrQjSpKOtk
         OeHopQb1pSxjyx7D4UwmcbBaRcuFK4lQYN4oaxIHPSpKK1QIUton0IGNix1KNk1n6ge5
         V6ycDw9dI9dOC7plsQUU7h3k/8myqP4F8PkyqtNrFXHOf35sCFuxIFMMzNRCldY4RwhA
         OkZWJvgWcYbGpwQLITyMw7OYsHtmfFm5mKHINnvhviWs5AQ2XEgqU/BSqr+WYPJIr0bd
         QPcO0BGFahNs5/tPGrScVqC0ZCdr9IJcWTtrYxlw2zUXp2yvHmySX8C8TINssC1WyEDe
         kPng==
X-Gm-Message-State: APjAAAUWo0KSs9L3yItmfQw1tXwNoANgz9q7lGcoCJvjyWJPDny9YVyf
        ZWJiz0n4MJCHiN9CLHkU2a3cug==
X-Google-Smtp-Source: APXvYqz0zDV4DU1xCLE+wRCoXoQJs4j/uYCwZ1M3A6PeINVW1+FbpvuzjWzQ55z1yFlxnkhf1+WfaA==
X-Received: by 2002:ac2:419a:: with SMTP id z26mr44458557lfh.21.1564140436505;
        Fri, 26 Jul 2019 04:27:16 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id j90sm9987780ljb.29.2019.07.26.04.27.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 04:27:15 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 2/2] arm64: KVM: hyp: debug-sr: Mark expected switch fall-through
Date:   Fri, 26 Jul 2019 13:27:10 +0200
Message-Id: <20190726112710.19051-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fall-through warnings was enabled by default the following warnings
was starting to show up:

../arch/arm64/kvm/hyp/debug-sr.c: In function ‘__debug_save_state’:
../arch/arm64/kvm/hyp/debug-sr.c:20:19: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
  case 15: ptr[15] = read_debug(reg, 15);   \
../arch/arm64/kvm/hyp/debug-sr.c:113:2: note: in expansion of macro ‘save_debug’
  save_debug(dbg->dbg_bcr, dbgbcr, brps);
  ^~~~~~~~~~
../arch/arm64/kvm/hyp/debug-sr.c:21:2: note: here
  case 14: ptr[14] = read_debug(reg, 14);   \
  ^~~~
../arch/arm64/kvm/hyp/debug-sr.c:113:2: note: in expansion of macro ‘save_debug’
  save_debug(dbg->dbg_bcr, dbgbcr, brps);
  ^~~~~~~~~~
../arch/arm64/kvm/hyp/debug-sr.c:21:19: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
  case 14: ptr[14] = read_debug(reg, 14);   \
../arch/arm64/kvm/hyp/debug-sr.c:113:2: note: in expansion of macro ‘save_debug’
  save_debug(dbg->dbg_bcr, dbgbcr, brps);
  ^~~~~~~~~~
../arch/arm64/kvm/hyp/debug-sr.c:22:2: note: here
  case 13: ptr[13] = read_debug(reg, 13);   \
  ^~~~
../arch/arm64/kvm/hyp/debug-sr.c:113:2: note: in expansion of macro ‘save_debug’
  save_debug(dbg->dbg_bcr, dbgbcr, brps);
  ^~~~~~~~~~

Rework to add a 'break;' where the compiler warned about fall-through.

Fixes: d93512ef0f0e ("Makefile: Globally enable fall-through warning")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/kvm/hyp/debug-sr.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/kvm/hyp/debug-sr.c b/arch/arm64/kvm/hyp/debug-sr.c
index 26781da3ad3e..0fc9872a1467 100644
--- a/arch/arm64/kvm/hyp/debug-sr.c
+++ b/arch/arm64/kvm/hyp/debug-sr.c
@@ -18,40 +18,70 @@
 #define save_debug(ptr,reg,nr)						\
 	switch (nr) {							\
 	case 15:	ptr[15] = read_debug(reg, 15);			\
+			/* Fall through */				\
 	case 14:	ptr[14] = read_debug(reg, 14);			\
+			/* Fall through */				\
 	case 13:	ptr[13] = read_debug(reg, 13);			\
+			/* Fall through */				\
 	case 12:	ptr[12] = read_debug(reg, 12);			\
+			/* Fall through */				\
 	case 11:	ptr[11] = read_debug(reg, 11);			\
+			/* Fall through */				\
 	case 10:	ptr[10] = read_debug(reg, 10);			\
+			/* Fall through */				\
 	case 9:		ptr[9] = read_debug(reg, 9);			\
+			/* Fall through */				\
 	case 8:		ptr[8] = read_debug(reg, 8);			\
+			/* Fall through */				\
 	case 7:		ptr[7] = read_debug(reg, 7);			\
+			/* Fall through */				\
 	case 6:		ptr[6] = read_debug(reg, 6);			\
+			/* Fall through */				\
 	case 5:		ptr[5] = read_debug(reg, 5);			\
+			/* Fall through */				\
 	case 4:		ptr[4] = read_debug(reg, 4);			\
+			/* Fall through */				\
 	case 3:		ptr[3] = read_debug(reg, 3);			\
+			/* Fall through */				\
 	case 2:		ptr[2] = read_debug(reg, 2);			\
+			/* Fall through */				\
 	case 1:		ptr[1] = read_debug(reg, 1);			\
+			/* Fall through */				\
 	default:	ptr[0] = read_debug(reg, 0);			\
 	}
 
 #define restore_debug(ptr,reg,nr)					\
 	switch (nr) {							\
 	case 15:	write_debug(ptr[15], reg, 15);			\
+			/* Fall through */				\
 	case 14:	write_debug(ptr[14], reg, 14);			\
+			/* Fall through */				\
 	case 13:	write_debug(ptr[13], reg, 13);			\
+			/* Fall through */				\
 	case 12:	write_debug(ptr[12], reg, 12);			\
+			/* Fall through */				\
 	case 11:	write_debug(ptr[11], reg, 11);			\
+			/* Fall through */				\
 	case 10:	write_debug(ptr[10], reg, 10);			\
+			/* Fall through */				\
 	case 9:		write_debug(ptr[9], reg, 9);			\
+			/* Fall through */				\
 	case 8:		write_debug(ptr[8], reg, 8);			\
+			/* Fall through */				\
 	case 7:		write_debug(ptr[7], reg, 7);			\
+			/* Fall through */				\
 	case 6:		write_debug(ptr[6], reg, 6);			\
+			/* Fall through */				\
 	case 5:		write_debug(ptr[5], reg, 5);			\
+			/* Fall through */				\
 	case 4:		write_debug(ptr[4], reg, 4);			\
+			/* Fall through */				\
 	case 3:		write_debug(ptr[3], reg, 3);			\
+			/* Fall through */				\
 	case 2:		write_debug(ptr[2], reg, 2);			\
+			/* Fall through */				\
 	case 1:		write_debug(ptr[1], reg, 1);			\
+			/* Fall through */				\
 	default:	write_debug(ptr[0], reg, 0);			\
 	}
 
-- 
2.20.1


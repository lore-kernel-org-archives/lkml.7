Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9437C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FAD520863
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="FxCPFdBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfCCMi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 07:38:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53576 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfCCMi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 07:38:26 -0500
Received: by mail-wm1-f65.google.com with SMTP id e74so2073965wmg.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 04:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wmaRd8ftTs0lTwJsk22PI1aI1d7YGIyjW6+ZlePZZRA=;
        b=FxCPFdBUCe/SxF0aNwT2urt3QRwAYO+32y3KXD4NuawGGWWesM+V1s3j51RWhqWy/g
         dHSzL7u/vb39uewF5j5S0qOjap2XQRWo2rN4+peaLR6HJROoBv4+FzmXU9OurngAvvUq
         +mAdo2zvj2sU4HDrsbuMjVTIA6sUn2JI9Wzoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wmaRd8ftTs0lTwJsk22PI1aI1d7YGIyjW6+ZlePZZRA=;
        b=QY4h0sG5sTIDt+nVIcy0q1wsf9gRZvxR8Qv+FVKR3juJ8/iOkK8bB9Wfzlk6M+0F73
         Ki64h3y6ts29/MqoHkofpqJNTn6fvxPdIEAf5nygPhjDXMNZXRJnCM5SCx3hZsTd5eXT
         QC8P5C6U+pkC1He+U0UEiJoFcSpfXtsirXoAAgNqIGwzm7cE+EntEEXuO6FsuWNKuUWP
         kFRCefswwTEiDC88rl7Mwa6ySwO85o0BdqA1LGeGF1mwGIK7dqeLAe1QWG5jmgIoGT8O
         hP6aUJKbh4kpa0c6N+OvO9a7S79jwQ38EGhD1/z5acTtO5icXJjfxwCfgGZnJVZGEb0M
         LT/w==
X-Gm-Message-State: AHQUAubbM1IwNhbpEu06WW28G6d2NYTy1kHhXeWigjoiqZIENMgLTrkA
        f7Uj/3X3CdzHnkxVsifnOSJHhINSUsM9eg==
X-Google-Smtp-Source: AHgI3IZkppvMGYiC8GNycYO8l2mL3PmpFcD4Znjme3vwD5cqO4IeHBz31wAvId4+qri99+h9IJxrBg==
X-Received: by 2002:a7b:cbcd:: with SMTP id n13mr8701045wmi.92.1551616704496;
        Sun, 03 Mar 2019 04:38:24 -0800 (PST)
Received: from localhost.localdomain ([95.149.160.3])
        by smtp.gmail.com with ESMTPSA id t202sm9450783wmt.0.2019.03.03.04.38.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 04:38:23 -0800 (PST)
From:   Louis Taylor <louis@kragniz.eu>
To:     corbet@lwn.net
Cc:     pmladek@suse.com, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        ndesaulniers@google.com, jflat@chromium.org,
        Louis Taylor <louis@kragniz.eu>
Subject: [PATCH] docs: add extra integer types to printk-formats
Date:   Sun,  3 Mar 2019 12:36:47 +0000
Message-Id: <20190303123647.22020-1-louis@kragniz.eu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few commonly used integer types were absent from this table, so add
them.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Louis Taylor <louis@kragniz.eu>
---
 Documentation/core-api/printk-formats.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index a7fae4538946..6f08b1b6240a 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -19,8 +19,16 @@ Integer types
 		unsigned long		%lu or %lx
 		long long		%lld or %llx
 		unsigned long long	%llu or %llx
+		short int		%hd or %hx
+		unsigned short int	%hu or %hx
+		char			%hhd or %hhx
+		unsigned char		%hhu or %hhx
 		size_t			%zu or %zx
 		ssize_t			%zd or %zx
+		s8			%hhd or %hhx
+		u8			%hhu or %hhx
+		s16			%hd or %hx
+		u16			%hu or %hx
 		s32			%d or %x
 		u32			%u or %x
 		s64			%lld or %llx
-- 
2.20.1


Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B13BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3540A2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="bybIht08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbfB1Lx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:53:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37302 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732208AbfB1Lx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:53:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id w6so18373530wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 03:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AyalN3R/+9m+MXW0m/d0m/0kqSvBITbtYdefnAtWs7M=;
        b=bybIht08JwklLU2I9b16lH7f2/meUfBi+YfdQPUNT0bGM+QcEeqVlIjX9aIyEK4Rkr
         OIVE8QNAYuxzJbb0DQg7RopmaLmGoP4OXm9i6nPxMj/W9Rp8PdTZJi7sm4wBt3L1mOSK
         E7x2RKsCJn0p35pym/zntGnEAUCQprRQOuxpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AyalN3R/+9m+MXW0m/d0m/0kqSvBITbtYdefnAtWs7M=;
        b=g9ioF2AswpMgdvLxJSeYMaEthyd71almUSMus1vEr+8+wOoLA/JcFs3cednUAyl+Kc
         h8crsyA9FJPW2B2ae/P5ehbycdhbjIIVD1y0JYSr6jARR0XG1CcFccZdU+mbwMD0bAJl
         N3bAJ79DnK7fxEsIjO7aruAwH+47ce6HrSY0ofiJ328iiaFsuQjEQTm8FbLSP2ajR04e
         ds/cZhU0VeuhPOveZ8vJ5dKnyQwiNXNwGDRtt3cV5Cbix3r5jtIPmrShhxDYa2gHhzI5
         6HJLI6i+ykNKvR1s7pCbC22GEAZNG/BK43m62qyG3Uha35mYvB9pMF9SlIMU1hRJ6lNK
         XSSQ==
X-Gm-Message-State: APjAAAU88RU8xnjkwXN9g0dy14BhQXvI/HEHdp9wu0i2rAJVp2EACTlw
        eEgadXJ5DMHDMzfOs+HCSiYWIkiRFpuj1Q==
X-Google-Smtp-Source: APXvYqwX78r5z9Yb0AhJA4PBL8pn2v6JuL7SyCpFlzwR4Z4DYAxuyIIbLDLNpRoE6uxvAGCZPrSxxw==
X-Received: by 2002:adf:fa47:: with SMTP id y7mr6034469wrr.301.1551354835870;
        Thu, 28 Feb 2019 03:53:55 -0800 (PST)
Received: from localhost.localdomain ([5.148.119.11])
        by smtp.gmail.com with ESMTPSA id x24sm6149491wmi.5.2019.02.28.03.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 03:53:55 -0800 (PST)
From:   Louis Taylor <louis@kragniz.eu>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, ndesaulniers@google.com,
        jflat@chromium.org, Louis Taylor <louis@kragniz.eu>
Subject: [PATCH] wusb: use correct format characters
Date:   Thu, 28 Feb 2019 11:52:56 +0000
Message-Id: <20190228115256.5446-1-louis@kragniz.eu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with -Wformat, clang warns:

./include/linux/usb/wusb.h:245:5: warning: format specifies type
'unsigned short' but the argument has type 'u8' (aka 'unsigned char')
[-Wformat]
  ckhdid->data[0],  ckhdid->data[1],
  ^~~~~~~~~~~~~~~

ckhdid->data is unconditionally defined as `u8 data[16]`, so this patch
updates the format characters to the correct one for unsigned char types.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Louis Taylor <louis@kragniz.eu>
---
 include/linux/usb/wusb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/usb/wusb.h b/include/linux/usb/wusb.h
index 9e4a3213f2c2..0a3cdf10972d 100644
--- a/include/linux/usb/wusb.h
+++ b/include/linux/usb/wusb.h
@@ -240,8 +240,8 @@ static inline size_t ckhdid_printf(char *pr_ckhdid, size_t size,
 				   const struct wusb_ckhdid *ckhdid)
 {
 	return scnprintf(pr_ckhdid, size,
-			 "%02hx %02hx %02hx %02hx %02hx %02hx %02hx %02hx "
-			 "%02hx %02hx %02hx %02hx %02hx %02hx %02hx %02hx",
+			 "%02hhu %02hhu %02hhu %02hhu %02hhu %02hhu %02hhu %02hhu "
+			 "%02hhu %02hhu %02hhu %02hhu %02hhu %02hhu %02hhu %02hhu",
 			 ckhdid->data[0],  ckhdid->data[1],
 			 ckhdid->data[2],  ckhdid->data[3],
 			 ckhdid->data[4],  ckhdid->data[5],
-- 
2.20.1


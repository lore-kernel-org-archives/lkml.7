Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D916C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9132083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="Bwa//9ZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732474AbfB1M2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:28:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35803 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732319AbfB1M2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:28:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id t18so21752309wrx.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 04:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AHorr1ZlR75Xo7d2v5K+mRGtoatjeXhGXf2KD/PH1JI=;
        b=Bwa//9ZK5E5XJwlJ2GyBNfeEBpqaE34kTNiW8whqHng71syFwOyNjugihptAv3Ozd/
         da4dSQ6UcQZrq06y/Lx6zv9hb6Jf1h739saBI6dgZGXksx5DfdKkaRzbWIhqEHk+9MSk
         vZbqTLOT12Ydio45RNc0twYd1Xpv0ISRxVeeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AHorr1ZlR75Xo7d2v5K+mRGtoatjeXhGXf2KD/PH1JI=;
        b=ntnm4rEEPF9SqLHBJitexKtPqdOdF2hH7R/mMFEilR1k6oT28ypThan+lSTrUrPxRS
         ghSVbDXxmuERxMgGmpfXuWRgoX/AB1YamW8wHZFkRSF/NmRgFF3I7FBINPaX+6PdYv1c
         71SY3MkTHh4Tyz71R/OK6eU/aU5NxdX4xD1H1WeSUmmqPjxK6SGFYxk8FLsU4UlscWwy
         ynMiYhFNgi6vabhobsW9sSdpMgEUnN7j+OfMwezDnn4JsLxR2iVsY7oVpDCaBBH7StmT
         mG+gWRDCJ6JlQxYyYfyfTVPkSvMuIaCdwiu+1791ojqOUMbJjwZpCQF4HTg3EcF2Q6AA
         ojkg==
X-Gm-Message-State: APjAAAW5T88lfvslf/JcObSHiEcw7kM8UYsD3LY4dqId0wL3KDtWXvQC
        Q/ShLOCXXH5NgxULtyfzAjkXAQ==
X-Google-Smtp-Source: APXvYqwVXSZDY6lyGkLn91tFGjc8BvmJb6mfhRimc7tZwyWHXVHf+12N7WBt69RdlqRB+TYH5mDFGA==
X-Received: by 2002:a5d:5681:: with SMTP id f1mr6206056wrv.95.1551356899270;
        Thu, 28 Feb 2019 04:28:19 -0800 (PST)
Received: from localhost.localdomain ([5.148.119.11])
        by smtp.gmail.com with ESMTPSA id a2sm12673753wrr.60.2019.02.28.04.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 04:28:18 -0800 (PST)
From:   Louis Taylor <louis@kragniz.eu>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, ndesaulniers@google.com,
        jflat@chromium.org, Louis Taylor <louis@kragniz.eu>
Subject: [PATCH v2] wusb: use correct format characters
Date:   Thu, 28 Feb 2019 12:24:17 +0000
Message-Id: <20190228122417.9318-1-louis@kragniz.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228115256.5446-1-louis@kragniz.eu>
References: <20190228115256.5446-1-louis@kragniz.eu>
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
index 9e4a3213f2c2..625366d3499e 100644
--- a/include/linux/usb/wusb.h
+++ b/include/linux/usb/wusb.h
@@ -240,8 +240,8 @@ static inline size_t ckhdid_printf(char *pr_ckhdid, size_t size,
 				   const struct wusb_ckhdid *ckhdid)
 {
 	return scnprintf(pr_ckhdid, size,
-			 "%02hx %02hx %02hx %02hx %02hx %02hx %02hx %02hx "
-			 "%02hx %02hx %02hx %02hx %02hx %02hx %02hx %02hx",
+			 "%02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx "
+			 "%02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx",
 			 ckhdid->data[0],  ckhdid->data[1],
 			 ckhdid->data[2],  ckhdid->data[3],
 			 ckhdid->data[4],  ckhdid->data[5],
-- 
2.20.1


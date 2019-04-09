Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDA4C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1A120883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="hmGG9/7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfDIVZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:25:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38133 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfDIVZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:25:54 -0400
Received: by mail-ed1-f65.google.com with SMTP id d13so129073edr.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 14:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZI11Zmtr2qg4/K1lFbCuudGPrJYgVYyPLkGzsua46oQ=;
        b=hmGG9/7al8yzsp5pJYYQNnpUZtCG6MaGXWnNfUmGHl6LFY4z5fr9QBU34I/0BdkT3x
         4EMZ4c9zTHIePHafB9nCo9/QWiqhYplmB7QIuntWk60CNP/rCEsl+xw0d5Jcp8YVXcjW
         oNexDIX1Wa/8+aZS6iruwWgQd0niWYVDIo/PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZI11Zmtr2qg4/K1lFbCuudGPrJYgVYyPLkGzsua46oQ=;
        b=AcW6RrcqF0AzXXGTyV6jfiSoLRa/uq72pn/QlKQNFiSODkHX2QRk8h+bnZbQW+VLDR
         kfQOtfloZX9NH/VDwFA1//o5zfuCHUgK0+FQud52nKBYjGSPgfRjvUQu6bl8byLNFtg9
         PtTco+WHW4hynwAJ0eLz0JueriyxRqj7USB5Xc2kidBMASxV8romVBzdwCntb/9wViSI
         4t23vZ+CS4S+OnPThKwQEeXArbE4xDX4hqwFIN3vKbnCxJSTacGqU5+S2ftQPMNH+Mrj
         j85HvbICm+u4fZqQqfdgi1F83ChOEhWU56s3OxArNJK1n4OPaPkGfSBXWe7fYuIjGyQA
         +mvQ==
X-Gm-Message-State: APjAAAW56cS2QkxsO7qMJNZhO1em9as5LeEbO+c5GLB4KxPFusBwit+y
        ZL/zcfwYUjS/QjVy+43yoX0hjw==
X-Google-Smtp-Source: APXvYqzF4Z112DSJvFPtbXsneqPByWGqfWRrvRCzok8md1Vl6vgFf2pZzbi5wrqyieANJwduPnMOPw==
X-Received: by 2002:a50:b4c9:: with SMTP id x9mr24548318edd.132.1554845152431;
        Tue, 09 Apr 2019 14:25:52 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id i26sm3477986ejc.51.2019.04.09.14.25.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 14:25:52 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 01/10] linux/device.h: use unique identifier for each struct _ddebug
Date:   Tue,  9 Apr 2019 23:25:08 +0200
Message-Id: <20190409212517.7321-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
References: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes on x86-64 later in this series require that all struct _ddebug
descriptors in a translation unit uses distinct identifiers. Realize
that for dev_dbg_ratelimited by generating such an identifier via
__UNIQUE_ID and pass that to an extra level of macros.

No functional change.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/device.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 4e6987e11f68..64b95a913fef 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1562,7 +1562,7 @@ do {									\
 	dev_level_ratelimited(dev_info, dev, fmt, ##__VA_ARGS__)
 #if defined(CONFIG_DYNAMIC_DEBUG)
 /* descriptor check is first to prevent flooding with "callbacks suppressed" */
-#define dev_dbg_ratelimited(dev, fmt, ...)				\
+#define _dev_dbg_ratelimited(descriptor, dev, fmt, ...)			\
 do {									\
 	static DEFINE_RATELIMIT_STATE(_rs,				\
 				      DEFAULT_RATELIMIT_INTERVAL,	\
@@ -1573,6 +1573,8 @@ do {									\
 		__dynamic_dev_dbg(&descriptor, dev, dev_fmt(fmt),	\
 				  ##__VA_ARGS__);			\
 } while (0)
+#define dev_dbg_ratelimited(dev, fmt, ...)				\
+	_dev_dbg_ratelimited(__UNIQUE_ID(ddebug), dev, fmt, ##__VA_ARGS__)
 #elif defined(DEBUG)
 #define dev_dbg_ratelimited(dev, fmt, ...)				\
 do {									\
-- 
2.20.1


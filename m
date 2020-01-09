Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97439C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF802077C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDCsoXgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387432AbgAIQJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:09:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23239 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387417AbgAIQJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x/rxJnoz2dp9/OgwOSiXn1XXvPb+lm1fPDfoPO+TlzQ=;
        b=HDCsoXgB1j3chip68L6QzJI6/Db6kEhxr6J20Hxml6/KMZ5xSNHYINJONxx8zC5p3LH8Gp
        cMUPcvPUgHON8GLND6cdj3eOdYKwo9BRLDahfB8Av7sJMo2/gYbc7dZgwhLds3GQgE8+sh
        +cmGYkrAN3XQ7TwtF9sLDIFlxC7rwYg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-NZVXg3HMO-GjOyFFuN746g-1; Thu, 09 Jan 2020 11:09:35 -0500
X-MC-Unique: NZVXg3HMO-GjOyFFuN746g-1
Received: by mail-wm1-f69.google.com with SMTP id b9so1098965wmj.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:09:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/rxJnoz2dp9/OgwOSiXn1XXvPb+lm1fPDfoPO+TlzQ=;
        b=XtnBYs3QFYJpnnKmlbSEUl8o9xAaOIUz/hc7xuB23e0D10tMZo5CFNTiOuUOljvtv/
         FZd0Q4bWDggJM2eZGgIhaPD3LvS5YJMlg8HSZlfElpodqPfMtfBTOJ/F5d43GhYtasv+
         6y/eAZSsvfka4Bcy100D8qM4rfdJdvlZ1ZydYrRFBEelCTQOJdYAjLyjZSe8tyjhYH4c
         03WsKoLtyTin7uykTOGg3YiLDkRSs9BafRAm28Eis28xCvrgW7O3f9yP2aDvDd0KxpRS
         UYRUofyO2d9oQbXqkr+95tJ8aQGhAnQQsG8viIE4Fo48Hq9tHXzSSi8gcGonjrO5a75J
         +zxw==
X-Gm-Message-State: APjAAAWgLar1+cxgRMA3AX7NhCOxQgJo6uOfOM9lbdMLhYt76DSM6orh
        5gAVojtf0r9hrtgz9hbDLouUI7nA9Mzp6Ebv5+HsJMWOllEDGAgHlnAk80tYq1sxPXk2QUHX9fV
        Z/9LGxUePcpzcE2rWa7vzwv6l
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr11396383wru.173.1578586173702;
        Thu, 09 Jan 2020 08:09:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqzzBZ0BLVEYI65yhSFFLKAZJl16GgmFQUcOJvP3sjdvkoaxTwI5EQ3O12ZHhk4lBNKmTURtAg==
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr11396364wru.173.1578586173488;
        Thu, 09 Jan 2020 08:09:33 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id e8sm8517707wrt.7.2020.01.09.08.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:09:32 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 51/57] arm64: crypto: Add exceptions for crypto object to prevent stack analysis
Date:   Thu,  9 Jan 2020 16:02:54 +0000
Message-Id: <20200109160300.26150-52-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

Some crypto modules contain `.word` of data in the .text section.
Since objtool can't make the distinction between data and incorrect
instruction, it gives a warning about the instruction being unknown
and stops the analysis of the object file.

The exception can be removed if the data are moved to another section
or if objtool is tweaked to handle this particular case.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/crypto/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
index d0901e610df3..576a19923185 100644
--- a/arch/arm64/crypto/Makefile
+++ b/arch/arm64/crypto/Makefile
@@ -43,9 +43,11 @@ aes-neon-blk-y := aes-glue-neon.o aes-neon.o
 
 obj-$(CONFIG_CRYPTO_SHA256_ARM64) += sha256-arm64.o
 sha256-arm64-y := sha256-glue.o sha256-core.o
+OBJECT_FILES_NON_STANDARD_sha256-core.o := y
 
 obj-$(CONFIG_CRYPTO_SHA512_ARM64) += sha512-arm64.o
 sha512-arm64-y := sha512-glue.o sha512-core.o
+OBJECT_FILES_NON_STANDARD_sha512-core.o := y
 
 obj-$(CONFIG_CRYPTO_CHACHA20_NEON) += chacha-neon.o
 chacha-neon-y := chacha-neon-core.o chacha-neon-glue.o
@@ -62,6 +64,7 @@ aes-arm64-y := aes-cipher-core.o aes-cipher-glue.o
 
 obj-$(CONFIG_CRYPTO_AES_ARM64_BS) += aes-neon-bs.o
 aes-neon-bs-y := aes-neonbs-core.o aes-neonbs-glue.o
+OBJECT_FILES_NON_STANDARD_aes-neonbs-core.o := y
 
 CFLAGS_aes-glue-ce.o	:= -DUSE_V8_CRYPTO_EXTENSIONS
 
-- 
2.21.0


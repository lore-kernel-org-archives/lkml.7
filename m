Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD4AC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8AA2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZNg6oVsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfKVW5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 17:57:49 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:41827 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVW5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 17:57:49 -0500
Received: by mail-il1-f194.google.com with SMTP id q15so8521966ils.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 14:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u3ZBGYnvbJ/3nC+9DjDgIqK97Mwi6LQxKmI4rG9RExg=;
        b=ZNg6oVsYlzBrw+efMsCCKJFqUM7pP5WJAG3qgMjIb0gYMFdfjOLDYsIxGc8FzaxZ1u
         RbVAQ2XiHWGtar5BEx1bZQmXaUagK/styfpLTil1J057VCH5u4FGEc5J7f/XRUqlAYAs
         i5HpA2gbxnG8lOh0IeB+P0Q9UqAVktrc+UYcSQfdo3LZHQpX81RZI3ImSIIujMdA1797
         uv3Yp9rNZ9DnTtkCi2392cEkIk2qJNF453a8+tvt8BK9Y13Q0HvO3tuCwK5KNcS5BNbe
         jlYieAQgReeHxuyWipzj2dBlt8eEu3IimpQSd7QcQA6SijuBE0Rdhtbi6CE8+SXm4YFb
         2LKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u3ZBGYnvbJ/3nC+9DjDgIqK97Mwi6LQxKmI4rG9RExg=;
        b=dQtExX27glvxkxIm2kbSjRvjaUTJ1UMGPd2wek1T2RDoQfkcNuKteQSJmP2nMprGpy
         XW6LmO5mRHxrOREnxsBNeiNybjUjG6/x5U+yNHqAMs4Um4wXPzxwMi7lYxDRj8Nw9nWf
         Uh+L7/Rj6vJe1i62kpfI5JU1FbmRQgGqsID2UGj+zLStOumXf/a6lM3LpNcQYzswGt/y
         9nwIqwat+IO7d9UZjl5EpzPAMkEJGvx2qN6XX/v+KfL4I4tRsZtl1NCFBOac5UgK45FS
         qeJ/qVG2jWef7Hp7SKo8H0MwOBVgWH3YB2gv+Q/r5dTEN7yF2zBOZhWuxYObJ7t8YGDT
         Zhxw==
X-Gm-Message-State: APjAAAWEikkMPhfY/frpjkbF2Zj1JrvCFNMOOePsL4TErbFK7E2EiGml
        oCikMmsuZbmPB4RgrvV5C1InA9KaOJ4=
X-Google-Smtp-Source: APXvYqxtiKJSC7igr3lL77ErIu+id/gxtWpxS43pAdQZ2RUOnTCZoaoEUbp6J8KXzVQejZdOdWf0NQ==
X-Received: by 2002:a92:109c:: with SMTP id 28mr19458344ilq.142.1574463468403;
        Fri, 22 Nov 2019 14:57:48 -0800 (PST)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id x9sm3277098ilp.43.2019.11.22.14.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 14:57:41 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] riscv: defconfigs: enable debugfs
Date:   Fri, 22 Nov 2019 14:56:58 -0800
Message-Id: <20191122225659.21876-2-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.24.0.rc0
In-Reply-To: <20191122225659.21876-1-paul.walmsley@sifive.com>
References: <20191122225659.21876-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs is broadly useful, so enable it in the RISC-V defconfigs.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/configs/defconfig      | 1 +
 arch/riscv/configs/rv32_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 420a0dbef386..f0710d8f50cc 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -100,4 +100,5 @@ CONFIG_9P_FS=y
 CONFIG_CRYPTO_USER_API_HASH=y
 CONFIG_CRYPTO_DEV_VIRTIO=y
 CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_FS=y
 # CONFIG_RCU_TRACE is not set
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index 87ee6e62b64b..bdec58e6c5f7 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -97,4 +97,5 @@ CONFIG_9P_FS=y
 CONFIG_CRYPTO_USER_API_HASH=y
 CONFIG_CRYPTO_DEV_VIRTIO=y
 CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_FS=y
 # CONFIG_RCU_TRACE is not set
-- 
2.24.0.rc0


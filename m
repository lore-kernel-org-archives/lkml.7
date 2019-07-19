Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FF9C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8CB2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XBMc40+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389772AbfGSEUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:20:13 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34781 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfGSEUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:20:03 -0400
Received: by mail-io1-f68.google.com with SMTP id k8so55763924iot.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 21:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=y7QcXz6snFzqEHX9oNiwROmLSfrbhKnVywQpaDFxKjU=;
        b=XBMc40+zE5hV9zvUK7QKYf84WeaZeVOkHEc+Ym7qahSCly2JPuO+wQ8TMLmOlquVIx
         ZOh7vrznORPoqN9Tk5Vy4ScOe7tXXzyVDkJmHmgSqcKTiL1JAUpA3JP47Z74JkvyMKoG
         Vru5wrI101h3kL1Fmmr22gglG4E6Gg7M9VEp7u6I4WoKhlt+iT9Hefknr+x05v9NdXh3
         Ol6fNQLRfAYllDwOtTVJulMat9PzO4gQsnKKY1BKcAINbgC1gOsqYc6NzQ5+wfbg8jar
         054ZQEV4ZYt2ryIpvydkJL2E2i9kvSUaTHhVznB3dTk8d0jWQU/WsRsAfLEAHW/cGuzf
         sZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=y7QcXz6snFzqEHX9oNiwROmLSfrbhKnVywQpaDFxKjU=;
        b=dSdO07Bv9F81VSfGP6Zi9Rat3VUf6hfXWY1LazUmyuF4FSjPZHs9jAHadTLWUOAkky
         CMkO6tXcwiUfEMYpnN6+V4Rl17MAUFCxkMJSZ/uw/KsMHtdMoELaxwMH5cF8aFiJtNyM
         t9s3sncEJRKxKSbW+nHJlViJFZThNAHzYngMJofVDadnsuEErwruUkTelIRby8kWYUNQ
         vUdhet/U3TWfS/IKI/Nl7bmTj4le+OwA91GR4rf/M2ocHrMaVMeKMdkSCQSXQcwhXiD9
         nWEsKOJge94Ews1nxVaMvTcIrFlJMAl92QdOcyodT0UJMgUHR3CMso4QQiBzDfxEObhd
         8D/w==
X-Gm-Message-State: APjAAAWFn8eYOldpfxkRNJXPg3nxnsdeljN8ro3/3B0vYwTIfY90WU/J
        aS3Gn4h0Od3QBK4fId/lM3gNBQ==
X-Google-Smtp-Source: APXvYqzGiWfVK10x/o/hAhjT31ymV7flaSQ4nE5/whEi7UQaYFpREf+rTapypi5WrJkv8Azrv/2p7w==
X-Received: by 2002:a5d:9749:: with SMTP id c9mr48787103ioo.258.1563510003006;
        Thu, 18 Jul 2019 21:20:03 -0700 (PDT)
Received: from localhost (67-0-62-24.albq.qwest.net. [67.0.62.24])
        by smtp.gmail.com with ESMTPSA id u4sm31205266iol.59.2019.07.18.21.20.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 21:20:02 -0700 (PDT)
Date:   Thu, 18 Jul 2019 21:20:01 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     linux-riscv@lists.infradead.org
cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        christian@brauner.io
Subject: [PATCH] riscv: enable sys_clone3 syscall for rv64
Message-ID: <alpine.DEB.2.21.9999.1907182118500.7083@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Enable the sys_clone3 syscall for RV64.  We simply include the generic
version.

Tested by running the program from

   https://lore.kernel.org/lkml/20190716130631.tohj4ub54md25dys@brauner.io/

and verifying that it completes successfully.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Christian Brauner <christian@brauner.io>
---
 arch/riscv/include/uapi/asm/unistd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
index 0e2eeeb1fd27..13ce76cc5aff 100644
--- a/arch/riscv/include/uapi/asm/unistd.h
+++ b/arch/riscv/include/uapi/asm/unistd.h
@@ -18,6 +18,7 @@
 #ifdef __LP64__
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_SYS_CLONE3
 #endif /* __LP64__ */
 
 #include <asm-generic/unistd.h>
-- 
2.22.0


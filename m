Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCABC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B395E2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dSdA4XKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404178AbfEXUUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 16:20:23 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42941 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403845AbfEXUUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 16:20:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id go2so4574848plb.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 13:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=jn/dM10djkegtPlL7Sb55El8ON07t/o4IMLGKNU09Wk=;
        b=dSdA4XKJphgdBP4R18tB+k2uO6rQX3ddrHhVVGYMhPrPsJila5ldAhulVOP1Zo8FFx
         ++lVxrQ8PY2p0LC1s8MK1Je8H+i4ORQW8U6YDs/+YeMa2RSzvTRH/9Vz79ecwvB7uL5e
         rOxHPuZCvzt0q7Y72IIDn518QXLevd7AkTlL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=jn/dM10djkegtPlL7Sb55El8ON07t/o4IMLGKNU09Wk=;
        b=ohb3Nt08EIIYtOON/dQYFh6M3jQwYtq/Khj/SDQ+IO/kCI4qBTAOt1X8BG9V63nqZB
         tuYeLzR1E6Kyrmwefz2oRKI3PkZdnje5i6RDPVCw0luODu+1aJSvw8gqpqMPkm6sMscU
         NqddC4o29+uhCFsmegVfAJYMgknqcyUtmupaRCqVr8oA4asHsN65kb5qb6hPgpbIqCgm
         Dk+gBXUNB9xBYZwVSwf1gpdQFsoETkxNTLN4YDRFQM+O+tX4GbRQjO5GOadXs4Lm4eKC
         GJ1Fc7yyj+3x80a0zVSJbVAxBXbkrJpTxkiRbxygwuMT5haksM/NGVu9L3jvuMIRfB31
         FPQw==
X-Gm-Message-State: APjAAAXJhpfSnf1FpIHJG8WZ7Uzb2eFV2X2sjkVhMf4F0nXfJSs8lek9
        PSutpheDK+pf+QCHw3kLdQtj7w==
X-Google-Smtp-Source: APXvYqwG6Voqp5ZNVFg2FoYgXTfsgicPu/GqE9QTLsxIXS/jYwIVRk8sK/mKSYh+fnVbkMgwe+fpaw==
X-Received: by 2002:a17:902:a81:: with SMTP id 1mr62618907plp.287.1558729222121;
        Fri, 24 May 2019 13:20:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z9sm3530373pgs.28.2019.05.24.13.20.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 13:20:20 -0700 (PDT)
Date:   Fri, 24 May 2019 13:20:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] net: tulip: de4x5: Drop redundant MODULE_DEVICE_TABLE()
Message-ID: <201905241318.229430E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with Clang reports the redundant use of MODULE_DEVICE_TABLE():

drivers/net/ethernet/dec/tulip/de4x5.c:2110:1: error: redefinition of '__mod_eisa__de4x5_eisa_ids_device_table'
MODULE_DEVICE_TABLE(eisa, de4x5_eisa_ids);
^
./include/linux/module.h:229:21: note: expanded from macro 'MODULE_DEVICE_TABLE'
extern typeof(name) __mod_##type##__##name##_device_table               \
                    ^
<scratch space>:90:1: note: expanded from here
__mod_eisa__de4x5_eisa_ids_device_table
^
drivers/net/ethernet/dec/tulip/de4x5.c:2100:1: note: previous definition is here
MODULE_DEVICE_TABLE(eisa, de4x5_eisa_ids);
^
./include/linux/module.h:229:21: note: expanded from macro 'MODULE_DEVICE_TABLE'
extern typeof(name) __mod_##type##__##name##_device_table               \
                    ^
<scratch space>:85:1: note: expanded from here
__mod_eisa__de4x5_eisa_ids_device_table
^

This drops the one further from the table definition to match the common
use of MODULE_DEVICE_TABLE().

Fixes: 07563c711fbc ("EISA bus MODALIAS attributes support")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/dec/tulip/de4x5.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/dec/tulip/de4x5.c b/drivers/net/ethernet/dec/tulip/de4x5.c
index 66535d1653f6..f16853c3c851 100644
--- a/drivers/net/ethernet/dec/tulip/de4x5.c
+++ b/drivers/net/ethernet/dec/tulip/de4x5.c
@@ -2107,7 +2107,6 @@ static struct eisa_driver de4x5_eisa_driver = {
 		.remove  = de4x5_eisa_remove,
         }
 };
-MODULE_DEVICE_TABLE(eisa, de4x5_eisa_ids);
 #endif
 
 #ifdef CONFIG_PCI
-- 
2.17.1


-- 
Kees Cook

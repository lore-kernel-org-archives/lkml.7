Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0565C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0B921773
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUlu/Uzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfEOMKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:10:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44179 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbfEOMKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:10:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id c5so2367225wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 05:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=04vE/yZS+t9ASvM0Tt3OFkOsi4P5+QK49E2+acvjvQQ=;
        b=rUlu/UzqF/esvoHFPYwpMh1FUQbOvqo/ap9EWcHUkZXAodrJoa4A/WsClM0UxEhqPd
         89uXP2igvjKzeI4J1Hkd3WYqDFy7q33uPxc2HUONPi+7AqmIu+A4ZEBys8tyXcAiAc2U
         fgoDY1VGYNRUFKDU7TJNTJnC8UK9AifnCu8v+6RzQhrID9QsM+xFxw79b3qv01iR+u4j
         ojzpdLQ8ZQf96P2uTac/x15aah6vPsvTGMzU0T/Lzktpgz6WLN0byC4GIaoettlYuPCo
         9E3yRcMBK3+M83PdDgC1RDjydxwsPWcaYqYT04iCsYv6JIcZhmFFAMW6BKad48eiXbD7
         nqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=04vE/yZS+t9ASvM0Tt3OFkOsi4P5+QK49E2+acvjvQQ=;
        b=I2aSokES5lCtYRA7ljKJ+aIhbevqvGhocnEuC7Cms84fbTZxqcAUl9RI0ATKqdfZdA
         1UPHIgBkfYztpjK+5B5ZIFRMUlCvTu6fCyvz6JrDbNJx2rE/dcl758mDJ09Hny7EsqQ+
         O1AMpYDdWB3a+TgVNNJWiNfQWOLuQJRH7o93Vc3QbaQnqiNcoztm+BHZbTN8ci0eibRf
         Vudo2MuTbtUiolhxCbiGK1476VUK+ZwQFFdhDDhFny1COfB7PEXFbV2Y4Wu8MY8o3A7K
         I/wc73UhAC7hefPKwLvQ9iAHkOyGdsgIHtL+mez4ENTr/q8ZygkqCbvuohLdn2btxLYW
         9q+Q==
X-Gm-Message-State: APjAAAWQwjz+twkUp0150Sqrx7P+7Fl/OWZ8Z7+kEig39mNpqRav1QJF
        +8OAsz6uqLVAYUgw6gyNExM=
X-Google-Smtp-Source: APXvYqwqRM2hZ1TYTAPN1pkRiFuk5jR7rSwKxqfJthKIZ+ilEP+0VrWCBasqLIcAE6IScwdALAL4Ug==
X-Received: by 2002:a5d:4b0b:: with SMTP id v11mr24672581wrq.317.1557922201948;
        Wed, 15 May 2019 05:10:01 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id b18sm2126219wrx.75.2019.05.15.05.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 05:10:01 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 15A9A1146D7B; Wed, 15 May 2019 14:09:50 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Michael Neuling <mikey@neuling.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: silence a -Wcast-function-type warning in dawr_write_file_bool
Date:   Wed, 15 May 2019 14:09:42 +0200
Message-Id: <20190515120942.3812-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit c1fe190c0672 ("powerpc: Add force enable of DAWR on P9
option") the following piece of code was added:

   smp_call_function((smp_call_func_t)set_dawr, &null_brk, 0);

Since GCC 8 this trigger the following warning about incompatible
function types:

  arch/powerpc/kernel/hw_breakpoint.c:408:21: error: cast between incompatible function types from 'int (*)(struct arch_hw_breakpoint *)' to 'void (*)(void *)' [-Werror=cast-function-type]

Cast the function to an intermediate (void*) to make the compiler loose
knowledge about actual type.

Fixes: c1fe190c0672 ("powerpc: Add force enable of DAWR on P9 option")
Cc: Michael Neuling <mikey@neuling.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/hw_breakpoint.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index f70fb89dbf60..baeb4c58de3b 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -405,7 +405,8 @@ static ssize_t dawr_write_file_bool(struct file *file,
 
 	/* If we are clearing, make sure all CPUs have the DAWR cleared */
 	if (!dawr_force_enable)
-		smp_call_function((smp_call_func_t)set_dawr, &null_brk, 0);
+		smp_call_function((smp_call_func_t)(void *)set_dawr,
+				  &null_brk, 0);
 
 	return rc;
 }
-- 
2.20.1


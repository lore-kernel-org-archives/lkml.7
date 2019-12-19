Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51D0C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BCC21655
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BO+5mc1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfLSRfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:35:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34148 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfLSRfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:35:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id f4so7542711wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 09:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=nW/VtVXYcqbEdi0n13WAqaTiNKpN7zA1JnbtuO/Ib0k=;
        b=BO+5mc1EonsJLkoNIxNKMLtWBhCtFIMeog9E6Ie5zN6iBJkngWawNPXHgdDgWD4JmB
         DXGvAMhe8OFpBahl+JfigxmOQFOlNM1HQH0hfu5KYFHbfkqTQEWo6KQc1+BjsCSYGe44
         Z6bQO1tC7JAHFI5C4R5/dpeXWHzZfcsw8pp2RTRrlyfvFmdzvduiWP8LF8qDwH0fct8u
         9doKasvNmIfRNyJtSYMrcJ5tfgzJeS4SpOsKONxP8NgGBKn0PHbrD4HZwCqyiRQoyioG
         NORuy751MpoAcNGoIxA6Pkh8Aw+qOXymFZ7bNPeDo/j2UOTUbyukD/LfeQ9xoKAxKkcO
         pEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nW/VtVXYcqbEdi0n13WAqaTiNKpN7zA1JnbtuO/Ib0k=;
        b=iBXSNkUyWCIAOKFhtCwVL7/hUw+5ZkP6ZbZn52bamxgFMX5LpHuFFGT1/7Kl1TUVBs
         g+9nMbHmT/gr4YsRrI3gL+8d4Br1M+znLAIeopMm+X/a9lAPpamw5RZp77IrDdQRav3H
         2d4bqaukb1cBOiImEpQSsDC4WN1bBjq5BnLSvAQesXdT7LbnFklaNtoOo8WbTtsIlNOp
         VRSfuAJb2aTYJcAbJuHfPSR9JrcH6ROrCNEP+OyI+63gTk3faoRmQknlzzX3ULZ8U8Mg
         4XkTQg7lLq+NKNZys2GhysTsw4kHO29fXmEGFZN97ARYxxM12CBB/zbQMaDRYE1Mb20a
         dUZg==
X-Gm-Message-State: APjAAAVzab+Dqg+exkV8kK/D08fCxh5Idgq2QGvHiXr/fhtEjz+HDchc
        1anf4KF1H0T9FH5ws1/adCDwbMU=
X-Google-Smtp-Source: APXvYqxR7k7aM/NQ4z/D0VSrwgYcQeV/3IHUd/IjmLxzZ49UzJXkxGt3hE/itmhWDk8qLJjG9rgIhA==
X-Received: by 2002:a1c:2504:: with SMTP id l4mr11494880wml.134.1576776901086;
        Thu, 19 Dec 2019 09:35:01 -0800 (PST)
Received: from avx2 ([46.53.254.180])
        by smtp.gmail.com with ESMTPSA id c68sm6822187wme.13.2019.12.19.09.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 09:35:00 -0800 (PST)
Date:   Thu, 19 Dec 2019 20:34:58 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: [PATCH] vsprintf: spread "const char *"
Message-ID: <20191219173458.GA4246@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 lib/vsprintf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1550,7 +1550,7 @@ static noinline_for_stack
 char *ip_addr_string(char *buf, char *end, const void *ptr,
 		     struct printf_spec spec, const char *fmt)
 {
-	char *err_fmt_msg;
+	const char *err_fmt_msg;
 
 	if (check_pointer(&buf, end, ptr, spec))
 		return buf;

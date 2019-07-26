Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C819EC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A230F2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mUP5bp4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfGZQbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:31:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43888 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbfGZQbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:31:05 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so17961446pld.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 09:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=/uapPV30FnuKZOrO/m+jPWlWR9noietQQzXlvKFWtUQ=;
        b=mUP5bp4BDhvX9Kpssr8T17MpsFdLah6pAxJ5MAWH71gFIWKSggQPSakLOdtYR4zNF4
         ZW/P5eudklFUK77ocHBWiRLn3aMcU38uxHsul1Xm7j3/Tiaiao2X5rBMnRR6nYb18YPg
         pFCr/Q67E6TnJx7eTRhKBk+R29Tj6EjP6/dbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/uapPV30FnuKZOrO/m+jPWlWR9noietQQzXlvKFWtUQ=;
        b=cum7s9qAIWtgW0yiy1KMTwyI0Od4BndrwAFKtCzINZdq85qeZa48+0nFOMl13xuLNp
         tOfiaYZG5LsVSpQINwqjsU7CLRY588C7R8+rJKW498+vcQUGJrlhkYgfh3cWugJH0Iln
         uNNaOOq+6kXI7R6PS7xvzaBtlNBtgRuGLGFGJZmQYTkA8x5QPHVOBfnxtDpuI98C/Qfc
         YggEZ79yfaxskSInarcCIUTYpdPkpCDkzXIvcm0LoPZznTrWv8AqQrZrDgEVu+Ja+D9C
         vXVI0ueH6K8T48/aB7jS8PQZun5DnuNqAttkVTvTOV7PO5PJPZJNH9zWwdY6FP09V00r
         Rhow==
X-Gm-Message-State: APjAAAX7uwduG9tRoow6cux0u9GHJMHoG0Bpf6/+yIOxYdxhFpTBTF/1
        Q4MYxXkCg3G5KdoyEydn9FHYNA==
X-Google-Smtp-Source: APXvYqyrzAX5xec1X60ADY+BupOXCKep6Mooa/4CsD65Phd1E2IrWJFtk1Zj0jRhyGRx6aBygBW3BQ==
X-Received: by 2002:a17:902:549:: with SMTP id 67mr96837111plf.86.1564158665090;
        Fri, 26 Jul 2019 09:31:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p2sm72905992pfb.118.2019.07.26.09.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jul 2019 09:31:04 -0700 (PDT)
Date:   Fri, 26 Jul 2019 09:31:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yann Droneaud <ydroneaud@opteya.com>,
        David Laight <David.Laight@aculab.com>,
        Jonathan Corbet <corbet@lwn.net>, Stephen Kitt <steve@sk2.org>,
        Nitin Gote <nitin.r.gote@intel.com>,
        "jannh@google.com" <jannh@google.com>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: [PATCH] strscpy: reject buffer sizes larger than INT_MAX
Message-ID: <201907260928.23DE35406@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As already done for snprintf(), add a check in strscpy() for giant
(i.e. likely negative and/or miscalculated) copy sizes, WARN, and
error out.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/string.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/string.c b/lib/string.c
index 461fb620f85f..913cb945a82a 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -182,7 +182,7 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
 	size_t max = count;
 	long res = 0;
 
-	if (count == 0)
+	if (count == 0 || WARN_ON_ONCE(count > INT_MAX))
 		return -E2BIG;
 
 #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
-- 
2.17.1


-- 
Kees Cook

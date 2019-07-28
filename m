Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA0EC7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FD020679
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZlpWLHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfG1Lvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 07:51:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51639 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfG1Lvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 07:51:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so51463955wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 04:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GZSQr/7XGRdedaNZsaOtEAo1JYrfvhe9geQhL0fqUE4=;
        b=hZlpWLHsdscUKU9xSQ2wjcGPgu+N1JZi5+/fnp9fGewhBzGlCxA+zJ71aEPp05Blqo
         smVcJ7BJPqyNp0Eh0O0h/V/T2nsRhl773AEsaDPToInoos8FVB6MWxZbaY2lgPzJ8k+1
         Ujp6fc5tnPcpuqThpdJVUBTb/W/b7eRubqoJBaluldpQAZt+J54ceIagI6Jx7b1sZfTJ
         oRRhJz+DXfGC/EdHVgPpDV/rOI+YlqBWOPl0H/L/RkbzsU/wvM3exsM82N2gmgF1r0lb
         l0M5JHmV71iIKHEe8iKSWw4H5J8dnaYofmJUO886MVrdiL7eGHV8eZeGFGRZZPM0zp4k
         kgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GZSQr/7XGRdedaNZsaOtEAo1JYrfvhe9geQhL0fqUE4=;
        b=CUtwjobhFO4yw16JEIrcKNByzLAxOHR3i4MOaz1MKNeqNE6F1fYb13qQM2BofUdNu2
         6hydwtcHR3VZkTVHbi8iGvzb8CzdAVrSayiNfL8s7zezCst2cbxsZioZYw6sUHmLZl/k
         fOuQwumdYSMN/teBItAZZ9+Gz0MiRf3+kW3sEF67aPiFRdOUwB/h0aLNQUr8O9wr3Mvm
         pAVHLk18hpLy8jicCwMo8WwcSwcfiqf31aiO8BlIVuPuGgHX4GfvfT7QvseObwiP5Ay5
         1kCWpb6SIwa1tTzdh4cpPilX9TmT8ir2RFhJ+UKsIHh6T0Cs3Hk85Cp6pnP3Hyl0bBWm
         LqdQ==
X-Gm-Message-State: APjAAAUwIx7AZPDPH/NNACli3clNx9l9x2pQ1tfzu6gHwdBnwzl3+m0k
        ODnaCtsDo4VVq907Ef7hpEwI84A=
X-Google-Smtp-Source: APXvYqwuXIK9WA7X20t2L43u9u6LEkWzxvH+BeRteJTIGP2rV2liTetm8w7/6qTINaevDA+zwb05Jw==
X-Received: by 2002:a1c:f914:: with SMTP id x20mr16585263wmh.142.1564314703389;
        Sun, 28 Jul 2019 04:51:43 -0700 (PDT)
Received: from avx2 ([46.53.254.41])
        by smtp.gmail.com with ESMTPSA id b8sm75875640wmh.46.2019.07.28.04.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 04:51:42 -0700 (PDT)
Date:   Sun, 28 Jul 2019 14:51:40 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: drop REG_OUT macro from hweight functions
Message-ID: <20190728115140.GA32463@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Output register is always RAX/EAX.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/include/asm/arch_hweight.h |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -6,10 +6,8 @@
 
 #ifdef CONFIG_64BIT
 #define REG_IN "D"
-#define REG_OUT "a"
 #else
 #define REG_IN "a"
-#define REG_OUT "a"
 #endif
 
 static __always_inline unsigned int __arch_hweight32(unsigned int w)
@@ -17,7 +15,7 @@ static __always_inline unsigned int __arch_hweight32(unsigned int w)
 	unsigned int res;
 
 	asm (ALTERNATIVE("call __sw_hweight32", "popcntl %1, %0", X86_FEATURE_POPCNT)
-			 : "="REG_OUT (res)
+			 : "=a" (res)
 			 : REG_IN (w));
 
 	return res;
@@ -45,7 +43,7 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 	unsigned long res;
 
 	asm (ALTERNATIVE("call __sw_hweight64", "popcntq %1, %0", X86_FEATURE_POPCNT)
-			 : "="REG_OUT (res)
+			 : "=a" (res)
 			 : REG_IN (w));
 
 	return res;

Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E39C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 21:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73303218A1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 21:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ER51eV17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfCPVBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 17:01:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45316 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfCPVBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 17:01:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id h99so12973121wrh.12
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 14:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=r99XPAScrpX6udcCOHKSQBy7cEAtCOnECA2rqBxf/TY=;
        b=ER51eV17y1gzRvdFpEH3tkqq2Vf7oMRUNVXUTtU1jYxNGi74PCA/UUhZlYyMtW+GhK
         omKVFIjejk/TtsCNkqmOobU4D2/dqfdfSFKAsXlnjfl04k7iJstjovonfydntvZ7Yw3Z
         fULKoVCKrTjIvKaI2ITcHTJxMJSVZGxJiZjdA4p20nJuO0MIy6XZ8Vd1RhTEDTaWz36T
         vzlYPWtL48XlxpqpW8NGF+DCgXgjAktS16BAuMa0ygMSlQBxsZ9gKZWB1ZAEebq8Q/Kh
         dljTNH8euJG6E6JX6CAB9FLGL+vsvbwot1nxytm9S55uLhZxe5P8W/3NNgAM4J6/2DeW
         k6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=r99XPAScrpX6udcCOHKSQBy7cEAtCOnECA2rqBxf/TY=;
        b=C09HxJ2VwjVjDEqTO/G1B2M+lGSUBWkiFXg61ZiYwlIV+lKH56Mda5kBoDOxLo5XxK
         9NdtfCuZ9z9Uzfr7Z1OsJMdGeRGjL/L0N0LjOkf07j6ii7JYR8uJY/KookS3MjeKMOgo
         kD7HFFdwMtc/C3S7g2EInszJXeAastlK1hYOys2qn3ZYiTWnYv+7L+C14oGo98GoSifn
         KgQJTN0u9vTtivEjvXtVzfij04DO15iPb3rv+Dapxs0HQLN1+8642SZ1yvCNplwKWytv
         IFPcYzpTEI7wbJv4qR+If82dyJ1FzmZ6YZMQuU41lc9pQSMkVj8iM90T6tH5kr/UOwol
         tRfA==
X-Gm-Message-State: APjAAAVjcKLNU2UK4fd7RcXK/PX6n8Ec2snd7Q05TuhUAWSfWqWJgh6i
        EgXAmACjsYEscu/wSNwfgw==
X-Google-Smtp-Source: APXvYqxpBoID8CGQvX4wVqtOvnoDaIUUHADqzBJ8V4wPeYXcwI4rnfLRXHF4ObIaY1Mw5VXcFZOKFA==
X-Received: by 2002:a5d:53c9:: with SMTP id a9mr702391wrw.59.1552770090305;
        Sat, 16 Mar 2019 14:01:30 -0700 (PDT)
Received: from avx2 ([46.53.243.195])
        by smtp.gmail.com with ESMTPSA id z10sm3918561wml.39.2019.03.16.14.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 14:01:29 -0700 (PDT)
Date:   Sun, 17 Mar 2019 00:01:27 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] x86, putuser: add ASM_CALL_CONSTRAINT
Message-ID: <20190316210127.GA21830@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clobber stack pointer given that assembly does CALL.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/include/asm/uaccess.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -176,7 +176,8 @@ __typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
 })
 
 #define __put_user_x(size, x, ptr, __ret_pu)			\
-	asm volatile("call __put_user_" #size : "=a" (__ret_pu)	\
+	asm volatile("call __put_user_" #size			\
+		     : "=a" (__ret_pu), ASM_CALL_CONSTRAINT	\
 		     : "0" ((typeof(*(ptr)))(x)), "c" (ptr) : "ebx")
 
 

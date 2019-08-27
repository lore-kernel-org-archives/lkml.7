Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37061C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C69214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YMViHd8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbfH0Ukl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:40:41 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:34189 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbfH0Ukk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:40:40 -0400
Received: by mail-pl1-f202.google.com with SMTP id b68so120719plb.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 13:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gDvIlxNr8TEoF4pbaoMLzWxO2r6ObQp6ll/9rTpnRHw=;
        b=YMViHd8LC0GbZNZVHrKmW6KGyH8quBNuS8Pd9Rx0mYImtdtmRm11fcVFLOyS+o1alx
         an6UcEqmkeG61I+R9JbATD3nT2oVNcjm5c8KEP/j08Q7d/tThlh5dRDnV7mVA69wTzf+
         T83H0JxAGEA8fRpmAUdYzTEAof+ptRtRDlSpyhdM7SkZ/B84by8Ja21bEDnL9X8T0Q38
         gGp4mxDePqRYjm1p/8awzKlrZMt59cfsc8kt7W05WMIyYkCVX9/KU9CfVrXB3QTx8a2s
         u0nUoOevdadoG6YMEi5JGpAuwax1DoDMUWoi7CzuC8wTI8ziJg3abKGjAgnjKOxGifUH
         JBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gDvIlxNr8TEoF4pbaoMLzWxO2r6ObQp6ll/9rTpnRHw=;
        b=HQwBOA/pYrw0oyErzZXO3iiauLDahwQJ5RL5oNUTzGb1Cwsm9iWYYb1i4XevECZtIb
         Rwp3JB2CuxGejGc9b9tb9jzwnKZHs5Jeo8dZRIGRAc1pNoDDcskFSEuwAKrq8Igh/+zw
         qWXv4CEtFwlp3KmwLiY4EGGrVxbq4rYN7z6EO7eVAX04iKwMfO44r7jthVXXYWyoL8TX
         om6pIwEmtv1f1zyjBUg2ulq70mNLV460GP+ijKMLYNTfQAFixsRP9v6IIrbam9a6XwEd
         S6KOlmasB8KDcbchCmG+GTWXAvgC1CO9yu19CEqRT+CkEsuqtUF3iJ1q1b6ra4sZzr+B
         8KPA==
X-Gm-Message-State: APjAAAVDMFwiXx1d0sCf0dpIZD7kIwzTsWQM5EFe7uvEOLHKDy8o6Q8H
        hIL8FJWEGQ8LUq/0cj8I3SrNgRfQ0F2IoCrvGh8=
X-Google-Smtp-Source: APXvYqx/m/f2ffuqBw8RXgINroqgs3uOhg9hsmbxYRp09akso2pMoDCn12ukZhE4dKfqLDfWUJ+Z1jqUtfjbSoQcLeM=
X-Received: by 2002:a63:9e56:: with SMTP id r22mr265817pgo.221.1566938439399;
 Tue, 27 Aug 2019 13:40:39 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:39:57 -0700
In-Reply-To: <20190827204007.201890-1-ndesaulniers@google.com>
Message-Id: <20190827204007.201890-5-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190827204007.201890-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2 04/14] um: prefer __section from compiler_attributes.h
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     miguel.ojeda.sandonis@gmail.com
Cc:     sedat.dilek@gmail.com, will@kernel.org, jpoimboe@redhat.com,
        naveen.n.rao@linux.vnet.ibm.com, davem@davemloft.net,
        paul.burton@mips.com, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC unescapes escaped string section names while Clang does not. Because
__section uses the `#` stringification operator for the section name, it
doesn't need to be escaped.

Instead, we should:
1. Prefer __section(.section_name_no_quotes).
2. Only use __attribute__((__section(".section"))) when creating the
section name via C preprocessor (see the definition of __define_initcall
in arch/um/include/shared/init.h).

This antipattern was found with:
$ grep -e __section\(\" -e __section__\(\" -r

See the discussions in:
Link: https://bugs.llvm.org/show_bug.cgi?id=42950
Link: https://marc.info/?l=linux-netdev&m=156412960619946&w=2
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/um/kernel/um_arch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index a818ccef30ca..18e0287dd97e 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -52,9 +52,9 @@ struct cpuinfo_um boot_cpu_data = {
 	.ipi_pipe		= { -1, -1 }
 };
 
-union thread_union cpu0_irqstack
-	__attribute__((__section__(".data..init_irqstack"))) =
-		{ .thread_info = INIT_THREAD_INFO(init_task) };
+union thread_union cpu0_irqstack __section(.data..init_irqstack) = {
+	.thread_info = INIT_THREAD_INFO(init_task)
+};
 
 /* Changed in setup_arch, which is called in early boot */
 static char host_info[(__NEW_UTS_LEN + 1) * 5];
-- 
2.23.0.187.g17f5b7556c-goog


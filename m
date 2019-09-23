Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357D9C432C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DC920856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QkV2uEzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503250AbfIWWYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 18:24:23 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:56389 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390460AbfIWWYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 18:24:22 -0400
Received: by mail-pg1-f202.google.com with SMTP id 135so4867502pgc.23
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 15:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=wBbyke/1peveMpLtlqWbxcVdjMGJbQeDIQGAiWlcIhI=;
        b=QkV2uEzl0J91ToT9bwa71ngvkxZNYIMmxnl+jVL0xM3sLqOb8PhAPO36SU43Ejv5In
         x6LOK3aSC0qaPa7IHZ4l8FVTL5oWw3Lr1MyGmUMlqG7upjwfyAwWirWrDZAg5N/LYYSf
         sJIqOLxSa7qJUEZFOg8tGWaHaKsiViBd2Do9CFKmCJc3zRRNOm1/d8lPBjHEXBjpdDd9
         Fwk+WCo0lo7IFC98NB/yvRvIuV1FknfVQ+H860kZ4TR82W+TkSYG18bv+VKm6vi8VGCS
         uR0svdGUeTcC4EXk1bVjWP7XS9IplSM2Zg/7wWMW8FGp5zbqtQ2lLqcSFIyqw4sc0k/x
         3g5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=wBbyke/1peveMpLtlqWbxcVdjMGJbQeDIQGAiWlcIhI=;
        b=LErHaHfDSL4PjdbfvVy/BEH3CtKcsLx6McS0wLpfIz6vJI6t1rpN38a+CsJDW/1kFj
         0VGNst387qVrkXMLW7nYWaWc2YKwwJIWUsLBJs7KpuvRwSqki7+u0RyO0UiHeLpQfUoR
         foXCdaAT5qSCSR/KHOvUlkEIgS8f0EbeMSFLYPfo6oYz805nH1x/5/UdMvHs2FGXPiIv
         mhmyc8toFO8PCOtIfgEqXDD70Sg84dtk2IU8OK3Dr9lmMzHgi9UKRK8K4Y/kma7s45D0
         iqUaKH7jxcmMmzCsXZyqCNwPMG4AmiOxkrnCbTEJXrRLgTziMUsHTw4rULKcFpgYJjLP
         /BIQ==
X-Gm-Message-State: APjAAAW+AO9kIG/w9/tkrF8OVvkP1JCbVJXRMr4taEf2+c/57uI7awpD
        B7tqyEL2JW+cOxzLXFkhqFpN6+t2vH/ufINvGHY=
X-Google-Smtp-Source: APXvYqwclkudlhpDijvGvhUJRap5SXd4lJiUN5+2zLrXyLkHY+XZ6dnG/AS8h9uPn66Uq/2CoeMokkBwIHkGskWq5hw=
X-Received: by 2002:a63:2006:: with SMTP id g6mr2091942pgg.287.1569277461795;
 Mon, 23 Sep 2019 15:24:21 -0700 (PDT)
Date:   Mon, 23 Sep 2019 15:24:02 -0700
Message-Id: <20190923222403.22956-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH] x86, realmode: explicitly set ENTRY in linker script
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linking with ld.lld via $ make LD=ld.lld produces the warning:
ld.lld: warning: cannot find entry symbol _start; defaulting to 0x1000

Linking with ld.bfd shows the default entry is 0x1000:
$ readelf -h arch/x86/realmode/rm/realmode.elf | grep Entry
  Entry point address:               0x1000

While ld.lld is being pedantic, just set the entry point explicitly,
instead of depending on the implicit default.

Link: https://github.com/ClangBuiltLinux/linux/issues/216
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/realmode/rm/realmode.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/realmode/rm/realmode.lds.S b/arch/x86/realmode/rm/realmode.lds.S
index 3bb980800c58..2034f5f79bff 100644
--- a/arch/x86/realmode/rm/realmode.lds.S
+++ b/arch/x86/realmode/rm/realmode.lds.S
@@ -11,6 +11,7 @@
 
 OUTPUT_FORMAT("elf32-i386")
 OUTPUT_ARCH(i386)
+ENTRY(0x1000)
 
 SECTIONS
 {
-- 
2.23.0.351.gc4317032e6-goog


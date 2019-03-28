Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2BAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788EB2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rE0qnyPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfC1OQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:16:58 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41214 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1OQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:16:57 -0400
Received: by mail-yw1-f68.google.com with SMTP id l15so14695269ywe.8;
        Thu, 28 Mar 2019 07:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=s1PNxO9w6P66F4KHKA/rF9ZUedXG3vp7Y93p0h/JBlc=;
        b=rE0qnyPfdPMVZByGli6s9HNBo6aiVYZIrpytKGVE6xoNYpcT8B5/Usu9hYw03obMR1
         L14UXrAHXmiL5tAXahfaEedmOTv+Qx3rCw1ppAnbVAl6TGBAZxdjO2BIhRejFovXFoEq
         BqXnIIG7Q2WHvyQxUoft0FZLJWG9WqfoZFWRpkkQjVhH5QLtlvVJ05AJxGEThmw5PB1W
         vsn9NzyahA79Uf+jN+b7HiVA36zIGULyFWkVgC2HGfBqhKZRwqvitxqjlxI3PiN1hNj5
         fI9ShKLgBrJfcbtHyXs98ZZymm3m2oz9HsQXK2NIhM4m3ZzIwXUtLBXZBAi/Y4+Je5J7
         j3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=s1PNxO9w6P66F4KHKA/rF9ZUedXG3vp7Y93p0h/JBlc=;
        b=RDJ2O3rmuFOPIGDMtrhoeIJqMvEIMfj/UQ8RSYsCgcjRzpiqon51r/DH1WpG+Z0hbA
         RXNhFG07VAX3cfYebAvhQNfM58SgxvltrjLJ+C7sbKPrgeghbvQz7hgWonpkGxshVBFl
         2cNU1p9FJiHveHYE4NoJY+fcnQbK9DpiNWQsr/EAMv0wy7LuklaofarcFtkVOQKz+utw
         vkEZ9UsafF9VjW/gjKPWOrfBYRD6GQp9AGFctdNlwr+KdXd6V5zGM4f7ydybk0vC0UQF
         quomuP+c6npE9zQHEl0U+xSzPLCDFlcguztqZtMupoaff6ZzRUpdHtGdBmFSwNKs8XSf
         Nd0Q==
X-Gm-Message-State: APjAAAW9hbAFQ7JgrHJPGgRsLLav/vvkzJ1jUoopTIsvx5tY0IR2ZnlX
        snC/uk+5ya11TycJ32Y5vX8=
X-Google-Smtp-Source: APXvYqyVsAz2EwP0CmOJ0F2nvDGNEFWLFg4ADLXr8vRnUaqxBVjIOnqYWKK9stEcsCZh3ENoMJPR4g==
X-Received: by 2002:a81:178c:: with SMTP id 134mr37022676ywx.480.1553782616680;
        Thu, 28 Mar 2019 07:16:56 -0700 (PDT)
Received: from yubo-2 ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id t71sm17023324ywc.4.2019.03.28.07.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 07:16:56 -0700 (PDT)
Date:   Thu, 28 Mar 2019 10:16:54 -0400
From:   Bo YU <tsu.yubo@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, jakub.kicinski@netronome.com,
        df@google.com
Cc:     tsu.yubo@gmail.com, quentin.monnet@netronome.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: bpftool: convert =?utf-8?B?4oCYY29uc3QgY2hhciAq?=
 =?utf-8?B?4oCZ?= type into 'char *' in assignment
Message-ID: <20190328141652.wssqboyekxmp6tkw@yubo-2>
Mail-Followup-To: ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, jakub.kicinski@netronome.com,
        df@google.com, quentin.monnet@netronome.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20180512-62-03f98a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with check flag: make -C tools/bpf/bpftool/
gcc will warning:

jit_disasm.c:119:29: warning: assignment discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
   info.disassembler_options = disassembler_options;

So convert 'const char *' type into 'char *' to fix the warning.

Fixes:3ddeac6705aba(tools: bpftool: use 4 context mode for the NFP disasm)
Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
 tools/bpf/bpftool/jit_disasm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index 3ef3093560ba..40b46e46454a 100644
--- a/tools/bpf/bpftool/jit_disasm.c
+++ b/tools/bpf/bpftool/jit_disasm.c
@@ -116,7 +116,7 @@ void disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
 	info.arch = bfd_get_arch(bfdf);
 	info.mach = bfd_get_mach(bfdf);
 	if (disassembler_options)
-		info.disassembler_options = disassembler_options;
+		info.disassembler_options = (char *)disassembler_options;
 	info.buffer = image;
 	info.buffer_length = len;
 
-- 
2.11.0


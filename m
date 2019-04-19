Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E014AC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2132171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0JjnRmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfDSUDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:03:48 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:55413 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfDSUDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:03:48 -0400
Received: by mail-wm1-f47.google.com with SMTP id o25so7235040wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 13:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=HkaUUMEyE0J/2pYdvNujrPvD1ZnFsAgpHeniNz9TYHw=;
        b=u0JjnRmKVihQG3XKPOpk/gPpdEVZbmqIBIofo/ikwQERLk966uEPRqTgcsh/9D+olj
         8pkNFWx6w1ylDPPCkP6kKHYhrFosAzEpu+u5rRZ+EeOIVr7bZ7CHvYaHHndL8i2xDIxz
         g+f2ijNActxMeTMEkZMUozpY20c7XwdKPN+REHKrG0cTtPIpbfpHxphh+7TNQeirbyBA
         FV6P7uH+2TKldM3b/bjUb6YGc5P3WSfT5YnO832tw83GEJdY9oHLwnQtFlwxS4k6r4j0
         6UKWdmhYQ2KqXdWyU9szF/vUuutl0AuX9wPyDw2k+nbOrB0tpnCpfPpoYM1bq3kvQxqO
         DGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HkaUUMEyE0J/2pYdvNujrPvD1ZnFsAgpHeniNz9TYHw=;
        b=s7Tgk0yZCnYXS4OnRl4mc95S6Xxqj0XrnuaX0t+cYb0d+tHGlewzyhYgMIKQvcAeC9
         wZF0daSUHvtKC4DCGDnc28C743QYnVqneCZHbiMNTrlvXJ1WJ+QdKfvtm1lRo1whgD05
         PTyKd2GZthK4NDHkXVsUTLZssmtwlnUeKiAYAV9iqUs7H+um2zMJfe58vstdWo4DAYyI
         eiDUqBQ8PgfUUPbpxxH41Pq2jX6MikEtB7WoX/lc0Vyx78sIkWt9YsKYPXhHvnUwHIFk
         W9duoVh9zzksJSc6qsmrHgXjZ9WlahWKEwwCnSxDkbQ+39BnAIgIccRuquV1k3ZCUPz0
         us4w==
X-Gm-Message-State: APjAAAVRZvaZSjyye/O5riu8/RhbtsXxcqczm9/ZLQdE0bfJKOJsvWyr
        gfdkZyrwSwMXMfMesSY39hoSuW4=
X-Google-Smtp-Source: APXvYqyvEjNPpahCGjREsMJ6DP/7Y5y0i1vbMQqIJXAlEvMnRz17iOezcNaEtIg7KvFw9qI+PT3y1g==
X-Received: by 2002:a7b:c257:: with SMTP id b23mr3670763wmj.83.1555704226473;
        Fri, 19 Apr 2019 13:03:46 -0700 (PDT)
Received: from avx2 ([46.53.241.77])
        by smtp.gmail.com with ESMTPSA id s1sm4354112wrt.43.2019.04.19.13.03.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 13:03:45 -0700 (PDT)
Date:   Fri, 19 Apr 2019 23:03:43 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH -mm] elf: init pt_regs pointer later
Message-ID: <20190419200343.GA19788@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get "current_pt_regs" pointer right before usage.

Space savings on x86_64:

	add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-180 (-180)
	Function                           old     new   delta
	load_elf_binary                   5806    5626    -180 !!!

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -704,12 +704,12 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	unsigned long start_code, end_code, start_data, end_data;
 	unsigned long reloc_func_desc __maybe_unused = 0;
 	int executable_stack = EXSTACK_DEFAULT;
-	struct pt_regs *regs = current_pt_regs();
 	struct {
 		struct elfhdr elf_ex;
 		struct elfhdr interp_elf_ex;
 	} *loc;
 	struct arch_elf_state arch_state = INIT_ARCH_ELF_STATE;
+	struct pt_regs *regs;
 
 	loc = kmalloc(sizeof(*loc), GFP_KERNEL);
 	if (!loc) {
@@ -1159,6 +1159,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				MAP_FIXED | MAP_PRIVATE, 0);
 	}
 
+	regs = current_pt_regs();
 #ifdef ELF_PLAT_INIT
 	/*
 	 * The ABI may specify that certain registers be set up in special

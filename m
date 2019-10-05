Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7081EC47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 16:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8442245A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 16:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTNXP2y4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387573AbfJEQux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 12:50:53 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36305 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfJEQux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 12:50:53 -0400
Received: by mail-ed1-f67.google.com with SMTP id h2so8740706edn.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8t10/oNSB0tF81S5vbfYl/G2BwRqE2Dvckh7dZl88DY=;
        b=LTNXP2y4yWUk2TapTglsy68qwlt2sKh2vZ+3jeQPaND6toP/11xWCgwXlXWkMyBgPm
         5l2suvOciy3ImSmoebYaK26Q06h06w2DKWQn3wdXtOjak9hLSHoF8tIe+C29/+s0vPQF
         5Zg1ZP6idqkj9NEXp9ImQnQdF6L0tUUhIbm05tdjKwsHqi1op52epZuLR82iMamLOyad
         dPWSg0td7XlrckIh2lmnMsQzR8kLFmczpPCRj6nh054Maa09gIU2JQWFmFoduCGyU2Ow
         VjWp8rBS6iZJb77ITDNNUduN+fF+jOMFnrWCZnAyV0en2pNSdF2CM+J2rhnZaGXgg2gQ
         42sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8t10/oNSB0tF81S5vbfYl/G2BwRqE2Dvckh7dZl88DY=;
        b=XznjSOl+/xZu10KFgyCVGriq/HBN7zUwEAnS7VtGu+8ccRsUIuLj3O9M8Zt+yrYjO9
         YcN+nm+S9GYIZdc+GVk8m6c6Oe2lSt14sQ9pmP2tuPoecTdB0bt0jlCbxdebtWqmjzAC
         tzzVqChXYJLnLBQj3AoRmfLEUfaNxiePBu4KUpxdf0/EutGkwqXzpHvUS1nEXvZ3zra/
         6jcLd3ayVQo9XrpPANbKE07RNTBXKNMFYsHgpjrj/AZylYSSLGUsHTiafvxwX53aBCBA
         FETkkPxm1cijcwTWewQhPxt706rAb89aB6RZTRkTYuRlJp4JFv86AizdrUhuf/Oq/spl
         aApg==
X-Gm-Message-State: APjAAAXLGWrGT4xvxKftNnl5W5rf8l6g9dnDJqppHYk+LOhuibLZIBsi
        8HdMzrwwZ6Ay8DMldyxs0+NtZrs=
X-Google-Smtp-Source: APXvYqwVoTJsOoAqrBIVDpmx9/grM9mLL7YwRjBfkr3enhsgovwij+/QTv/4eT4t2vsyBmx4LiqKGA==
X-Received: by 2002:aa7:c555:: with SMTP id s21mr21255907edr.151.1570294251552;
        Sat, 05 Oct 2019 09:50:51 -0700 (PDT)
Received: from avx2 ([46.53.253.60])
        by smtp.gmail.com with ESMTPSA id k40sm2061533ede.22.2019.10.05.09.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Oct 2019 09:50:51 -0700 (PDT)
Date:   Sat, 5 Oct 2019 19:50:49 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] elf: delete unused "interp_map_addr" argument
Message-ID: <20191005165049.GA26927@avx2>
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

 fs/binfmt_elf.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -544,7 +544,7 @@ static inline int make_prot(u32 p_flags)
    an ELF header */
 
 static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
-		struct file *interpreter, unsigned long *interp_map_addr,
+		struct file *interpreter,
 		unsigned long no_base, struct elf_phdr *interp_elf_phdata)
 {
 	struct elf_phdr *eppnt;
@@ -590,8 +590,6 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 			map_addr = elf_map(interpreter, load_addr + vaddr,
 					eppnt, elf_prot, elf_type, total_size);
 			total_size = 0;
-			if (!*interp_map_addr)
-				*interp_map_addr = map_addr;
 			error = map_addr;
 			if (BAD_ADDR(map_addr))
 				goto out;
@@ -1061,11 +1059,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	}
 
 	if (interpreter) {
-		unsigned long interp_map_addr = 0;
-
 		elf_entry = load_elf_interp(&loc->interp_elf_ex,
 					    interpreter,
-					    &interp_map_addr,
 					    load_bias, interp_elf_phdata);
 		if (!IS_ERR((void *)elf_entry)) {
 			/*

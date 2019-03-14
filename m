Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1855CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FD020854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZGaCfqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfCNUuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:50:46 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:33325 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfCNUuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 16:50:46 -0400
Received: by mail-wr1-f54.google.com with SMTP id i8so7370449wrm.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 13:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=L1aIJrlErpapvrR97G5FT5eI0I42BD3UFhXj0vyyRcM=;
        b=QZGaCfqAmofFeAsN/QD8gqT6liKvcOeZF7ywJKULztWanbfAF/KIBBAbBp9hI3xWEK
         n04AyVWNh5pPaLG1PWB8rN2wUHzZL7SalZWG2hbnkkKf/Om65II1mPCfhHeAIZWOkRU0
         Lbkg6pL3MDqQFxUDLFM+f8K0drQ/rSF5FKxEaeKWd+EHxQqrRV3E9HFdD5DZGquMrO3D
         awDe2Ysrjl6W3GH5alhasOwwxkUmQt9o/0+ByNy20Pd69TuSbqTlzWR8YFmL0HSCv+Fm
         Q6Il4ehAq/TdYV8M1uL6CLkRSJ0ljNfhoi45vcWe7ahhN1+3bj/0SOELpS81T0ta7BfN
         pO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=L1aIJrlErpapvrR97G5FT5eI0I42BD3UFhXj0vyyRcM=;
        b=pIXkHvyb/2xNkVtZGPdayvK+iDrUtLYAXk3G40m8MqIqT6fYsFXJZClfcOVo9jZGPp
         C/G5G5peIFSY68hOZjo/zR2rFJ3FYAzRxexfPp2d0xgIndjfAbUYCJsm9b1uHkRx63Y1
         y82E73Z00RgbYjmUswTXuJjK7AzqVikg9sMhfsP3lMV3dZL5nn7ehlmQAVTOA5kYc8QX
         N4O62tMgxob4IINSvUS4Ny0OQ/nBZol621D7s5qCALUzH1FAN2Phdb48HgCpdUb9QjdL
         0TQH7iGyR+UndTBg7oCTMHqimEyQq0CJTXh+h9gPXGa041uemIt6bVcbmA2un86Ocx4+
         VNdg==
X-Gm-Message-State: APjAAAWXeYK3IMM+AmNoFBKDQ2uyWuaj9d+2nOjXnE6scgW4jZLhGjxw
        5sLRSznUWJKyhtPKAqYF+g==
X-Google-Smtp-Source: APXvYqxqWeLhWH54IWd7yfu9NG/pXvlyqlmaVWhpQ6IPCQ7oxEAAGM4eiY00N4qz/lHOjSviO/MskQ==
X-Received: by 2002:a5d:5392:: with SMTP id d18mr28813540wrv.274.1552596644684;
        Thu, 14 Mar 2019 13:50:44 -0700 (PDT)
Received: from avx2 ([46.53.246.8])
        by smtp.gmail.com with ESMTPSA id h126sm263601wmf.2.2019.03.14.13.50.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 13:50:44 -0700 (PDT)
Date:   Thu, 14 Mar 2019 23:50:42 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] elf: delete trailing "return;" in functions returning "void"
Message-ID: <20190314205042.GE18143@avx2>
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

 fs/binfmt_elf.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1456,8 +1456,6 @@ static void fill_elf_header(struct elfhdr *elf, int segs,
 	elf->e_ehsize = sizeof(struct elfhdr);
 	elf->e_phentsize = sizeof(struct elf_phdr);
 	elf->e_phnum = segs;
-
-	return;
 }
 
 static void fill_elf_note_phdr(struct elf_phdr *phdr, int sz, loff_t offset)
@@ -1470,7 +1468,6 @@ static void fill_elf_note_phdr(struct elf_phdr *phdr, int sz, loff_t offset)
 	phdr->p_memsz = 0;
 	phdr->p_flags = 0;
 	phdr->p_align = 0;
-	return;
 }
 
 static void fill_note(struct memelfnote *note, const char *name, int type, 
@@ -1480,7 +1477,6 @@ static void fill_note(struct memelfnote *note, const char *name, int type,
 	note->type = type;
 	note->datasz = sz;
 	note->data = data;
-	return;
 }
 
 /*

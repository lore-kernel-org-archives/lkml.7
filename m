Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D5FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D87218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZH4g4fY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfCNUrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:47:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37643 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbfCNUrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 16:47:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id x10so4042345wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 13:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FAE+gefVvzzjbgtQgDTkJ8IwCdhFztZoHPrcP5qMEsQ=;
        b=BZH4g4fYE4gGxzV6H0i/+AaCUIGknGXBjx+qC6ZFNNiyxEN2QQs1hR8LZxxMz3DsKa
         B/LOMY0Fa0hJlyVjE2uyie312qtvb2B6SC5jPKFVAeZKz6C7O5/h9lpAFBqip+xiDcH2
         PKjlEBXMYr7gxRcDvFKyfbf0cyP/ySjAxqVfhIrB+tIswAYoS/1YOjK3+/TjYu+s0oCS
         y0QoU/5cKpjlkJvT1GDwfqpfMzfFEjxvT310pSQDSjb/0k30IQj35tkNj5oXe7fW4W39
         6XzEaiR+fJt4epalqkkS7WLmQ80YUa+QjwdTuSDbt9vwhXXY1Sw18tlbvVFiIfqK7wtK
         pIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FAE+gefVvzzjbgtQgDTkJ8IwCdhFztZoHPrcP5qMEsQ=;
        b=kuPifQQbfD2UPzhuPEq0xs0zEU5nWAzlOYraVz5YFdTeQvaQfxcfnU1lTyCTl4dHIg
         7g30O4UhK1hKhBK00s9mp/IfbsoopmtsNFWLof07YDurTaDJn7ntUDkD7HsvMvIASVEi
         nMb+MaIwV/6TLKLKwbr8uMUbucw6tsjbtKuX0d+T2AM6QmnJnTJbswdDQO/W56LEm8WF
         YO4CepLjzO9SDSowHnoiaRZM8RkyqbpiWEHMYMrVi5WCQxAFnaNOgn+Av2dXea8cSWnS
         4HKzXe3pnyKbfiFXFqdRTBWLdkyoIgk8zdKZzsSS/5fVwe0MAotuX8KDPtk+8E2xD1jK
         wD7w==
X-Gm-Message-State: APjAAAVLZVk3+K3MsKypJOHjz3H0MkSTJBnm/UUl3FAI+zgsp/023FX6
        Cb6xCvcLCY5mgXUFuerc8g==
X-Google-Smtp-Source: APXvYqwZ+RmikgdtLgMhVL9B09yW45Rurp1G+MQfyJsQiwUzaw45IisyNHDWj8/ApJCUTCHUO4cigQ==
X-Received: by 2002:a1c:cb86:: with SMTP id b128mr260680wmg.46.1552596429592;
        Thu, 14 Mar 2019 13:47:09 -0700 (PDT)
Received: from avx2 ([46.53.246.8])
        by smtp.gmail.com with ESMTPSA id s12sm11785996wro.67.2019.03.14.13.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 13:47:09 -0700 (PDT)
Date:   Thu, 14 Mar 2019 23:47:07 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] elf: make scope of "pos" variable smaller
Message-ID: <20190314204707.GC18143@avx2>
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

 fs/binfmt_elf.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -703,7 +703,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		struct elfhdr interp_elf_ex;
 	} *loc;
 	struct arch_elf_state arch_state = INIT_ARCH_ELF_STATE;
-	loff_t pos;
 
 	loc = kmalloc(sizeof(*loc), GFP_KERNEL);
 	if (!loc) {
@@ -743,6 +742,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 	for (i = 0; i < loc->elf_ex.e_phnum; i++) {
 		if (elf_ppnt->p_type == PT_INTERP) {
+			loff_t pos;
+
 			/* This is the program interpreter used for
 			 * shared libraries - for now assume that this
 			 * is an a.out format binary

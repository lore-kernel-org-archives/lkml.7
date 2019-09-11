Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9826EC4740C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 04:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB1F21D79
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 04:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJdFUC3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfIKEyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 00:54:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39270 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfIKEyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 00:54:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id bd8so9600723plb.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 21:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5gcsHX1jM73NrhKsXACQeSTphDjoPn7GsPpfGO2Qoek=;
        b=GJdFUC3yNvSWX58n2jkWy5f1Y/EheqUE8tLAB1NUkxjQpa6GRAgCQHlFRmINhLM5hL
         Ww6LUqH4F9EdY9DxaWKX7fjpG0u93sLSZQXj+tftl99JYdFH9N3ixuQRkngP15Fk1w18
         WsFhfuEfCz3TSweZ8YZ3yJgVXv6QHwhFWpLA3Jmm6dtQ0W4IVhrKVtk2KsueNC1XGbxX
         zqxzj+cf6gxTztp1d5sS6Awnz023Y9YhgS13/4vbX6ReYOJOV3A/AzwHrB3F2C5n6tgY
         HKsXAnKDz1mU/mLeALbgdJFgTFV2gIjUxkCPyHDf6KHSE11EOffWbAqZ/3I1poWZREN9
         215g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5gcsHX1jM73NrhKsXACQeSTphDjoPn7GsPpfGO2Qoek=;
        b=EjDJfDcYmO32jXKZGvaoO/OswkISqQJHhAX0vPEi1YXALKxU5Z0RBS18qLheO6zR8R
         iqOZ1W8ZEf3GHMeOVkj+NBazmf5JmJCRfe3LaVEUAqZoYRdJhUwSPLgf0Q0uzFNcvqgs
         EA//E/2nxBeAyG20WwY1/CNoCJVKNyOguYQbn5Wltz7CUckSEtauINBIVx5NbmvRZMEb
         V+7WAouGjx5zDpatDi46vaijPAgYMrcZqQ72kY+mRxPK5mLpZk+XexT/Pe+iM5L99yFz
         2NzedKyimLKfg6c+iAf9lQd3jpWyeO6ERyrhPqglIWKYdqCmFjDaIW1ahVe6CgCx7z/K
         XYqQ==
X-Gm-Message-State: APjAAAXt4LvAON9ATbLagYqPZngZW1hvuNYAE+RtBBmyoYHnMyW5Iroa
        7JqFgadO5wZkTAZNkZQUAWY=
X-Google-Smtp-Source: APXvYqx+WwrQ59WbRKhxTrX038bhtsCNOaRLTsvfuuiIzJUW1ROpG1neMcP2+anS++fR5Cmt/auYPg==
X-Received: by 2002:a17:902:36e:: with SMTP id 101mr33406340pld.51.1568177653661;
        Tue, 10 Sep 2019 21:54:13 -0700 (PDT)
Received: from LGEARND20B15 ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id v23sm610304pfe.85.2019.09.10.21.54.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 21:54:13 -0700 (PDT)
Date:   Wed, 11 Sep 2019 13:54:08 +0900
From:   Austin Kim <austindh.kim@gmail.com>
To:     linux@armlinux.org.uk, allison@lohutok.net, info@metux.net,
        matthias.schiffer@ew.tq-group.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        austindh.kim@gmail.com
Subject: [PATCH] ARM: module: Drop 'rel->r_offset < 0' always false statement
Message-ID: <20190911045408.GA62424@LGEARND20B15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since rel->r_offset is declared as Elf32_Addr,
this value is always non-negative.
typedef struct elf32_rel {
	  Elf32_Addr	r_offset;
	    Elf32_Word	r_info;
} Elf32_Rel;

typedef __u32	Elf32_Addr;
typedef unsigned int __u32;

Drop 'rel->r_offset < 0' statement which is always false.

Signed-off-by: Austin Kim <austindh.kim@gmail.com>
---
 arch/arm/kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index deef17f..0921ce7 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -92,7 +92,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 		sym = ((Elf32_Sym *)symsec->sh_addr) + offset;
 		symname = strtab + sym->st_name;
 
-		if (rel->r_offset < 0 || rel->r_offset > dstsec->sh_size - sizeof(u32)) {
+		if (rel->r_offset > dstsec->sh_size - sizeof(u32)) {
 			pr_err("%s: section %u reloc %u sym '%s': out of bounds relocation, offset %d size %u\n",
 			       module->name, relindex, i, symname,
 			       rel->r_offset, dstsec->sh_size);
-- 
2.6.2


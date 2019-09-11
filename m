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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C24ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 14:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D2820863
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 14:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiDNR8b5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfIKOQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 10:16:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37350 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfIKOQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 10:16:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id y5so11004020pfo.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 07:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pwI9Nj5vtGdzn5MvkjXpV83BoYE5sMntyDtos1t7hrk=;
        b=MiDNR8b5UQcE1rhM2uCd+Ka3gMWU2mmQI3g2DJQitzSEzCa3o69gPLwbEV4gi5T6Ci
         DKGVUEN1MPAqhyT22ldAeym832I0wB5sS0q3nq6kMoHqxbhJQv3PeOxASPkIQn8QBDOy
         u24zd3weX7xY/4kFfPk5R8bLtZDL7WU8/78TQifzn1tAi89M9r2m4C4KP/Q4FyD4wvRD
         QVoJE5Jfkbb9tx+uRV1ZxtD3GpQeSPx4pGzPP/8vG2EwfD4drfaMPxW9b7wdXUFkxoKL
         wGG+tdDcIq+9T9x5CvAjLEdndm9y2y65YlgrPD05+ZXStDrhdSP0WYw9rrI0DFN8hkwH
         jBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pwI9Nj5vtGdzn5MvkjXpV83BoYE5sMntyDtos1t7hrk=;
        b=bLxJzn+scNGnemtxBj0PZqbx+Yf/QJq/MgRL9SQF5I4HGXbvb7b0iY2A/CU5JGcXd3
         tY0GMdQzeB4OhM8P578W1/IR8vTLKRq5DyPumVlsAN54VUdPodSIgivWxi0mWMZ/MnGr
         6zin/BNQCv69an5yAWtTtYeN7vOw8j4XE0NQ2t1vZPHfDLOAArDxRdBhSCVZVCp9iPrW
         fDhqY3URI4ZV80k+KaUvJHxhhZ2TFolEDhO0a4Ye/YLpXaDKNUAH0UJNPqj+Xn53f2OA
         PWzpvv1H/bo+3kQpDkSJR2Mjn+iStwanF4qy3KBs9o0GZYgghUnlxaaJpS+viV8TAfT8
         gg4g==
X-Gm-Message-State: APjAAAWoAH5yUbvFU+qrGpVFKsz8ZmFf7kqQdYaZaIddhH9CEP5HlOhP
        eF8z8Ntn/5jSryb8tRYv9o4uNTKiLGciCQ==
X-Google-Smtp-Source: APXvYqxoFjgTMSHcF44EumRFFrggEjZ7D4/eizzE8mBrEw4K/LE8gZAeoQzVxY5OLRmUt8D4UlDoKQ==
X-Received: by 2002:a17:90a:ae15:: with SMTP id t21mr5781382pjq.50.1568211362448;
        Wed, 11 Sep 2019 07:16:02 -0700 (PDT)
Received: from raspberrypi ([210.183.35.47])
        by smtp.gmail.com with ESMTPSA id w13sm23185858pfi.30.2019.09.11.07.16.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 07:16:01 -0700 (PDT)
Date:   Wed, 11 Sep 2019 23:15:55 +0900
From:   Austin Kim <austindh.kim@gmail.com>
To:     linux@armlinux.org.uk, allison@lohutok.net, info@metux.net,
        matthias.schiffer@ew.tq-group.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        austindh.kim@gmail.com
Subject: [RESEND PATCH] ARM: module: Drop 'rel->r_offset < 0' statement
Message-ID: <20190911141552.rtpdazx3ekfgsh3v@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since rel->r_offset is declared as Elf32_Addr,
this value is always non-negative.
typedef struct elf32_rel {
  Elf32_Addr    r_offset;
  Elf32_Word  r_info;
} Elf32_Rel;

typedef __u32   Elf32_Addr;
typedef unsigned int __u32;

Drop 'rel->r_offset < 0' statement which is always false.
Also change %u to %d in pr_err() for rel->r_offset.

Signed-off-by: Austin Kim <austindh.kim@gmail.com>
---
 arch/arm/kernel/module.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index deef17f34..f805bcbda 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -92,8 +92,8 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 		sym = ((Elf32_Sym *)symsec->sh_addr) + offset;
 		symname = strtab + sym->st_name;
 
-		if (rel->r_offset < 0 || rel->r_offset > dstsec->sh_size - sizeof(u32)) {
-			pr_err("%s: section %u reloc %u sym '%s': out of bounds relocation, offset %d size %u\n",
+		if (rel->r_offset > dstsec->sh_size - sizeof(u32)) {
+			pr_err("%s: section %u reloc %u sym '%s': out of bounds relocation, offset %u size %u\n",
 			       module->name, relindex, i, symname,
 			       rel->r_offset, dstsec->sh_size);
 			return -ENOEXEC;
-- 
2.11.0


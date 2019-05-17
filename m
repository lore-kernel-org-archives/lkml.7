Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0632C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D08820868
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDr7/lKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfEQI0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 04:26:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47032 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbfEQI0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 04:26:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id y11so3312180pfm.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 01:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3ii3urujYGVVyIDraN70rev/XODhbjkZr5+BEyKlbDU=;
        b=IDr7/lKglqdHsGzVnubyhU2QO5rVQxhkW/MANbgk05yD28L6NUEdgKUm5h+JrRQeOE
         EhMdnDhkgmMczul7077EXJDZIF9fagBjdJcyA+105Xu1kcDw50sN9EOaIx1uXDdeqFdk
         fd5JQbXvkqtY2x0b1CLuMmq2voBVDYR1UNzqUke3TQ2+FrxdxKToMv896+Vq7nCuia0V
         d3/o5uDUbIWqECX7m5C/popc6bTPelmCA0e6rfZVYldSVeGwx7H+iDCc8YwaAEH1zb00
         +DEcn8a3Mc4ogSqycITCDl7ANG44ZGJokG8DQry1GHCzuIzXuT7K+Ht8I4+b+o6qFE2a
         RgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3ii3urujYGVVyIDraN70rev/XODhbjkZr5+BEyKlbDU=;
        b=Ia9joT0ok4GlGRbk+850uQ1ALMdNbDPK7G0awTOcpc5EVJyeu99vaTjIXYlNSEJQ4l
         NXffYR25Rzob7cpHGEUaMUKr1Gyt5A7X7Hvs/A7QRTe12Pc8qquaj7ee94CZ+5iIJ4Lw
         CiyBRr2y/V+58qZEVdtcNEVRf2Zb5qJAC9wOmn07D4LxVO0nLfu7N4dngIy69KtLWDdd
         HlaEXzUN8Slj5U1re3EU9/14K7SokiGMBiv3ed5M60NM5PZ9Iq+6tMihlHRYtE+ruru1
         Gj+Rpoqu7+2bClzl9TC51jA2KSZ+x5r+XKOLWa0XSxa/zhL7CbjLVmPmjf8zpVMiUohb
         I4BQ==
X-Gm-Message-State: APjAAAVoB76FrgQqQCkavMLS3W+JdYHO0OJ9Yv42mZZOoApa/LxJqFXs
        Kz0SMOIwfvnveMFROKjU8nG3kC1IQjg=
X-Google-Smtp-Source: APXvYqz9nrUQmFl9lvrOxqgmIRPI4b0G396uDlRR3vxBDHu/SdZMxg7PPB6QZQLNCetIRT3Cwx99Cg==
X-Received: by 2002:a63:231d:: with SMTP id j29mr29530998pgj.278.1558081605760;
        Fri, 17 May 2019 01:26:45 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id d15sm10977168pfr.179.2019.05.17.01.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 01:26:45 -0700 (PDT)
Date:   Fri, 17 May 2019 16:26:33 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     ard.biesheuvel@linaro.org, dvhart@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] efi_64: Fix a missing-check bug in
 arch/x86/platform/efi/efi_64.c of Linux 5.1
Message-ID: <20190517082633.GA3890@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

save_pgd is allocated by kmalloc_array. And it is dereferenced in the
following codes. However, memory allocation functions such as
kmalloc_array may fail. Dereferencing this save_pgd null pointer may 
cause the kernel go wrong. Thus we should check this allocation and add
error handling code.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

---
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index cf0347f..fb9ae57 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -91,6 +91,8 @@ pgd_t * __init efi_call_phys_prolog(void)
 
 	n_pgds = DIV_ROUND_UP((max_pfn << PAGE_SHIFT), PGDIR_SIZE);
 	save_pgd = kmalloc_array(n_pgds, sizeof(*save_pgd), GFP_KERNEL);
+	if (!save_pgd)
+		goto err;
 
 	/*
 	 * Build 1:1 identity mapping for efi=old_map usage. Note that
@@ -142,6 +144,9 @@ pgd_t * __init efi_call_phys_prolog(void)
 	__flush_tlb_all();
 
 	return save_pgd;
+err:
+	__flush_tlb_all();
+	return ERR_PTR(-ENOMEM);
 }
 
 void __init efi_call_phys_epilog(pgd_t *save_pgd)
---

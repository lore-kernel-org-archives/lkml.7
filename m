Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3270EFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069FC2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KXn3cyGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393680AbfJPPYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:24:10 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:45601 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731357AbfJPPYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:24:10 -0400
Received: by mail-il1-f195.google.com with SMTP id u1so3019639ilq.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 08:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=m6YvTC56tPty4UucunSEA15cVT7bFCmaoiGJUpQ0cBw=;
        b=KXn3cyGteTFQOdBxy4js14JQAsqJPlqSpcTTlnW9WRZKJpxck4oF2gh6Z54q3qAY39
         zQ21uHEpi3HJD3nJX7mI4Z4wc29Gd5mVNjHdciFBnLUC/FADeeeAJcROeCjHYxddvWiL
         wfZb2QQKN8V7+l+JMfr9lUa9AiELF/jFtTN8PbfPa9kSf3r7aGB3m3fbMNMW+mo5/p6t
         mdFUKJRwXPzGoMAXZ/VS9CU+8I1+f516eyUfAN9JYiqalyO9Zr4GSUA2MjpB7d5OC2nH
         HxdZ2LCcvugonljcCw9SCMuDq7T/G9mZOEuvpctUP/UGF+hPewnih3CrluZOlY56VDgA
         j5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=m6YvTC56tPty4UucunSEA15cVT7bFCmaoiGJUpQ0cBw=;
        b=pPAQlarAa6Be1IpQTRWYKsURYLf/99nsmrpnOtM3N/U+tNJ4tPaRZ/klJeoWSdf+Av
         YRdWGBLKc16VRt8Co6vo4RD/YxncNLytZRo2Df6sz27+h46do6bZLQKk8kbYhjBWbwCZ
         ftMN+UDj0lz/znMLcizqMdaSoVLmIEkVzXiDRmC4DLaY9VhV7dZsRKeFfVaLSRNRcrwT
         wzYwCbHWoqmKjfCOl4+a+K0/RkEZ0Ng59NAqDseFBdiObzxSJP/5jWuNIkYuthtRUl/0
         eE5p3kOJgL67VRPl+7abfyvpbnJ8w+KmT216Mu/XsZA4Um+SUtqfCByIjVAimdqdA6j9
         XXaQ==
X-Gm-Message-State: APjAAAWK3RDeMmpWPIHZzx34tjXC/s76+PZtsZfW6+SlqSlhOKtmwWXW
        hrn0tHM3rbi7pRa6V7u/CxPbbw==
X-Google-Smtp-Source: APXvYqxLZ9xD/GF9/M3Jsq4zVM+6GSCwzw+b2YJNe+PuhGX5MtpISsN2Zeth+fX0y3aQ+7BE8iV8DQ==
X-Received: by 2002:a92:5fd7:: with SMTP id i84mr12437767ill.151.1571239449319;
        Wed, 16 Oct 2019 08:24:09 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id t9sm17591906iop.86.2019.10.16.08.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 08:24:07 -0700 (PDT)
Date:   Wed, 16 Oct 2019 08:24:04 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     greentime.hu@sifive.com
cc:     green.hu@gmail.com, palmer@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: fix virtual address overlapped in FIXADDR_START
 and VMEMMAP_START
In-Reply-To: <20191016073408.7299-1-greentime.hu@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1910160823240.12675@viisi.sifive.com>
References: <20191016073408.7299-1-greentime.hu@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019, greentime.hu@sifive.com wrote:

> From: Greentime Hu <greentime.hu@sifive.com>
> 
> This patch fixes the virtual address layout in pgtable.h.
> The virtual address of FIXADDR_START and VMEMMAP_START should not be overlapped.
> These addresses will be existed at the same time in Linux kernel that they can't
> be overlapped.
> 
> Fixes: d95f1a542c3d ("RISC-V: Implement sparsemem")
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>

Thanks, here's what's been queued for v5.4-rc.
 

- Paul

From: Greentime Hu <greentime.hu@sifive.com>
Date: Tue, 8 Oct 2019 14:45:24 +0800
Subject: [PATCH] RISC-V: fix virtual address overlapped in FIXADDR_START and
 VMEMMAP_START

This patch fixes the virtual address layout in pgtable.h.  The virtual
address of FIXADDR_START and VMEMMAP_START should not be overlapped.

Fixes: d95f1a542c3d ("RISC-V: Implement sparsemem")
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
[paul.walmsley@sifive.com: fixed patch description]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/include/asm/pgtable.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 7255f2d8395b..42292d99cc74 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -87,14 +87,6 @@ extern pgd_t swapper_pg_dir[];
 #define VMALLOC_END      (PAGE_OFFSET - 1)
 #define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
 
-#define FIXADDR_TOP      VMALLOC_START
-#ifdef CONFIG_64BIT
-#define FIXADDR_SIZE     PMD_SIZE
-#else
-#define FIXADDR_SIZE     PGDIR_SIZE
-#endif
-#define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
-
 /*
  * Roughly size the vmemmap space to be large enough to fit enough
  * struct pages to map half the virtual address space. Then
@@ -108,6 +100,14 @@ extern pgd_t swapper_pg_dir[];
 
 #define vmemmap		((struct page *)VMEMMAP_START)
 
+#define FIXADDR_TOP      (VMEMMAP_START)
+#ifdef CONFIG_64BIT
+#define FIXADDR_SIZE     PMD_SIZE
+#else
+#define FIXADDR_SIZE     PGDIR_SIZE
+#endif
+#define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
+
 /*
  * ZERO_PAGE is a global shared page that is always zero,
  * used for zero-mapped memory areas, etc.
-- 
2.23.0


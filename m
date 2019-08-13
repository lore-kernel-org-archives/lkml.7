Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70492C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB382070D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fXtPZ3S0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfHMVDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:03:24 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40277 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbfHMVDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:03:22 -0400
Received: by mail-ot1-f66.google.com with SMTP id c34so37361847otb.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 14:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=q/tq0J9ADbe9GkNWVaHD9QAS+rJhqu7CATlDgV//5SE=;
        b=fXtPZ3S0p6tfagYECMpB+kExsFKebrXX3vbg2qNrvpveYDkZEq+CyuHOTXhrGP1ayF
         8V9f90Gp8IMPmiPDan+vxWIc+J2pSHwbnK6L9w16U7sQ+hOFVNsStsfXvM4C7rEKv9bo
         R/tmhgsaAOrMT+88oASxBgCR13rDlRbjkU4BIwN77kbLic0fRK9jd1vvMxOM6jDCDrdf
         QpMfyFqBQy6xHIEzuVllZWBRLh+E+fM9+oRiNUSkUgwllTCCXBgH4u4NDWuJlFgfcUJy
         GEQr68mBjMgrXXgqBHjR6h1XfyJ/E+t7oztQI2scqecOcb8uh03q/GzNCofE8QcfR3Vc
         yKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=q/tq0J9ADbe9GkNWVaHD9QAS+rJhqu7CATlDgV//5SE=;
        b=Yx2dBPJK9hB9N5uV9NHzcVOv+dZLWpS2y/+hsN+Ea61YMBGl6qu2RRNQ6sY+tP5z1G
         kP/V2XHsTzbYPuiIV5Wjcfo213AouL2gZakJRjlcrBFh86PatkytkJbXaqu+75nmXP0w
         9kxWnCDZFffxLKKwL2t+KxrMGXhN84GWCgPVeyQ+bWjRVyU2jvG6veHNbtRXPHVrO0ee
         lpR2PwARSMwm7mvC74eZ0rWjVi+bqUKfHeCucn0YsP1dA5Mpp3Qia1777rTIKAb/YGZi
         xGUq+pFA9C0+Re8ZWvuNwuxoT34ghwss169B/hSzSctSv14MKUlz6UoG/cn537G1pM9H
         HSww==
X-Gm-Message-State: APjAAAU1RrSr8Efem8sjtJ0gUxJbDkOHVoD5TQtCSL7IaMFvdZT5f2pe
        Kc5GNaJl4TmN1DGnMyjyJXu99w==
X-Google-Smtp-Source: APXvYqwqpLcNilHMNePInAYsPu8XqFoSf4UtCXsBc9IBylPbk1c0yWtb7xx4vAbu7jyk9D7zwWiQWA==
X-Received: by 2002:a5e:9308:: with SMTP id k8mr27757300iom.143.1565730201709;
        Tue, 13 Aug 2019 14:03:21 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id p12sm3323996ioh.72.2019.08.13.14.03.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 14:03:21 -0700 (PDT)
Date:   Tue, 13 Aug 2019 14:03:20 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@infradead.org>
cc:     linux-riscv@lists.infradead.org, schwab@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: fix flush_tlb_range() end address for
 flush_tlb_page()
In-Reply-To: <20190812144337.GA26897@infradead.org>
Message-ID: <alpine.DEB.2.21.9999.1908131359280.19217@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1908080923320.31070@viisi.sifive.com> <20190812144337.GA26897@infradead.org>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019, Christoph Hellwig wrote:

> >  #define flush_tlb_range(vma, start, end) \
> >  	remote_sfence_vma(mm_cpumask((vma)->vm_mm), start, (end) - (start))
> > -#define flush_tlb_mm(mm) \
> > +
> > +static inline void flush_tlb_page(struct vm_area_struct *vma,
> > +				  unsigned long addr) {
> > +	flush_tlb_range(vma, addr, addr + PAGE_SIZE);
> > +}
> 
> Please put the opening brace on a line of its own.
> 
> Otherwise looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks, updated patch below.

Looks like checkpatch.pl is no longer issuing warnings about this type of 
brace placement issue.

Queuing for v5.3-rc.


- Paul

From: Paul Walmsley <paul.walmsley@sifive.com>
Date: Wed, 7 Aug 2019 19:07:34 -0700
Subject: [PATCH] riscv: fix flush_tlb_range() end address for flush_tlb_page()

The RISC-V kernel implementation of flush_tlb_page() when CONFIG_SMP
is set is wrong.  It passes zero to flush_tlb_range() as the final
address to flush, but it should be at least 'addr'.

Some other Linux architecture ports use the beginning address to
flush, plus PAGE_SIZE, as the final address to flush.  This might
flush slightly more than what's needed, but it seems unlikely that
being more clever would improve anything.  So let's just take that
implementation for now.

While here, convert the macro into a static inline function, primarily
to avoid unintentional multiple evaluations of 'addr'.

This second version of the patch fixes a coding style issue found by
Christoph Hellwig <hch@lst.de>.

Reported-by: Andreas Schwab <schwab@suse.de>
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/tlbflush.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 687dd19735a7..4d9bbe8438bf 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -53,10 +53,17 @@ static inline void remote_sfence_vma(struct cpumask *cmask, unsigned long start,
 }
 
 #define flush_tlb_all() sbi_remote_sfence_vma(NULL, 0, -1)
-#define flush_tlb_page(vma, addr) flush_tlb_range(vma, addr, 0)
+
 #define flush_tlb_range(vma, start, end) \
 	remote_sfence_vma(mm_cpumask((vma)->vm_mm), start, (end) - (start))
-#define flush_tlb_mm(mm) \
+
+static inline void flush_tlb_page(struct vm_area_struct *vma,
+				  unsigned long addr)
+{
+	flush_tlb_range(vma, addr, addr + PAGE_SIZE);
+}
+
+#define flush_tlb_mm(mm)				\
 	remote_sfence_vma(mm_cpumask(mm), 0, -1)
 
 #endif /* CONFIG_SMP */
-- 
2.23.0.rc1


Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2F1C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1777206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYIChDWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfHNNgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:36:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41388 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfHNNgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:36:32 -0400
Received: by mail-qt1-f193.google.com with SMTP id i4so1627144qtj.8;
        Wed, 14 Aug 2019 06:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7jNFYKqok1WxQkQOs/YwyOOaIz+VbJc2j5ls/D5y77M=;
        b=HYIChDWLH9XOd9wfjAXa2QyaCp4B3PIQC2h9kbMtijVD8fN8JjLmNkYVo5F8gKLD8r
         uFBANj6AjO4uU7fc4Tq9hU3zaRgjvqB7kPtkA+V+r7UmOfmtGIznpJw8bpOoYT8G4Xk0
         +lOWbTWEV1D+evgK+d9I3asGNxYmX2M3+YBM+WwIQX2ti0voMBcQRWKwd/YO+ZxlQeGK
         GBUwdFgCAkj3/++3T2BS45+XAQwHiozVk+qmSLlCwTZxPKX48jBZuUEqPAcNXldQhxYW
         NVCIlZWHw0q2XL8UitH4s+NFIHScJPyjEk5zQDJGF6dVi4AeIqw4XcRobMMuaAY9tGil
         5Pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7jNFYKqok1WxQkQOs/YwyOOaIz+VbJc2j5ls/D5y77M=;
        b=W24Coyw9x1KydQTHSldMhudp5W2FL/L1ueS0Kjd7J3AaAH9xgp2y0amyi19mogz6x+
         RmlXkXguVm4o+snEw0PbsFYVNnyxBKwReKe7TQmUpVsdpzRxkMSvPw7J/ynMV+9hz3S8
         TE86dq3ZGSqf9XLAfx4FmgGgNAbDhU7mreVKjZ4Jp6TsOa0zYYV4tbKNgugbTWM3CdFM
         tWXiQ2plIUHxx1QNe37sLObn6wk7RKpbbCz5h0nV5p/bzLKK6PYJd264v383IzhwSyos
         vxS/avdQZDKdgNSugWlsV7XUfjyOztMAZD0wl7SFKCaOaBo0yD6cNGu+Z8u8wlHYWTqm
         6bQw==
X-Gm-Message-State: APjAAAVQWS2IE3YF1OPPEokcGaddao7TU1ac0PDoaW25rVo+c3t3OjlC
        /7Pt5gTNEUesdmwW4j7hWrDWzJy3ZkbTfprO6Go=
X-Google-Smtp-Source: APXvYqyukeT2bAlkPamYfKTVua1D1rgoLpk3//U+glyXyZZ+Rk7w2JHmeAGXpMvKDmxUoGR5K8RXhbKOSIhnkPyDhk0=
X-Received: by 2002:ac8:2d2c:: with SMTP id n41mr37554622qta.28.1565789791477;
 Wed, 14 Aug 2019 06:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190109203911.7887-1-logang@deltatee.com> <20190109203911.7887-3-logang@deltatee.com>
 <CAEbi=3d0RNVKbDUwRL-o70O12XBV7q6n_UT-pLqFoh9omYJZKQ@mail.gmail.com>
 <c4298fdd-6fd6-fa7f-73f7-5ff016788e49@deltatee.com> <CAEbi=3cn4+7zk2DU1iRa45CDwTsJYfkAV8jXHf-S7Jz63eYy-A@mail.gmail.com>
 <CAEbi=3eZcgWevpX9VO9ohgxVDFVprk_t52Xbs3-TdtZ+js3NVA@mail.gmail.com>
 <0926a261-520e-4c40-f926-ddd40bb8ce44@deltatee.com> <CAEbi=3ebNM-t_vA4OA7KCvQUF08o6VmL1j=kMojVnYsYsN_fBw@mail.gmail.com>
 <e2603558-7b2c-2e5f-e28c-f01782dc4e66@deltatee.com> <CAEbi=3d7_xefYaVXEnMJW49Bzdbbmc2+UOwXWrCiBo7YkTAihg@mail.gmail.com>
 <96156909-1453-d487-ff66-a041d67c74d6@deltatee.com> <CAEbi=3dC86dhGdwdarS_x+6-5=WPydUBKjo613qRZxKLDAqU_g@mail.gmail.com>
 <5506c875-9387-acc9-a7fe-5b7c10036c40@deltatee.com> <alpine.DEB.2.21.9999.1908130921170.30024@viisi.sifive.com>
 <e1f78a33-18bb-bd6e-eede-e5e86758a4d0@deltatee.com>
In-Reply-To: <e1f78a33-18bb-bd6e-eede-e5e86758a4d0@deltatee.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 14 Aug 2019 21:35:55 +0800
Message-ID: <CAEbi=3f+JDywuHYspfYKuC8z2wm8inRenBz+3DYbKK3ixFjU_g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] RISC-V: Implement sparsemem
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>,
        Olof Johansson <olof@lixom.net>, greentime.hu@sifive.com,
        linux-riscv@lists.infradead.org,
        Michael Clark <michaeljclark@mac.com>,
        Christoph Hellwig <hch@lst.de>, linux-mm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Logan Gunthorpe <logang@deltatee.com> =E6=96=BC 2019=E5=B9=B48=E6=9C=8814=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8812:50=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On 2019-08-13 10:39 a.m., Paul Walmsley wrote:
> > On Tue, 13 Aug 2019, Logan Gunthorpe wrote:
> >
> >> On 2019-08-13 12:04 a.m., Greentime Hu wrote:
> >>
> >>> Every architecture with mmu defines their own pfn_valid().
> >>
> >> Not true. Arm64, for example just uses the generic implementation in
> >> mmzone.h.
> >
> > arm64 seems to define their own:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/arch/arm64/Kconfig#n899
>
> Oh, yup. My mistake.
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/arch/arm64/mm/init.c#n235
> >
> > While there are many architectures which have their own pfn_valid();
> > oddly, almost none of them set HAVE_ARCH_PFN_VALID ?
>
> Yes, much of this is super confusing. Seems HAVE_ARCH_PFN_VALID only
> matters if SPARSEMEM is set. So risc-v probably doesn't need to set it
> and we just need a #ifdef !CONFIG_FLATMEM around the pfn_valid
> definition like other arches.
>

Maybe this commit explains why it used HAVE_ARCH_PFN_VALID instead of SPARS=
EMEM.
https://github.com/torvalds/linux/commit/7b7bf499f79de3f6c85a340c8453a78789=
523f85

BTW, I found another issue here.
#define FIXADDR_TOP            (VMALLOC_START)
#define FIXADDR_START           (FIXADDR_TOP - FIXADDR_SIZE)
#define VMEMMAP_END    (VMALLOC_START - 1)
#define VMEMMAP_START  (VMALLOC_START - VMEMMAP_SIZE)
These 2 regions are overlapped.

How about this fix? Not sure if it is good for everyone.

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 3f12b069af1d..3c4d394679d0 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -115,9 +115,6 @@ config PGTABLE_LEVELS
        default 3 if 64BIT
        default 2

-config HAVE_ARCH_PFN_VALID
-       def_bool y
-
 menu "Platform type"

 choice
diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixma=
p.h
index c207f6634b91..72e106b60bc5 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -26,7 +26,7 @@ enum fixed_addresses {
 };

 #define FIXADDR_SIZE           (__end_of_fixed_addresses * PAGE_SIZE)
-#define FIXADDR_TOP            (VMALLOC_START)
+#define FIXADDR_TOP            (VMEMMAP_START)
 #define FIXADDR_START          (FIXADDR_TOP - FIXADDR_SIZE)

 #define FIXMAP_PAGE_IO         PAGE_KERNEL
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 8ddb6c7fedac..83830997dce6 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -100,8 +100,10 @@ extern unsigned long min_low_pfn;
 #define page_to_bus(page)      (page_to_phys(page))
 #define phys_to_page(paddr)    (pfn_to_page(phys_to_pfn(paddr)))

+#if defined(CONFIG_FLATMEM)
 #define pfn_valid(pfn) \
        (((pfn) >=3D pfn_base) && (((pfn)-pfn_base) < max_mapnr))
+#endif

 #define ARCH_PFN_OFFSET                (pfn_base)

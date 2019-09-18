Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81419C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50071218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KmopZsfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbfIRPIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 11:08:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41483 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbfIRPIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 11:08:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id h7so7298653wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 08:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ZHorGm2MuyyGCvKnYrvMqsguI6FU0r6Y2tWoWqD8t48=;
        b=KmopZsfO0DLvPQQ41CYF1GC8GFYQ4oL214i1x8VV1ehxS6300Hwy0JLXi2aK35B3/A
         82WZWek/QRLMAmOq6375s+h9VX595MKp7aKizeki7Mai8yzzykji5tWAs0aM7S6/GIOP
         WmIWwvlbs+5XJgRjxkR7usL1BJu7IlFXSKl/s/plpK6b6O9Cih3pXNwDjBqZkKtX7PaF
         7X7vRoxL8iv6TUhEovuYg9bSGYudFydeT0kyKO7bNkcOCX2tP+VXa6AgqoKD4w9BfP0J
         L81aLMaQhnvx/T36HdH/BD5rHmkiiUUjhcqgeXxKfIzoAMBwKEuwLctkOBBoE1X1JJwz
         nlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ZHorGm2MuyyGCvKnYrvMqsguI6FU0r6Y2tWoWqD8t48=;
        b=nK0GqDlst2gYShGgcienKRm55Adbli+mwS1lGM2a1U5LvysR9d0LEPIF4X3TTm4QGk
         gNfjCYsiUGhtJtWzxPjMmYaKsdW7fbz/EPaa71iRrgBE7Y5m5IZiTA+wZFGPo5AjpKiw
         0I9zYumDMK0peyaI9ZSqDJUXwYlWSZzg/ubUp/tpRdMFnRwLkIYI2Ia//OQg/g617kLn
         XhOZptRdIiNvCjozGO6rl73lTZlwx3SI3dfDhplOrrL4+Mx7AxUpdReZkasuWPk+r+ii
         2W06DQRH0oQ8pGt1LBujqpNOpJD3ftdRtitc2fFKQaFXtlmd+FHL5WfOXVSxY5pphb2e
         Gduw==
X-Gm-Message-State: APjAAAUOwzNsX/mcJLce64WZ4A257jkphPxGMG39lMc4jB3DPvLsnQKz
        1J/hBqr8Qi24ko7oeO+nuGyLhA==
X-Google-Smtp-Source: APXvYqxikggtthBynFvBdM6RFvgeSlc79Un78tPLbHaiowsQsBeHrMPReEdaJo26DwccO9KlAioQzQ==
X-Received: by 2002:adf:e48a:: with SMTP id i10mr3434964wrm.311.1568819292364;
        Wed, 18 Sep 2019 08:08:12 -0700 (PDT)
Received: from localhost ([195.200.173.126])
        by smtp.gmail.com with ESMTPSA id m16sm2042728wml.11.2019.09.18.08.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 08:08:11 -0700 (PDT)
Date:   Wed, 18 Sep 2019 08:08:10 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     greentime.hu@sifive.com
cc:     green.hu@gmail.com, linux-hackers@sifive.com, palmer@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Fix building error when
 CONFIG_SPARSEMEM_MANUAL=y
In-Reply-To: <20190918103825.8694-1-greentime.hu@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1909180806310.13446@viisi.sifive.com>
References: <20190918103825.8694-1-greentime.hu@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2123992612-1568819290=:13446"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2123992612-1568819290=:13446
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 18 Sep 2019, greentime.hu@sifive.com wrote:

> From: Greentime Hu <greentime.hu@sifive.com>
>=20
> To adjust the place of VMALLOC_* and FIXADDR_* defined location to let VM=
EMMAP_*
> get it.
>=20
>   CC      init/main.o
> In file included from ./include/linux/mm.h:99,
>                  from ./include/linux/ring_buffer.h:5,
>                  from ./include/linux/trace_events.h:6,
>                  from ./include/trace/syscall.h:7,
>                  from ./include/linux/syscalls.h:85,
>                  from init/main.c:21:
> ./arch/riscv/include/asm/pgtable.h: In function =E2=80=98pmd_page=E2=80=
=99:
> ./arch/riscv/include/asm/pgtable.h:95:24: error: =E2=80=98VMALLOC_START=
=E2=80=99 undeclared (first use in this function); did you mean =E2=80=98VM=
EMMAP_START=E2=80=99?
>  #define VMEMMAP_START (VMALLOC_START - VMEMMAP_SIZE)
>                         ^~~~~~~~~~~~~
>=20
> Fixes: d95f1a542c3d ("RISC-V: Implement sparsemem")
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>

Thanks, queued the following for v5.4-rc.


- Paul

From: Greentime Hu <greentime.hu@sifive.com>
Date: Wed, 18 Sep 2019 18:38:24 +0800
Subject: [PATCH] RISC-V: Fix building error when CONFIG_SPARSEMEM_MANUAL=3D=
y

Fix a build break by adjusting where VMALLOC_* and FIXADDR_* are
defined.  This fixes the definition of the MEMMAP_* macros.

  CC      init/main.o
In file included from ./include/linux/mm.h:99,
                 from ./include/linux/ring_buffer.h:5,
                 from ./include/linux/trace_events.h:6,
                 from ./include/trace/syscall.h:7,
                 from ./include/linux/syscalls.h:85,
                 from init/main.c:21:
=2E/arch/riscv/include/asm/pgtable.h: In function =E2=80=98pmd_page=E2=80=
=99:
=2E/arch/riscv/include/asm/pgtable.h:95:24: error: =E2=80=98VMALLOC_START=
=E2=80=99 undeclared (first use in this function); did you mean =E2=80=98VM=
EMMAP_START=E2=80=99?
 #define VMEMMAP_START (VMALLOC_START - VMEMMAP_SIZE)
                        ^~~~~~~~~~~~~

Fixes: d95f1a542c3d ("RISC-V: Implement sparsemem")
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
[paul.walmsley@sifive.com: fix patch description]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/include/asm/pgtable.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgta=
ble.h
index 80905b27ee98..4f4162d90586 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -83,6 +83,18 @@ extern pgd_t swapper_pg_dir[];
 #define __S110=09PAGE_SHARED_EXEC
 #define __S111=09PAGE_SHARED_EXEC
=20
+#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
+#define VMALLOC_END      (PAGE_OFFSET - 1)
+#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
+
+#define FIXADDR_TOP      VMALLOC_START
+#ifdef CONFIG_64BIT
+#define FIXADDR_SIZE     PMD_SIZE
+#else
+#define FIXADDR_SIZE     PGDIR_SIZE
+#endif
+#define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
+
 /*
  * Roughly size the vmemmap space to be large enough to fit enough
  * struct pages to map half the virtual address space. Then
@@ -429,18 +441,6 @@ static inline void pgtable_cache_init(void)
 =09/* No page table caches to initialize */
 }
=20
-#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
-#define VMALLOC_END      (PAGE_OFFSET - 1)
-#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
-
-#define FIXADDR_TOP      VMALLOC_START
-#ifdef CONFIG_64BIT
-#define FIXADDR_SIZE     PMD_SIZE
-#else
-#define FIXADDR_SIZE     PGDIR_SIZE
-#endif
-#define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
-
 /*
  * Task size is 0x4000000000 for RV64 or 0x9fc00000 for RV32.
  * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
--=20
2.23.0

--8323329-2123992612-1568819290=:13446--

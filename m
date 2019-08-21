Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23493C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68A82082F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVa8QFM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbfHUNNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:13:22 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:44519 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbfHUNNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:13:21 -0400
Received: by mail-ot1-f46.google.com with SMTP id w4so1952908ote.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 06:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ftCsi7swyeqO2oPmLgC3apsygx3sfZ7n3eFksV9YU6s=;
        b=UVa8QFM9l7I1l8Vdm0TS1X87cbtaFr2HdZ3WtYXRktms2Yjzw/zZRjYuIMpzXIY/9O
         x2iLcma1vb5lDMlmLxhFKOw0El12nCVTO1ld6L8yoyhj9qh97mb9qr4CKbxmvnIjq5AG
         krYSOTHPjlCVPZs5kGYvQM494xClWXAdheH0VKfhPgTqQuUYAv1sCCyRyjjsPleGnWtI
         W0ZYdGKsWg6qSLl7w+jl9fUxlsUwUM1YZiDqE0SudlgKah1YVlwiGokUvwTDY7Tx3jJj
         KV40kb4pLymShyywYpEJqbajFpH7u75EhNzDn1jDwCtleHQYeIVuAl6t/rL0V9yLzaZA
         EUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ftCsi7swyeqO2oPmLgC3apsygx3sfZ7n3eFksV9YU6s=;
        b=WXi2FGemEIMci348fCZuk16vrgYuUmfwh+6FmF1bEXae3GwfrY2G/Xfg7Ky4rDQh38
         FerVRUJS5Rbfu/xbemtpXEtukQU1dzk2gL5HpycCvFMwHUcQU4nGj6Tm24yaMs/uN6AR
         lClj2fRw8R4IU337ucU/qDBVFfVV6sCldDC5tsm86Gs3TvOxzH+SE5erNKwRDaJQ6KPX
         VU3ZcDa8J2WmZbPcQl8BZLoPynrX23cSX0UhufaKZkaHxtU+sovKq0MFpMNxN3yXFHkf
         +SS7tzRk+RlhwoIJIlF4vzcPW4Ih1ugNP1OpJq0V/g3I7l5x1viLsx9T+pIA/kZ0PKCz
         66Ww==
X-Gm-Message-State: APjAAAVH4PDnSnAxWIw3o3r7qKS9vbG3JweovxvqdhcGZco4mZT7OFjv
        CmTXSZR3ep+lw4u1B/1phGNoJxMBeY44+bK7TQ8FGPmGU2UeXQ==
X-Google-Smtp-Source: APXvYqym0mELbROWhmFtE82C6OvNPTX2aFKpjGH/dXKmjAUtG0uf91ji+n4CgScqTrf7CYcJtTKDbewietn4PGmaXRU=
X-Received: by 2002:a05:6830:1151:: with SMTP id x17mr25004482otq.270.1566393200058;
 Wed, 21 Aug 2019 06:13:20 -0700 (PDT)
MIME-Version: 1.0
From:   Siarhei Liakh <sliakh.lkml@gmail.com>
Date:   Wed, 21 Aug 2019 09:13:08 -0400
Message-ID: <CALBuU529+=+Xmsccc3AU2R0tSOCJtMQx=yMGDHopc3=tO3uM3Q@mail.gmail.com>
Subject: Pointer magic in mm_init_cpumask()
To:     LKML <linux-kernel@vger.kernel.org>, riel@surriel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone.
I was chasing some issue in my own code when I came across the
following in include/linux/mm_types.h:
======================
/* Pointer magic because the dynamic array size confuses some compilers. */
static inline void mm_init_cpumask(struct mm_struct *mm)
{
        unsigned long cpu_bitmap = (unsigned long)mm;

        cpu_bitmap += offsetof(struct mm_struct, cpu_bitmap);
        cpumask_clear((struct cpumask *)cpu_bitmap);
}

/* Future-safe accessor for struct mm_struct's cpu_vm_mask. */
static inline cpumask_t *mm_cpumask(struct mm_struct *mm)
{
        return (struct cpumask *)&mm->cpu_bitmap;
}
======================
Bodies of both functions came from commit
c1a2f7f0c06454387c2cd7b93ff1491c715a8c69 "mm: Allocate the mm_cpumask
(mm->cpu_bitmap[]) dynamically based on nr_cpu_ids"

This raises the following issues:
If pointer magic is required in mm_init_cpumask(), then what makes
mm_cpumask() safe (and vice versa)?
If mm_cpumask() is not safe, then at the very least the following has
to be fixed:
$ grep -rIn 'cpumask_clear(mm_cpumask(' *
arch/powerpc/include/asm/tlb.h:69:    cpumask_clear(mm_cpumask(mm));
arch/sparc/mm/init_64.c:857:        cpumask_clear(mm_cpumask(mm));
arch/ia64/include/asm/mmu_context.h:92:        cpumask_clear(mm_cpumask(mm));
arch/csky/mm/asid.c:126:    cpumask_clear(mm_cpumask(mm));
arch/arm/mm/context.c:233:    cpumask_clear(mm_cpumask(mm));

Otherwise, mm_init_cpumask() can be simplified down to
cpumask_clear(mm_cpumask(mm)).
What do you think?

Please CC me on reply.
Thank you.

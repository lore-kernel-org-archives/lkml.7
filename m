Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A6DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E53206DD
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jWiovE0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbfHUVMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 17:12:12 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36232 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbfHUVML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 17:12:11 -0400
Received: by mail-qk1-f196.google.com with SMTP id d23so3202663qko.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 14:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wKfoGD8n1EExPN/R416sVnt2YzIc0+Wi95CWXfv+Qwc=;
        b=jWiovE0WVWyuoSRn6Q6NcWiLlhDCr9SDx17bU42gfmxyhc87oSxHk+qHbYQygjSfT+
         tH6VXnvSQoPDO+HDRApqHP4MObAmzQzTMzR6FKHuYJC0tiQ5dn1Zjbc24IAQyM6CaIAW
         YQLNp62YoI8b/iy9qxXFMbmXwdZGaGuNw3hvqWAqz8kcU+qZ6Q9q/f83Gr+jG/Exj/S3
         AGV4XoW0HaHZ3fJZj349TaO5HvUvu1Mfqtyf+s54/WqqEJkysXIDIXTeOLSb2nMSMuDQ
         gLY6v4P4ZNk/rp6JLor6rfPfkfOcLrPtuvUqTzN1BpVfGlgGoChwtv4vh3mihM+QR7f+
         8vvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wKfoGD8n1EExPN/R416sVnt2YzIc0+Wi95CWXfv+Qwc=;
        b=G9uTJYMnk7/Xx/1iBhLjLG2AxAwEiyfC1dDray23GMTnZQCAmx61Wpue4uoD+jlYXy
         uJNr7yrU8Huh7HumbUQQXwUW/yXlufGh2sHQE8IbHiR8VzOhWi41sQWWRxGu1LnsNA6b
         93McttbzIV+hUW94qHCbg+4pu5a5CykOqBJ9pO879T73gr4dVFI34QsmymbZHiRxBLqb
         in9mTz4k8uEiN3A6EAFLaB0HdIf/Eq0cYfnNeAert9o+3J0Hlxi+LVMhpVmgBs1W/xni
         7eI/JXUpoaQPKz2fcBWbyRLwxivUhFiAE9KX1v3c1dKrP1Qe79gzLNQ+Twx3i32rqrc1
         SW/Q==
X-Gm-Message-State: APjAAAUtPYTyg4r95Ma4xlaGmHC8efLzAEG41iF4f8EBAJhvwxKx4nkU
        dlkLXwEnKH1P9k1Fq23Q9wdb0A==
X-Google-Smtp-Source: APXvYqwZ/bY1z3XLINRGQysL7fa2x5zQOYp0Z/0iOTKQ6+P8g3Nz+pt9/o+NHkYuXYYVlhIkIK4F5A==
X-Received: by 2002:ae9:ef06:: with SMTP id d6mr33003385qkg.157.1566421930297;
        Wed, 21 Aug 2019 14:12:10 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z22sm5710821qti.1.2019.08.21.14.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 14:12:09 -0700 (PDT)
Message-ID: <1566421927.5576.3.camel@lca.pw>
Subject: Re: devm_memremap_pages() triggers a kasan_add_zero_shadow() warning
From:   Qian Cai <cai@lca.pw>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev@googlegroups.com, Baoquan He <bhe@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Wed, 21 Aug 2019 17:12:07 -0400
In-Reply-To: <0AC959D7-5BCB-4A81-BBDC-990E9826EB45@lca.pw>
References: <1565991345.8572.28.camel@lca.pw>
         <CAPcyv4i9VFLSrU75U0gQH6K2sz8AZttqvYidPdDcS7sU2SFaCA@mail.gmail.com>
         <0FB85A78-C2EE-4135-9E0F-D5623CE6EA47@lca.pw>
         <CAPcyv4h9Y7wSdF+jnNzLDRobnjzLfkGLpJsML2XYLUZZZUPsQA@mail.gmail.com>
         <E7A04694-504D-4FB3-9864-03C2CBA3898E@lca.pw>
         <CAPcyv4gofF-Xf0KTLH4EUkxuXdRO3ha-w+GoxgmiW7gOdS2nXQ@mail.gmail.com>
         <0AC959D7-5BCB-4A81-BBDC-990E9826EB45@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-08-17 at 23:25 -0400, Qian Cai wrote:
> > On Aug 17, 2019, at 12:59 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> > 
> > On Sat, Aug 17, 2019 at 4:13 AM Qian Cai <cai@lca.pw> wrote:
> > > 
> > > 
> > > 
> > > > On Aug 16, 2019, at 11:57 PM, Dan Williams <dan.j.williams@intel.com>
> > > > wrote:
> > > > 
> > > > On Fri, Aug 16, 2019 at 8:34 PM Qian Cai <cai@lca.pw> wrote:
> > > > > 
> > > > > 
> > > > > 
> > > > > > On Aug 16, 2019, at 5:48 PM, Dan Williams <dan.j.williams@intel.com>
> > > > > > wrote:
> > > > > > 
> > > > > > On Fri, Aug 16, 2019 at 2:36 PM Qian Cai <cai@lca.pw> wrote:
> > > > > > > 
> > > > > > > Every so often recently, booting Intel CPU server on linux-next
> > > > > > > triggers this
> > > > > > > warning. Trying to figure out if  the commit 7cc7867fb061
> > > > > > > ("mm/devm_memremap_pages: enable sub-section remap") is the
> > > > > > > culprit here.
> > > > > > > 
> > > > > > > # ./scripts/faddr2line vmlinux devm_memremap_pages+0x894/0xc70
> > > > > > > devm_memremap_pages+0x894/0xc70:
> > > > > > > devm_memremap_pages at mm/memremap.c:307
> > > > > > 
> > > > > > Previously the forced section alignment in devm_memremap_pages()
> > > > > > would
> > > > > > cause the implementation to never violate the
> > > > > > KASAN_SHADOW_SCALE_SIZE
> > > > > > (12K on x86) constraint.
> > > > > > 
> > > > > > Can you provide a dump of /proc/iomem? I'm curious what resource is
> > > > > > triggering such a small alignment granularity.
> > > > > 
> > > > > This is with memmap=4G!4G ,
> > > > > 
> > > > > # cat /proc/iomem
> > > > 
> > > > [..]
> > > > > 100000000-155dfffff : Persistent Memory (legacy)
> > > > > 100000000-155dfffff : namespace0.0
> > > > > 155e00000-15982bfff : System RAM
> > > > > 155e00000-156a00fa0 : Kernel code
> > > > > 156a00fa1-15765d67f : Kernel data
> > > > > 157837000-1597fffff : Kernel bss
> > > > > 15982c000-1ffffffff : Persistent Memory (legacy)
> > > > > 200000000-87fffffff : System RAM
> > > > 
> > > > Ok, looks like 4G is bad choice to land the pmem emulation on this
> > > > system because it collides with where the kernel is deployed and gets
> > > > broken into tiny pieces that violate kasan's. This is a known problem
> > > > with memmap=. You need to pick an memory range that does not collide
> > > > with anything else. See:
> > > > 
> > > >   https://nvdimm.wiki.kernel.org/how_to_choose_the_correct_memmap_kernel
> > > > _parameter_for_pmem_on_your_system
> > > > 
> > > > ...for more info.
> > > 
> > > Well, it seems I did exactly follow the information in that link,
> > > 
> > > [    0.000000] BIOS-provided physical RAM map:
> > > [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000093fff]
> > > usable
> > > [    0.000000] BIOS-e820: [mem 0x0000000000094000-0x000000000009ffff]
> > > reserved
> > > [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff]
> > > reserved
> > > [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000005a7a0fff]
> > > usable
> > > [    0.000000] BIOS-e820: [mem 0x000000005a7a1000-0x000000005b5e0fff]
> > > reserved
> > > [    0.000000] BIOS-e820: [mem 0x000000005b5e1000-0x00000000790fefff]
> > > usable
> > > [    0.000000] BIOS-e820: [mem 0x00000000790ff000-0x00000000791fefff]
> > > reserved
> > > [    0.000000] BIOS-e820: [mem 0x00000000791ff000-0x000000007b5fefff] ACPI
> > > NVS
> > > [    0.000000] BIOS-e820: [mem 0x000000007b5ff000-0x000000007b7fefff] ACPI
> > > data
> > > [    0.000000] BIOS-e820: [mem 0x000000007b7ff000-0x000000007b7fffff]
> > > usable
> > > [    0.000000] BIOS-e820: [mem 0x000000007b800000-0x000000008fffffff]
> > > reserved
> > > [    0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000000ffffffff]
> > > reserved
> > > [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000087fffffff]
> > > usable
> > > 
> > > Where 4G is good. Then,
> > > 
> > > [    0.000000] user-defined physical RAM map:
> > > [    0.000000] user: [mem 0x0000000000000000-0x0000000000093fff] usable
> > > [    0.000000] user: [mem 0x0000000000094000-0x000000000009ffff] reserved
> > > [    0.000000] user: [mem 0x00000000000e0000-0x00000000000fffff] reserved
> > > [    0.000000] user: [mem 0x0000000000100000-0x000000005a7a0fff] usable
> > > [    0.000000] user: [mem 0x000000005a7a1000-0x000000005b5e0fff] reserved
> > > [    0.000000] user: [mem 0x000000005b5e1000-0x00000000790fefff] usable
> > > [    0.000000] user: [mem 0x00000000790ff000-0x00000000791fefff] reserved
> > > [    0.000000] user: [mem 0x00000000791ff000-0x000000007b5fefff] ACPI NVS
> > > [    0.000000] user: [mem 0x000000007b5ff000-0x000000007b7fefff] ACPI data
> > > [    0.000000] user: [mem 0x000000007b7ff000-0x000000007b7fffff] usable
> > > [    0.000000] user: [mem 0x000000007b800000-0x000000008fffffff] reserved
> > > [    0.000000] user: [mem 0x00000000ff800000-0x00000000ffffffff] reserved
> > > [    0.000000] user: [mem 0x0000000100000000-0x00000001ffffffff]
> > > persistent (type 12)
> > > [    0.000000] user: [mem 0x0000000200000000-0x000000087fffffff] usable
> > > 
> > > The doc did mention that “There seems to be an issue with CONFIG_KSAN at
> > > the moment however.”
> > > without more detail though.
> > 
> > Does disabling CONFIG_RANDOMIZE_BASE help? Maybe that workaround has
> > regressed. Effectively we need to find what is causing the kernel to
> > sometimes be placed in the middle of a custom reserved memmap= range.
> 
> Yes, disabling KASLR works good so far. Assuming the workaround, i.e.,
> f28442497b5c
> (“x86/boot: Fix KASLR and memmap= collision”) is correct.
> 
> The only other commit that might regress it from my research so far is,
> 
> d52e7d5a952c ("x86/KASLR: Parse all 'memmap=' boot option entries”)
> 

It turns out that the origin commit f28442497b5c (“x86/boot: Fix KASLR and
memmap= collision”) has a bug that is unable to handle "memmap=" in
CONFIG_CMDLINE instead of a parameter in bootloader because when it (as well as
the commit d52e7d5a952c) calls get_cmd_line_ptr() in order to run
mem_avoid_memmap(), "boot_params" has no knowledge of CONFIG_CMDLINE. Only later
in setup_arch(), the kernel will deal with parameters over there.

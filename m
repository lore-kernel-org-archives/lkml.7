Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960A4C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637D02175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YbkFofSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfDXXXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:23:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34373 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfDXXXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:23:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id b3so10128272pfd.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=/z9H1bjGAN+NhWO4cJm4XUDJLQDERO7DpYsjfK91LLc=;
        b=YbkFofSFfog0jO7FGGCcAlnOh/4CSJOMHqL6e3bBGVQjiJk/cCD/K5LCnXZobO7XRE
         +8p7yjwtiMXTzJSk1f1kfhGLeDcmCrPBuFa3u84gyW/RbSK5hJudqYwsHX1J81Dl4FEd
         coTbWdFPhAaDYKU8rBBJUkE6yy6rCjqX+uwtG8SLGdjtXWRaEwedGp+XmhLQyw3JtL4/
         fSuZk6y7gx0Bnj6UEGF8NyReO6/g/jm+D02fBNIL4prq4ahdzYWJeCtTUxlOc06xKgcH
         cBLj6qw5LmurioHtGKiLmbIr0oktn8kcSWSEezFdBPHAvEt2Neh0YIa8J27XfY7RHAG3
         Wf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=/z9H1bjGAN+NhWO4cJm4XUDJLQDERO7DpYsjfK91LLc=;
        b=LnDAz9pObr/9SIEglZeRlzInEI0B2AIfAv/XuPejf7PG1eV8TJZEUei29mqLJPdOBt
         P2lgXsBVNJt44F7qH7A9gKvKlmO6wJesCmG2rq/3gUjnWzEv2Iki028FEymF/kZOYPGV
         aswnkL+yN0uOXZoi83ZgdHTD8en6h8phOLJU4dML2OnEr2xShfY5z7ON+RZbJMrGQLRl
         uho7yX4JDzssAKdQUGgYZVXGRMDMyZj3oJKKmfqJjnB7Iolg0zoILf/vhCZHMWgv+SJx
         Gw5H9Np1apATtClamG/hPHZyNhbazAasCx1toQPLvA9tYl4o5ctdnO/gzy0F1iRHuLST
         J4IQ==
X-Gm-Message-State: APjAAAW+x0NBTnEvyl0J1WTb5Hj0uVXIB2or5DCyWnXHIbA7xkxFg12v
        iGjMHqRgVToi7fCay7Dn0HnDUZp63U0=
X-Google-Smtp-Source: APXvYqzjjA3hX2DuVpPR/WNJ/pnpwN5twO7NMUKFHEU2IhtSQELT5m6yP8Joaoo/kvZ0eqUdXznVgQ==
X-Received: by 2002:a62:2ad5:: with SMTP id q204mr35815462pfq.259.1556148183563;
        Wed, 24 Apr 2019 16:23:03 -0700 (PDT)
Received: from localhost ([134.134.139.92])
        by smtp.gmail.com with ESMTPSA id q24sm27357806pgm.16.2019.04.24.16.23.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 16:23:01 -0700 (PDT)
Date:   Wed, 24 Apr 2019 16:23:01 -0700 (PDT)
X-Google-Original-Date: Wed, 24 Apr 2019 15:49:08 PDT (-0700)
Subject:     Re: [PATCH 0/7] RISC-V: Sparsmem, Memory Hotplug and pte_devmap for P2P
In-Reply-To: <20190327213643.23789-1-logang@deltatee.com>
CC:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        sbates@raithlin.com, Christoph Hellwig <hch@lst.de>,
        aou@eecs.berkeley.edu, logang@deltatee.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     logang@deltatee.com
Message-ID: <mhng-8e27a4f1-db30-46cf-b987-51bba8cd96c7@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019 14:36:36 PDT (-0700), logang@deltatee.com wrote:
> Hi,
>
> This patchset enables P2P on the RISC-V architecture. To do this on the
> current kernel, we only need to be able to back IO memory with struct
> pages using devm_memremap_pages(). This requires ARCH_HAS_ZONE_DEVICE,
> ARCH_ENABLE_MEMORY_HOTPLUG, and ARCH_ENABLE_MEMORY_HOTREMOVE; which in
> turn requires ARCH_SPARSEMEM_ENABLE. We also need to ensure that the
> IO memory regions in hardware can be covered by the linear region
> so that there is a linear relation ship between the virtual address and
> the struct page address in the vmemmap region.
>
> While our reason to do this work is for P2P, these features are all
> useful, more generally, and also enable other kernel features.
>
> The first patch in the series implements sparse mem. It was already
> submitted and reviewed last cycle, only forgotten. It has been rebased
> onto v5.1-rc2.
>
> Patches 2 through 4 rework the architecture's virtual address space
> mapping trying to get as much of the IO regions covered by the linear
> mapping. With Sv39, we do not have enough address space to cover all the
> typical hardware regions but we can get the majority of it.
>
> Patch 5 and 6 implement memory hotplug and remove. These are relatively
> straight forward additions similar to other arches.
>
> Patch 7 implements pte_devmap which allows us to set
> ARCH_HAS_ZONE_DEVICE.
>
> The patchset was tested in QEMU and on a HiFive Unleashed board.
> However, we were unable to actually test P2P transactions with this
> exact set because we have been unable to get PCI working with v5.1-rc2.
> We were able to get it running on a 4.19 era kernel (with a bunch of
> out-of-tree patches for PCI on a Microsemi PolarFire board).
>
> This series is based on v5.1-rc2 and a git tree is available here:
>
> https://github.com/sbates130272/linux-p2pmem riscv-p2p-v1

Looks like these don't build on rv32 when applied on top of 5.1-rc6.  We now
have rv32_defconfig, which should make it easier to tests these sorts of
things.

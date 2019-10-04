Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DA8C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3B0222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DSK+ulNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388169AbfJDRew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:34:52 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41794 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387948AbfJDRew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:34:52 -0400
Received: by mail-io1-f65.google.com with SMTP id n26so15214587ioj.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 10:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=v/i7XLtrzGj5HWyiPm+j5Xy1MKLob96Pn8gCzJZLO94=;
        b=DSK+ulNPfHd96JrD/Nrd6qtE+EN6h/TsM0gK3cApR11oaFbfUB6WSuksd4uKUHymWC
         5wKyCHdF1BZ8VOSpuLzNBhFFjhsws+TKQf7rjHllGb4Nk1ixVBN6x62DmdB3QS5BlvLb
         hgEQ+ZSuWPHdFtgDq+YunT+Eoex7HwOubh6vYtoQ6iRDuqL3m9lLNgIQdvODGUdmdWDe
         LX8P+/10vo6lklhnW84GH51xQ86nnLFgL1EM0Sp+pfwGWXoFHxCs65N9KYl8wHCdH21M
         0rHvEAlmxQNhGr7nZ3nIaImQyyTibpTLktiMx1AmQyxAzR8HBhoo6yixSA9JfEzlN9+U
         fg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=v/i7XLtrzGj5HWyiPm+j5Xy1MKLob96Pn8gCzJZLO94=;
        b=uecYLoOvuGzyhN6pFOjcIjcahwgCGMeNqqFwtIf4akFSTeMsCyym1NQTBTSvUHNupY
         xFMRM2XZ1WHGub9+Is2R+i9cdQg6eZb+weITb6a3FncCs3GCOyF0mE7xZsam2sddaeSx
         J2ghKdmX9tPsh6otG0VfZBf8vTEcFIi3hrcVr3Jg0SBRUrox/JtW0f3kC5hnkWAYtakG
         Y+FGxMJ3u55lxpWSX/ZDLC+JZfT8fRDfrjt8qBdvN/muSelaGalOvtlYbHIAbdjiFqhS
         riEZ5N7Nia/cRuKOJdI8gr8IPqN9GERxNbDFHWzW8j4K/Zsx4zWoYuswhwPIo8ErL8hV
         2iMg==
X-Gm-Message-State: APjAAAUfDxVbbAwvibAKRl9alD+o5Awf3sjYf0rVQg6KX8SVuOPqd8cw
        m2M3a5RkWyNsNyIFHfPE5kbAQcZMw98=
X-Google-Smtp-Source: APXvYqzP6wXJnsykySCx+JZLu+IOGWw+CFG8e+IfotAKMSOUbTbbw5PQyBxqn3GhJtvI+VXxSjbE0Q==
X-Received: by 2002:a6b:3806:: with SMTP id f6mr13624530ioa.120.1570210491344;
        Fri, 04 Oct 2019 10:34:51 -0700 (PDT)
Received: from localhost (67-0-10-3.albq.qwest.net. [67.0.10.3])
        by smtp.gmail.com with ESMTPSA id o187sm2852084ila.13.2019.10.04.10.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 10:34:50 -0700 (PDT)
Date:   Fri, 4 Oct 2019 10:34:49 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Albert Ou <aou@eecs.berkeley.edu>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: Fix memblock reservation for device tree
 blob
In-Reply-To: <20190927231418.83100-1-aou@eecs.berkeley.edu>
Message-ID: <alpine.DEB.2.21.9999.1910041034321.15827@viisi.sifive.com>
References: <20190927231418.83100-1-aou@eecs.berkeley.edu>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2019, Albert Ou wrote:

> This fixes an error with how the FDT blob is reserved in memblock.
> An incorrect physical address calculation exposed the FDT header to
> unintended corruption, which typically manifested with of_fdt_raw_init()
> faulting during late boot after fdt_totalsize() returned a wrong value.
> Systems with smaller physical memory sizes more frequently trigger this
> issue, as the kernel is more likely to allocate from the DMA32 zone
> where bbl places the DTB after the kernel image.
> 
> Commit 671f9a3e2e24 ("RISC-V: Setup initial page tables in two stages")
> changed the mapping of the DTB to reside in the fixmap area.
> Consequently, early_init_fdt_reserve_self() cannot be used anymore in
> setup_bootmem() since it relies on __pa() to derive a physical address,
> which does not work with dtb_early_va that is no longer a valid kernel
> logical address.
> 
> The reserved[0x1] region shows the effect of the pointer underflow
> resulting from the __pa(initial_boot_params) offset subtraction:
> 
> [    0.000000] MEMBLOCK configuration:
> [    0.000000]  memory size = 0x000000001fe00000 reserved size = 0x0000000000a2e514
> [    0.000000]  memory.cnt  = 0x1
> [    0.000000]  memory[0x0]     [0x0000000080200000-0x000000009fffffff], 0x000000001fe00000 bytes flags: 0x0
> [    0.000000]  reserved.cnt  = 0x2
> [    0.000000]  reserved[0x0]   [0x0000000080200000-0x0000000080c2dfeb], 0x0000000000a2dfec bytes flags: 0x0
> [    0.000000]  reserved[0x1]   [0xfffffff080100000-0xfffffff080100527], 0x0000000000000528 bytes flags: 0x0
> 
> With the fix applied:
> 
> [    0.000000] MEMBLOCK configuration:
> [    0.000000]  memory size = 0x000000001fe00000 reserved size = 0x0000000000a2e514
> [    0.000000]  memory.cnt  = 0x1
> [    0.000000]  memory[0x0]     [0x0000000080200000-0x000000009fffffff], 0x000000001fe00000 bytes flags: 0x0
> [    0.000000]  reserved.cnt  = 0x2
> [    0.000000]  reserved[0x0]   [0x0000000080200000-0x0000000080c2dfeb], 0x0000000000a2dfec bytes flags: 0x0
> [    0.000000]  reserved[0x1]   [0x0000000080e00000-0x0000000080e00527], 0x0000000000000528 bytes flags: 0x0
> 
> Fixes: 671f9a3e2e24 ("RISC-V: Setup initial page tables in two stages")
> Signed-off-by: Albert Ou <aou@eecs.berkeley.edu>

Thanks, queued for v5.4-rc.  Welcome back Albert :-)


- Paul

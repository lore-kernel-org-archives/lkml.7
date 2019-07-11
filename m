Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0002DC74A3F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 00:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C427720872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 00:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="htBotMQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfGKAFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 20:05:22 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35524 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfGKAFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 20:05:22 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so8693286ioo.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 17:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ubdKGsXmNmNnrEmma+QqWUc+ucOLRj+HPkmSnpqQuV8=;
        b=htBotMQJrwsoybVJZB28UjYjxet4BUak3it6nJxmo7QAH7wBc2t28AQTwHji8TEwqV
         lEJ1V1JCIU46kmTU8Z1zYo8UhQgGw+JcvP5S7z1fLKCjPeaBh3MfYucDJAeMhtZqFL9F
         awjetkAQgrmHTZm9n1P80LsDzB8GbQxYpbE+TGjVdwAfN7TTO8YJTNMMFi+kqW46y5wK
         fOPD1hbzjf4CqbyghjrnhKhBk2UDSulSZC07u7wzr4j//tlrd1T/0FhVlAHmgptsaeZ5
         akArVtvTsKtVw3MPjxVSrUMFcjLYLZCTIl1xzTJpOVGxlGxaqR3NYH/xdsvQNzlfkDuc
         FCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ubdKGsXmNmNnrEmma+QqWUc+ucOLRj+HPkmSnpqQuV8=;
        b=l1JJxgzS15jhKEc10TxUksyK02MDctHVIvAQLUxyWmXzlljl2vfNkN4xpKbRaSvMTW
         FyzUxX13psI90yf2azdAt0i8pdkJDwQFQHkL6UrGYK0lt5zz19Yuc6bj65YYkhgixF/9
         DffJstR2K7Ug6Rdx3H6sjLyphbl0Dv6MU8q+F8hr8l3QbcKVAydWfENObf61bqIuQipN
         AqZhAK2oH8SSc1ar4klxmq+tco9IO2/rgHuAqXMNgtmC1o851EbWIh1KlVvNMw9PQ2HA
         6EmpMxI4byRqam3a64qoMa57bQPs9KYS8QSr9onEl9bkBTtayxZKEiayz7zv4xwQNdOR
         PSZw==
X-Gm-Message-State: APjAAAVDc2pFA708vmf0T952BUNdkIzDi59PUbLRXngG0SJOZ7WgrfQm
        +kNw0pmAnb9D7NcFmxc/iKmXNw==
X-Google-Smtp-Source: APXvYqzI0ZGsvCJlbPuVmTX4ExXT+ybqLhdjgIDQz807wMeSW6DorWjk/uf1GNcys8zFII1ozD2WRg==
X-Received: by 2002:a6b:2c96:: with SMTP id s144mr958546ios.57.1562803521318;
        Wed, 10 Jul 2019 17:05:21 -0700 (PDT)
Received: from localhost (67-0-62-24.albq.qwest.net. [67.0.62.24])
        by smtp.gmail.com with ESMTPSA id p3sm4076474iom.7.2019.07.10.17.05.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 17:05:20 -0700 (PDT)
Date:   Wed, 10 Jul 2019 17:05:19 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Anup Patel <Anup.Patel@wdc.com>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] RISC-V: Setup initial page tables in two stages
In-Reply-To: <20190607060049.29257-3-anup.patel@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1907101703150.3422@viisi.sifive.com>
References: <20190607060049.29257-1-anup.patel@wdc.com> <20190607060049.29257-3-anup.patel@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jun 2019, Anup Patel wrote:

> Currently, the setup_vm() does initial page table setup in one-shot
> very early before enabling MMU. Due to this, the setup_vm() has to map
> all possible kernel virtual addresses since it does not know size and
> location of RAM. This means we have kernel mappings for non-existent
> RAM and any buggy driver (or kernel) code doing out-of-bound access
> to RAM will not fault and cause underterministic behaviour.
> 
> Further, the setup_vm() creates PMD mappings (i.e. 2M mappings) for
> RV64 systems. This means for PAGE_OFFSET=0xffffffe000000000 (i.e.
> MAXPHYSMEM_128GB=y), the setup_vm() will require 129 pages (i.e.
> 516 KB) of memory for initial page tables which is never freed. The
> memory required for initial page tables will further increase if
> we chose a lower value of PAGE_OFFSET (e.g. 0xffffff0000000000)
> 
> This patch implements two-staged initial page table setup, as follows:
> 1. Early (i.e. setup_vm()): This stage maps kernel image and DTB in
> a early page table (i.e. early_pg_dir). The early_pg_dir will be used
> only by boot HART so it can be freed as-part of init memory free-up.
> 2. Final (i.e. setup_vm_final()): This stage maps all possible RAM
> banks in the final page table (i.e. swapper_pg_dir). The boot HART
> will start using swapper_pg_dir at the end of setup_vm_final(). All
> non-boot HARTs directly use the swapper_pg_dir created by boot HART.
> 
> We have following advantages with this new approach:
> 1. Kernel mappings for non-existent RAM don't exists anymore.
> 2. Memory consumed by initial page tables is now indpendent of the
> chosen PAGE_OFFSET.
> 3. Memory consumed by initial page tables on RV64 system is 2 pages
> (i.e. 8 KB) which has significantly reduced and these pages will be
> freed as-part of the init memory free-up.
> 
> The patch also provides a foundation for implementing strict kernel
> mappings where we protect kernel text and rodata using PTE permissions.
> 
> Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Thanks, updated to apply and to fix a checkpatch warning, and queued.  

This may not make it in for v5.3-rc1; if not, we'll submit it later.


- Paul

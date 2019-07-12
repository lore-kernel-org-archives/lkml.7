Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A827C742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2A12080A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YT2j/iU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfGLRQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 13:16:43 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41136 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfGLRQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 13:16:42 -0400
Received: by mail-io1-f68.google.com with SMTP id j5so17715010ioj.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 10:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=iXtdpQd8nnhs4LGXKgAYAQvupi8/WOX4e9Rzt2Cr9CU=;
        b=YT2j/iU40MxuBBXO9lb5IQbBE5jrkfnrRY9xLOdGAaikbSdl2YU6uISPilY0ddfipw
         SPtU62qkG3Z5Z3Ogc2azK7ti8QpOISRgUsmIIABxcIsT1X+rWxrTo6IzUEhlO1bsVrAX
         IveXj25vZsg7hNSxNfVrqRhQ0scEmYofrPVcosq7oaf1o1lzV41Pxc/GvnY5xxtmwY2K
         fevC+u/BdbIWXOzlfkUy2QZuiBwhUm4UUuihyenGCKdHe92z/Ub/e3biIlISfJPE1eXI
         plfC/5M62ssyRlos7GBsgbXMMsn21QEaFARhtqdvHLFp5TTp0Ko2bKH5YUaAl4pEeEEd
         ub5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=iXtdpQd8nnhs4LGXKgAYAQvupi8/WOX4e9Rzt2Cr9CU=;
        b=bEQpzorFw8Zua6YPalVb1bWOpJc60XvwyteGw/hsEWWunjG4zAQHCT8F/sr3v78o9c
         nIV40zqjU8ftKVqb+orRNnhRy/kaNbCZaIf2XFj5qoDkFcnsPPfO35NbHi9UPsTPyu5T
         zj7YdWQLTe07EmfnoPGuat8g4ZsElqtI8ZBh6VljBmC9WlEFaW5s231rhwBpwJKkYHFL
         gHxrrccnC3mBQ5h0O1Ysu2kRbe0d8XaIDQ4zTCQSqoRdEu2xYSZP9wcWt9oiZDl+Vwrs
         zO1cyACAYnHH9PaUz8cSEP1WI7ZTQbIWU8JfjWJ7Biqbjy3zBgdGqw/nnoSICUE30FEJ
         BLbw==
X-Gm-Message-State: APjAAAXzdStbcrWXxogKqcZ7xCd2nWbpfRk70afxS5iaXiI5F6FRlBSm
        uiPYzyqKQB3Rx03jFjmoKDPXnw==
X-Google-Smtp-Source: APXvYqxp30Df9fi24c2tRwl/AdFAuK1PmmHMpS9VUIm5CnVMt7nYgcOw7iNzakTGt5JdeoZaczA5TQ==
X-Received: by 2002:a6b:7d49:: with SMTP id d9mr12058493ioq.50.1562951801913;
        Fri, 12 Jul 2019 10:16:41 -0700 (PDT)
Received: from localhost (67-0-62-24.albq.qwest.net. [67.0.62.24])
        by smtp.gmail.com with ESMTPSA id c81sm13381678iof.28.2019.07.12.10.16.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 10:16:41 -0700 (PDT)
Date:   Fri, 12 Jul 2019 10:16:40 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v8 0/7] Unify CPU topology across ARM & RISC-V 
In-Reply-To: <20190627195302.28300-1-atish.patra@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1907121012050.2267@viisi.sifive.com>
References: <20190627195302.28300-1-atish.patra@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

On Thu, 27 Jun 2019, Atish Patra wrote:

> The cpu-map DT entry in ARM can describe the CPU topology in much better
> way compared to other existing approaches. RISC-V can easily adopt this
> binding to represent its own CPU topology. Thus, both cpu-map DT
> binding and topology parsing code can be moved to a common location so
> that RISC-V or any other architecture can leverage that.
> 
> The relevant discussion regarding unifying cpu topology can be found in
> [1].
> 
> arch_topology seems to be a perfect place to move the common code. I
> have not introduced any significant functional changes in the moved code.
> The only downside in this approach is that the capacity code will be
> executed for RISC-V as well. But, it will exit immediately after not
> able to find the appropriate DT node. If the overhead is considered too
> much, we can always compile out capacity related functions under a
> different config for the architectures that do not support them.
> 
> There was an opportunity to unify topology data structure for ARM32 done
> by patch 3/4. But, I refrained from making any other changes as I am not
> very well versed with original intention for some functions that
> are present in arch_topology.c. I hope this patch series can be served
> as a baseline for such changes in the future.
> 
> The patches have been tested for RISC-V, ARM64, ARM32 & compile tested for
> x86.

Since these patches touch files across several different architectures, 
and thus really should sit in -next for a while; and because it's late in 
the merge window, I'm planning to postpone sending these patches upstream 
until after v5.3-rc1 is released.

Once v5.3-rc1 is released, let's plan to get these patches rebased and 
reposted and into linux-next as soon as possible.


Sorry for the delay here,


- Paul

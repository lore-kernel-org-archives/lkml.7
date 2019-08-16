Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D75DC3A59E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290A52171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="G7B+K2Wj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfHPROE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:14:04 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38662 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfHPROD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:14:03 -0400
Received: by mail-io1-f68.google.com with SMTP id j6so7609013ioa.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 10:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=P1RIaHOqGWyyl0LvEugaw544sTC25Cpr3BLhnNSKbO4=;
        b=G7B+K2WjY9RlUlzaAnqOuGPgUjdTR9RckXKzQpOT2brfVUdN+XfRKMj4LIqCeKcMwY
         5wL7YHYsWryoT9OLwEE/42kvdCggJOgiDaQulrteM7ZK21nW8dbEuSOpz0NXVyHrcrbf
         1vdxpfe58WRpNdCzs7vgJfnCA8bgUR0V+X5CMnFGvMz5mgaif2gYTpOSNSOb9XfkVkdB
         KDShek+ojIQ4Hf34NrJy6/c2ZMJKe5mzh1UVDpMBXf3ZdyHZepAeLMt2U28K3eUmrXtl
         jeBSpwP/0W9vxEtB/531QhxJc0vcVO4ioFfZ+3Kv4uZaUO0yv28yFEXlPBMhKu85DmC/
         C7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=P1RIaHOqGWyyl0LvEugaw544sTC25Cpr3BLhnNSKbO4=;
        b=X1QzHlcFVtJWTxyNQ1MwKjQFhVwU7hwNzCxIu0+uCSKT2CqfScsMRG4HC9+DfcLWRk
         krk3xil64WrmM71y5yEmjYXWerWwME35a75161qXq2N6qhdojFDrabh+4qrP3CcBH8rl
         ArLssEuXufyN1nX+lR0+/YFDTjMBwt4jQiTUjtccRosnuQ70nbMvnCZvN/3qtiVQpm/v
         bQlfNVtWT9XGCqbG4Q2Z1rpDiLzfLif7cjPB9wJljd/mNpTg0WtuYm8u3Lm5eiLQ0OqF
         cNJxzlHBlDwz/Gn05H2O9tX78MyGO/d6/y32fjeTnBqaESxbYkFGedQQ4KbbpHDPSEoQ
         djew==
X-Gm-Message-State: APjAAAUmsNbpn80HR+tSeGV8hjEHZdtTOMcezVVvqBnA/s2MM5sXQdWp
        qHaGybpAoqGIaJj7fFCHKVfQ+w==
X-Google-Smtp-Source: APXvYqyGU90OasXL2SfKiCVDJt51GDcakg9jaNR01R5cy/jXwPzDEB4rhvbBPTJ/NuD7LZkKPqAbTA==
X-Received: by 2002:a5e:df06:: with SMTP id f6mr3225296ioq.93.1565975642550;
        Fri, 16 Aug 2019 10:14:02 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id w6sm5716237iob.29.2019.08.16.10.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 10:14:01 -0700 (PDT)
Date:   Fri, 16 Aug 2019 10:14:01 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Mao Han <han_mao@c-sky.com>
cc:     linux-kernel@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Guo Ren <guoren@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 0/3] riscv: Add perf callchain support
In-Reply-To: <cover.1558081981.git.han_mao@c-sky.com>
Message-ID: <alpine.DEB.2.21.9999.1908161008450.18249@viisi.sifive.com>
References: <cover.1558081981.git.han_mao@c-sky.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mao Han,

On Fri, 17 May 2019, Mao Han wrote:

> This patch set add perf callchain(FP/DWARF) support for RISC-V.
> It comes from the csky version callchain support with some
> slight modifications. The patchset base on Linux 5.1.
> 
> CC: Palmer Dabbelt <palmer@sifive.com>
> CC: linux-riscv <linux-riscv@lists.infradead.org>
> CC: Christoph Hellwig <hch@lst.de>
> CC: Guo Ren <guoren@kernel.org>

I tried these patches on v5.3-rc4, both on the HiFive Unleashed board 
with a Debian-based rootfs and QEMU rv64 with a Fedora-based rootfs.  For 
QEMU, I used defconfig, and for the HiFive Unleashed, I added a few more 
Kconfig directives; and on both, I enabled CONFIG_PERF_EVENTS.  I built 
the perf tools from the kernel tree.

Upon running "/root/bin/perf record -e cpu-clock --call-graph fp 
/bin/ls", I see the backtraces below.  The first is on the HiFive 
Unleashed, the second is on QEMU.  

Could you take a look and tell me if you see similar issues?  And if not, 
could you please walk me through your process for testing these patches on 
rv64, so I can reproduce it here?


thanks,

- Paul


# /root/bin/perf record -e cpu-clock --call-graph fp /bin/ls
[  213.258888] Unable to handle kernel paging request at virtual address ffffffd2d979000c
[  213.266025] Oops [#1]
[  213.268278] Modules linked in:
[  213.271323] CPU: 2 PID: 165 Comm: ls Not tainted 5.3.0-rc4-00006-g2615b94055fc #164
[  213.278961] sepc: ffffffe0005bde76 ra : ffffffe0005bde84 sp : ffffffe1f609d870
[  213.286166]  gp : ffffffe000dbe6c0 tp : ffffffe1f60fa600 t0 : 0000000000046000
[  213.293372]  t1 : 0000000000000002 t2 : 0000002aaaac4890 s0 : ffffffe1f609d8b0
[  213.300579]  s1 : ffffffe1f609d8d8 a0 : 0000000000000004 a1 : 0000000000000000
[  213.307785]  a2 : 10ef8552d9790004 a3 : 0000000000000018 a4 : 0000000000000018
[  213.314991]  a5 : 0000000000000003 a6 : 0000000000000001 a7 : ffffffe1f7b685e0
[  213.322198]  s2 : 10ef8552d9790014 s3 : 0000003fffffffff s4 : 0000000000001ff8
[  213.329404]  s5 : b7e9595db7f9e15f s6 : ffffffe000dbe128 s7 : ffffffe1f8d6f820
[  213.336610]  s8 : 00000031a394a3e8 s9 : ffffffe000656150 s10: 0000000200000120
[  213.343816]  s11: 0000002aaaabc938 t3 : ffffffe1f7b685c0 t4 : 0000000000000001
[  213.351021]  t5 : 0000000000000008 t6 : 0000000000000000
[  213.356319] sstatus: 0000000200000100 sbadaddr: ffffffd2d979000c scause: 000000000000000d
[  213.364482] ---[ end trace f325867b8e0786aa ]---
[  213.369083] Kernel panic - not syncing: Fatal exception in interrupt
[  213.375421] SMP: stopping secondary CPUs
[  213.379336] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---


# /root/bin/perf record -e cpu-clock --call-graph fp /bin/ls
[ 3465.349655] Unable to handle kernel paging request at virtual address d9bfd43b47718688
[ 3465.352356] Oops [#1]
[ 3465.353375] Modules linked in:
[ 3465.354496] CPU: 0 PID: 9501 Comm: ls Not tainted 5.3.0-rc4-00004-g3bfea1b43363 #165
[ 3465.355904] sepc: ffffffe000039a0a ra : ffffffe000039a18 sp : ffffffe078c5b5e0
[ 3465.361041]  gp : ffffffe000837760 tp : ffffffe078d88940 t0 : 0000000000046000
[ 3465.366104]  t1 : 0000000000000002 t2 : 000000004387194a s0 : ffffffe078c5b620
[ 3465.366839]  s1 : ffffffe078c5b648 a0 : 0000000000000004 a1 : 0000000000000000
[ 3465.369101]  a2 : d9bfd43b47718680 a3 : 0000000000000690 a4 : 0000000000000018
[ 3465.370949]  a5 : 0000000000000003 a6 : 0000000000000001 a7 : ffffffe0743b16d0
[ 3465.371650]  s2 : d9bfd43b47718690 s3 : 0000003fffffffff s4 : 0000000000001ff8
[ 3465.372658]  s5 : e85970cf9e9fbbc8 s6 : ffffffe0008371c8 s7 : ffffffe07a1527a0
[ 3465.373570]  s8 : 00000326c7b3d418 s9 : ffffffe0000d3326 s10: 0000000000000120
[ 3465.377102]  s11: ffffffe078cb4880 t3 : ffffffe0743b16c0 t4 : 0000000000000001
[ 3465.378125]  t5 : 0000000000000008 t6 : ffffffe078c5bd60
[ 3465.380603] sstatus: 0000000000000100 sbadaddr: d9bfd43b47718688 scause: 000000000000000d
[ 3465.382872] ---[ end trace f0ff9969d564eb82 ]---
[ 3465.383998] Kernel panic - not syncing: Fatal exception in interrupt
[ 3465.385812] SMP: stopping secondary CPUs
[ 3465.394408] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---


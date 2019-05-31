Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4303C28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 02:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9272525F06
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 02:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MilRU/M0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfEaC2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 22:28:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39459 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfEaC2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 22:28:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id 196so3123997pgc.6;
        Thu, 30 May 2019 19:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=tFPvqxan87K4UIZDQiuamz+1CiNgG4tkkib38N+fGUs=;
        b=MilRU/M0osjINIfZ5urpAG/Vwy8F5NS8GIxLcSTcCg7n+D2VqELO9vvQ7aMe4x8EAl
         7O/kz6NHoNyZV/lXN2FY7Sz4jjXGDhEif7r9Y8GaE7/4ahMUxciPNEN61UysDoifqu0i
         ZYRCgMXid1+PiEykFV/KrHMJC64i0q+eO5JoT6HQd1BT9M0Ys6M7V/lulLhC2AWkIwft
         e9TjgPMDEfyxf+d+AGE26MoAxL9qSA2dvNulJfJC1C0igEgNH3NJ94aR8UmQq2c9k6c5
         cURPxBTjXP0ZkSrznXX3BS4ieMpv0jjUZ7jZFTJLXYSIbJLcFTfCOc+0fLPGINbMLK0e
         2VEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=tFPvqxan87K4UIZDQiuamz+1CiNgG4tkkib38N+fGUs=;
        b=oUx/C6g7mTTXmSEQ4+4XfpAvFO0juVBHRDZuCSSvN+XzrNLYE9/YEH9wcRmuOwSZna
         OcNro/zRQKNN3xIXHP27seLu9xDlnJ1PSyw8b+itMxfPbGUfN3eU9Yev938hxaC6xbwn
         kx5Gu+gJQRNsDkMya+HCdqkQMTTZ8pwVfPhSZLEbdvi9GsQQKIWgVGXqs9/i3ERNJ9lT
         v3u2n1KBEjWV34bO9T9IIY3kK0PqWOnr0G1oH70nP0j+YoHjhNFpoL5/xKHdglT2yIOz
         StSHbq98YFL2jV8AO+aHmT2jQzykugIj1UvGi7fh3GycBmeXBNxxsLr6SPbxm2naPxo5
         lSBA==
X-Gm-Message-State: APjAAAUkt9IJyTuJ9PZ8NCSSoi7rRPG7+r77kJ8d0Hcd9SCbJBSq5HEH
        kKUxEfqqOGjQbqQHso5polU=
X-Google-Smtp-Source: APXvYqwBqYyq2ep6dNEnw7NY9lRuBFO6SE6x4bxClkpAPFVCvb+b+tM9x8ubB+mmXAEwNeHtkGUzGA==
X-Received: by 2002:a65:5308:: with SMTP id m8mr6508684pgq.54.1559269697229;
        Thu, 30 May 2019 19:28:17 -0700 (PDT)
Received: from localhost (193-116-81-133.tpgi.com.au. [193.116.81.133])
        by smtp.gmail.com with ESMTPSA id g8sm3511361pgq.33.2019.05.30.19.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 19:28:16 -0700 (PDT)
Date:   Fri, 31 May 2019 12:27:58 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: linux-next: boot failure after merge of the akpm tree
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux =?iso-8859-1?q?Kernel=0A?= Mailing List 
        <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
References: <20190530161741.0b4c3e92@canb.auug.org.au>
In-Reply-To: <20190530161741.0b4c3e92@canb.auug.org.au>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1559269507.z7w3zfjexi.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell's on May 30, 2019 4:17 pm:
> Hi all,
>=20
> My qemu boot (PowerPC le guest on PowerPC le host, with and without kvm,
> using a kernel built with powerpc_pseries_le_defconfig) oopses during boo=
t
> like this:
>=20
> -------------------------------------------------------------------------=
----
> numa: Node 0 CPUs: 0
> Using standard scheduler topology
> devtmpfs: initialized
> clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_n=
s: 19112604462750000 ns
> futex hash table entries: 256 (order: -1, 32768 bytes)
> ------------[ cut here ]------------
> kernel BUG at mm/vmalloc.c:472!
> Oops: Exception in kernel mode, sig: 5 [#1]
> LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA pSeries
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc2 #2
> NIP:  c000000000369b18 LR: c000000000369c74 CTR: c000000000176e30
> REGS: c00000007e6636e0 TRAP: 0700   Not tainted  (5.2.0-rc2)
> MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24024882  XER: 200=
00000
> CFAR: c000000000369c78 IRQMASK: 0=20
> GPR00: c000000000369c74 c00000007e663970 c00000000119c100 000000000000000=
1=20
> GPR04: 000000007ec20000 00000001f4fe19cb 00000001f5398c84 c00000000138000=
0=20
> GPR08: 0000000000000000 0000000000000001 0000000000000001 00000000000002b=
2=20
> GPR12: 0000000000004000 c000000001380000 c000000000010fc0 000000000000000=
1=20
> GPR16: 0000000000010000 800000000000018e c000000000df9988 000000000000000=
0=20
> GPR20: 0000000000010000 0000000000002dc2 0000000000000dc0 000000000000002=
2=20
> GPR24: c00000007e2204c0 0000000000000dc2 0000000000010000 c00a00000000000=
0=20
> GPR28: c008000000000000 0000000000010000 ffffffffffffffff 0000000000000dc=
0=20
> NIP [c000000000369b18] __vmalloc_node_range+0x1f8/0x410
> LR [c000000000369c74] __vmalloc_node_range+0x354/0x410
> Call Trace:
> [c00000007e663970] [c000000000369c74] __vmalloc_node_range+0x354/0x410 (u=
nreliable)
> [c00000007e663a70] [c000000000369d80] __vmalloc+0x50/0x60
> [c00000007e663ae0] [c000000000299a98] bpf_prog_alloc_no_stats+0x58/0x120
> [c00000007e663b20] [c000000000299b90] bpf_prog_alloc+0x30/0xe0
> [c00000007e663b60] [c000000000a49dd8] bpf_prog_create+0x68/0x100
> [c00000007e663ba0] [c000000000f4f2a8] ptp_classifier_init+0x4c/0x80
> [c00000007e663be0] [c000000000f4b9e8] sock_init+0xe0/0x100
> [c00000007e663c10] [c000000000010b60] do_one_initcall+0x60/0x2c0
> [c00000007e663ce0] [c000000000ee45b0] kernel_init_freeable+0x37c/0x478
> [c00000007e663db0] [c000000000010fe4] kernel_init+0x2c/0x148
> [c00000007e663e20] [c00000000000c0cc] ret_from_kernel_thread+0x5c/0x70
> Instruction dump:
> 60000000 2c230000 418200dc e9580020 79e91f24 7c6a492a 40920170 8138002c=20
> 394f0001 794f0020 7f895040 419dffbc <0fe00000> 60000000 3f400001 4bfffedc=
=20
> ---[ end trace 49ed8f97d467e164 ]---
>=20
> Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x00000005
> -------------------------------------------------------------------------=
----
>=20
> The BUG is:
>=20
> 	BUG_ON(page_shift !=3D PAGE_SIZE);
>=20
> in the !CONFIG_HAVE_ARCH_HUGE_VMAP version of vmap_hpages_range().
>=20
> I am guessing this is something to do with the vmalloc changes in Andrew'=
s
> patches (or it could be the fixup I did to Nick's patch).
>=20
> I have reverted
>=20
>   c353e2997976 ("mm/vmalloc: hugepage vmalloc mappings")
>   a826492f28d9 ("mm: move ioremap page table mapping function to mm/")
>=20
> (and my fix up) for today and things seem to work (if only because the
> BUG() has been removed :-)).

Good to know, maybe I didn't test powerpc without later enabling=20
patches...

The series also has a compile bug on ARM I have to work out, so
yeah drop those for now, I'll post a v2. The large system map patches
that I posted in that series can stay I think.

Thanks,
Nick
=

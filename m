Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE01C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1E52173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b="PjVLUqAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfEILR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 07:17:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42072 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfEILR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:17:56 -0400
Received: by mail-oi1-f196.google.com with SMTP id k9so1577466oig.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 04:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=smWLjGUg06jn9mNxgI74eqHgAJH964ix3KVxduwpFHo=;
        b=PjVLUqAc1KV1M6/mhdzVfBQoYSg827xJyQbCwimbsw53fCylR88pdp/7GMQZqHdkCz
         p1rAXcAjX485WC4t3+EVFBuypekm+n9UCaOJSHybRy1TnGDsD/IDlleMwllUx+a+6Ju5
         Wm9Kc1Umy4Ybqie5pLqYTpQQtQOWl3o+8ujrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=smWLjGUg06jn9mNxgI74eqHgAJH964ix3KVxduwpFHo=;
        b=G9h8s/EXXURRvJ32N7v8udnJ0u5RtxyDy85LOJO8O1wOWIcarqCEFSlmpcLBlH9g1b
         hPOFq2s1tjM3UVxXHFac68LZdGpdlGuBweXDW18cXXgL6Hwl4Y3Eu2o9iCPYbKOIpXrJ
         BNgYa1fEL7a2tWbgzIm4SstnE5rE+pkBy7tfsef/nPA6TVul8p12YEbNQk1sJ/o2IZBV
         1AdWywVS45HJkJ7MwmcLn/Wq0UQ0kYL3J8Svbj/2dSss6d7cTvC7dy72NzMt1cVqwlLL
         8Z//krIGbY9swgcuU3qgkYNDGyaxYh/TOwCOX/8xndq3XNX/hmPA+3KtBDj42BOp/RK+
         ck0w==
X-Gm-Message-State: APjAAAXLUYakrz7Dcy+Xrj7rPYk6NKzXoCTalYYdnfX6AlH50a3fOTDT
        +5pxAR4ggKar8oroq5iyKtDOVjXT7DeZVc2301bynVToT133EQ==
X-Google-Smtp-Source: APXvYqyRgRhvS4MZY/iC+DYai/9+rQqTrcvKWa3Eb1xRLuJBThR1P6FVckreMZUImp5heB5ZMwgBCHahDh9k/grm8VM=
X-Received: by 2002:aca:43d5:: with SMTP id q204mr1174599oia.100.1557400674685;
 Thu, 09 May 2019 04:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <002901d5064d$42355ea0$c6a01be0$@lucidpixels.com>
In-Reply-To: <002901d5064d$42355ea0$c6a01be0$@lucidpixels.com>
From:   Justin Piszcz <jpiszcz@lucidpixels.com>
Date:   Thu, 9 May 2019 07:17:43 -0400
Message-ID: <CAO9zADwmyFZiiHPdggrxkyJ2jL8YOcBY9Wj35zGz5SYAvk+Vvg@mail.gmail.com>
Subject: Re: 5.1 kernel: khugepaged stuck at 100%
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 5:54 AM Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
>
> Hello,
>
> Kernel: 5.1 (self-compiled, no modules)
> Arch: x86_64
> Distro: Debian Testing
>
> Issue: I was performing a dump of ext3 and ext4 filesystems and then
> restoring them to a separate volume (testing)-- afterwards I noticed that
> khugepaged is stuck at 100% CPU. It is currently still stuck at 100% CPU, is
> there anything I can do to debug what is happening prior to a reboot to work
> around the issue?  I have never seen this behavior prior to 5.1.
>
> $ cat /proc/cmdline
> auto BOOT_IMAGE=5.1.0-2 ro root=901 3w-sas.use_msi=1 nohugeiomap
> page_poison=1 pcie_aspm=off pti=on rootfstype=ext4 slub_debug=P
> zram.enabled=1 zram.num_devices=12 zswap.enabled=1 zswap.compressor=lz4
> zswap.zpool=z3fold
>
> $ 5.1 .config attached: config.txt.gz
>
> $ attachment: graphic.JPG -> graph of the processes, dark green ->
> khugepaged
>
> $ top
>
>   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>    77 root      39  19       0      0      0 R 100.0   0.0  23:29.27
> khugepaged
>     1 root      20   0  171800   7832   4948 S   0.0   0.0   1:25.59 systemd
>     2 root      20   0       0      0      0 S   0.0   0.0   0:00.02
> kthreadd
>     3 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_gp
>     4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00
> rcu_par_gp
>     6 root       0 -20       0      0      0 I   0.0   0.0   0:00.00
> kworker/0+
>     8 root       0 -20       0      0      0 I   0.0   0.0   0:00.00
> mm_percpu+
>

Will disable zcache/zswap for now, but FWIW

From perf top:

   PerfTop:    1181 irqs/sec  kernel:83.1%  exact: 96.9% lost: 73/137
drop: 0/0 [4000Hz cycles],  (all, 12 CPUs)
-------------------------------------------------------------------------------

    54.56%  [kernel]            [k] compaction_alloc
    29.46%  [kernel]            [k] __pageblock_pfn_to_page
    10.66%  [kernel]            [k] nmi
     0.61%  [kernel]            [k] _cond_resched
     0.32%  [kernel]            [k] format_decode
     0.25%  [kernel]            [k] __lock_text_start
     0.20%  [kernel]            [k] __vma_adjust
     0.16%  perf                [.] __symbols__insert
     0.13%  perf                [.] rb_insert_color_cached

I tried dropping caches, etc, I will disable huge pages for now.

Some other posts:
https://bugzilla.redhat.com/show_bug.cgi?id=879801
https://lkml.org/lkml/2012/6/27/565
https://lkml.org/lkml/2011/11/9/252

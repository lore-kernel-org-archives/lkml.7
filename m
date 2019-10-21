Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575C2CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8742084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="LB6qbqzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfJUOB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:01:27 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33070 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfJUOB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:01:27 -0400
Received: by mail-qk1-f194.google.com with SMTP id 71so8820029qkl.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 07:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UpxkHPEmvTpGSIaFfa1DVMi1SAwYCw7pioD2SbRukZE=;
        b=LB6qbqzgqbrNch0AZul4MtUoNoWGQPcU8MBz4tSIndiDbzA3fH3ppUvQ5D4B6Wv0zc
         TsAyl2I/FDDcL2jwNvVc+x85z25xX7MPs5XAw7iy2WMQwfXENuw/h6nu3pfhWvkpPO5R
         hbvc/OeLyZdoZgJmlpNPDuYM62Xgl0VwIKBcqZApE3h48gURHvTMJeNYZBcr2bQypfDM
         Z3Q33cO5sR1ZQqsGY+eLRguKebxTpKEn7Un2V15h30Ylag7FK4/07P/Hxn8/FHMGJPYj
         v5MvxM4D6S9gEZKHgOV6QVlH1cHM56QJsgvj7sEZNgjaqo7ihXd1veQRsnjAX53MOsXE
         Vf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UpxkHPEmvTpGSIaFfa1DVMi1SAwYCw7pioD2SbRukZE=;
        b=rRXh0emKY/z490vscyv/ISFOJuntxnyibx3Mxaeh14fhNmfY3SgA5xrGyawwUE4sTR
         B/AHjvnrymU2XRlMN4wzLqkiyKxwVk/KABLWpuOX+wZX/MHlw1ORh3wU3WWiZ//rlj2X
         82TSsx03HUrB0asHXGhEvSh+p8rmjl1c/gpr434BX6PBLYLTXXtldEIdWDn0kk+F9fL/
         txFmW2Pwh9g5tiXky/8gy3fWbHAbfURtglAUTFUD+x1lU2MLaj0avRAdCwn+vk5H4+we
         YvojC+Hgbv4DLsgdsuX/y0ls43Yfe/smKMtjrdEQQ7qn4jpnjm0U+mmkeuK/UTYjm+Ie
         gBkA==
X-Gm-Message-State: APjAAAWGWeP8Z5e6yZV53qHav9G4VU0XJJxdsNfa2HtjaiWcnTPQY1Sl
        wWDmdZq8tOyiJax6HeNu0xbWfA==
X-Google-Smtp-Source: APXvYqy3UHgnO34VHMLYiT3Nah+9/0i2v9AhBD33Pql6X9qoosSZ2V8VKcb48rozDP8Aa5t7888x4w==
X-Received: by 2002:a05:620a:9da:: with SMTP id y26mr12170065qky.456.1571666485959;
        Mon, 21 Oct 2019 07:01:25 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q64sm8476827qkb.32.2019.10.21.07.01.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 07:01:25 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/3] mm, meminit: Recalculate pcpu batch and high limits
 after init completes
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20191021094808.28824-2-mgorman@techsingularity.net>
Date:   Mon, 21 Oct 2019 10:01:24 -0400
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <85A7E76A-0839-4A43-86F3-6847639F9F92@lca.pw>
References: <20191021094808.28824-1-mgorman@techsingularity.net>
 <20191021094808.28824-2-mgorman@techsingularity.net>
To:     Mel Gorman <mgorman@techsingularity.net>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 21, 2019, at 5:48 AM, Mel Gorman <mgorman@techsingularity.net> =
wrote:
>=20
> Deferred memory initialisation updates zone->managed_pages during
> the initialisation phase but before that finishes, the per-cpu page
> allocator (pcpu) calculates the number of pages allocated/freed in
> batches as well as the maximum number of pages allowed on a per-cpu =
list.
> As zone->managed_pages is not up to date yet, the pcpu initialisation
> calculates inappropriately low batch and high values.
>=20
> This increases zone lock contention quite severely in some cases with =
the
> degree of severity depending on how many CPUs share a local zone and =
the
> size of the zone. A private report indicated that kernel build times =
were
> excessive with extremely high system CPU usage. A perf profile =
indicated
> that a large chunk of time was lost on zone->lock contention.
>=20
> This patch recalculates the pcpu batch and high values after deferred
> initialisation completes for every populated zone in the system. It
> was tested on a 2-socket AMD EPYC 2 machine using a kernel compilation
> workload -- allmodconfig and all available CPUs.
>=20
> mmtests configuration: config-workload-kernbench-max
> Configuration was modified to build on a fresh XFS partition.
>=20
> kernbench
>                                5.4.0-rc3              5.4.0-rc3
>                                  vanilla           resetpcpu-v2
> Amean     user-256    13249.50 (   0.00%)    16401.31 * -23.79%*
> Amean     syst-256    14760.30 (   0.00%)     4448.39 *  69.86%*
> Amean     elsp-256      162.42 (   0.00%)      119.13 *  26.65%*
> Stddev    user-256       42.97 (   0.00%)       19.15 (  55.43%)
> Stddev    syst-256      336.87 (   0.00%)        6.71 (  98.01%)
> Stddev    elsp-256        2.46 (   0.00%)        0.39 (  84.03%)
>=20
>                   5.4.0-rc3    5.4.0-rc3
>                     vanilla resetpcpu-v2
> Duration User       39766.24     49221.79
> Duration System     44298.10     13361.67
> Duration Elapsed      519.11       388.87
>=20
> The patch reduces system CPU usage by 69.86% and total build time by
> 26.65%. The variance of system CPU usage is also much reduced.
>=20
> Before, this was the breakdown of batch and high values over all zones =
was.
>=20
>    256               batch: 1
>    256               batch: 63
>    512               batch: 7
>    256               high:  0
>    256               high:  378
>    512               high:  42
>=20
> 512 pcpu pagesets had a batch limit of 7 and a high limit of 42. After =
the patch
>=20
>    256               batch: 1
>    768               batch: 63
>    256               high:  0
>    768               high:  378
>=20
> Cc: stable@vger.kernel.org # v4.1+
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
> mm/page_alloc.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
>=20
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c0b2e0306720..f972076d0f6b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1947,6 +1947,14 @@ void __init page_alloc_init_late(void)
> 	/* Block until all are initialised */
> 	wait_for_completion(&pgdat_init_all_done_comp);
>=20
> +	/*
> +	 * The number of managed pages has changed due to the =
initialisation
> +	 * so the pcpu batch and high limits needs to be updated or the =
limits
> +	 * will be artificially small.
> +	 */
> +	for_each_populated_zone(zone)
> +		zone_pcp_update(zone);
> +
> 	/*
> 	 * We initialized the rest of the deferred pages.  Permanently =
disable
> 	 * on-demand struct page initialization.
> --=20
> 2.16.4
>=20
>=20

Warnings from linux-next,

[   14.265911][  T659] BUG: sleeping function called from invalid =
context at kernel/locking/mutex.c:935
[   14.265992][  T659] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, =
pid: 659, name: pgdatinit8
[   14.266044][  T659] 1 lock held by pgdatinit8/659:
[   14.266075][  T659]  #0: c000201ffca87b40 =
(&(&pgdat->node_size_lock)->rlock){....}, at: =
deferred_init_memmap+0xc4/0x26c
[   14.266160][  T659] irq event stamp: 26
[   14.266194][  T659] hardirqs last  enabled at (25): =
[<c000000000950584>] _raw_spin_unlock_irq+0x44/0x80
[   14.266246][  T659] hardirqs last disabled at (26): =
[<c0000000009502ec>] _raw_spin_lock_irqsave+0x3c/0xa0
[   14.266299][  T659] softirqs last  enabled at (0): =
[<c0000000000ff8d0>] copy_process+0x720/0x19b0
[   14.266339][  T659] softirqs last disabled at (0): =
[<0000000000000000>] 0x0
[   14.266400][  T659] CPU: 64 PID: 659 Comm: pgdatinit8 Not tainted =
5.4.0-rc4-next-20191021 #1
[   14.266462][  T659] Call Trace:
[   14.266494][  T659] [c00000003d8efae0] [c000000000921cf4] =
dump_stack+0xe8/0x164 (unreliable)
[   14.266538][  T659] [c00000003d8efb30] [c000000000157c54] =
___might_sleep+0x334/0x370
[   14.266577][  T659] [c00000003d8efbb0] [c00000000094a784] =
__mutex_lock+0x84/0xb20
[   14.266627][  T659] [c00000003d8efcc0] [c000000000954038] =
zone_pcp_update+0x34/0x64
[   14.266677][  T659] [c00000003d8efcf0] [c000000000b9e6bc] =
deferred_init_memmap+0x1b8/0x26c
[   14.266740][  T659] [c00000003d8efdb0] [c000000000149528] =
kthread+0x1a8/0x1b0
[   14.266792][  T659] [c00000003d8efe20] [c00000000000b748] =
ret_from_kernel_thread+0x5c/0x74
[   14.268288][  T659] node 8 initialised, 1879186 pages in 12200ms
[   14.268527][  T659] pgdatinit8 (659) used greatest stack depth: 27984 =
bytes left
[   15.589983][  T658] BUG: sleeping function called from invalid =
context at kernel/locking/mutex.c:935
[   15.590041][  T658] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, =
pid: 658, name: pgdatinit0
[   15.590078][  T658] 1 lock held by pgdatinit0/658:
[   15.590108][  T658]  #0: c000001fff5c7b40 =
(&(&pgdat->node_size_lock)->rlock){....}, at: =
deferred_init_memmap+0xc4/0x26c
[   15.590192][  T658] irq event stamp: 18
[   15.590224][  T658] hardirqs last  enabled at (17): =
[<c000000000950654>] _raw_spin_unlock_irqrestore+0x94/0xd0
[   15.590283][  T658] hardirqs last disabled at (18): =
[<c0000000009502ec>] _raw_spin_lock_irqsave+0x3c/0xa0
[   15.590332][  T658] softirqs last  enabled at (0): =
[<c0000000000ff8d0>] copy_process+0x720/0x19b0
[   15.590379][  T658] softirqs last disabled at (0): =
[<0000000000000000>] 0x0
[   15.590414][  T658] CPU: 8 PID: 658 Comm: pgdatinit0 Tainted: G       =
 W         5.4.0-rc4-next-20191021 #1
[   15.590460][  T658] Call Trace:
[   15.590491][  T658] [c00000003d8cfae0] [c000000000921cf4] =
dump_stack+0xe8/0x164 (unreliable)
[   15.590541][  T658] [c00000003d8cfb30] [c000000000157c54] =
___might_sleep+0x334/0x370
[   15.590588][  T658] [c00000003d8cfbb0] [c00000000094a784] =
__mutex_lock+0x84/0xb20
[   15.590643][  T658] [c00000003d8cfcc0] [c000000000954038] =
zone_pcp_update+0x34/0x64
[   15.590689][  T658] [c00000003d8cfcf0] [c000000000b9e6bc] =
deferred_init_memmap+0x1b8/0x26c
[   15.590739][  T658] [c00000003d8cfdb0] [c000000000149528] =
kthread+0x1a8/0x1b0
[   15.590790][  T658] [c00000003d8cfe20] [c00000000000b748] =
ret_from_kernel_thread+0x5c/0x74


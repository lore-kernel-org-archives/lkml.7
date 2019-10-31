Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E849CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5B82086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="UQBU8pga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfJaJgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 05:36:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38875 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfJaJgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 05:36:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id j30so201337pgn.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 02:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=W3IvectI3U8q0HFF/2f4e8iwJrLi+nuiRQbnbTxHTY4=;
        b=UQBU8pga/J7ePOwPMzsTWyVEdxrfo7cdGzhDjxv8yuKxBCWLeUX7wN0ysAomBzf0rv
         6HkWJH85yBZWYjLtk16ZSrZR9tst8mYaRvC5ni/cd5jRuKZc3d+k4Qcs6U8qzK8b6Gwy
         hshflkHLKqRQnXnqJ5o9u8/e4HMs5ZY+fQkss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=W3IvectI3U8q0HFF/2f4e8iwJrLi+nuiRQbnbTxHTY4=;
        b=nRk1oOAFOOn+//MP1MR0qmhBLYQdlk8GQ5hfRqK8wZyoSmaAhZ0L5fb/8ewERYyMKP
         yt9Y1V/qhGT5A4xbP401Oi9Oz2DF3+cwx7zjvB2vdtKVDYbUtcRp4V/k2NzQf//ds4TI
         3LIPWC/sfSFZyg1uZlTyxDvcC7vvgDVapdFkoNfHIRMT5fMTVo55YFpLKse0UJn1u8oK
         waGDf4E+jK7qmRvF6cosQ7jdwm+4f2lZHy3UChIZr/IBp6imd+rP1njrL1DwOZdKQYcP
         kddeS4BgOJ09bto1SmkZSg5apFFgFSbHr6XO+tuSFEWLxIR7ipkLtHOGUVPad5aH5HZq
         27hQ==
X-Gm-Message-State: APjAAAWicBqpQCZ4b/on6/6UJt7rVeAAQUCzQkZX4G6cY41Z55c3UyzO
        THeotZMh5CK47ExAClgSE/bmOhwz+qo=
X-Google-Smtp-Source: APXvYqzhpdRbvtvxfJX9ZT+cYCOInadyvR9a7dOApHJ2j74C/PDMrWRAe01F5X/e2EPBEt+jSYBJog==
X-Received: by 2002:a17:90a:c505:: with SMTP id k5mr5768175pjt.84.1572514612591;
        Thu, 31 Oct 2019 02:36:52 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-783a-2bb9-f7cb-7c3c.static.ipv6.internode.on.net. [2001:44b8:1113:6700:783a:2bb9:f7cb:7c3c])
        by smtp.gmail.com with ESMTPSA id i16sm2708223pfa.184.2019.10.31.02.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 02:36:51 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com
Subject: Re: [PATCH v10 1/5] kasan: support backing vmalloc space with real shadow memory
In-Reply-To: <20191030142951.GA24958@pc636>
References: <20191029042059.28541-1-dja@axtens.net> <20191029042059.28541-2-dja@axtens.net> <20191030142951.GA24958@pc636>
Date:   Thu, 31 Oct 2019 20:36:48 +1100
Message-ID: <87k18lmf2n.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uladzislau Rezki <urezki@gmail.com> writes:

> Hello, Daniel
>
>>  
>> @@ -1294,14 +1299,19 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
>>  	spin_lock(&free_vmap_area_lock);
>>  	llist_for_each_entry_safe(va, n_va, valist, purge_list) {
>>  		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
>> +		unsigned long orig_start = va->va_start;
>> +		unsigned long orig_end = va->va_end;
>>  
>>  		/*
>>  		 * Finally insert or merge lazily-freed area. It is
>>  		 * detached and there is no need to "unlink" it from
>>  		 * anything.
>>  		 */
>> -		merge_or_add_vmap_area(va,
>> -			&free_vmap_area_root, &free_vmap_area_list);
>> +		va = merge_or_add_vmap_area(va, &free_vmap_area_root,
>> +					    &free_vmap_area_list);
>> +
>> +		kasan_release_vmalloc(orig_start, orig_end,
>> +				      va->va_start, va->va_end);
>>  
> I have some questions here. I have not analyzed kasan_releace_vmalloc()
> logic in detail, sorry for that if i miss something. __purge_vmap_area_lazy()
> deals with big address space, so not only vmalloc addresses it frees here,
> basically it can be any, starting from 1 until ULONG_MAX, whereas vmalloc
> space spans from VMALLOC_START - VMALLOC_END:
>
> 1) Should it be checked that vmalloc only address is freed or you handle
> it somewhere else?
>
> if (is_vmalloc_addr(va->va_start))
>     kasan_release_vmalloc(...)

So in kasan_release_vmalloc we only free the region covered by the
shadow of orig_start to orig_end, and possibly 1 page to either side. So
it will never attempt to free an enormous area. And it will also do
nothing if called for a region where there is no shadow backin
installed.

Having said that, there should be a test on orig_start, and I've added
that in v11 - good catch.

> 2) Have you run any bencmarking just to see how much overhead it adds?
> I am asking, because probably it make sense to add those figures to the
> backlog(commit message). For example you can run:
>
> <snip>
> sudo ./test_vmalloc.sh performance
> and
> sudo ./test_vmalloc.sh sequential_test_order=1
> <snip>

I have now done that:

Testing with test_vmalloc.sh on an x86 VM with 2 vCPUs shows that:

 - Turning on KASAN, inline instrumentation, without this feature, introuduces
   a 4.1x-4.2x slowdown in vmalloc operations.

 - Turning this on introduces the following slowdowns over KASAN:
     * ~1.76x slower single-threaded (test_vmalloc.sh performance)
     * ~2.18x slower when both cpus are performing operations
       simultaneously (test_vmalloc.sh sequential_test_order=1)

This is unfortunate but given that this is a debug feature only, not
the end of the world.

The full figures are:


Performance

                              No KASAN      KASAN original x baseline  KASAN vmalloc x baseline    x KASAN

fix_size_alloc_test            1697913            14229459       8.38       22981983      13.54       1.62
full_fit_alloc_test            1841601            15152633       8.23       17902922       9.72       1.18
long_busy_list_alloc_test     17874082            58856758       3.29      103925371       5.81       1.77
random_size_alloc_test         9356047            29544085       3.16       57871338       6.19       1.96
fix_align_alloc_test           3188968            19821620       6.22       37979436      11.91       1.92
random_size_align_alloc_te     3033507            17584339       5.80       32588942      10.74       1.85
align_shift_alloc_test             325                1154       3.55           7263      22.35       6.29
pcpu_alloc_test                 231952              278181       1.20         318977       1.38       1.15
Total Cycles              235852824254        985040965542       4.18  1733258779416       7.35       1.76

Sequential, 2 cpus

                              No KASAN      KASAN original x baseline  KASAN vmalloc x baseline    x KASAN

fix_size_alloc_test            2505806            17989253       7.18       39651038      15.82       2.20
full_fit_alloc_test            3579676            18829862       5.26       21142645       5.91       1.12
long_busy_list_alloc_test     21594983            74766736       3.46      140701363       6.52       1.88
random_size_alloc_test        10884695            34282077       3.15       91945108       8.45       2.68
fix_align_alloc_test           4133226            26304745       6.36       76163270      18.43       2.90
random_size_align_alloc_te     4261175            22927883       5.38       55236058      12.96       2.41
align_shift_alloc_test             948                4827       5.09           4144       4.37       0.86
pcpu_alloc_test                 371789              307654       0.83         374412       1.01       1.22
Total Cycles               99965417402        412710461642       4.13   897968646378       8.98       2.18
fix_size_alloc_test            2502718            17921542       7.16       39893515      15.94       2.23
full_fit_alloc_test            3547996            18675007       5.26       21330495       6.01       1.14
long_busy_list_alloc_test     21522579            74610739       3.47      139822907       6.50       1.87
random_size_alloc_test        10881507            34317349       3.15       91110531       8.37       2.65
fix_align_alloc_test           4119755            26180887       6.35       75818927      18.40       2.90
random_size_align_alloc_te     4297708            23058344       5.37       55969004      13.02       2.43
align_shift_alloc_test             956                5574       5.83           4591       4.80       0.82
pcpu_alloc_test                 306340              347014       1.13         571289       1.86       1.65
Total Cycles               99642832084        412084074628       4.14   896497227762       9.00       2.18


Regards,
Daniel

> Thanks!
>
> --
> Vlad Rezki

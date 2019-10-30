Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582D7CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BEC82087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="NTwARt8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfJ3NuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 09:50:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35819 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfJ3NuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:50:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id x6so1029853pln.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 06:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=pb0XrKghyFZgq2oeDgc1vRiv8K2ZCa6MKROaXA8DqHQ=;
        b=NTwARt8GUFCdG5TLJcI8i9cPiC/uXK1HfVAmkF/Gi70bnHnieGDcLcKhO+TpHqC1fD
         x4C83BpfmUyDj8Rjo5KmeHlhXkrHNK0d01ZempNxNYWBY4EvFCzdf8V7F/HDhoG9uk2i
         sSv0amtdfi01NJeawZo9HWDVM2mJxLKzuZIuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=pb0XrKghyFZgq2oeDgc1vRiv8K2ZCa6MKROaXA8DqHQ=;
        b=mROqbA94ZvsWkosErhqkPAQoEklDTuRYRjAwVwNPB+F8c8JltqfpnIrLoHO+GsVI5L
         hrg/dpmH77gdIXAnvQAsfIDtZyZv9e6Nof78aP1T3c+jst08ttZFmHJUNqKEvaRfgYSU
         IXtUqKox9faaq5PsWrfsp2qJOcgdxI0i24MrXtFfs0Gu6SYMcySmh/lwVbvH0c6956D3
         2s8F7/2/yGwJ+lxuBdxTDyNu7l2nXL78HK708A8sqybX8xTcO7A+mCgKNc3HbJ1buVs4
         hrD8p1+fve3hTDh9yUWzo/uVypSJMLbw518lcaCHlxJNW+x/N5As0t/xO8B52KicNemz
         SzeA==
X-Gm-Message-State: APjAAAW+eNek24o5+/37S7wCzCVVhAchFLeX0j1mU+S/4Ahc2E01TC6q
        jE3QlO61hCa5j0esKKWG6tNBqA==
X-Google-Smtp-Source: APXvYqxZKEVBxM1Ya92TQcJqH+4T3C4D/gFc7Fw6wdXNjsqrvLc0beAsZLlvhMi0VRPxusNFqNzDbA==
X-Received: by 2002:a17:902:760c:: with SMTP id k12mr102582pll.256.1572443409483;
        Wed, 30 Oct 2019 06:50:09 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-783a-2bb9-f7cb-7c3c.static.ipv6.internode.on.net. [2001:44b8:1113:6700:783a:2bb9:f7cb:7c3c])
        by smtp.gmail.com with ESMTPSA id e198sm35049pfh.83.2019.10.30.06.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 06:50:08 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        glider@google.com, luto@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 4/5] x86/kasan: support KASAN_VMALLOC
In-Reply-To: <a144eaca-d7e1-1a18-5975-bd0bfdb9450e@virtuozzo.com>
References: <20191029042059.28541-1-dja@axtens.net> <20191029042059.28541-5-dja@axtens.net> <a144eaca-d7e1-1a18-5975-bd0bfdb9450e@virtuozzo.com>
Date:   Thu, 31 Oct 2019 00:50:05 +1100
Message-ID: <87sgnamjg2.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Ryabinin <aryabinin@virtuozzo.com> writes:

> On 10/29/19 7:20 AM, Daniel Axtens wrote:
>> In the case where KASAN directly allocates memory to back vmalloc
>> space, don't map the early shadow page over it.
>> 
>> We prepopulate pgds/p4ds for the range that would otherwise be empty.
>> This is required to get it synced to hardware on boot, allowing the
>> lower levels of the page tables to be filled dynamically.
>> 
>> Acked-by: Dmitry Vyukov <dvyukov@google.com>
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>> 
>> ---
>
>> +static void __init kasan_shallow_populate_pgds(void *start, void *end)
>> +{
>> +	unsigned long addr, next;
>> +	pgd_t *pgd;
>> +	void *p;
>> +	int nid = early_pfn_to_nid((unsigned long)start);
>
> This doesn't make sense. start is not even a pfn. With linear mapping 
> we try to identify nid to have the shadow on the same node as memory. But 
> in this case we don't have memory or the corresponding shadow (yet),
> we only install pgd/p4d.
> I guess we could just use NUMA_NO_NODE.

Ah wow, that's quite the clanger on my part.

There are a couple of other invocations of early_pfn_to_nid in that file
that use an address directly, but at least they reference actual memory.
I'll send a separate patch to fix those up.

> The rest looks ok, so with that fixed:
>
> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>

Thanks heaps! I've fixed up the nit you identifed in the first patch,
and I agree that the last patch probably isn't needed. I'll respin the
series shortly.

Regards,
Daniel

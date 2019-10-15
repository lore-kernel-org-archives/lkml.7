Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165FFC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 06:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEC8217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 06:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="BrUhn4gp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfJOG2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 02:28:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35247 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfJOG2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 02:28:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so11805626pfw.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 23:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=NXE3NjexAQXsjlqVk+3nF0FjJ7hypONs1Weo4aM4img=;
        b=BrUhn4gpvpU5Z1D3BIYiGb5+BX15AlS0UBGrN2TfSOqnRdqvz5ESw5SxNRYtS6rfNu
         yEEKByqH3yonfpP8XawOOPCfeNQSFnK5jX/7PnK2qG0KaOjg7QKYKECvhz/2DsUi6qL3
         idKHz9QtT8s/JH4+qA0A7Xc0ogpK60OJ9OHFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=NXE3NjexAQXsjlqVk+3nF0FjJ7hypONs1Weo4aM4img=;
        b=KUA9Lh8jk4eyp4AZ+l+E3+IOuuB493FZft8zd2GHl6ml/kyzqz3Dp4AjDrOqP3rhX0
         APY4jLf+V55s5+nZPS3ZYVEzNJUTuJJLg8/ThhPeovXKhXg5DkBSDGGvVp6JunZOuLDG
         mpE/QCIHRah06aZVf/jzTNwafN7eaRU2ZSfrM388SqcqCS9WmZaFJ4mPeMOfmHSt0pET
         crLxvItwbHoIt0hAw3Vv6B4oWF5wQ9zaV1jBBNDx+58B5DjRn6wAtYs1ZKh+DS48zS7l
         mKyOCI7fnUUl8nHEchPCpOqm+TSjrJ+kdib98bGHbzp+/3wiT38fEuIpJgmZ7/qY2OS+
         insQ==
X-Gm-Message-State: APjAAAVi3AQBitcOOcFwuxGcuUStBS9qBGivkS7TFujaxAmd2R5CL8um
        3aKiNkL1cYwFu/XS+KpHdZi7e6XtVgw=
X-Google-Smtp-Source: APXvYqx2YnPD7idhykG7qGhqI/5d0pFVNgvu+VZ7HdsMybk4ZNBm9CymFRlu6abFrzqOPws1e0wZyg==
X-Received: by 2002:a17:90a:6302:: with SMTP id e2mr39528114pjj.20.1571120881762;
        Mon, 14 Oct 2019 23:28:01 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id q76sm44206995pfc.86.2019.10.14.23.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 23:28:00 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, dvyukov@google.com,
        christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org,
        gor@linux.ibm.com
Subject: Re: [PATCH v8 1/5] kasan: support backing vmalloc space with real shadow memory
In-Reply-To: <20191014154359.GC20438@lakrids.cambridge.arm.com>
References: <20191001065834.8880-1-dja@axtens.net> <20191001065834.8880-2-dja@axtens.net> <20191014154359.GC20438@lakrids.cambridge.arm.com>
Date:   Tue, 15 Oct 2019 17:27:57 +1100
Message-ID: <87a7a2ttea.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rutland <mark.rutland@arm.com> writes:

> On Tue, Oct 01, 2019 at 04:58:30PM +1000, Daniel Axtens wrote:
>> Hook into vmalloc and vmap, and dynamically allocate real shadow
>> memory to back the mappings.
>> 
>> Most mappings in vmalloc space are small, requiring less than a full
>> page of shadow space. Allocating a full shadow page per mapping would
>> therefore be wasteful. Furthermore, to ensure that different mappings
>> use different shadow pages, mappings would have to be aligned to
>> KASAN_SHADOW_SCALE_SIZE * PAGE_SIZE.
>> 
>> Instead, share backing space across multiple mappings. Allocate a
>> backing page when a mapping in vmalloc space uses a particular page of
>> the shadow region. This page can be shared by other vmalloc mappings
>> later on.
>> 
>> We hook in to the vmap infrastructure to lazily clean up unused shadow
>> memory.
>> 
>> To avoid the difficulties around swapping mappings around, this code
>> expects that the part of the shadow region that covers the vmalloc
>> space will not be covered by the early shadow page, but will be left
>> unmapped. This will require changes in arch-specific code.
>> 
>> This allows KASAN with VMAP_STACK, and may be helpful for architectures
>> that do not have a separate module space (e.g. powerpc64, which I am
>> currently working on). It also allows relaxing the module alignment
>> back to PAGE_SIZE.
>> 
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=202009
>> Acked-by: Vasily Gorbik <gor@linux.ibm.com>
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>> [Mark: rework shadow allocation]
>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>
> Sorry to point this out so late, but your S-o-B should come last in the
> chain per Documentation/process/submitting-patches.rst. Judging by the
> rest of that, I think you want something like:
>
> Co-developed-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com> [shadow rework]
> Signed-off-by: Daniel Axtens <dja@axtens.net>
>
> ... leaving yourself as the Author in the headers.

no worries, I wasn't really sure how best to arrange them, so thanks for
clarifying!

>
> Sorry to have made that more complicated!
>
> [...]
>
>> +static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
>> +					void *unused)
>> +{
>> +	unsigned long page;
>> +
>> +	page = (unsigned long)__va(pte_pfn(*ptep) << PAGE_SHIFT);
>> +
>> +	spin_lock(&init_mm.page_table_lock);
>> +
>> +	if (likely(!pte_none(*ptep))) {
>> +		pte_clear(&init_mm, addr, ptep);
>> +		free_page(page);
>> +	}
>
> There should be TLB maintenance between clearing the PTE and freeing the
> page here.

Fixed for v9.

Regards,
Daniel

>
> Thanks,
> Mark.

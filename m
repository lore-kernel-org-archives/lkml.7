Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF22C5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE26D2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kkh8QnWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfF1D7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 23:59:42 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:47033 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfF1D7l (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 23:59:41 -0400
Received: by mail-io1-f43.google.com with SMTP id i10so9521114iol.13
        for <Linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 20:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cs/BCNc/RCyeiUvf3Dd7XA6XNw70/7ZfOeMlzKTDfTw=;
        b=Kkh8QnWIzrZazVljg6hBsx7W/ZP0eBr1ejVjQyHZVuyvnJ6opqO1Z13W5iz5qwZfcj
         H0lYWcBOzr76HbMzjj9mSOh7bOMz8gIv2Mc8LAsLOX1h/MbSQcUX+u0P7/MCrytmMmf1
         LP6QAlNDiOPI4CvLDKDvIhwWm+6F4zDZ/QIV2jsOeWikKn5H8nTXUpxnPFDi+tADdELb
         wftLrz7FO1ZOq0s5Vc8glGunRKW99QX4s7hsFHySk3XEKUzqbNXquuqnZrDKU6fKvAgc
         +PVk85g3fniAVaasVO0H0eME/b4zu2fMzz+50cj1nNgjd2/g2/SKXK8IT1YVcTH0vSHL
         pMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cs/BCNc/RCyeiUvf3Dd7XA6XNw70/7ZfOeMlzKTDfTw=;
        b=IBcnEnQPLY9hoDEzBKl+nlxW3eXPOIK3UB7KPFBltqkUI3lLCCF76aKVOdu6wYXF6Z
         1RxUYUXPWARRF4uKP83YsplweVxgY02q/Zx9ysncG5QEWpXJLdUbz7QEXh1qAVmV6ILM
         v2RephfPvDttzfsAhPGQgDZ5HPcr+O5Q8BFPBks5u9OfBBBazWMNpUH/3prwo41j35mp
         H8aAw8aXuTLALFqE5LUq4RqzrUbuVpEe9i4viwXBP39N6kGQG5XGVh5kfAFM/AztZo+t
         2cjUnpYbeRPKff8X3GQti+/jDbxPd9GwhRpQJCyU5JtMlyNzOFr0859cLH1GRMxLkosX
         em7w==
X-Gm-Message-State: APjAAAWvYk5NN7c+V9BfV5RIIVozceioxq5eaCLvbT4ZbdaVGIUEocEu
        Y+UN4rQ7VOn8UAl2vud+Tp3YMcHMhs3OAgYcqQ==
X-Google-Smtp-Source: APXvYqyY3ydiSQhtYGah1iASt/iBOIbXr1KVVwN5LrQiYQZl9AUwyMpJlNcyVhrRfjf43MZT+WCGvVS8crgLy/UEH1M=
X-Received: by 2002:a02:c6b8:: with SMTP id o24mr9180808jan.80.1561694381133;
 Thu, 27 Jun 2019 20:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <1561612545-28997-1-git-send-email-kernelfans@gmail.com> <20190627162511.1cf10f5b04538c955c329408@linux-foundation.org>
In-Reply-To: <20190627162511.1cf10f5b04538c955c329408@linux-foundation.org>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 28 Jun 2019 11:59:29 +0800
Message-ID: <CAFgQCTsO6WOef1v69J3+Vx-AuU8pPVeJSTjrf04VQum=YXEk2w@mail.gmail.com>
Subject: Re: [PATCHv5] mm/gup: speed up check_and_migrate_cma_pages() on huge page
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        LKML <Linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 7:25 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 27 Jun 2019 13:15:45 +0800 Pingfan Liu <kernelfans@gmail.com> wrote:
>
> > Both hugetlb and thp locate on the same migration type of pageblock, since
> > they are allocated from a free_list[]. Based on this fact, it is enough to
> > check on a single subpage to decide the migration type of the whole huge
> > page. By this way, it saves (2M/4K - 1) times loop for pmd_huge on x86,
> > similar on other archs.
> >
> > Furthermore, when executing isolate_huge_page(), it avoid taking global
> > hugetlb_lock many times, and meanless remove/add to the local link list
> > cma_page_list.
> >
>
> Thanks, looks good to me.  Have any timing measurements been taken?
Not yet. It is a little hard to force huge page to be allocated CMA
area. Should I provide the measurements?
>
> > ...
> >
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -1336,25 +1336,30 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
> >                                       struct vm_area_struct **vmas,
> >                                       unsigned int gup_flags)
> >  {
> > -     long i;
> > +     long i, step;
>
> I'll make these variables unsigned long - to match nr_pages and because
> we have no need for them to be negative.
OK, will fix it.

Thanks,
  Pingfan
>
> > ...

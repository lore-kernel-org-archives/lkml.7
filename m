Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F94C31E4E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDB42073F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="KVXUFAN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfFNSEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:04:07 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:45801 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFNSEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:04:07 -0400
Received: by mail-oi1-f174.google.com with SMTP id m206so2576045oib.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 11:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KI77U09jc4yTSNFo3uKcj1zjV8YecEqjHXwcoLePMbY=;
        b=KVXUFAN3swMFWBGzzixjB8VlLjL76aesYtmPDtHwjQ4F2McCRNHoqKURqafp/z9EzM
         CAB5WYDWPfK52bdUBpHevist0z44Pi2lSZn189XQJxSDbdHQfkUYppM1ZJysDXyxLF9j
         +Xm0fCtvrQaDvbqusIZe7jzFxi25W/YjyILyNf5tasvgIEADk/uTH1mnlPi8s7MYFP/8
         EODfrEggoA1lfki5F+9dja6mP9uPJruC1He/5jm9B0GhXCV1WKodyOoCFK/Gc+Y9KRdF
         7C1NEl1EFI4aOl01s/23HOQgsTtc9R5bUauyt0GKzfzdpx8EXaePvYzuSjjyqZRp/sWE
         lsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KI77U09jc4yTSNFo3uKcj1zjV8YecEqjHXwcoLePMbY=;
        b=izAp34G0lgn0Zpuu7wMASUWXcWdNJS9hC48uC5w7vcDBV1qDUwtAyuPeeskpHIS6hv
         xYrEfmjNxO6tKxCKhNlYORayUrbjNQop0D9o/YPExQhIil5wI7euJvrHqKmz4eVc/daK
         LJjwU70NFheMSzPHu79qGKx0PbNXMxMm+hvsZuN/1ThjiUS9XBim7eR4iYdUzuUjKhd1
         3U6MD/Du9gp+xQCXbZfXZ69vD193dMP0FZ6gWmWSK5CHE9wWKRaYatAWV7oEn3fZWpw/
         bUJJGWlzNVGG4lbg9V06KmBGcrn+K8iSsK5VmO61PrpWypihU31SNLcuHP6kW+3TSJRR
         2CCg==
X-Gm-Message-State: APjAAAXh8Xx0UaEojzGTuTvH+G9eWsND/UEy9tDuk3h7fl/5T8BphIIB
        UVhXYf2pvC5B5x4ZNtr3YiQwiheUb+xOXDd9rkxuaA==
X-Google-Smtp-Source: APXvYqwbsBOYR/vwuJCqEYhR3cOJgH0hPf6MeFYglFOg2KYQKUxstG5xreGllhZuqvwSfn7udfK/3H+QuupdLKIx3Yo=
X-Received: by 2002:aca:4208:: with SMTP id p8mr2745114oia.105.1560535446101;
 Fri, 14 Jun 2019 11:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <1560366952-10660-1-git-send-email-cai@lca.pw> <CAPcyv4hn0Vz24s5EWKr39roXORtBTevZf7dDutH+jwapgV3oSw@mail.gmail.com>
 <CAPcyv4iuNYXmF0-EMP8GF5aiPsWF+pOFMYKCnr509WoAQ0VNUA@mail.gmail.com>
 <1560376072.5154.6.camel@lca.pw> <87lfy4ilvj.fsf@linux.ibm.com> <1560524365.5154.21.camel@lca.pw>
In-Reply-To: <1560524365.5154.21.camel@lca.pw>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 14 Jun 2019 11:03:55 -0700
Message-ID: <CAPcyv4jAzMzFjSD22VU9Csw+kgGbf8r=XHbdJYzgL_uH_GVEvw@mail.gmail.com>
Subject: Re: [PATCH -next] mm/hotplug: skip bad PFNs from pfn_to_online_page()
To:     Qian Cai <cai@lca.pw>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 7:59 AM Qian Cai <cai@lca.pw> wrote:
>
> On Fri, 2019-06-14 at 14:28 +0530, Aneesh Kumar K.V wrote:
> > Qian Cai <cai@lca.pw> writes:
> >
> >
> > > 1) offline is busted [1]. It looks like test_pages_in_a_zone() missed the
> > > same
> > > pfn_section_valid() check.
> > >
> > > 2) powerpc booting is generating endless warnings [2]. In
> > > vmemmap_populated() at
> > > arch/powerpc/mm/init_64.c, I tried to change PAGES_PER_SECTION to
> > > PAGES_PER_SUBSECTION, but it alone seems not enough.
> > >
> >
> > Can you check with this change on ppc64.  I haven't reviewed this series yet.
> > I did limited testing with change . Before merging this I need to go
> > through the full series again. The vmemmap poplulate on ppc64 needs to
> > handle two translation mode (hash and radix). With respect to vmemap
> > hash doesn't setup a translation in the linux page table. Hence we need
> > to make sure we don't try to setup a mapping for a range which is
> > arleady convered by an existing mapping.
>
> It works fine.

Strange... it would only change behavior if valid_section() is true
when pfn_valid() is not or vice versa. They "should" be identical
because subsection-size == section-size on PowerPC, at least with the
current definition of SUBSECTION_SHIFT. I suspect maybe
free_area_init_nodes() is too late to call subsection_map_init() for
PowerPC.

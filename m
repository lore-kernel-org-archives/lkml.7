Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B9BC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353D7217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="1MsSopdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfETTda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:33:30 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34100 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfETTd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:33:29 -0400
Received: by mail-ot1-f66.google.com with SMTP id l17so14118610otq.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 12:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qGBGhJB57YNAdImoizW32uytynq+gOiiGUhFhCXS0Eg=;
        b=1MsSopdTCsKraANCSKqF8PkxUMuTUoIUX0XO+JfoxkweztyYhtzTmIQcE8sdcRWVP1
         Fg0I2uWxd6AfxohwPY4dVXOa5GSrBd8YuEgTpyjwQpaQMvUX5RMIyltCY8N1R74raqPP
         HjA8UzJ7Ok893kpAWJGplsaQ4/xqw/FC5u845MKOBoIRlf9j8440PEUtUsmBKg35J779
         oHgEefa+u6KkVzFDKrK9tMjfHTnogbSN9rtWs3uV3aH9slC9uklwamdRB6ILUVg5w8IA
         VFVQPjlq3w7YXuc88iwUhcMwzR5Fum0dqGybPoNp6dlZXnkXWg9APZOq/w6S85LcVRwe
         sc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qGBGhJB57YNAdImoizW32uytynq+gOiiGUhFhCXS0Eg=;
        b=nDYRzznU9hGKyQ8XL2PFgFEx6s1Ff2/UWZvA/04BulRveQFTMiVgfSpdo8YpRTlsdg
         npJjeMSx1rWV0uQrJEAEEnXx7UcclCZY0c75RZoUoelSCOV35rkteBHqa0YCDqD9Tz6q
         91ShS7xgLyFeNNo8bj2ST5ihy9qaNCq1IFUKXxC/044q65znVVebpiZo57EzMRVlDkEa
         lOlyOmD8S9bi2bphNWTFO9x8DucLoUXRjyi2esFF2qB/e6tz3fKFouPSJVp7jzTIuPxh
         xcyB7fM3C4Ezm0f9r690rd8By3NIuHINAJzWJD9o2NUyWp/2DBwLKn/Ucxihw/XxeJI6
         OWbA==
X-Gm-Message-State: APjAAAX4Bk+6MTHUXt2tzbvKMi2V8pnBMc+uAjJgsVXfJpzKRbORn5iz
        QD1n6458IkPz6SeazgsTVh8NhlBhmfwEca6a3F2Bk7lF
X-Google-Smtp-Source: APXvYqxLMFozNV6q34tnpQxP/V7RDYkIWBzc4fvMUALsYjtMGCEcUw5ebnzdkghF4wJZ7BssXKYTwlfrdTh73iXn4bA=
X-Received: by 2002:a05:6830:1182:: with SMTP id u2mr34896558otq.71.1558380809245;
 Mon, 20 May 2019 12:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <1558089514-25067-1-git-send-email-anshuman.khandual@arm.com>
 <20190517145050.2b6b0afdaab5c3c69a4b153e@linux-foundation.org>
 <cb8cbd57-9220-aba9-7579-dbcf35f02672@arm.com> <20190520192721.GA4049@redhat.com>
In-Reply-To: <20190520192721.GA4049@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 20 May 2019 12:33:17 -0700
Message-ID: <CAPcyv4gN0Pz66a_dEMxkS5xvCyPoboGEkyxZFHQU3L2DDj8fAg@mail.gmail.com>
Subject: Re: [PATCH] mm/dev_pfn: Exclude MEMORY_DEVICE_PRIVATE while computing
 virtual address
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 12:27 PM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Mon, May 20, 2019 at 11:07:38AM +0530, Anshuman Khandual wrote:
> > On 05/18/2019 03:20 AM, Andrew Morton wrote:
> > > On Fri, 17 May 2019 16:08:34 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> > >
> > >> The presence of struct page does not guarantee linear mapping for the pfn
> > >> physical range. Device private memory which is non-coherent is excluded
> > >> from linear mapping during devm_memremap_pages() though they will still
> > >> have struct page coverage. Just check for device private memory before
> > >> giving out virtual address for a given pfn.
> > >
> > > I was going to give my standard "what are the user-visible runtime
> > > effects of this change?", but...
> > >
> > >> All these helper functions are all pfn_t related but could not figure out
> > >> another way of determining a private pfn without looking into it's struct
> > >> page. pfn_t_to_virt() is not getting used any where in mainline kernel.Is
> > >> it used by out of tree drivers ? Should we then drop it completely ?
> > >
> > > Yeah, let's kill it.
> > >
> > > But first, let's fix it so that if someone brings it back, they bring
> > > back a non-buggy version.
> >
> > Makes sense.
> >
> > >
> > > So...  what (would be) the user-visible runtime effects of this change?
> >
> > I am not very well aware about the user interaction with the drivers which
> > hotplug and manage ZONE_DEVICE memory in general. Hence will not be able to
> > comment on it's user visible runtime impact. I just figured this out from
> > code audit while testing ZONE_DEVICE on arm64 platform. But the fix makes
> > the function bit more expensive as it now involve some additional memory
> > references.
>
> A device private pfn can never leak outside code that does not understand it
> So this change is useless for any existing users and i would like to keep the
> existing behavior ie never leak device private pfn.

The issue is that only an HMM expert might know that such a pfn can
never leak, in other words the pfn concept from a code perspective is
already leaked / widespread. Ideally any developer familiar with a pfn
and the core-mm pfn helpers need only worry about pfn semantics
without being required to go audit HMM users.

Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B919FC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757FA217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="AJYXOTYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfDSDZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 23:25:35 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:44354 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbfDSDZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 23:25:35 -0400
Received: by mail-oi1-f181.google.com with SMTP id i21so3156838oib.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 20:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M3KZlmbTuZ2H5T1ldOvJ/lTcJF1EunhRYO6gI9bp16A=;
        b=AJYXOTYal8a2RJDZxJcIFEijx9f6mEXGoR2tvf87cLkTecJtJ9YSBPnmpvUr4hok50
         cOQr9jW3d8KRIyb+1UWV7nyqpA1jlQVBa8IQI/Mq1U8oICkWET/LYgNdqqIGX5OyOamG
         +iLu0IlSHZF84ih+uZdtIqpI4lRnXwEfZH4vfm6YZsQ7SROSE6X/D8pmo+m/2WmZNKCa
         FTOMq7Kcdcu8EA9JfZ3lbs1IdfIi/zIOknFoud1nDCQhyTPiA08KHifPPr53WK9uqR45
         MbZe/7R714qEPt1svrbQqFNxhAm2ALVqpOp1yDMoV+XcdJUIXfyBQeXUF+fKft4Gk/Ho
         IeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M3KZlmbTuZ2H5T1ldOvJ/lTcJF1EunhRYO6gI9bp16A=;
        b=rKZ7aGHIakVnI8EoTGEhTMQaF3kJDhpcsl4vHWw3goCvyW7bBwwjmzaChe8+kzab1A
         l21BGXlLVDs9xl4yHlAgcyCOuDZbEUpIYzI4F5Tu0yHyVUlcVtxFyiJ+kEySxPTwA2q0
         5L6Tbt7mVk2u9wYAHn9yyQUbT2A0BBf0ywcXra3o8FMbLUCw24m5CBZ71ecQWC61ip0B
         n9D3jU151zJIpTtYsutvdez+smQfLcde+vrp01qh3Y/sTCg65PYN9xSXmNxZDrahp/p/
         vGprM5VWLgq4Fwm6lTgCO2UJGBk4dU8J1B4NloHBi1annhElUdyo2ynqc9It4kyoYebE
         wKNA==
X-Gm-Message-State: APjAAAXFVg6thiq9PkDOwwp+NvKc+KOpa9/G+0mtT1oJ7UVUZ/7AIhgI
        4edmLWL9CZ6x6NehBvbuT0MghOjz3wbtB0hkrHF+UA==
X-Google-Smtp-Source: APXvYqzZF3vp7DVt9JqqtH0Z9V1KA9PGDB7qSCTpqgGKNLlAzHxWdi2y+8hfsB3Ix4eXJHqq+3zDLC3S85uNsv5YmY4=
X-Received: by 2002:aca:aa57:: with SMTP id t84mr700347oie.149.1555644334421;
 Thu, 18 Apr 2019 20:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190417150331.90219ca42a1c0db8632d0fd5@linux-foundation.org>
 <CAPcyv4hB47NJrVi1sm+7msL+6dJNhBD10BJbtLPZRcK2JK6+pg@mail.gmail.com>
 <CAPcyv4iW=xhhUQbg0bt=xCgVaR_jUvATeLxSoCfvzG5gTEAX6A@mail.gmail.com> <x49lg07eb3d.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49lg07eb3d.fsf@segfault.boston.devel.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 18 Apr 2019 20:25:22 -0700
Message-ID: <CAPcyv4jZwRfL5st3_MKwtTyuX8Rb+dYq6vpqwaEpp+BmZTgrYQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/12] mm: Sub-section memory hotplug support
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        stable <stable@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 5:45 AM Jeff Moyer <jmoyer@redhat.com> wrote:
[..]
> >> > v6 and we're not showing any review activity.  Who would be suitable
> >> > people to help out here?
> >>
> >> There was quite a bit of review of the cover letter from Michal and
> >> David, but you're right the details not so much as of yet. I'd like to
> >> call out other people where I can reciprocate with some review of my
> >> own. Oscar's altmap work looks like a good candidate for that.
> >
> > I'm also hoping Jeff can give a tested-by for the customer scenarios
> > that fall over with the current implementation.
>
> Sure.  I'll also have a look over the patches.

Andrew, heads up it looks like there is a memory corruption bug in
these patches as I've gotten a few reported of "bad page state" at
boot. Please drop until I can track down the failure.

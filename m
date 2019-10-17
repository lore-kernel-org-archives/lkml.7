Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31334ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0718421925
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shdaf3RG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440666AbfJQRUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:20:43 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37121 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbfJQRUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:20:42 -0400
Received: by mail-qt1-f196.google.com with SMTP id n17so4721765qtr.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 10:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qhptbpId7hBoCEy521ZldkxQoZ8KyT+B+QjPOyNo5f4=;
        b=shdaf3RG+fIKoGa0z2l/NkUI+QSGKKpOKxxaiF90zWPhsnEc8EiAfpbnd2S9OWAPAJ
         bcXLZTUi9GwCYBdVmPOSWSCcd89tXJhLO+NdzZSsgLUKIlDDfCWi4Utzj7ZCjiVTRL60
         +5iiurA6DXo4kxPiaGVaFeXWDicGzgQWmMmz2M5Fq0UfSVP7mmCcPRqR6d3rgrMxtWeD
         LP8FY/MFZcmObD4HT4SftqKmi5sey/YfVCLhObskA3iO0k5TI9IcGzGp3Hgx4pVhX0Qs
         peUUIw05kWHFGQ7VwaQWVpNVmgqrst7IIfpzuvN+eenxlKQPNeFghk3Ohm0mKY8VbctO
         UIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhptbpId7hBoCEy521ZldkxQoZ8KyT+B+QjPOyNo5f4=;
        b=h2IuL7174LuvvfJysRfT2xa2vpGuZ+ERZejiqTCykf34ffuXodWGrxubxT737wJGge
         ncKzFUQ8c4+Wg+hhJWciUfVKFP+TWs1WeFZxnhfkWrp+Ew5WHmQdxMUHyjcf8mMXT8xg
         J1kexkwogsneJv1MMr6L5AiEA519vvrnWfCO5vimNZu67E/bgzZzanKjap/S17uZQH1M
         eOWOQQErMtNLMAYv99LM26oSYkJA+idm+C4PksHMFekEcUt6GErYpXEa5ChLumT9c13h
         vUsbB2Oec4B9HEYWXnSoiXzZgJ0tKLBQbmh0eRHZ1KraewMzLNt7kPaYASq/QhIw0Yxr
         M46A==
X-Gm-Message-State: APjAAAVOEg6NxPAuXFTFJcmYz0ZZZZL9nPzolV0kS4qz/64SH0FMjbYm
        n5bVUVtbOjBlzafeB9wd7GDOGcgAYgTVd5TqkW7orFthC7c=
X-Google-Smtp-Source: APXvYqxdtktP+2U70vxHOqKva5KuxDofP+Rntw44AzYUZmxHU+3P46z5pumD6R+jgyMCQf7jp5NDIKNndOqoBhe57HY=
X-Received: by 2002:ad4:530b:: with SMTP id y11mr4937814qvr.12.1571332841511;
 Thu, 17 Oct 2019 10:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191016221148.F9CCD155@viggo.jf.intel.com> <CALvZod5wdToX6bx4Bnwx9AgrzY3xkmE0OMH61f88hKxeGX+tvA@mail.gmail.com>
 <496566a6-2581-17f4-a4f2-e5def7f97582@intel.com>
In-Reply-To: <496566a6-2581-17f4-a4f2-e5def7f97582@intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 17 Oct 2019 10:20:30 -0700
Message-ID: <CAHbLzkq6cvS4L4DYnr+oyggfXzZTKegfpdNUi_XHA+-67HZYNA@mail.gmail.com>
Subject: Re: [PATCH 0/4] [RFC] Migrate Pages in lieu of discard
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Adams <jwadams@google.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 7:26 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 10/16/19 8:45 PM, Shakeel Butt wrote:
> > On Wed, Oct 16, 2019 at 3:49 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
> >> This set implements a solution to these problems.  At the end of the
> >> reclaim process in shrink_page_list() just before the last page
> >> refcount is dropped, the page is migrated to persistent memory instead
> >> of being dropped.
> ..> The memory cgroup part of the story is missing here. Since PMEM is
> > treated as slow DRAM, shouldn't its usage be accounted to the
> > corresponding memcg's memory/memsw counters and the migration should
> > not happen for memcg limit reclaim? Otherwise some jobs can hog the
> > whole PMEM.
>
> My expectation (and I haven't confirmed this) is that the any memory use
> is accounted to the owning cgroup, whether it is DRAM or PMEM.  memcg
> limit reclaim and global reclaim both end up doing migrations and
> neither should have a net effect on the counters.

Yes, your expectation is correct. As long as PMEM is a NUMA node, it
is treated as regular memory by memcg. But, I don't think memcg limit
reclaim should do migration since limit reclaim is used to reduce
memory usage, but migration doesn't reduce usage, it just moves memory
from one node to the other.

In my implementation, I just skip migration for memcg limit reclaim,
please see: https://lore.kernel.org/linux-mm/1560468577-101178-7-git-send-email-yang.shi@linux.alibaba.com/

>
> There is certainly a problem here because DRAM is a more valuable
> resource vs. PMEM, and memcg accounts for them as if they were equally
> valuable.  I really want to see memcg account for this cost discrepancy
> at some point, but I'm not quite sure what form it would take.  Any
> feedback from you heavy memcg users out there would be much appreciated.

We did have some demands to control the ratio between DRAM and PMEM as
I mentioned in LSF/MM. Mel Gorman did suggest make memcg account DRAM
and PMEM respectively or something similar.

>
> > Also what happens when PMEM is full? Can the memory migrated to PMEM
> > be reclaimed (or discarded)?
>
> Yep.  The "migration path" can be as long as you want, but once the data
> hits a "terminal node" it will stop getting migrated and normal discard
> at the end of reclaim happens.

I recalled I had a hallway conversation with Keith about this in
LSF/MM. We all agree there should be not a cycle. But, IMHO, I don't
think exporting migration path to userspace (or letting user to define
migration path) and having multiple migration stops are good ideas in
general.

>

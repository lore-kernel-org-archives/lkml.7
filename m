Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34796C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC1520868
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbfEWLE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 07:04:58 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55089 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbfEWLE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 07:04:58 -0400
Received: by mail-it1-f193.google.com with SMTP id h20so8891882itk.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 04:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bszh6zWvpIHD18LEdDJozbrleTCn7t9j7iqoQX16fGM=;
        b=RD08U9sC6ZYEHrUzMFD6/ept4W9FyhEN3Lm8Jzb61IKq9RLIC05QlTgbHnkrc1HfKp
         y161BMqwOJDpwXWvXxlCrZ/flAA5VS31End9o8WTyahHtGwlI3ltlZKUNWMDCdZZHcuK
         ICedpJn+6hlVZHVZnOgJe+ZoWYH9h8xKYkhlUBdgdYRTEwUgzMjKvl6t/ZPPF/3UmtoM
         GEKJ50uGEdFw6VbTjGwo/lhPthfAUHVbmPH3o2YkA24dYbpcEpnl+hyFtI0D/sl4aPLM
         9gxStzKR3BSozqrUgSjtyGEOvlHISPIYl0OjcKINZVKC4q2uOvcfBM77TmtqWWk5hzAn
         SiPg==
X-Gm-Message-State: APjAAAWxpmyEbe7jEz5HlnnxtgfDBQ8g68FlFtLTrrbJc9iDUo0nvqjo
        cjfepVaaQVmvRkhobF08Su0jlYiHJM1dm6v2RrODKw==
X-Google-Smtp-Source: APXvYqxpHp3aEjhr0YWO4vPclq+586+5ta6PM+gNM5Wk9qiqR0agN/Sh7u8nwGrt0VxhHiM/lpyPe4e06GbuTy54uEo=
X-Received: by 2002:a24:6cd5:: with SMTP id w204mr12287305itb.12.1558609497196;
 Thu, 23 May 2019 04:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190520061834.32231-1-kasong@redhat.com> <0c0fb7af-f386-bde1-46f6-1afa29782243@redhat.com>
In-Reply-To: <0c0fb7af-f386-bde1-46f6-1afa29782243@redhat.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Thu, 23 May 2019 19:04:36 +0800
Message-ID: <CACPcB9fWsOHGhyF-b4emTuoTUO4twbG6of=bruBYop4Jf4rzig@mail.gmail.com>
Subject: Re: [PATCH v2] vmcore: Add a kernel cmdline vmcore_device_dump
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 2:44 AM Bhupesh Sharma <bhsharma@redhat.com> wrote:
>
> On 05/20/2019 11:48 AM, Kairui Song wrote:
> > Since commit 2724273e8fd0 ('vmcore: add API to collect hardware dump in
> > second kernel'), drivers is allowed to add device related dump data to
> > vmcore as they want by using the device dump API. This have a potential
> > issue, the data is stored in memory, drivers may append too much data
> > and use too much memory. The vmcore is typically used in a kdump kernel
> > which runs in a pre-reserved small chunk of memory. So as a result it
> > will make kdump unusable at all due to OOM issues.
> >
> > So introduce new vmcore_device_dump= kernel parameter, and disable
> > device dump by default. User can enable it only if device dump data is
> > required for debugging, and have the chance to increase the kdump
> > reserved memory accordingly before device dump fails kdump.
> >
> > Signed-off-by: Kairui Song <kasong@redhat.com>
> > ---
> >   Update from V1:
> >    - Use bool parameter to turn it on/off instead of letting user give
> >      the size limit. Size of device dump is hard to determine.
> >
> >   Documentation/admin-guide/kernel-parameters.txt | 15 +++++++++++++++
> >   fs/proc/vmcore.c                                | 13 +++++++++++++
> >   2 files changed, 28 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 43176340c73d..2d48e39fd080 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5062,6 +5062,21 @@
> >                       decrease the size and leave more room for directly
> >                       mapped kernel RAM.
> >
> > +     vmcore_device_dump=
> > +                     [VMCORE]
> > +                     Format: {"off" | "on"}
> > +                     If CONFIG_PROC_VMCORE_DEVICE_DUMP is set,
> > +                     this parameter allows enable or disable device dump
> > +                     for vmcore.
>
> We can add a simpler description here, something like:
>                         Depends on CONFIG_PROC_VMCORE_DEVICE_DUMP
>
> > +                     Device dump allows drivers to append dump data to
> > +                     vmcore so you can collect driver specified debug info.
> > +                     Note that the drivers could append the data without
> > +                     any limit, and the data is stored in memory, this may
> > +                     bring a significant memory stress. If you want to turn
> > +                     on this option, make sure you have reserved enough memory
> > +                     with crashkernel= parameter.
> > +                     default: off
>
> ... and massage the rest of text accordingly.
>
> Better to also modify the help text for 'PROC_VMCORE_DEVICE_DUMP' config
> option defined in 'fs/proc/Kconfig'. Something like:
>
> config PROC_VMCORE_DEVICE_DUMP
>         bool "Device Hardware/Firmware Log Collection"
> <..snip..>
>           If you say Y here, the collected device dumps will be added
>           as ELF notes to /proc/vmcore.
>
>           If this option is selected, device dump collection can still be
> disabled by passing vmcore_device_dump=off to the kernel.
>
> See config INTEL_IOMMU_DEFAULT_ON in 'drivers/iommu/Kconfig' as an example.
>

Good suggestion! I'll update in V3.

-- 
Best Regards,
Kairui Song

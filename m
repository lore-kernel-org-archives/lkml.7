Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACC0C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 05:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B09120657
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 05:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfE0FFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 01:05:32 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50836 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfE0FFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 01:05:32 -0400
Received: by mail-it1-f195.google.com with SMTP id a186so15093668itg.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 22:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fecGg/jgfxlMFonO7luUGh/bB0iD//wEkaV+M3q4RX0=;
        b=WVjOr102Rts5WSL+aV6qzakniqQ4vY7SI4peHwHMuTR017FqPNxWXxhHJkdovoTXET
         mylIYkf368mhroQp2W5rUNUE//3HFl1DXzkQhObMAw+QqYQdf1qiQ7Jkva2/GRQeyqwo
         1BGXJJXFwllLuKk9JDawwdJTXGzwBxCmZszEZfmLLqAV+WjvXTtSZZDh5/jjxNkTaM5D
         wq41jcCszYjDajJrqQHEo2Mdq5O2adluRVisF+UtKcRW0xwOJSVNTzLDwRr6KxyqSzJ8
         8qsIezmpLiYce9AZpJBCuhBdzQcqCVy6MwwrATWgYScQCi/ipaou3I+hlqCGEcAsYacl
         RCjA==
X-Gm-Message-State: APjAAAXQCQQmfZtgaxKl5Dt5aaYzppRTs8cJZITHrB0eR1o/1lRinCdJ
        1zgmixVzKbkDgzypTr8IYPUEs9hALMx5GS56XldVDQ==
X-Google-Smtp-Source: APXvYqwcvPdCPk8AIJTPTsjfAvZ8f+sZfCQfXTM00cFHC0kZBGd/ZsBpfBgRTX83yFH2Q1m7gbhpZEMO6ZUuaBDBTJ0=
X-Received: by 2002:a24:7a90:: with SMTP id a138mr27452432itc.95.1558933531100;
 Sun, 26 May 2019 22:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190524062922.26399-1-kasong@redhat.com> <20190524125456.GA3342@dhcp-128-65.nay.redhat.com>
 <CACi5LpNue+9GVafB-aYxhTNRWf6jbRk9O6Vq8BCQO3EHWrNnrw@mail.gmail.com>
In-Reply-To: <CACi5LpNue+9GVafB-aYxhTNRWf6jbRk9O6Vq8BCQO3EHWrNnrw@mail.gmail.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Mon, 27 May 2019 13:05:20 +0800
Message-ID: <CACPcB9eGujOmDMfez2dWUtt2s6K=bDp2PEDSKhY9NLu2pHpfvg@mail.gmail.com>
Subject: Re: [PATCH v3] vmcore: Add a kernel parameter vmcore_device_dump
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 2:45 AM Bhupesh Sharma <bhsharma@redhat.com> wrote:
>
> On Fri, May 24, 2019 at 6:25 PM Dave Young <dyoung@redhat.com> wrote:
> >
> > On 05/24/19 at 02:29pm, Kairui Song wrote:
> > > Since commit 2724273e8fd0 ("vmcore: add API to collect hardware dump in
> > > second kernel"), drivers is allowed to add device related dump data to
> > > vmcore as they want by using the device dump API. This have a potential
> > > issue, the data is stored in memory, drivers may append too much data
> > > and use too much memory. The vmcore is typically used in a kdump kernel
> > > which runs in a pre-reserved small chunk of memory. So as a result it
> > > will make kdump unusable at all due to OOM issues.
> > >
> > > So introduce new vmcore_device_dump= kernel parameter, and disable
> > > device dump by default. User can enable it only if device dump data is
> > > required for debugging, and have the chance to increase the kdump
> > > reserved memory accordingly before device dump fails kdump.
> > >
> > > Signed-off-by: Kairui Song <kasong@redhat.com>
> > >
> > > ---
> > >
> > >  Update from V2:
> > >   - Improve related docs
> > >
> > >  Update from V1:
> > >   - Use bool parameter to turn it on/off instead of letting user give
> > >     the size limit. Size of device dump is hard to determine.
> > >
> > >  Documentation/admin-guide/kernel-parameters.txt | 14 ++++++++++++++
> > >  fs/proc/Kconfig                                 |  6 ++++--
> > >  fs/proc/vmcore.c                                | 13 +++++++++++++
> > >  3 files changed, 31 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index 138f6664b2e2..3706ad9e1d97 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -5078,6 +5078,20 @@
> > >                       decrease the size and leave more room for directly
> > >                       mapped kernel RAM.
> > >
> > > +     vmcore_device_dump=     [KNL,KDUMP]
> > > +                     Format: {"off" | "on"}
> > > +                     Depends on CONFIG_PROC_VMCORE_DEVICE_DUMP.
> > > +                     This parameter allows enable or disable device dump
> > > +                     for vmcore on kernel start-up.
> > > +                     Device dump allows drivers to append dump data to
> > > +                     vmcore so you can collect driver specified debug info.
> > > +                     Note that the drivers could append the data without
> > > +                     any limit, and the data is stored in memory, this may
> > > +                     bring a significant memory stress. If you want to turn
> > > +                     on this option, make sure you have reserved enough memory
> > > +                     with crashkernel= parameter.
> > > +                     default: off
> > > +
> > >       vmcp_cma=nn[MG] [KNL,S390]
> > >                       Sets the memory size reserved for contiguous memory
> > >                       allocations for the vmcp device driver.
> > > diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
> > > index 817c02b13b1d..1a7a38976bb0 100644
> > > --- a/fs/proc/Kconfig
> > > +++ b/fs/proc/Kconfig
> > > @@ -56,8 +56,10 @@ config PROC_VMCORE_DEVICE_DUMP
> > >         recovery kernel's initramfs to collect its underlying device
> > >         snapshot.
> > >
> > > -       If you say Y here, the collected device dumps will be added
> > > -       as ELF notes to /proc/vmcore.
> > > +       If you say Y here, a new kernel parameter 'vmcore_device_dump'
> > > +       will be available. You can then enable device dump by passing
> >
> > "a new kernel parameter 'vmcore_device_dump' will be available" is not
> > necessary, "new" is a not a clear word.  I suggest to remove this
> > sentence.
> >
> > s/You can then/You can
>
> I agree with Dave. We are just trying to say here that even if
> CONFIG_PROC_VMCORE_DEVICE_DUMP is set to Y, one can still disable the
> device dump feature by passing parameter 'vmcore_device_dump=off' to
> the kernel.
>
> May be you can use the wording I mentioned in the v2 patch review,
> which tried to convey a similar meaning.
>
> With the change addressed:
> Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>
>
> Thanks,
> Bhupesh
>
OK, How about:

  If you say Y here, device dump is still disabled by default.
  You can enable device dump by passing 'vmcore_device_dump=on'
  to kernel, the collected device dumps will be added as ELF
  notes to /proc/vmcore.

If you think this is good I'll send V4 including the changes.

-- 
Best Regards,
Kairui Song

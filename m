Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84019C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5391120868
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbfEWLFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 07:05:02 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43318 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbfEWLFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 07:05:00 -0400
Received: by mail-io1-f68.google.com with SMTP id v7so4471021iob.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 04:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eRrHvKQERKjgiXIkofXLltvm3gZLl1VkOb0Hjm91f/o=;
        b=Nvh4OWo5wZF6S6jcn2vkVwIlefsuZac9N8dLbpx9mPggRSFSBMxL2iTPNMQndOjKof
         EITwsoT0KuVYZNCJOkiiK2G2xj+iP8ZaDUaSZ5Wge89QK8Z3dhkUObWNBGAVBjVBje8+
         sMds8yhGFW7ISoYyoeFVgvn7Tro/K4Za+J1eaZddu/Q3sqnbdwyar5F7mstfIAslnIDT
         cYRtwaCxq94lrs2mRx5bn389KWTLqoqorvhi49CefteqDup08znW6A3Dp3Zjd1ZL7Hdp
         C5k2bgGhU3+q8hI9qMsgFT3HObdtS0KHrRRZtiND21JJMaQSe3OtWN6BAPWYYZe0/4zh
         9ivA==
X-Gm-Message-State: APjAAAUxhQLBa7K84MbKB3syajHa98o/rU9bk0+Q7gkGOww/GU6SprHl
        jhPOSPZTab5iAj/vfLvqsEkwFuVXJC8805TCZJo0JQ==
X-Google-Smtp-Source: APXvYqzhB+kWTw0fY0OON2WJw3UAMBGFm+i/VrtMNe1jls4j2XTSAkI0N08ZlcXD33EQ59ABBEMrh2dEdMkWZS2bEzE=
X-Received: by 2002:a05:6602:211a:: with SMTP id x26mr2541980iox.202.1558609499901;
 Thu, 23 May 2019 04:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190520061834.32231-1-kasong@redhat.com> <20190522053822.GA4472@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190522053822.GA4472@dhcp-128-65.nay.redhat.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Thu, 23 May 2019 19:04:42 +0800
Message-ID: <CACPcB9dM97sFmydswSkpj8nmFHvsWXUhnQJ-8jW2aEc-m7g9qg@mail.gmail.com>
Subject: Re: [PATCH v2] vmcore: Add a kernel cmdline vmcore_device_dump
To:     Dave Young <dyoung@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Bhupesh Sharma <bhsharma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 1:38 PM Dave Young <dyoung@redhat.com> wrote:
>
> On 05/20/19 at 02:18pm, Kairui Song wrote:
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
> >  Update from V1:
> >   - Use bool parameter to turn it on/off instead of letting user give
> >     the size limit. Size of device dump is hard to determine.
> >
> >  Documentation/admin-guide/kernel-parameters.txt | 15 +++++++++++++++
> >  fs/proc/vmcore.c                                | 13 +++++++++++++
> >  2 files changed, 28 insertions(+)
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
>
> It looks better to have above two line merged in one line, also use
> [KNL, KDUMP] will be better.
>
> > +                     Format: {"off" | "on"}
> > +                     If CONFIG_PROC_VMCORE_DEVICE_DUMP is set,
> > +                     this parameter allows enable or disable device dump
> > +                     for vmcore.
> > +                     Device dump allows drivers to append dump data to
> > +                     vmcore so you can collect driver specified debug info.
> > +                     Note that the drivers could append the data without
> > +                     any limit, and the data is stored in memory, this may
> > +                     bring a significant memory stress. If you want to turn
> > +                     on this option, make sure you have reserved enough memory
> > +                     with crashkernel= parameter.
> > +                     default: off
> > +
> >       vmcp_cma=nn[MG] [KNL,S390]
> >                       Sets the memory size reserved for contiguous memory
> >                       allocations for the vmcp device driver.
> > diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> > index 3fe90443c1bb..d1b608b0efad 100644
> > --- a/fs/proc/vmcore.c
> > +++ b/fs/proc/vmcore.c
> > @@ -53,6 +53,8 @@ static struct proc_dir_entry *proc_vmcore;
> >  /* Device Dump list and mutex to synchronize access to list */
> >  static LIST_HEAD(vmcoredd_list);
> >  static DEFINE_MUTEX(vmcoredd_mutex);
> > +
> > +static bool vmcoredd_enabled;
> >  #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
> >
> >  /* Device Dump Size */
> > @@ -1451,6 +1453,11 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
> >       size_t data_size;
> >       int ret;
> >
> > +     if (!vmcoredd_enabled) {
> > +             pr_err_once("Device dump is disabled\n");
> > +             return -EINVAL;
> > +     }
> > +
> >       if (!data || !strlen(data->dump_name) ||
> >           !data->vmcoredd_callback || !data->size)
> >               return -EINVAL;
> > @@ -1502,6 +1509,12 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
> >       return ret;
> >  }
> >  EXPORT_SYMBOL(vmcore_add_device_dump);
> > +
> > +static int __init vmcoredd_parse_cmdline(char *arg)
> > +{
> > +     return kstrtobool(arg, &vmcoredd_enabled);
> > +}
> > +__setup("vmcore_device_dump=", vmcoredd_parse_cmdline);
> >  #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
> >
> >  /* Free all dumps in vmcore device dump list */
> > --
> > 2.21.0
> >
>
> Thanks
> Dave

Good suggestion, I'll update in V3.

-- 
Best Regards,
Kairui Song

Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B12C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DF3206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbfETGVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 02:21:11 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36755 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbfETGVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 02:21:10 -0400
Received: by mail-io1-f68.google.com with SMTP id e19so10131199iob.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 23:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PZhlZQDH0UX81lkJWWOeHSTJfZZYrpPxyp1pvS+ZbMc=;
        b=lI/pzBvgrhl/OorGbt4BXbncGtSheTjpCExjtTh5ii5ZEf18nNlvRn9kUGDr556iPK
         N7nILWKMfLVlROmwlfnr8xzv+ajfPm+VSqYRlrCJJKqHawNvTD8tm7JWexI7z/yInTTf
         0LeKTlsseLBG/rkxN0XmmOxdJqeCCubScQBO0Brd8b9kNm068YOuDq27slj0ukStUQTI
         Kq3xwTIX3ymBjG5apqxSm5VWCxYeu4eJv/8HsoRAnIzx9MNZJ0+9Q6Crl7yuiH0TlR0O
         o4k+ysfLdZHLbCtNu86WNY6u1shlrT1P/RLQMdb1eyg48UU1+HAFRYdkIPNo9MSjUfT9
         yKTQ==
X-Gm-Message-State: APjAAAVy8RXlLx8xj8XtXaodyfxCeE8xclWvauJVEmb3Ach0HdoTYXZn
        OlZMC9a0RG7NPYwsEKYQNrP0bG3VwuHbjbMOu6VJqA==
X-Google-Smtp-Source: APXvYqxR/Fql4KDJcKRZJv3CUfV3aTUUKWMg8Py+x6jf/u0nHU+OipajcVLbiGvRSBLCjm5Y6f/MWnsEvmIbiSDEH50=
X-Received: by 2002:a6b:7d0d:: with SMTP id c13mr9484096ioq.249.1558333269784;
 Sun, 19 May 2019 23:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190510102051.25647-1-kasong@redhat.com> <4f453ec6-67a6-2c8f-2aab-acb54ae55645@redhat.com>
 <CACPcB9d-h75MEMrjREe7sMvjRqvxBhGxaeR3_k7An2-BDsDy4Q@mail.gmail.com> <1b170096-b47b-2178-b27a-c4ec351f564d@redhat.com>
In-Reply-To: <1b170096-b47b-2178-b27a-c4ec351f564d@redhat.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Mon, 20 May 2019 14:20:58 +0800
Message-ID: <CACPcB9dJKUOZtGU5MQ1DNrQkajdDQDo3Z8bds6zYNoCAOr8+sw@mail.gmail.com>
Subject: Re: [RFC PATCH] vmcore: Add a kernel cmdline device_dump_limit
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 1:55 PM Bhupesh Sharma <bhsharma@redhat.com> wrote:
>
> On 05/16/2019 01:49 PM, Kairui Song wrote:
> > On Fri, May 10, 2019 at 7:17 PM Bhupesh Sharma <bhsharma@redhat.com> wrote:
> >>
> >> Hi Kairui,
> >>
> >> Thanks for the patch. Please see my comments in-line:
> >>
> >> On 05/10/2019 03:50 PM, Kairui Song wrote:
> >>> Device dump allow drivers to add device related dump data to vmcore as
> >>> they want. This have a potential issue, the data is stored in memory,
> >>> drivers may append too much data and use too much memory. The vmcore is
> >>> typically used in a kdump kernel which runs in a pre-reserved small
> >>> chunk of memory. So as a result it will make kdump unusable at all due
> >>> to OOM issues.
> >>>
> >>> So introduce new device_dump_limit= kernel parameter, and set the
> >>> default limit to 0, so device dump is not enabled unless user specify
> >>> the accetable maxiam
> >>
> >>         ^^^^ acceptable maximum
> >
> > Will fix this typo.
>
> Ok.
>
> >>> memory usage for device dump data. In this way user
> >>> will also have the chance to adjust the kdump reserved memory
> >>> accordingly.
> >>
> >> Hmmm., this doesn't give much confidence with the
> >> PROC_VMCORE_DEVICE_DUMP feature in its current shape. Rather shouldn't
> >> we be enabling config PROC_VMCORE_DEVICE_DUMP only under EXPERT mode for
> >> now, considering that this feature needs further thrashing and testing
> >> with real setups including platforms where drivers append large amounts
> >> of data to vmcore:
> >
> > I think no need to move it to expert mode, just leave it disabled by
> > default should be better, that should be enough to make sure driver
> > won't append that much memory and cause OOM, while it could still be
> > enabled without changing the kernel, so this feature won't bring extra
> > risk, and could be enabled anytime easily.
>
> I have seen some arm64 users report issues on mailing lists with
> PROC_VMCORE_DEVICE_DUMP enabled as this causes frequent OOM in the arm64
> crash dump kernel.
>
> I think they are using this infrastructure to extend/enable device
> driver debugging on some arm64 platforms and finding issues with the
> crash dump kernel.
>
> I will do some analysis later-on (when I get some spare time) and post a
> patch (if needed) to put the same under EXPERT mode for now.
>
> >> diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
> >> index 817c02b13b1d..c47a12cf7fc0 100644
> >> --- a/fs/proc/Kconfig
> >> +++ b/fs/proc/Kconfig
> >> @@ -45,7 +45,7 @@ config PROC_VMCORE
> >>            Exports the dump image of crashed kernel in ELF format.
> >>
> >>    config PROC_VMCORE_DEVICE_DUMP
> >> -       bool "Device Hardware/Firmware Log Collection"
> >> +       bool "Device Hardware/Firmware Log Collection" if EXPERT
> >>           depends on PROC_VMCORE
> >>           default n
> >>           help
> >> @@ -59,6 +59,12 @@ config PROC_VMCORE_DEVICE_DUMP
> >>             If you say Y here, the collected device dumps will be added
> >>             as ELF notes to /proc/vmcore.
> >>
> >> +         Considering that there can be device drivers which append
> >> +         large amounts of data to vmcore, you should say N here unless
> >> +         you are reserving a large chunk of memory for crashdump
> >> +         kernel, because otherwise the crashdump kernel might become
> >> +         unusable due to OOM issues.
> >> +
> >>
> >> May be you can add a 'Fixes:' tag here.
> >
> > Problem is previous commit seems not broken, just bring extra memory
> > stress. Is "Fixes:" tag suitable for this commit?
>
> I think since the earlier patch causes an OOM, it would be better to
> atleast mention it in the git log (for easier git bisect later on).
>
> If not the 'Fixes:' tag may be we can use a 'Since commit ..' like
> wording in the commit log.
>
> >>> Signed-off-by: Kairui Song <kasong@redhat.com>
> >>> ---
> >>>    fs/proc/vmcore.c | 20 ++++++++++++++++++++
> >>>    1 file changed, 20 insertions(+)
> >>>
> >>> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> >>> index 3fe90443c1bb..e28695ef2439 100644
> >>> --- a/fs/proc/vmcore.c
> >>> +++ b/fs/proc/vmcore.c
> >>> @@ -53,6 +53,9 @@ static struct proc_dir_entry *proc_vmcore;
> >>>    /* Device Dump list and mutex to synchronize access to list */
> >>>    static LIST_HEAD(vmcoredd_list);
> >>>    static DEFINE_MUTEX(vmcoredd_mutex);
> >>> +
> >>> +/* Device Dump Limit */
> >>> +static size_t vmcoredd_limit;
> >>>    #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
> >>>
> >>>    /* Device Dump Size */
> >>> @@ -1465,6 +1468,11 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
> >>>        data_size = roundup(sizeof(struct vmcoredd_header) + data->size,
> >>>                            PAGE_SIZE);
> >>>
> >>> +     if (vmcoredd_orig_sz + data_size >= vmcoredd_limit) {
> >>> +             ret = -ENOMEM;
> >>
> >> Should we be adding a WARN() here to let the user know that the device
> >> dump data will not be available in vmcore?
> >
> > Yes, that could be very helpful. How about pr_err_once? WARN is too
> > noise, just give a hint to the user that device dump is disabled
> > should be enough, so user will know why device dump data is not
> > present and will just enable it.
>
> Sure, pr_err() should be OK as well.
>
> >>> +             goto out_err;
> >>> +     }
> >>> +
> >>>        /* Allocate buffer for driver's to write their dumps */
> >>>        buf = vmcore_alloc_buf(data_size);
> >>>        if (!buf) {
> >>> @@ -1502,6 +1510,18 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
> >>>        return ret;
> >>>    }
> >>>    EXPORT_SYMBOL(vmcore_add_device_dump);
> >>> +
> >>> +static int __init parse_vmcoredd_limit(char *arg)
> >>> +{
> >>> +     char *end;
> >>> +
> >>> +     if (!arg)
> >>> +             return -EINVAL;
> >>> +     vmcoredd_limit = memparse(arg, &end);
> >>> +     return end > arg ? 0 : -EINVAL;
> >>> +
> >>> +}
> >>> +__setup("device_dump_limit=", parse_vmcoredd_limit);
> >>
> >> We should be adding this boot argument and its description to
> >> 'Documentation/admin-guide/kernel-parameters.txt'
> >
> > Good suggestion, will update the document.
> >
> >>
> >>>    #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
> >>>
> >>>    /* Free all dumps in vmcore device dump list */
> >>>
>
> Thanks,
> Bhupesh

Thanks for the reply, I've updated the patch accordingly and sent V2.

-- 
Best Regards,
Kairui Song

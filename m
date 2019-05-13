Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098F6C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 02:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE791208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 02:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfEMCTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 22:19:20 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41395 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfEMCTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 22:19:20 -0400
Received: by mail-io1-f67.google.com with SMTP id a17so8804592iot.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 19:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0YBhbwDYDQaaP8Q10VnTc/btcudJfr9E3ZfK2SxCdhk=;
        b=PDZ0cczf/4UwcfxcPfFPDDqA/HrIwatWujHbWgbcjOPAo3jyhA88JOa7NERFRHCC9C
         Wngf8sMm8xPBrywhsADMXK+B31b3+5Zz8AXHIcAD8cFyi770bDtXiGYFTm1aW5txij86
         T9ngXUgcn/8LL5OcS6jrdieniy20cDylEm/7gLy90AE6h7jBnpJiSoENmiz83RnmUwXI
         XkCd5ZMmel1xhN7lfbqNu7OrVYg2tjBGpXhxVj0/3q3z6K/trUfovXpdI4kQs5tx3Cag
         2EBxrzSnRRijc/G0yV9KFMVnXEX+ooBlcr2S2ZkOcEjcwSSesdEfSg7ANOXaLUwnK5It
         A9tw==
X-Gm-Message-State: APjAAAV/EjHMFrxQWpMndLuxkvCJEB36Gr+Rm4Z6HxwGZFZ7pq3CsXpX
        kHwSXsAUyilsfljJGZ8dTZVAps3Zl2SEtQT3xqthBw==
X-Google-Smtp-Source: APXvYqxSjKkZk82Y54ujLVRJgcrrrKogjwMJkYhxpeZmx46iKS1c74Y9SdqcEl/G4NjTc0/EPvfw8FuBhmHk3VLVwAY=
X-Received: by 2002:a5d:83c5:: with SMTP id u5mr14476328ior.137.1557713959523;
 Sun, 12 May 2019 19:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190510102051.25647-1-kasong@redhat.com> <20190513015241.GA8515@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190513015241.GA8515@dhcp-128-65.nay.redhat.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Mon, 13 May 2019 10:19:09 +0800
Message-ID: <CACPcB9ezEbAzGadCwvVQGgCA+XP2tzCZbvT7ytiSk98O_unXZQ@mail.gmail.com>
Subject: Re: [RFC PATCH] vmcore: Add a kernel cmdline device_dump_limit
To:     Dave Young <dyoung@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
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

On Mon, May 13, 2019 at 9:52 AM Dave Young <dyoung@redhat.com> wrote:
>
> On 05/10/19 at 06:20pm, Kairui Song wrote:
> > Device dump allow drivers to add device related dump data to vmcore as
> > they want. This have a potential issue, the data is stored in memory,
> > drivers may append too much data and use too much memory. The vmcore is
> > typically used in a kdump kernel which runs in a pre-reserved small
> > chunk of memory. So as a result it will make kdump unusable at all due
> > to OOM issues.
> >
> > So introduce new device_dump_limit= kernel parameter, and set the
> > default limit to 0, so device dump is not enabled unless user specify
> > the accetable maxiam memory usage for device dump data. In this way user
> > will also have the chance to adjust the kdump reserved memory
> > accordingly.
>
> The device dump is only affective in kdump 2nd kernel, so add the
> limitation seems not useful.  One is hard to know the correct size
> unless one does some crash test.  If one did the test and want to eanble
> the device dump he needs increase crashkernel= size in 1st kernel and
> add the limit param in 2nd kernel.
>
> So a global on/off param sounds easier and better, something like
> vmcore_device_dump=on  (default is off)

Yes, on/off could be another way to solve this issue, the size limit
could being more flexibility, if device dump is not asking for too
much memory then it would just work but bring extra complexity indeed.
Considering it's actually hard to know how much memory is needed for
the device dump drivers to work, I'll update to use the on/off cmdline
then.

>
> >
> > Signed-off-by: Kairui Song <kasong@redhat.com>
> > ---
> >  fs/proc/vmcore.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> > index 3fe90443c1bb..e28695ef2439 100644
> > --- a/fs/proc/vmcore.c
> > +++ b/fs/proc/vmcore.c
> > @@ -53,6 +53,9 @@ static struct proc_dir_entry *proc_vmcore;
> >  /* Device Dump list and mutex to synchronize access to list */
> >  static LIST_HEAD(vmcoredd_list);
> >  static DEFINE_MUTEX(vmcoredd_mutex);
> > +
> > +/* Device Dump Limit */
> > +static size_t vmcoredd_limit;
> >  #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
> >
> >  /* Device Dump Size */
> > @@ -1465,6 +1468,11 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
> >       data_size = roundup(sizeof(struct vmcoredd_header) + data->size,
> >                           PAGE_SIZE);
> >
> > +     if (vmcoredd_orig_sz + data_size >= vmcoredd_limit) {
> > +             ret = -ENOMEM;
> > +             goto out_err;
> > +     }
> > +
> >       /* Allocate buffer for driver's to write their dumps */
> >       buf = vmcore_alloc_buf(data_size);
> >       if (!buf) {
> > @@ -1502,6 +1510,18 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
> >       return ret;
> >  }
> >  EXPORT_SYMBOL(vmcore_add_device_dump);
> > +
> > +static int __init parse_vmcoredd_limit(char *arg)
> > +{
> > +     char *end;
> > +
> > +     if (!arg)
> > +             return -EINVAL;
> > +     vmcoredd_limit = memparse(arg, &end);
> > +     return end > arg ? 0 : -EINVAL;
> > +
> > +}
> > +__setup("device_dump_limit=", parse_vmcoredd_limit);
> >  #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
> >
> >  /* Free all dumps in vmcore device dump list */
> > --
> > 2.20.1
> >
>
> Thanks
> Dave



-- 
Best Regards,
Kairui Song

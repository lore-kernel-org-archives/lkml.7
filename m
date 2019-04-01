Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140C7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79F02084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aV1brJ+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbfDARyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:54:21 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33761 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729565AbfDARyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:54:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id e5so8089417oii.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 10:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PVJC2Hvwh1aS32am4+7sp49S8mVxW4cUTfYouidDA5I=;
        b=aV1brJ+Ieoewi+ZBpNq5ILV3gd+dLnwG+/qA/cHmK0OVY/CNkzHCPFnEAiuTew2Et5
         d7/GpzKrR5Yjvj+G432V0uf5P//usGGybySlrWR5Vxb6GQC9L4KRjLKkpQv2+jpN9p5l
         a8udGFY4OkFf+faBoXG5BJatupLL3/PROOV9PhWz7hlquqqvBlB3rNxyieOJR+fWiZFq
         6U6qh8N2VHmq1r4c0zlNTmz7AdMc7xAWjyXCEc52mD1/M6IvNjBkOdxV4JUZvM76bLTe
         sbHx++O6Nm0AaGez7hz3UHsxuUWxWoYwyanU83Rvoy37koDRWt2eTbNgs4ZmK2BpVIR+
         mlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PVJC2Hvwh1aS32am4+7sp49S8mVxW4cUTfYouidDA5I=;
        b=FJczs42Yo3lkgcetYtYvxBOIXuoxW315bXnbDonJWuTnVKJBaxYObuhPGnpzbyngXE
         z02OM5oEzXGRM7GPa4Ijg+Swgj7Bxq9NYsXSVjDg1xmd4vIL+biStl8/NiK2LzFEJJa7
         Uwbx4li3XW0fM6YsP762w5sJpdDZRFnvuCew/Olw3NnZxsAc8PBro6HnXFnsEHywpy+Y
         lWfb5BkZjHkOlauyQV8MHVbAO24eaDe8s9m5q6mY8+HfLOu9aY9rBWxQK3gnjeAXjRKZ
         Yks+s5QotyNrJxQbUTaJBx9vqScSAxz27un7EkxCTMWWBK+uyb4mHejmS52J3fEefPt5
         3OEw==
X-Gm-Message-State: APjAAAVjZZCHqPZMaOlg8UtYJM+qPJP8rOgjMv8Pj1ujnFuxVI6+qVRV
        p+ePhBZSQgI5fsTsE29oZhZoHcfIWMLkud01Hz3xCuOohoVewg==
X-Google-Smtp-Source: APXvYqzsg8P3UPrxNS/Rk5ZzU6JSoJP9wA0gkMFidbJzLiEjsXDG1Ts8J5PO4rBCzk3rJDJCdvNYybhw5pqLI0YSvPo=
X-Received: by 2002:aca:dcd7:: with SMTP id t206mr3675346oig.68.1554141254298;
 Mon, 01 Apr 2019 10:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190329214652.258477-1-jannh@google.com> <20190329214652.258477-2-jannh@google.com>
 <20190401173031.GK28264@zn.tnic>
In-Reply-To: <20190401173031.GK28264@zn.tnic>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 1 Apr 2019 19:53:46 +0200
Message-ID: <CAG48ez04ARfFNXHUsod1kCH08k=-EvTbQkgLoLMfegNfyj-0zg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] x86/microcode: Fix __user annotations around generic_load_microcode()
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Qiaowei Ren <qiaowei.ren@intel.com>,
        Mukesh Ojha <mojha@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 7:30 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Mar 29, 2019 at 10:46:50PM +0100, Jann Horn wrote:
> > generic_load_microcode() deals with a pointer that can be either a kernel
> > pointer or a user pointer. Pass it around as a __user pointer so that it
> > can't be dereferenced accidentally while its address space is unknown.
> > Use explicit casts to convert between __user and __kernel to inform the
> > checker that these address space conversions are intentional.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  arch/x86/kernel/cpu/microcode/intel.c | 20 ++++++++++++--------
> >  1 file changed, 12 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> > index 16936a24795c..e8ef65c275c7 100644
> > --- a/arch/x86/kernel/cpu/microcode/intel.c
> > +++ b/arch/x86/kernel/cpu/microcode/intel.c
> > @@ -861,11 +861,13 @@ static enum ucode_state apply_microcode_intel(int cpu)
> >       return ret;
> >  }
> >
> > -static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
> > -                             int (*get_ucode_data)(void *, const void *, size_t))
> > +static enum ucode_state generic_load_microcode(int cpu,
> > +             const void __user *data, size_t size,
> > +             int (*get_ucode_data)(void *, const void __user *, size_t))
>
> Ok, how about something completely different?
>
> This ->get_ucode_data() BIOS-code-like contraption has always bugged me
> for being too ugly to live.
>
> How about we vmalloc() a properly sized buffer - both
> generic_load_microcode() callers have the size - and then hand that
> buffer into generic_load_microcode() ?
>
> That solves the __user annotation fun immediately and would simplify
> generic_load_microcode() additionally.
>
> The disadvantage would be having to vmalloc() a couple of... , I think
> it is megabytes, with that old loading method request_microcode_user()
> but then if vmalloc() fails, then it was clearly too big. I don't think
> the blob can ever be that big though, to fail vmalloc(), but I'm not
> going to bet on it...

Hm. request_microcode_fw() gets that buffer from
request_firmware_direct(), which does this:

        __module_get(THIS_MODULE);
        ret = _request_firmware(firmware_p, name, device, NULL, 0,
                                FW_OPT_UEVENT | FW_OPT_NO_WARN |
                                FW_OPT_NOFALLBACK);
        module_put(THIS_MODULE);
        return ret;

What is that module_get()/module_put() supposed to be good for? Are we
expecting that caller to do something ridiculous like calling
module_put() on us? This doesn't seem to make any sense.

And then _request_firmware() goes and ends up in places like
kernel_read_file(), which already use vmalloc().


Anyway, isn't this kind of thing exactly why we have that iov_iter
stuff? request_microcode_fw() can build an ITER_KVEC,
request_microcode_user() can build an ITER_IOVEC. And then
generic_load_microcode() can use something like copy_from_iter(). Does
that sound reasonable?

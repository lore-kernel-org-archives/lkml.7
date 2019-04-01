Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33C3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A9E208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EAycm5SK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfDAPE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:04:29 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35158 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfDAPE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:04:29 -0400
Received: by mail-ot1-f65.google.com with SMTP id m10so8979476otp.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 08:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hh7tyO+RaWp7KSodMe7WKcK66rWlDGPe7rlXlqce7Lw=;
        b=EAycm5SKzrsi+Kso9+g5FjPDDS7w6687Arv1NqpEY5RcerG/ftEtt74HkPMlxT3jol
         kY0CE/0oXVYN1wQZSSkNGdafIJom1bfsV28gZVcMz+eZKa1jrPx7PU5wv3tJgZfs/GGg
         WObfuKv0A2irYfpuX3OyVX/nsPej5Wwi6UJRY3J13/wd9oL7Ur38k8gwhBUJj0ggJqhQ
         LFLPUPNIJVqPYVb2UztjUnuhyV/mj1yTHcM02QKPgYleRCgL37MLeuH/nD0ixzAVO8A1
         2v+xJI97gwrNJe5HDzK5XoyK5lHPoZLe7VQBrN9b9eLG2E9U8UMx6yMpLfnfZAVWkO39
         V13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hh7tyO+RaWp7KSodMe7WKcK66rWlDGPe7rlXlqce7Lw=;
        b=U17X1RhOZeRXw7zOGjMtdP1jSVHXM3m7LTyG2CkoTcaiysmEcqFeuKqJTuPDuzZWuy
         oZRek/M+LZleKg5OPL06k3t183kxNVN6zUorGkli8qlKyUa9rDcuSunUqDRWQ12xHUFz
         pUY+bkJ/9GOoMH5YzVyqyFDTsJUB40CM0XN1y6/dkckbzwkyjnVgoj2vYeTDq5YPc1XL
         x8LEE62mQ7TOX29zJbe93y50n8a1/N48//2dJklDwKV9x0Gm0PrbDlPM3Gju98t0mvNh
         FXc0IHh6j8nSh1mb1jxaXEX+Ylx9QgAuX/l6WcG9oII7rIwisDq2TujjgtLIAwuWIQVY
         9Qeg==
X-Gm-Message-State: APjAAAVnCvo+MQzvvs9yjjUwTJggatARe9GDowDiRXrWJy4zI1rkp589
        a4BU2V/Eh0F973NnsP8teB0tyg/mOmMPAO6+u5VmLvd+Cqk=
X-Google-Smtp-Source: APXvYqyiDtf0Hl7OW+Yo1Cz3hRakjUqkwwkViHuIVD5VIgLRZb/4owpy4lquA9GgVgp7JAzcMHXGTyvjiEHUHiMGpBQ=
X-Received: by 2002:a9d:7095:: with SMTP id l21mr46673238otj.35.1554131067973;
 Mon, 01 Apr 2019 08:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190328212321.92463-1-jannh@google.com> <20190328212321.92463-2-jannh@google.com>
 <ca2d792df2e9420090383f1a65a6d99f@AcuMS.aculab.com>
In-Reply-To: <ca2d792df2e9420090383f1a65a6d99f@AcuMS.aculab.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 1 Apr 2019 17:04:00 +0200
Message-ID: <CAG48ez05JxAAfen6DanFWigBDPLCOEKYZ4ZL2RQ1bRcRVTf13A@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86: fix __user annotations
To:     David Laight <David.Laight@aculab.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qiaowei Ren <qiaowei.ren@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 4:36 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Jann Horn
> > Sent: 28 March 2019 21:23
> > Fix __user annotations in various places across the x86 tree:
> >
> ...
> >  - generic_load_microcode() deals with a pointer that can be either a
> >    kernel pointer or a user pointer; change the code to pass it around as
> >    a __user pointer, and add explicit casts to convert between __user and
> >    __kernel
> ...
> > -static int get_ucode_fw(void *to, const void *from, size_t n)
> > +static int get_ucode_fw(void *to, const void __user *from, size_t n)
> >  {
> > -     memcpy(to, from, n);
> > +     /* cast paired with request_microcode_fw() */
> > +     memcpy(to, (const void __force *)from, n);
> >       return 0;
> >  }
> >
> > @@ -993,7 +996,8 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device,
> >               return UCODE_NFOUND;
> >       }
> >
> > -     ret = generic_load_microcode(cpu, (void *)firmware->data,
> > +     /* cast paired with get_ucode_fw() */
> > +     ret = generic_load_microcode(cpu, (void __force __user *)firmware->data,
> >                                    firmware->size, &get_ucode_fw);
> >
> >       release_firmware(firmware);
> > @@ -1001,7 +1005,7 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device,
> >       return ret;
> >  }
> >
> > -static int get_ucode_user(void *to, const void *from, size_t n)
> > +static int get_ucode_user(void *to, const void __user *from, size_t n)
> >  {
> >       return copy_from_user(to, from, n);
> >  }
> > @@ -1012,7 +1016,7 @@ request_microcode_user(int cpu, const void __user *buf, size_t size)
> >       if (is_blacklisted(cpu))
> >               return UCODE_NFOUND;
> >
> > -     return generic_load_microcode(cpu, (void *)buf, size, &get_ucode_user);
> > +     return generic_load_microcode(cpu, buf, size, &get_ucode_user);
>
> That is all an 'accident waiting to happen' ...

What's your suggestion? The code used to store user pointers in
kernel-typed pointers. Now it only stores kernel pointers in
user-typed pointers, which is much less hazardous.

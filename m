Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E4CC19759
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 01:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5A0206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 01:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bTRX3vnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390630AbfHBBTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 21:19:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37606 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388503AbfHBBTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 21:19:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so64741944wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 18:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hYkecIBjzROR5NsLeOwFUoMJIb/qPM7Hd2+NHJCx9T0=;
        b=bTRX3vnbUBvVzMx3EnZMIFrwYtFIhquzKtu5cZFrCSlpDg9eHRpK79SeMK722L58Lx
         suLi8IuxYepKjTtwrQeaYVw3UCa8TC07WWhpnjqVI5obNgp88fmw8vBOPXJUZGQpRn3B
         Kek3LyGyDmhXd3x80/nb19A+dxuaSEOgzwEGFICIugHC5OjNurwiPLEhR0Qt6mgoLXjA
         FwAFPVU6P6CA6yRutdDhbVYbVWw7/HfTbgfyb0533DmsKVM2ZZ8vsVGIHrd5KmAOQN+i
         lCgtdD3z/Vn3GnJDL/vFmRcjQkREp3QDDU0DEVt09uQ5KrxVEQpbGvpFaA2UDavihbW/
         kt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hYkecIBjzROR5NsLeOwFUoMJIb/qPM7Hd2+NHJCx9T0=;
        b=fqntsi0ar4HfvUxZP00pKzZFiOB1gfB0HKO60JhkVEkRQYxGEUiZ+o3Nt0TsZPNTLP
         QXne2GzJn+7JQK4cKq+cQaY9FSVQFdH4YeZqC/eIDdMhKe7W9sDKZSVfjmVQq/bWkQnP
         58hNy2wby9fxb/ma7pSW31h+CPI8W68yaAu49qPk52SjnBXRV7w5/mW/Mf+oF+rVKS29
         GrmiHhu463jToUAVde/8igb3aNu7fBt6Nd1BbB3woEXqyfJTjPDudriREP0PkpKqUFwf
         RjDBBrYG9OOCW6QRXJyIFHCbOifrqwoDXPGIMhPm285HwjvOuaB+7YUPzz4+2spOQzlX
         yd1w==
X-Gm-Message-State: APjAAAWKEHRrfzQ1uN9Tdj9Pw7ymcFuEibDRlWJM+Cyl8Ppfn0oq61uD
        n5GwBk9y92J4/mF4Pm4wBfRAwGYCpIDQ1imjwphMMQ==
X-Google-Smtp-Source: APXvYqzhOtoCy4Rhyi1dtBv4uO4BEfsQUkH57i/KR8+jcXqr7blW2/4PVm+qncKQu2ijKNfJDcK5/BaT+O4JpGxbK+Q=
X-Received: by 2002:a1c:1f41:: with SMTP id f62mr1061380wmf.176.1564708758410;
 Thu, 01 Aug 2019 18:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190730013310.162367-1-surenb@google.com> <20190730081122.GH31381@hirez.programming.kicks-ass.net>
 <CAJuCfpH7NpuYKv-B9-27SpQSKhkzraw0LZzpik7_cyNMYcqB2Q@mail.gmail.com>
 <20190801095112.GA31381@hirez.programming.kicks-ass.net> <CAJuCfpHGpsU4bVcRxpc3wOybAOtiTKAsB=BNAtZcGnt10j5gbA@mail.gmail.com>
 <20190801215904.GC2332@hirez.programming.kicks-ass.net>
In-Reply-To: <20190801215904.GC2332@hirez.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 1 Aug 2019 18:19:07 -0700
Message-ID: <CAJuCfpHEhK_g5pDhJ3JEu+ioE0xKME56Vs5xmPiUtXH4M0umog@mail.gmail.com>
Subject: Re: [PATCH 1/1] psi: do not require setsched permission from the
 trigger creator
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, lizefan@huawei.com,
        Johannes Weiner <hannes@cmpxchg.org>, axboe@kernel.dk,
        Dennis Zhou <dennis@kernel.org>,
        Dennis Zhou <dennisszhou@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Nick Kralevich <nnk@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 2:59 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Aug 01, 2019 at 11:28:30AM -0700, Suren Baghdasaryan wrote:
> > > By marking it FIFO-99 you're in effect saying that your stupid
> > > statistics gathering is more important than your life. It will preempt
> > > the task that's in control of the band-saw emergency break, it will
> > > preempt the task that's adjusting the electromagnetic field containing
> > > this plasma flow.
> > >
> > > That's insane.
> >
> > IMHO an opt-in feature stops being "stupid" as soon as the user opted
> > in to use it, therefore explicitly indicating interest in it. However
> > I assume you are using "stupid" here to indicate that it's "less
> > important" rather than it's "useless".
>
> Quite; PSI does have its uses. RT just isn't one of them.

Sorry about messing it up in the first place.
If you don't see any issues with my patch replacing
sched_setscheduler() with sched_setscheduler_nocheck(), would you mind
taking it too? I applied it over your patch onto Linus' ToT with no
merge conflicts.
Thanks,
Suren.

> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>

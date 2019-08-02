Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEE5C32757
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 02:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D74206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 02:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bW3cGh8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389904AbfHBC0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 22:26:37 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41706 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389848AbfHBC0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 22:26:33 -0400
Received: by mail-io1-f67.google.com with SMTP id j5so144768998ioj.8;
        Thu, 01 Aug 2019 19:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3jE/qOtP1fz3hEG4RtDQhO7tMIcvYMp5O+T6euuQUcE=;
        b=bW3cGh8WxyTsYRSlys+blG/7dyjyHuuJdV0CGpicWGTcMv1lMBIUJFzGI3ZxbivNp/
         kGBVZFEOzphL7mdDABnFlkKMzahiyYkxYpKQYI9TdiLAx9gOxHLYNQsP8vjk8m3NKS7r
         PnvuUvC/m5mN01hHSwFHhu6kCCMzO8spTMPZlZuiPhBfRrbAtLvPoKeOjg8+dp6pCvZC
         kbwJNMfkmxjNlajmzjhwXXyC+UQ56we+n1ud+C3meYTiVxedTqFrbLUujt2PwCJWsNu9
         23D4FZieUPeho65AsuIyVBIJ6fCqQW/GCsH3rBryYAf8UCUu2zZwPvbHAmGlRSvpNLh+
         zhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3jE/qOtP1fz3hEG4RtDQhO7tMIcvYMp5O+T6euuQUcE=;
        b=a5b3LJ53Ln3DcFdd6ERxCp0LXIaZdLFoM49y7zcqlQ67oED413BqxKi8tYRTpFx1CO
         WFxCenPdDbmTOtC7Pq61ZQDST8I+CUxJIyfHcmKxj5QaRR1i67hQVWG0NQkCc7SZu39i
         cF+1UK6JCRzAW5vsEfQQiJHTqhG3zHkEHRB3GCudYF51yiQU3UU6XWQaKTNR8SKq28mr
         hWhvO9rL/NNK3jdmaDMmrK221XTOyrctcwBZtBOojML1tFnH8oUR0FAJAOkg9jhaKPV8
         j44oEeTuB1FmyGTjyy2GSXgLWjGK5jRUBml8aCpoGCQeu4TQdHqIrADRyLcGB2lNzy1Y
         t7UA==
X-Gm-Message-State: APjAAAUmx8oc6uezaRVsJib4k+rC9BzuQlBnR4qv03cGx60fbXHvweK4
        lPzzPg2YPMF9cd4HecuKzBWxnaEgrXrtIzm33Sc=
X-Google-Smtp-Source: APXvYqypHgvjA7X7cmae9+y5zSYvl+e77KaCUfJ6RL6RNUikeasXpNPo9yD4B0mY1IZK6pdZKcqCKLatRUR2EIk2sxw=
X-Received: by 2002:a6b:ed09:: with SMTP id n9mr9894028iog.153.1564712792776;
 Thu, 01 Aug 2019 19:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190730014924.2193-1-deepa.kernel@gmail.com> <20190730014924.2193-20-deepa.kernel@gmail.com>
 <201907292129.AC796230@keescook> <CAK8P3a2rWEciT=PegCYUww-n-3smQHNjvW4duBqoS2PLSGdhYw@mail.gmail.com>
In-Reply-To: <CAK8P3a2rWEciT=PegCYUww-n-3smQHNjvW4duBqoS2PLSGdhYw@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Thu, 1 Aug 2019 19:26:21 -0700
Message-ID: <CABeXuvrmNkUOH5ZU59Kg4Ge1cFE9nqp9NhTPJjus5KkCrYeC6w@mail.gmail.com>
Subject: Re: [PATCH 19/20] pstore: fs superblock limits
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 12:36 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jul 30, 2019 at 6:31 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Jul 29, 2019 at 06:49:23PM -0700, Deepa Dinamani wrote:
> > > Also update the gran since pstore has microsecond granularity.
> >
> > So, I'm fine with this, but technically the granularity depends on the
> > backend storage... many have no actual time keeping, though. My point is,
> > pstore's timestamps are really mostly a lie, but the most common backend
> > (ramoops) is seconds-granularity.
> >
> > So, I'm fine with this, but it's a lie but it's a lie that doesn't
> > matter, so ...
> >
> > Acked-by: Kees Cook <keescook@chromium.org>
> >
> > I'm open to suggestions to improve it...
>
> If we don't care about using sub-second granularity, then setting it
> to one second unconditionally here will make it always use that and
> report it correctly.

Should this printf in ramoops_write_kmsg_hdr() also be fixed then?

        RAMOOPS_KERNMSG_HDR "%lld.%06lu-%c\n",
        (time64_t)record->time.tv_sec,
        record->time.tv_nsec / 1000,
        record->compressed ? 'C' : 'D');
    persistent_ram_write(prz, hdr, len);

ramoops_read_kmsg_hdr() doesn't read this as microseconds. Seems like
a mismatch from above.

If we want to agree that we just want seconds granularity for pstore,
we could replace the tv_nsec part to be all 0's if anybody else is
depending on this format.
I could drop this patch from the series and post that patch seperately.

Thanks,
-Deepa

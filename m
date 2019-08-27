Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1A5C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529C92077B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R5Z3Ido7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbfH0VKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 17:10:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39912 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbfH0VKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:10:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so148588pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 14:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gDQhuGUNXTVg1cy6UlUpQaDjBmPIGubFH3m9ia7NwmU=;
        b=R5Z3Ido7+Z6yOmAJW8IRgNP+qk4n6MJnOHT9/Xi8ETg6NpXvZvDhRz4IuK9UKdYSnI
         yAzieh4hi3ekHBVWpgVCaAyUZIjzkPsjbxXBZHwB+ssiM/+ytebM5143IwSu7n8B07Hq
         hkVX1t7b6hLBKFoK1GmLIom7EUBv1RakqFbGnJG2Nuq9Ybh1kI3qBPhKKVBhoZLS7own
         7K+7ozUhSrKE2Y/0sM2WydLGIT6G+8MTOOpfKkEeKujz1VYMrEXzEPt6KvpmE/m8ZiDX
         sdLrY+Jlbtg3vL1fFq7CPUa5Y6CFJ/k7P1XlywX37Zk27NBOkOXUyGtFbDV4qPM7Rd/Y
         ZbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gDQhuGUNXTVg1cy6UlUpQaDjBmPIGubFH3m9ia7NwmU=;
        b=YrKe4Y9XMmwrh2EWV/9MLb9rrM5s8Krqb4VmM891THcgzir79d80GheIFUow42aku8
         xvshGm4qPIy6S37GB+WesaZrZnj+A6Tl2RHhncY1NtRvaDyg9dAPiCHE1akpnD2X9vsx
         yqHADYVtc7gmcI9V7g/8w64KojJXmVnmC0Dz64WxOluovF6OXupg7GcEwTwIbMsC/rPa
         iQWKbWnISwEvfQivQOW8kGa2Ha0ulcvd6zSCCxeanQOg7u6WSaqC8PVkXxnVQWj2r3Up
         EggxSeMyyRPRazY3oau68d7sTQKb8VnFCkZGDqeIHcr8RRu4OBE4y/xkiYuWz4WmJ8hr
         PvxA==
X-Gm-Message-State: APjAAAUDK7pIhyCJ/amR2Ybbx+ryojYejZhINk2RESllILOQQGHCw7T4
        QzqaiCY/NBoM4iYAMU9KVwGdhOiguvmVSlMHbCkddw==
X-Google-Smtp-Source: APXvYqzdviPbfXTy38bMu6n0IqBlrSoYhZivN3fnTLfz93bOGZ1KraawZl2ZOrhYTE305ZNUJ4rqlmVUsrSjP4nX+Pg=
X-Received: by 2002:a63:205f:: with SMTP id r31mr385340pgm.159.1566940206681;
 Tue, 27 Aug 2019 14:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190827174932.44177-1-brendanhiggins@google.com>
 <ae9b9102-187c-eefe-d377-6efa63de2d28@kernel.org> <CAFd5g473nZAfM4D=Vkr54O_+nn=MSt3dzuDcXzNMZGRDWg1nxA@mail.gmail.com>
In-Reply-To: <CAFd5g473nZAfM4D=Vkr54O_+nn=MSt3dzuDcXzNMZGRDWg1nxA@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 27 Aug 2019 14:09:55 -0700
Message-ID: <CAFd5g47rSBJS8QVH6d5HqoJW5PJXdNnkoP6WcvQCFUqHUEmDzw@mail.gmail.com>
Subject: Re: [PATCH v1] kunit: fix failure to build without printk
To:     shuah <shuah@kernel.org>
Cc:     kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 2:03 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Tue, Aug 27, 2019 at 1:21 PM shuah <shuah@kernel.org> wrote:
> >
> > On 8/27/19 11:49 AM, Brendan Higgins wrote:
> > > Previously KUnit assumed that printk would always be present, which is
> > > not a valid assumption to make. Fix that by ifdefing out functions which
> > > directly depend on printk core functions similar to what dev_printk
> > > does.
> > >
> > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-715a-fabe016259df@kernel.org/T/#t
> > > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > ---
> > >   include/kunit/test.h |  7 +++++++
> > >   kunit/test.c         | 41 ++++++++++++++++++++++++-----------------
> > >   2 files changed, 31 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > > index 8b7eb03d4971..339af5f95c4a 100644
> > > --- a/include/kunit/test.h
> > > +++ b/include/kunit/test.h
> > > @@ -339,9 +339,16 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
> [...]
> > Okay after reviewing this, I am not sure why you need to do all
> > this.
> >
> > Why can't you just change the root function that throws the warn:
> >
> >   static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
> > {
> >          return vprintk_emit(0, level, NULL, 0, fmt, args);
> > }
> >
> > You aren'r really doing anything extra here, other than calling
> > vprintk_emit()
>
> Yeah, I did that a while ago. I think it was a combination of trying
> to avoid an extra layer of adding and then removing the log level, and
> that's what dev_printk and friends did.
>
> But I think you are probably right. It's a lot of maintenance overhead
> to get rid of that. Probably best to just use what the printk people
> have.
>
> > Unless I am missing something, can't you solve this problem by including
> > printk.h and let it handle the !CONFIG_PRINTK case?
>
> Randy, I hope you don't mind, but I am going to ask you to re-ack my
> next revision since it basically addresses the problem in a totally
> different way.

Actually, scratch that. Checkpatch doesn't like me calling printk
without using a KERN_<LEVEL>.

Now that I am thinking back to when I wrote this. I think it also
might not like using a dynamic KERN_<LEVEL> either (printk("%s my
message", KERN_INFO)).

I am going to have to do some more investigation.

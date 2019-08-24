Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CA5C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA42206BB
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566680235;
	bh=+q+uORFs9TRLYXFSpmQS7lxTbHi6yGFOQNw1kZKJREk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lNtZmQcJSzo4I6CHvSiUIy40lrgamHIHQY1niqgLaDE8YHzpNYeSRh62hqIJrfVG0
	 atKHfP63H6mtqChNxHIYchw8NPhwRH+M9rdCp2X488TzlT9h4q+kDSQBlHNhko8QNQ
	 0iwi43JsEsr+d3GEZN/BKvRRgfHyDWGWDX00QaZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfHXU5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 16:57:14 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32906 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfHXU5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 16:57:14 -0400
Received: by mail-lf1-f66.google.com with SMTP id x3so9567220lfc.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2019 13:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4FNawqrGstVg6/hchmJtJa+3GbYylvff3HJoX49z1Bg=;
        b=gXFLdh+h1JD7M0QXxAssSmO7tCgPsqexep8TcMfZYMtlEq3GemctWmlFZXrwmMpgx4
         j2eSyrBEVQRalyQTUcFDyIGUhZp+bkb3dLQHAn+SjsmDgYctuqTCd3Rv8t3Z3iVbyrnT
         CWkiwNQCW92lSuB+8JMuWQBbJVufIfkr0aW9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4FNawqrGstVg6/hchmJtJa+3GbYylvff3HJoX49z1Bg=;
        b=S4l/1k9AJ57lldvSDdgD88IuecXR4SU7vIsQcW/y26IVh5qGyY0vxHzmnRBI7eT7J+
         YaULOtpz3GPywTp2UW52pEVj5YqJYwdc3Ylg40gWHC3YTb+91+8AKUt3GPy+faP1QsWN
         CsOeFc6Yu4kyjEYEDMDTWonmkfgOdiEee4Haq1/zGvYt6wC0A+UR9yHkLfgyMFU2ZUpd
         Tt3qPRMcIeKSubzK2BroK+ZuZrucCMLiRkTWkRN81CUcI/ZyRD50A4y/jwZQidNQxTmR
         iGSuSMq16stf3r2snyHNyGuCLi4mtr9Q2fijw9/0XYZWCfZzvxWe91Po2/ME00mPsaW6
         aMqg==
X-Gm-Message-State: APjAAAVGBO1qLsWZz3aHbzNrpLNx69LGV2i/q5XPiTIu2xAmpYRJFk7N
        Cqx6YPaGdR77q1/OayJYx3cOji3I1dc=
X-Google-Smtp-Source: APXvYqzU8FHg5MJQuT+XOQZ7ZxgPCEXu/7NQdIp+v7VLrXlQ1pvkIMfKxTNkHLK8TI+FHlIvxwGJKQ==
X-Received: by 2002:a19:f11a:: with SMTP id p26mr6309655lfh.160.1566680231453;
        Sat, 24 Aug 2019 13:57:11 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id j4sm1260888lfm.19.2019.08.24.13.57.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2019 13:57:10 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id x3so9539589lfn.6
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2019 13:57:10 -0700 (PDT)
X-Received: by 2002:ac2:4c12:: with SMTP id t18mr6495890lfq.134.1566680230001;
 Sat, 24 Aug 2019 13:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <1566338811-4464-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAHk-=wjFsF6zmcDaBdpYEvCWiq=x7_NuQWEm=OinZ9TuQd4ZZQ@mail.gmail.com>
 <20190823091636.GA10064@gmail.com> <CAHk-=wj=HcHWjrrNRmZ_hxEdBBrvUnPNFCw37EAu8_qJn71saQ@mail.gmail.com>
 <20190824161432.GA25950@gmail.com> <CAHk-=whFQNkqPJ5zA1xAyvgtCPLN2C4xeJ181rU3k6bG+2zugg@mail.gmail.com>
 <20190824202224.GA5286@gmail.com>
In-Reply-To: <20190824202224.GA5286@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 24 Aug 2019 13:56:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjD5MMbAm0OkbKadzerwG3yGr9SvE7mrsCnhmiqRRdxMw@mail.gmail.com>
Message-ID: <CAHk-=wjD5MMbAm0OkbKadzerwG3yGr9SvE7mrsCnhmiqRRdxMw@mail.gmail.com>
Subject: Re: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2019 at 1:22 PM Ingo Molnar <mingo@kernel.org> wrote:
>
> That makes sense: I measured 17 seconds per 100 MB of data, which is is
> 0.16 usecs per byte. The instruction used by
> copy_user_enhanced_fast_string() is REP MOVSB - which supposedly goes as
> high as cacheline size accesses - but perhaps those get broken down for
> physical memory that has no device claiming it?

All the "rep string" optimizations are _only_ done for regular memory.

When it hits any IO accesses, it will do the accesses at the specified
size (so "movsb" will do it a byte at a time).

0.16 usec per byte is faster than the traditional ISA 'inb', but not
by a huge factor.

> Interruption is arguably *not* an 'error', so preserving partial reads
> sounds like the higher quality solution, nevertheless one could argue
> that particual read *could* be returned by read_kmem() if progress was
> made.

So if we react to regular signals, not just fatal ones, we definitely
need to honor partial reads.

> I.e. if for example an iomem area is already mapped by a driver with some
> conflicting cache attribute, xlate_dev_mem_ptr() AFAICS will not
> ioremap_cache() it to cached? IIRC some CPUs would triple fault or
> completely misbehave on certain cache attribute conflicts.

Yeah, I guess we have the machine check possibility with mixed cached cases.

> This check in mremap() might also trigger:
>
>         if (is_ram == REGION_MIXED) {
>                 WARN_ONCE(1, "memremap attempted on mixed range %pa size: %#lx\n",
>                                 &offset, (unsigned long) size);
>                 return NULL;
>         }
>
> So I'd say xlate_dev_mem_ptr() looks messy, but is possibly a bit more
> robust in this regard?

It clearly does work. Slowly, but work.

At least it works on x86. On some other architectures /dev/mem
definitely cannot possibly handle IO memory correctly, because you
can't even try to just read it as regular memory.

But those architectures are few and likely not relevant anyway (eg early alpha).

             Linus

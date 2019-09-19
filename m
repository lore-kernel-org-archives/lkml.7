Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96DBC4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 02:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0F7214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 02:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568858898;
	bh=ijQObP1ViXv2IiyhYIO3hOgjDjMCT66WfvFvJLjFVWo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UPJRPoB/csbQeH91PwcCYaNmgBcTcKO1BWTAuKXUozEAXzCVL+WMQjyj03y6WYu3l
	 EJ+OYbuiB4P7nDnz5XABSWGOD1n/xLCQ+6wO5WE1q25raEcv9T/LZkeF8GUjzCsor1
	 SRW6MoMZmB81Y0LJfSI7J3jTq0M22PD0tO6Ygh/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387924AbfISCIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 22:08:17 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46266 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387712AbfISCIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 22:08:17 -0400
Received: by mail-lf1-f66.google.com with SMTP id t8so1069377lfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 19:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Xuld3BlUHhLVm41JSQ0g37C/9G156A47j1pRWimdvw=;
        b=K4bnmhnBOLjP8CCgm9SQOLs8Azqf3H69cXUe+ZDqGsJNsVyqgu4XmqoP9IeTJLNk2l
         //0jhii85ZMd5vOF7E688yX86AzktkkMYhlQ07aMMj+h5+afd2UQCp7atEt6iXXdF2LU
         RRh/vpBYAp69fsqpH8cadS17r2gGFQbSW0FSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Xuld3BlUHhLVm41JSQ0g37C/9G156A47j1pRWimdvw=;
        b=jKa/WbpdCX/3XH88RD2Si1t/aAkKt2K6tA0tsGeFy7+PrgqHXoRYH7Dx3VJqKGXbR0
         kOAKe/I9nzkjU+oCF5bYuSn9J2W94hIbmegzR+lzXzHbJrKm450FpAdQ2s7oxMNUiEvG
         G1mwYKqo38bc8EkWGgNu7yFdCdR/0fMFBqEKjBY7deyvIMiRLAMnUEpRFEhRVDhjcxpD
         QeByaYGALu+IsXe8DETet23y561+ywg1wIokkMSO7wWXwHGyo8bzyaKWZQzCFtcpFCnC
         dw6IyaiAw2BZeJMU8lvZIim0TL1vNF9PDHuWGBZ+cIXVYIXEJsMggr/TQY9WEjcqV/Ca
         FlbA==
X-Gm-Message-State: APjAAAUewt6tmaVvta8F2oJ+G1b/WX9uWdh/R1DIN/6+oNnig9JJ2H/C
        /0mPEhRL+Z3pOshucalZN1bQn8hqK2E=
X-Google-Smtp-Source: APXvYqz6VMZ+/GZ2QM0Gdno+f+SeDn1HasoOWPpXzWdjyqYeC3PgemuZndY9tgng0U2f4sljWcn48g==
X-Received: by 2002:ac2:554c:: with SMTP id l12mr3702006lfk.10.1568858894836;
        Wed, 18 Sep 2019 19:08:14 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id b10sm1242105lji.48.2019.09.18.19.08.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 19:08:13 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id u28so1108714lfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 19:08:13 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr3524864lfn.52.1568858892842;
 Wed, 18 Sep 2019 19:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190917152140.GU2229799@magnolia> <CAHk-=wj9Zjb=NENJ6SViNiYiYi4LFX9WYqskZh4E_OzjijK1VA@mail.gmail.com>
In-Reply-To: <CAHk-=wj9Zjb=NENJ6SViNiYiYi4LFX9WYqskZh4E_OzjijK1VA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Sep 2019 19:07:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXBV57mz46ZB5XivjiSBGkM0cjuvnU2OWyfRF=+41NPQ@mail.gmail.com>
Message-ID: <CAHk-=wgXBV57mz46ZB5XivjiSBGkM0cjuvnU2OWyfRF=+41NPQ@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: new code for 5.4
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 6:31 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Why would anybody use that odd "list_pop()" thing in a loop, when what
> it really seems to just want is that bog-standard
> "list_for_each_entry_safe()"

Side note: I do agree that the list_for_each_entry_safe() thing isn't
exactly beautiful, particularly since you need that extra variable for
the temporary "next" pointer.

It's one of the C++ features I'd really like to use in the kernel -
the whole "declare new variable in a for (;;) statement" thing.

In fact, it made it into C - it's there in C99 -  but we still use
"-std=gnu89" because of other problems with the c99 updates.

Anyway, I *would* be interested in cleaning up
list_for_each_entry_safe() if somebody has the energy and figures out
what we could do to get the c99 behavior without the breakage from
other sources.

For some background: the reason we use "gnu89" is because we use the
GNU extension with type cast initializers quite a bit, ie things like

    #define __RAW_SPIN_LOCK_UNLOCKED(lockname)      \
        (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)

and that broke in c99 and gnu99, which considers those compound
literals and you can no longer use them as initializers.

See

    https://lore.kernel.org/lkml/20141019231031.GB9319@node.dhcp.inet.fi/

for some of the historical discussion about this. It really _is_ sad,
because variable declarations inside for-loops are very useful, and
would have the potential to make some of our "for_each_xyz()" macros a
lot prettier (and easier to use too).

So our list_for_each_entry_safe() thing isn't perfect, but that's no
reason to try to then make up completely new things.

             Linus

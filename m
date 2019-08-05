Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F4FC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533E4217D9
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9YZ2Yxq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfHEGWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 02:22:54 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38548 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbfHEGWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 02:22:51 -0400
Received: by mail-ed1-f65.google.com with SMTP id r12so42778040edo.5;
        Sun, 04 Aug 2019 23:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tGdeKkO6NF7wDJ7Q5bh/TgttU4eme3KB46fSMxOwVRA=;
        b=M9YZ2YxqcdoIX7YXTDFw+22XCqU+0OIb5RpWCbwZW4THqevYUE3gzQ3/n9FCZs0Puj
         8XYIDbH/DEDPGkjbGuKPUKD19eFwZRx3Ni890NOrXOe/NlO/Jby9xvzJers3NsVxnCI2
         OcH6NoXkcntvuBZ8sn3drrNH/jS+JwcYehMb8OgUFStTQgwkU3ISGZT0TQvDMFr1hmgk
         9UYFOVfu2hsVIQU2QLTrAPJbp0SKqhIsrGp9Qf9NDZsxI8TcFdP8DzStbDSqsQ/KDfN5
         kzY8USuixdBFDnvS97LfvawcTXwFb5+6VobAHwLsTxPEhWREAPK35NLOOhknHbzUlDeO
         JVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGdeKkO6NF7wDJ7Q5bh/TgttU4eme3KB46fSMxOwVRA=;
        b=lDODaL2y7DAZnf5DO0QEYL1tc2DldYPgUUTXAiVmSC5bjbF/KzT7Y73G5p5TFNxay1
         IWZHOZEJtDJlmZR/WfxQLd5/R9KiB5QiktvN1i0Gx6oPww8v7KghaeztBgHVpOp2266z
         FlvpHt05KxlKx2gRw3TdzHsAQPSAirEHFhOzpAB9hc/g+A+/OjxFRqwMKp/9kRAWZoBm
         mcclRX4gl8tp+ZWN95J+mN5g/QFvCIe8qiGqiuYZ7hS+LbZb7Yc1eKVijIzHVkTF7zGw
         0JJAm4rYRDPrJWYldstLpFZYJ55/lkTr73fv8Q5dM0I0fysR2um+mveZk9WmXYm/bR0J
         0n6Q==
X-Gm-Message-State: APjAAAWuH5oDMIdi4ePHMPaguvIeo3raKIB324pJ9aMTre+uZnP89iI4
        3W/M1x/T8eBna8O6wq3jWTNCC5JhDrsUusNFXKI=
X-Google-Smtp-Source: APXvYqzflf4qXhYsaRJU4r6IXLMuCAO7l8ggqaaQXaXViLftYO5nPqiMMBo7z3qWSwykuxGy5zY9MuxJGY+x7SYvG0U=
X-Received: by 2002:a50:fb0a:: with SMTP id d10mr103635158edq.124.1564986169613;
 Sun, 04 Aug 2019 23:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190730084047.26482-1-hslester96@gmail.com> <1564498597.4300.10.camel@linux.ibm.com>
In-Reply-To: <1564498597.4300.10.camel@linux.ibm.com>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Mon, 5 Aug 2019 14:22:38 +0800
Message-ID: <CANhBUQ0KD9YqYWT-m7q-7FcqAwRstVPzh_s2rRmCCjwQYcivBQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: 3w-sas: Fix unterminated strncpy
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Adam Radford <aradford@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 10:56 PM James Bottomley <jejb@linux.ibm.com> wrote:
>
> On Tue, 2019-07-30 at 16:40 +0800, Chuhong Yuan wrote:
> > strncpy(dest, src, strlen(src)) leads to unterminated
> > dest, which is dangerous.
>
> I don't buy that.  The structure is only used for the
> TW_IOCTL_GET_COMPATIBILITY_INFO ioctl and all the fields for that are
> fixed width and are copied over as such.
>
> > Here driver_version's len is 32 and TW_DRIVER_VERSION
> > is shorter than 32.
> > Therefore strcpy is OK.
>
> The best practice for copying a string to a fixed width destination
> that does get printed within the kernel would be what the 3w-9xxx.c
> does
>
>         strlcpy(tw_dev->tw_compat_info.driver_version, TW_DRIVER_VERSION,
>                 sizeof(tw_dev->tw_compat_info.driver_version));
>

This is right, and strscpy() is better than strlcpy(). strlcpy() is deprecated
now according to the documentation.
I choose strcpy() since it has better performance and there is no worry of
overflow here. And I find there are indeed some places using strcpy() to fix
this problem, like add_man_viewer() in tools/perf/builtin-help.c.

> But as I said, it doesn't really matter for a fixed width field that's
> never printed within the kernel.
>

I think it is not good to leave a exploitable place here, and fixing it does not
need much effort.

Regards,
Chuhong

> James
>

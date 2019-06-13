Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D28C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE88720644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2mhSEu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390771AbfFMQe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:34:27 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:38021 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730775AbfFMHwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:52:24 -0400
Received: by mail-ot1-f52.google.com with SMTP id d17so18064767oth.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 00:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x7HLKRclBYkI4l8xezabyIsI1B9pbvnD70ysiff/Q9I=;
        b=i2mhSEu3HULgbyY3/yHZx3wJfp9kSeVS6V90pgxEo1RvXXcUN2VbDcaukTCsYRJzlE
         eRz7XH+tRZJFjQaE5xBGY0gWA6cjEoSogRGArWjPbNilUgg35eQnVsBuLrgs2NtjXLJh
         w+xq5wE4Z6Sc/NAHILr8fPixyTflU0YR2cEEi0n8bo/6GESlRZ6f8ZiVmR0RxizFoeGB
         NKvM+7fe5os65B7BpoQv8nggL16sa3ceXec1kyI7HDzQPj2nLIdNy4VEZve+YODOGcuR
         2ZJ/x1vEJR8L5k67sCIOG22Hz3J0CIV8aIW0rEHhELpxhyO9XzRMURwa3KPSb/81MZ80
         sCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7HLKRclBYkI4l8xezabyIsI1B9pbvnD70ysiff/Q9I=;
        b=VAxv3k3Am1Xlm7oQhkR9CIJZoU8j1o5x/R2C/pEHW6kb1Sojto0D5hJt0jojPZ/Srd
         ccypZ56ThLSZkChN1j8pXnANm6Fy+4ATwSs14V4jMm4x0XmxYlZrf9I4IjN2QQ244wn1
         K4gwmskfkvSRoqm9qdxmgoXs/xZqsrceUv4BEeUIjSR71DfCeQ7CiLZG9iNqAFTK/t14
         rHTOtgGeecvwFdeaS55WxkU8zpv9cUu9qu4N0orcMm7P9VtltZHpPcOiToFVfONELQ5F
         GmW58BoHx+XEv/Dk0krrfQgPCLsluMLDJ3Y2r++pQHu/KjlXGnJgBtitzibZM2tKN58P
         31dw==
X-Gm-Message-State: APjAAAUwS8bFVVkrTEYe/S+c/ktNJSHaSLaQs0N5kNqYvZwRT6xzcIKU
        zfoBCRBrvrR6IDN6sR9qO9muJgTXJgmSYX96VAvfr6PhvFw=
X-Google-Smtp-Source: APXvYqzul2HTv6oUHbzOV/m3sOro8XF+jwMiCPBp7INX3G7Ere0e+wvfo+oHu/kHRTbah1JqMy85q9UHRUoq0RcaLA4=
X-Received: by 2002:a9d:3f62:: with SMTP id m89mr43725442otc.128.1560412343351;
 Thu, 13 Jun 2019 00:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLifSHQmi+jCMzRGYz3kzct+NB_vyv-yiwL91adRZPkTrQ@mail.gmail.com>
In-Reply-To: <CAOuPNLifSHQmi+jCMzRGYz3kzct+NB_vyv-yiwL91adRZPkTrQ@mail.gmail.com>
From:   Shyam Saini <mayhs11saini@gmail.com>
Date:   Thu, 13 Jun 2019 13:22:12 +0530
Message-ID: <CAOfkYf7BZ1Ttrm7iVioq4mxZcJy7V44gNmusavPzgi=59=TY6g@mail.gmail.com>
Subject: Re: Pause a process execution from external program
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        open list <linux-kernel@vger.kernel.org>, pedro@palves.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pintu,


> Hi All,
> I was just wondering if this is possible in the Linux world.
> My requirement is:
> For some reason, I want to halt/pause the execution (for some
> specified time) of a running process/thread (at some location),
> without modified the source, may be by firing some events/signals from
> an another external program, by specifying the address location or a
> line number.
>
> Is this possible ?
> May be by using some system call, or other mechanism using the process PID.
> Assume that its a debugging system with all root privileges.
>
> Basically, its just like how "gdb" is able to set the break-point in a
> program, and able to stop its execution exactly at that location.
> I am wondering what mechanism "gdb" uses to do this?

gdb uses ptrace system call, may you can explore ptrace?

> I tried to check here, but could find the exact place, where this is handled:
> https://github.com/bminor/binutils-gdb/blob/master/gdb/breakpoint.c

from command line we use ctrl-z to stop execution of a foreground
process but you can program
SIGTSTP signal handler in your application code to do the same.

is that you want ?

Thanks a lot,
Shyam

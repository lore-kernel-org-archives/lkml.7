Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5B6C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 14:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F387321743
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 14:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtbU3TV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732725AbfFMO72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 10:59:28 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:43510 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732608AbfFMOxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:53:24 -0400
Received: by mail-vs1-f44.google.com with SMTP id j26so892628vsn.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V+yDsP1w6a5l/+u0u89gIJIvGqAKvFSmmikVgpJYGog=;
        b=ZtbU3TV6qSNoRMZ2VnMKPMX/QZnnX8rJS1W4M8+Htte8DT5AAsttsM1tHdg8+BHLng
         oRWe7/VsZa9BRMDJ70ll3bHt6WYPd3jjKXj9UindCIGByvsyyfkJJugAf/EtZxlKAP43
         2z4Xdpl+9HknjyJ9A6T+JLEJRaicMDSE2HP6j1369/Km8WOLPZDMOnF+88slRyvZf81z
         FG85xbJnW9pFc72eAePnMM/robHwdfcvlMgDMTVTTOyGRZxvqLagIN6YV4qx6EuXUNQC
         fCSTYSpqSrnLUH6EB64cnbFDTLC8wRG9ka3gJ8TSWgHzXRtjgGX9M/eXkfbN+wEx6afE
         kgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+yDsP1w6a5l/+u0u89gIJIvGqAKvFSmmikVgpJYGog=;
        b=HQp+7Jl6t3KL6vxy7t0wihNjtHowpCh5qji6KumJnrsocPxWDXpkUgpTFHMhsSFuwi
         +4Ra/HRT8q02n90mJLiDR9xW72b8TS3RScD58LIOBYwkiczAL7b6YKJCFWVbjBnvoLCt
         xlu0jhNWZpxfGU6aDpq46uKJzTADSmVBXmWh2J9rc0yysgEyPKzC33men0YP9dLstr/K
         c0ImcxlmyVJZQd/TA8v/b7XFuWqKYZkckTVoj7Q72aFUOn5L4Gh7P64UwZTpCUMwNHyl
         2JdxTF6BnqDrD7T/jqvFm+VQOnynCLhGIdIPhgdyaXDDMrB0hMLnt4LT2Wdsb324gYP0
         IiHQ==
X-Gm-Message-State: APjAAAX+t1JteL1MqOR09lQ5xmeaOsVAAWSqmZPAJOMFleT4Ry3Hf0GK
        g2il55oZrSm/quZ7i7xy6CarPZxA6jmRjesvxvg=
X-Google-Smtp-Source: APXvYqwVT15ISeE4OXEf4ZSfeyzhYmABcdFuToe5TYa1G3vEVUfB92ABTVALFEFgx+FGgdMYYjyenT0Fh1nciagkB4I=
X-Received: by 2002:a67:e419:: with SMTP id d25mr19945168vsf.196.1560437602879;
 Thu, 13 Jun 2019 07:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLifSHQmi+jCMzRGYz3kzct+NB_vyv-yiwL91adRZPkTrQ@mail.gmail.com>
 <CAOfkYf7BZ1Ttrm7iVioq4mxZcJy7V44gNmusavPzgi=59=TY6g@mail.gmail.com>
In-Reply-To: <CAOfkYf7BZ1Ttrm7iVioq4mxZcJy7V44gNmusavPzgi=59=TY6g@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Thu, 13 Jun 2019 20:23:11 +0530
Message-ID: <CAOuPNLivFg5jnhzz7GaUjz6Sd5+-3aNeUhbPbnMTBnumpPgSvA@mail.gmail.com>
Subject: Re: Pause a process execution from external program
To:     Shyam Saini <mayhs11saini@gmail.com>
Cc:     Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        open list <linux-kernel@vger.kernel.org>, pedro@palves.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 1:22 PM Shyam Saini <mayhs11saini@gmail.com> wrote:
>
> Hi Pintu,
>
>
> > Hi All,
> > I was just wondering if this is possible in the Linux world.
> > My requirement is:
> > For some reason, I want to halt/pause the execution (for some
> > specified time) of a running process/thread (at some location),
> > without modified the source, may be by firing some events/signals from
> > an another external program, by specifying the address location or a
> > line number.
> >
> > Is this possible ?
> > May be by using some system call, or other mechanism using the process PID.
> > Assume that its a debugging system with all root privileges.
> >
> > Basically, its just like how "gdb" is able to set the break-point in a
> > program, and able to stop its execution exactly at that location.
> > I am wondering what mechanism "gdb" uses to do this?
>
> gdb uses ptrace system call, may you can explore ptrace?
>
oh thank you so much.
Yes, ptrace is going to be very helpful. I will explore more on this
and come back if required.

> > I tried to check here, but could find the exact place, where this is handled:
> > https://github.com/bminor/binutils-gdb/blob/master/gdb/breakpoint.c
>
> from command line we use ctrl-z to stop execution of a foreground
> process but you can program
> SIGTSTP signal handler in your application code to do the same.
>
> is that you want ?
>
This required source code modification in the target program, so I
don't want this.

> Thanks a lot,
> Shyam

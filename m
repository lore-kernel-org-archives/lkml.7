Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2563AC10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C35205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vfj3uJFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfCKQgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:36:24 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40009 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfCKQgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:36:24 -0400
Received: by mail-it1-f194.google.com with SMTP id l139so8284134ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 09:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/fI3qTkgpdY5Rt3zarXzq2kzVx67QSqse33gh9oYOXo=;
        b=Vfj3uJFJfnW58Myoo7xtTHzZojAbWg8KwWv79MEz3BIh6n3wfalUQEAmDxSyAjgCX1
         kyDSaWgME5bwzbw8D0navJlAJL4kj4Wy0+NIRGIOhYDiF+6AbYZT7j0fvAYAyNMXQxMA
         HSHFiQNCj7DcNz3H7XWL28eyl17w5VrMD4x16nnmJjKCDM7nWry3FiVEQbuozuMxb2cT
         6rCM+WAhtWkXdFC5IkCz2FBc+OdYFnfM3OBJmvyxbinij8cbBbD7jRsuFfhMJ0J4KHFq
         Br0HV1IF7cuDkVMABolaaEjaCGLpyVslp8lh7NxuAOTai9IaTar0eW0bMIIbTace57y2
         IbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/fI3qTkgpdY5Rt3zarXzq2kzVx67QSqse33gh9oYOXo=;
        b=s1ZsjNrNB7TL/gP6g9l9IHdGE2V7CBZeYOIU9bsjf8izE5P+XwHaquVK8zjkIaNRE+
         ihD0+oeKN8lgt1rMS3hD6pgveBwga9Yl0UehgeRHhrL8yayTbWoArN09e5vra4X4+EdX
         PmgTYOk5Qh1VBaimwOhQ1SfUkAf4+kuFz8dAMjoWQfaE+6jl/BQVV2kR84gTjn0/Sa9O
         iY4fLX4HzE5gniytjExhkGNoKECcITQDl290g0xu91QA+uKU7ih3Ln0h29GHR3ZX97DC
         OOxbtmku6pwGPbEabp+bTkLbZVtwI/A5KYX82T3mJQe/gOhDItw+DI1ttEtfnGTgMD2d
         rJUA==
X-Gm-Message-State: APjAAAVoloSXEs1iDbatzRf8eQF/gBd/PMqnhxNBXhLB2Yb5bXvTpPkx
        vVZWK0tXaZkdZvHn0XBNvqIsp+6fkgar9URmQ6Gi5g==
X-Google-Smtp-Source: APXvYqwLiWUBxDNY3OTYLFa+WsqzNgUwbKi5gA9EEmNsWbx1yO1sW1/sJpEoUwU3Pzr308X3+NXm4VJqB8i9uqubXEw=
X-Received: by 2002:a24:674a:: with SMTP id u71mr397848itc.12.1552322183512;
 Mon, 11 Mar 2019 09:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008f34570583d15823@google.com> <0ded99b8d69a74c260f3f44f5ae1ab59@suse.de>
 <CACT4Y+ZXBhNamhTYVW_9y_yUWRE+=rO8vdBF=m40kjqJQGY-gQ@mail.gmail.com> <531016fbc6fee2f1a1c386b0daeba867@suse.de>
In-Reply-To: <531016fbc6fee2f1a1c386b0daeba867@suse.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 11 Mar 2019 17:36:12 +0100
Message-ID: <CACT4Y+YLZYJ21Bao5HVAvXhvb9PQ41J-4RvtkZZEMF38qtkxHg@mail.gmail.com>
Subject: Re: WARNING in ep_poll_callback
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, dbueso@suse.de,
        Jason Baron <jbaron@akamai.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 2:53 PM Roman Penyaev <rpenyaev@suse.de> wrote:
>
> On 2019-03-11 14:45, Dmitry Vyukov wrote:
> > On Mon, Mar 11, 2019 at 2:37 PM Roman Penyaev <rpenyaev@suse.de> wrote:
> >>
> >> Hi Andrew,
> >>
> >> I thought "epoll: loosen irq safety in ep_poll_callback()" patch was
> >> removed from your tree, at least I got a notification on 9th of
> >> january,
> >> also I do not see it in the linux-next tree.
> >>
> >> Should I ignore this syzbot message?
> >
> > If this was resolved we need to communicate it to syzbot one way or the
> > other.
> > Since it was in linux-next, it won't even be able to do fix bisection.
> > So the bug will be open forever otherwise.
>
> Bug was fixed (commit was simply dropped).  How can I tell syzbot to
> shut up
> and to resolve the issue?

Hi Roman,

The docs are at:

> See https://goo.gl/tpsmEJ for more information about syzbot.

There is no official support for bugs fixed not by commit merges.
Linux-next creates various interesting corner-cases for the process.
Let's go with this option for now:

#syz invalid

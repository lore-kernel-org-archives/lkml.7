Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0ABC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 21:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A89A21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 21:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vcqB8L/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfC1VeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 17:34:10 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54448 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfC1VeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 17:34:10 -0400
Received: by mail-it1-f196.google.com with SMTP id w18so600234itj.4;
        Thu, 28 Mar 2019 14:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BwJ3ahE9qKEzbgRpb2OvUo1z5D/jo/o/M5wFIL1CiC8=;
        b=vcqB8L/6O308V8thCNonQWMtwVOfoHxnu4a0MnxWmfzP/m8jOybmSO/xj42trCQIk+
         O0yJkMdbThmKA/h+7Hk4i8Cftza4gVLypu+0zFcrz8j15m8CL8fTlvPzPLZDSPYlJrUS
         OjG4XXVdNjyuWOfs2oQtYl96Enx3xqw3qifk9aEhpYE65cBmarYVxoRx88rnWQmqEf61
         +PCKTt7y5YXWg8MljOjtktzGfZcVMSC8pOZXhAFwM+cj/U5eFguxcbBd2sUdxq7bhIWl
         azhzx2tOsylMIws807slbs/zJS+Xh49i3xVXI1iGsXITJVi0zudz7549bqWkiF8iJwVQ
         QTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwJ3ahE9qKEzbgRpb2OvUo1z5D/jo/o/M5wFIL1CiC8=;
        b=tZuvt3QENu5KQqCXv+a039RgsvfSoLOHoiYfR/U020fQvKyy2CKKa/6X2Ubp8sRTgM
         OAJj4Fg6hgwtcVkyFaBpwrVi28kAjU4B9gTgztvCJu0jaBuln9Zca1lXWHBdatvq7ir0
         7k3bDzaJqWJs95AGmWU0exYmPeP2g2CO1LOPTxECsIfpLUGD8wPm4/29VU5QajuS0wsh
         ZqF4I/Wyg8Hk4SgMLTnal2Vv5c2xoJtTh7LFz56PnE2WbTJssontzd1OybcBy8qJADkf
         0E7BbTDoJ8/9Kpa5wDoiucFHYesZ6nQj48ktr7xQ4tV7zth4RVrTYjGarW1cmgyD4G6k
         uy9g==
X-Gm-Message-State: APjAAAXYVcSp71/kYnnNTfsF5NJj06ud7HvoaBelciFOIwoGrxJEe7Yb
        WFcSZcHvdnpNdj+5vVEA1qRIePC3+1MboHx3hzg=
X-Google-Smtp-Source: APXvYqxB99IOVRQ9Y/gCc3Zy3JvgkUuUnsinjxjYxuImQIZiT6RIR0r6ZFd5+FThUPxvLd7NilDy3mWHaW/ICjHOOqw=
X-Received: by 2002:a02:5541:: with SMTP id e62mr10689867jab.88.1553808848380;
 Thu, 28 Mar 2019 14:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190315101013.GN8455@Legion-PC.fortress> <CAK7LNATsm23e_CuyfFw7_CR8xZQ3HnwNHCXhEm_zQZU2PUGK5A@mail.gmail.com>
 <20190326172411.GA15936@Legion-PC.fortress> <20190327154025.GB23293@linux-8ccs>
 <CAKi4VA+14kihzGFbMT623BwMbZEzgYU6+jz8MpR9jqoC059oog@mail.gmail.com> <20190328184546.GB23800@kroah.com>
In-Reply-To: <20190328184546.GB23800@kroah.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Thu, 28 Mar 2019 14:33:56 -0700
Message-ID: <CAKdAkRTxvJjuocVgENDPsmTjV+uNbD81wgReLRyF4CUFqzTF0Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v1] moduleparam: Save information about built-in
 modules in separate file
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Jessica Yu <jeyu@kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:ABI/API" <linux-api@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 11:45 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Mar 28, 2019 at 10:41:59AM -0700, Lucas De Marchi wrote:
> > On Wed, Mar 27, 2019 at 8:40 AM Jessica Yu <jeyu@kernel.org> wrote:
> > > >No. There are definitely not all modules. I have a builtin sha256_generic,
> > > >but I can't find him in the /sys/module.
> > >
> > > Yeah, you'll only find builtin modules under /sys/module/ if it has any module
> > > parameters, otherwise you won't find it there. As Masahiro already mentioned,
> > > if a builtin module has any parameters, they would be accessible under /sys/module/.
> >
> > Could we please change that and add the sysfs entry regardless of
> > what's being discussed here? Not having the entry there simply because
> > we don't have parameters for that module always annoyed me.

What is the benefit compared to wasting some memory for the directory?

>
> What is the sysfs directory going to show?  Will it just be empty?
>
> Feel free to send a patch for this, but from what I remember, it wasn't
> the easiest thing to do for some reason.  But given that the code was
> implemented before git was, I can't quite remember.

I am pretty sure we allow empty attribute groups, so it is probbaly as
simple as removing "If (!params) return 0;" form
module_param_sysfs_setup() and making sure we always create
"parameters" group instead of doing it on first visible parameter in
add_sysfs_param(). I suppose we no longer want to skip over parameters
that are not readable nor writable either?

Thanks.

-- 
Dmitry

Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A0AC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC20E2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfFXI0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 04:26:03 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37635 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFXI0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 04:26:01 -0400
Received: by mail-io1-f67.google.com with SMTP id e5so733916iok.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 01:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kfyERo/qbyCrZtACfmY6e7oEdMDreZL5930Ld8MdyWA=;
        b=gyW61FIpTDEeaIXO/6rIe8yxFB7luXiRUEl9CPYNxIqCKMxblktl/j8IKH8bMH0tag
         4x4Tcwn3BYlwFbAIj0R4DVntDq0yRWjRjDM3N/nidSdJBkS3ToDoK5Bd5uL0XiKCwNci
         sVblZxv5OcT1Um6QKAATeMHhuU9KvNuZxlZVq+c4k9nRYpjR33B8Oo6NG+2hxwRObxnS
         7dYqq4o8HthkHPLm5bplshqMJU0F9k/OaNCGWnnyhXrCr1rJ615xNpqnVE6XAlzwiHRQ
         rut5WIZQPusbEzc7+uHJa5zao9boJVS4bFG/Q68nKXETSMs0IUImbhhqJE7cM9nteb+K
         F2Og==
X-Gm-Message-State: APjAAAUSi/4FQrhlsqV7uwgNnkunA4CTLih9s0uZV7LiZq3KMuFP3qAn
        xhnO89SkYRsA4paVhyvs470AdjOuFKT42RisWkDdLXmH
X-Google-Smtp-Source: APXvYqxWKVfvD82LkcUgZZSuaW7gHtIZNb3ThzXsHToF9uKf0p3weHT5YuTecAFti5V8yJGEHzcSv4flXMz9LzUVNyw=
X-Received: by 2002:a5d:9c46:: with SMTP id 6mr8555199iof.6.1561364760754;
 Mon, 24 Jun 2019 01:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190619123019.30032-1-mszeredi@redhat.com> <20190619123019.30032-5-mszeredi@redhat.com>
 <1ea8ec52ce19499f021510b5c9e38be8d8ebe38f.camel@themaw.net>
In-Reply-To: <1ea8ec52ce19499f021510b5c9e38be8d8ebe38f.camel@themaw.net>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon, 24 Jun 2019 10:25:49 +0200
Message-ID: <CAOssrKcU2JKDYMDbW7V6jpM7_4WFSMA91h9AjpjoYmX=H4ybeg@mail.gmail.com>
Subject: Re: [PATCH 05/13] vfs: don't parse "silent" option
To:     Ian Kent <raven@themaw.net>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 6:40 AM Ian Kent <raven@themaw.net> wrote:
>
> On Wed, 2019-06-19 at 14:30 +0200, Miklos Szeredi wrote:
> > While this is a standard option as documented in mount(8), it is ignored by
> > most filesystems.  So reject, unless filesystem explicitly wants to handle
> > it.
> >
> > The exception is unconverted filesystems, where it is unknown if the
> > filesystem handles this or not.
> >
> > Any implementation, such as mount(8) that needs to parse this option
> > without failing should simply ignore the return value from fsconfig().
>
> In theory this is fine but every time someone has attempted
> to change the handling of this in the past autofs has had
> problems so I'm a bit wary of the change.
>
> It was originally meant to tell the file system to ignore
> invalid options such as could be found in automount maps that
> are used with multiple OS implementations that have differences
> in their options.
>
> That was, IIRC, primarily NFS although NFS should handle most
> (if not all of those) cases these days.
>
> Nevertheless I'm a bit nervous about it, ;)

What I'm saying is that with a new interface the rules need not follow
the rules of the old interface, because at the start no one is using
the new interface, so no chance of breaking anything.

Yes, there's a chance of making the interface difficult to use, but I
don't think this is one of those things.

For one, "silent" should not be needed on the new interface at all,
because error messages relating to the setup of the filesystem can be
redirected to a log buffer dedicated to the setup instance,
effectively enabling silent operation by default.

Thanks.,
Miklos

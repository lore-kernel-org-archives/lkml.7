Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A559CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109C22084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DHleAkBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409340AbfJXOHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 10:07:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43529 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404950AbfJXOHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 10:07:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id a2so15228408pfo.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 07:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJy55SIwOEViP+KRXPJ0Yoq5S5v3p1+WPbnz7NQz+Rw=;
        b=DHleAkBO43p7Td0l0m9fgcBg++GJfNaNysbPHYOR3EDKGcJfyjw+OFG87PHiqq46J0
         b+PjEYAiFPnWvFmBCuHUuh6eAeOek4OscCicD3vplvCzdPMXyu657mMLAMkHbzjhK3jN
         5K77AR3icppTUGMPykEyp4oE112KmrSJj7aOQ6jgUt8wMMmAGTFCPijZCHBiO0GhmhAg
         Cun7dZY3nHT1/wd2XTEYPYzcj//YDCcQ6J2FC+aFksKcn4/Hp9MBI7iUDuDH0U+JUq6a
         7e515Jz29iNCGkWrFI9AwL9HiU33MxNv4ofUHbXEiCz41WSYgUhgyfjgDDn7Tdq8wb+7
         bSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJy55SIwOEViP+KRXPJ0Yoq5S5v3p1+WPbnz7NQz+Rw=;
        b=e8AiRy2OEzTr8r5UT2WHSsc5LG1tR/NKaK48CWUd4qTDN9fRhWKmvBunAtyeJnCqTb
         ZCAEvDQLSX5b5UQ8Ds3Rf/BU4OPJedaViDGH1+LCxgStDwuJ3sSSUBuHB2y36nvCwi11
         Lvxo6iSUdsX2VZOcf7PcV5M4Uy/R4B6WU4LxfPeZ26WFl7yaqKJREv1/G4trAgmUy5gA
         fSioh0qy8LY9uojARPFqT+n9AdXDbnmSspxomRbH40xtUxJgO/egu6t+fVoHIHp0YNoX
         gCBqnIkJ0oISnGzjh6lmfrEuPS/eGFGvVnpU2amBCfAZZrUfTBGGGukDQ3FHzur5SsB4
         Erxg==
X-Gm-Message-State: APjAAAVWdI4IE3GnJqSLR/K5Nqvb3DWeiF0ymsh5vSP4ddz7lwCy0y5u
        C2cD6sp0O0/NEVUnJMLNkJX9pwq39NJqwJQKAWJuXg==
X-Google-Smtp-Source: APXvYqyV0t4sRpTwI6AFnypLA2oz7oqaLuam9C1OVUwv5QmmO1DL5KIwlKtuylj4NxY4ud+gg2s3kte/wvyq7XiVR1g=
X-Received: by 2002:a65:4c03:: with SMTP id u3mr16829386pgq.440.1571926037251;
 Thu, 24 Oct 2019 07:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571844200.git.andreyknvl@google.com> <beeae42e313ef57b4630cc9f36e2e78ad42fd5b7.1571844200.git.andreyknvl@google.com>
 <CACT4Y+a6t08RmtSYfF=3TuASx9ReCEe0Qp0AP=GbCtNyL2j+TA@mail.gmail.com>
In-Reply-To: <CACT4Y+a6t08RmtSYfF=3TuASx9ReCEe0Qp0AP=GbCtNyL2j+TA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 24 Oct 2019 16:07:05 +0200
Message-ID: <CAAeHK+xnRSZp5fxikyDzMB18bsDMmCvmrZexrjr_JV3Wgw80Ww@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kcov: remote coverage support
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     USB list <linux-usb@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Windsor <dwindsor@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 9:27 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Oct 23, 2019 at 5:24 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > This patch adds background thread coverage collection ability to kcov.
> ...
> > +static struct kcov_remote *kcov_remote_add(struct kcov *kcov, u64 handle)
> > +{
> > +       struct kcov_remote *remote;
> > +
> > +       if (kcov_remote_find(handle))
> > +               return ERR_PTR(-EEXIST);
> > +       remote = kmalloc(sizeof(*remote), GFP_ATOMIC);
> > +       if (!remote)
> > +               return ERR_PTR(-ENOMEM);
> > +       remote->handle = handle;
> > +       remote->kcov = kcov;
> > +       hash_add(kcov_remote_map, &remote->hnode, handle);
>
> I think it will make sense to check that there is no existing kcov
> with the same handle registered. Such condition will be extremely hard
> to debug based on episodically missing coverage.

Will do in v3.

>
> ...
> >  void kcov_task_exit(struct task_struct *t)
> >  {
> >         struct kcov *kcov;
> > @@ -256,15 +401,23 @@ void kcov_task_exit(struct task_struct *t)
> >         kcov = t->kcov;
> >         if (kcov == NULL)
> >                 return;
> > +
> >         spin_lock(&kcov->lock);
> > +       kcov_debug("t = %px, kcov->t = %px\n", t, kcov->t);
> > +       /*
> > +        * If !kcov->remote, this checks that t->kcov->t == t.
> > +        * If kcov->remote == true then the exiting task is either:
> > +        * 1. a remote task between kcov_remote_start() and kcov_remote_stop(),
> > +        *    in this case t != kcov->t and we'll print a warning; or
>
> Why? Is kcov->t == NULL for remote kcov's? May be worth mentioning in
> the comment b/c it's a very condensed form to check lots of different
> things at once.

For remote kcov instances kcov->t points to the thread that created
the kcov device (I'll update the comment in struct kcov). When a task
is between kcov_remote_start() and kcov_remote_stop(), it's t->kcov
point to the remote kcov. So t is current for this task, and
t->kcov->t is the task that created the kcov instance. I'll expand the
comment to explain this better.

> Otherwise the series look good to me:
>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Great, thanks!

>
> But Andrew's comments stand. It's possible I understand all of this
> only because I already know how it works and why it works this way.

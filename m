Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C83DC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C692067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="LW/2QAVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfGaWb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:31:28 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44999 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfGaWb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:31:28 -0400
Received: by mail-ot1-f66.google.com with SMTP id b7so21756068otl.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 15:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bSadfWcJlLBywRMIXV9mcKywOnO5UwqEGEWSQilvyk4=;
        b=LW/2QAVfnNW3GEBvxs9wNawPIAoMZk/0kwFSaO1XaizvoejDoLgbxsgsUgY/uGL0dZ
         yhxvSHeR5lsR+wFWpl/2fj8xc6VbU7TQrZloxL27dMYuF4TDl6mJtaP5h4ZfgvaGVHBK
         lfnAEQCAxd3LAyWlAgRYCL03Urv2hulKQP7B8BD45BjA+IsG6tM9pBZdB8sRDgDimvMm
         ge8q0uG4NeM10+6to5axXDi4dnvwesT52peVFmh6Nl95hktoj+XmTwPTujTWmRKUdjIc
         2vQE6FJRQoHGe3et+ANR8Lft0SqgQ3GbPTMr6gtNTnVo6ppgvF8+lwff4SsTTLZDuevb
         MLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bSadfWcJlLBywRMIXV9mcKywOnO5UwqEGEWSQilvyk4=;
        b=ZzKjcQZQJ6USRd+dMcvvdDefHsnThdlt+8Ceny0k3ZaMt1TASbgD3duhZzXNTcPG4h
         J7gurF3AI3utP+q1gxprYW8y9MxLNKdwBzsl4vV7rhIL8/6CA8Lr5w5UnIDqv7K4H2+y
         jKATkZjaeTXRyk8QYsc+yXGXoTU02DgrkHmTdDynNwWcONOd+CSHm9jHSBa2lJJ6hkwE
         QbxckNZ9FUZP/5MHeMVJ+tsVhwMetPPIysOQ/WnHxQzDzrHewUIgI0LROvjbUMZKIgxf
         X1QevYifLMB+HFyluDlo8K80Vvf0PKIMO4T/vYIc8vFw35099RL8Zihwolo9IhE11hZA
         56YA==
X-Gm-Message-State: APjAAAVTxkn53y/kTKpWB9n23qHavW7s4t6jOlWxwxvhN+r7a/c1Slnr
        9B5coy5+7rZLFSBQtCM9uchsc5L0YzkaY0Zs9SU=
X-Google-Smtp-Source: APXvYqyY4M0ZbQ9S2sovoW2815xr3pNT9xRL/dTcExgSxr/7uBuTQP/vrOsNAKkgiamDk10BFoz3IdaIfk7gSZmsTaE=
X-Received: by 2002:a9d:5911:: with SMTP id t17mr9029675oth.159.1564612287120;
 Wed, 31 Jul 2019 15:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190731215514.212215-1-trong@android.com> <5d420f45.1c69fb81.35877.3d86@mx.google.com>
 <32598586.Mjd66ZhNnG@kreacher>
In-Reply-To: <32598586.Mjd66ZhNnG@kreacher>
From:   Tri Vo <trong@android.com>
Date:   Wed, 31 Jul 2019 15:31:16 -0700
Message-ID: <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 3:17 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Wednesday, July 31, 2019 11:59:32 PM CEST Stephen Boyd wrote:
> > Quoting Tri Vo (2019-07-31 14:55:14)
> > > +/**
> > > + * wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs.
> > > + * @parent: Device given wakeup source is associated with (or NULL if virtual).
> > > + * @ws: Wakeup source to be added in sysfs.
> > > + */
> > > +int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source *ws)
> > > +{
> > > +       struct device *dev;
> > > +       int id;
> > > +
> > > +       id = ida_alloc(&wakeup_ida, GFP_KERNEL);
>
> So can anyone remind me why the IDA thing is needed here at all?

IDA is used to generate the directory name ("ws%d", ID) that is unique
among wakeup_sources. That is what ends up in
/sys/class/wakeup/ws<ID>/* path.
>
> > > +       if (id < 0)
> > > +               return id;
> > > +       ws->id = id;
> > > +
> > > +       dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
> > > +                                       wakeup_source_groups, "ws%d",
> >
> > I thought the name was going to still be 'wakeupN'?
>
> So can't we prefix the wakeup source name with something like "wakeup:" or similar here?

"ws%d" here is the name in the sysfs path rather than the name of the
wakeup source. Wakeup source name is not altered in this patch.

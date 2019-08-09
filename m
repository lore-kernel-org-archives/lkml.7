Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4158C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BE820B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="icVRSXJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfHIUIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 16:08:38 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39416 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfHIUIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 16:08:38 -0400
Received: by mail-ot1-f68.google.com with SMTP id r21so131276895otq.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 13:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bK7KxUzVsn8VTJ+Hf3wxQB3YMP5WkwuYdnj8VxgnBSE=;
        b=icVRSXJ8l3gDBm5+KYdytP97B5LamsZL9GMxcIs4Y1k3glZqs/6mIq2T9/cDkslS/M
         LLMPBAk0Puq6bECPCbYsNCYP6srkhQ2v2hYqXOl1KKvdLQnP3CWC0EqbAeT39Xthu+MO
         4Xqh+ECX+M3ps31nU2QA64d6Obf4vsTKQYqdo/PGEP4sDjK+F1kdD8ivG0dvB0Vr04er
         GaDXu9ph/EdDe6hiwp+1hzzvc0Aw1mhzvgpIzJUsu9xNX+mNM2TzxRci5HEwu5nMxX3m
         p4qCEn3Nm8mFBxTqYSPOeWGhvgx/gYCwIXiAdgdNTqDhKIgwY/M/qeqv3mC9Poyr0tOM
         Vm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bK7KxUzVsn8VTJ+Hf3wxQB3YMP5WkwuYdnj8VxgnBSE=;
        b=Ymu+TZS7cj4Quc6AmHcrzqKBA5zTS5vBUMUr57PAejLM5Y2GkEPGWqvVRdcJ54WDKi
         G4jZg2jbLk7omo4jBO5GQBBCa4xKQ/yuaUb8yfXBsgvBOM4zIZlfYOE3ogYjBnviyyMc
         x3z/6m0bX7l1bHa+OyLNv2EMT+sdhEpSsxVekyIBXa62XVp1tcMsXOV4HjKa2Zk7ufBJ
         x45c2GliMAyWBD3wMOXX5xaNEnzJCiyCOGJ0YWCEXKfHxyv0NkSR1nsPbYHL5uxjTvE6
         RTqUHwR/C/EjY7LNRvMcxWwgCJrE+lErEbzUbLltuW8dxXTlLTeastExl3Os/oMInuNg
         sYUQ==
X-Gm-Message-State: APjAAAVa8LbKekQXpQ0MG13vyKKo9CDF8O0ZbQSuVgoiJM3fvx2PscD4
        XdxrBVJPbmer6F1Xcc1SKcBpH6LmwcoVSX3qIberwQ==
X-Google-Smtp-Source: APXvYqww2xFRM10n5D7e4RwxGnvUBVisuszGhFTmaJYbJF8aWwP1GvcI7JkaufQUg2xZQgUI03lQUoHetkTrSfSFcBo=
X-Received: by 2002:aca:5a04:: with SMTP id o4mr1089820oib.36.1565381317080;
 Fri, 09 Aug 2019 13:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190808222727.132744-1-hridya@google.com> <20190808222727.132744-2-hridya@google.com>
 <20190809145016.GB16262@kroah.com> <20190809182216.5xzx6tss6fh42mso@wittgenstein>
In-Reply-To: <20190809182216.5xzx6tss6fh42mso@wittgenstein>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Fri, 9 Aug 2019 13:08:01 -0700
Message-ID: <CA+wgaPNjfvcVvcDB9ZBWupLegHchZ3AxYibBV8BPFE9SrPymtg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] binder: Add default binder devices through
 binderfs when configured
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 11:22 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Fri, Aug 09, 2019 at 04:50:16PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Aug 08, 2019 at 03:27:25PM -0700, Hridya Valsaraju wrote:
> > > Currently, since each binderfs instance needs its own
> > > private binder devices, every time a binderfs instance is
> > > mounted, all the default binder devices need to be created
> > > via the BINDER_CTL_ADD IOCTL.
> >
> > Wasn't that a design goal of binderfs?
>
> Sure, but if you solely rely binderfs to be used to provide binder
> devices having them pre-created on each mount makes quite some sense,
> imho.
>
> >
> > > This patch aims to
> > > add a solution to automatically create the default binder
> > > devices for each binderfs instance that gets mounted.
> > > To achieve this goal, when CONFIG_ANDROID_BINDERFS is set,
> > > the default binder devices specified by CONFIG_ANDROID_BINDER_DEVICES
> > > are created in each binderfs instance instead of global devices
> > > being created by the binder driver.
> >
> > This is going to change how things work today, what is going to break
> > because of this change?
> >
> > I don't object to this, except for the worry of changing the default
> > behavior.
>
> This is something that Hridya and Todd can speak better to given that
> they suggested this change. :)
> From my perspective, binderfs binder devices and the regular binder
> driver are mostly used mutually exclusive in practice atm so that this
> change has little chance of breaking anyone.

As Christian says, we do not anticipate the change to break any
existing use cases since binderfs binder devices and regular binder
devices are generally not used simultaneously. Hopefully, there are
not a lot of unusual use cases since binderfs itself is relatively new
as well :)


>
> Now I really need to go back to vacation time - which I suck at
> apparently. :)
>
> Christian

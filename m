Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FD6C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2926C2087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N8PIZnJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbfIDQvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:51:47 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42478 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731829AbfIDQvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:51:47 -0400
Received: by mail-ot1-f68.google.com with SMTP id c10so9928835otd.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 09:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MlIv6DeXLkg4uR1/sPKQNkLhMSuShpHchXiSAIDmZ0E=;
        b=N8PIZnJHFOI8JoHe9sxqWDMgOn4GZ6iQqYjA020wCxu3o7sOm/6bIQk9/8EoQ+OeZa
         AKLFKYYU9+YgR34WalofuXjHVk6yw6IoIL/Fa+YtH3YhWpsdBH7FzVe7fsFuvrCQEccM
         mHW9Zd3+Rsd8IZLmjvjy1WCd/QoQ/gIbtTdIArWVI8DqvE6tfdZaK9Rb/8sy6Ko7Q2l7
         O0vbYxXouuJ3S45WM6Wj2vdWqPqDplGZJCnyPjhwGI2HRdgKWyAouB0OFCvt3NiuPEqQ
         WxMXHJU7nUBKYXRaaM02KRIQoeMN+HtidM91MfhREDtcBhB71gvzzc8Nx78tAhdmlFfu
         Pvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MlIv6DeXLkg4uR1/sPKQNkLhMSuShpHchXiSAIDmZ0E=;
        b=FhRhSkhN53Rdp1/GKhBRD5YPQq7ZZyLEOCoufjakkXdHqzGnxg8nkezaFaNH1MQwzs
         ZiS9e8BBIrSY37HNXqVYtaQnwOYEPgwrEvRK+ftypcm1rDg0Lswq9HoN/48VgLvl4J2I
         sJn7yOijDmbrFENaniUIVUz1cktu/3oiys8WFaVQWTHK1bM6vpT514mCVjNWOmZjACmk
         9J6MsMumotSmte+a691rKOov2YlPldO9COeQjL+ls3y1sdO5fpLl31JTarNbLdW5itqk
         jgk824qotnoJ2UNAjtHByFsgKgBOWPrgLAw1l4XwsnVZzB5+p403J4BRe44+VQkCzi5l
         cH0w==
X-Gm-Message-State: APjAAAVeDLz+T/xzl6oAGE5L/ploD3ygNBzG3TA35Y7rrjN9WREeAQMx
        jQdmSBq1JxtSG6PS6Eo9iQNqUVUgY8/SciZFnxD4EQ==
X-Google-Smtp-Source: APXvYqydoIKXu3gB6t4ZJpZ6BjNALeXpBGBsWdQ9ycCVnj7lK23s91IiGy8iCWh0qHMq+IHITd+wqHt/tVATfORbQoA=
X-Received: by 2002:a05:6830:1bc3:: with SMTP id v3mr14369770ota.97.1567615906001;
 Wed, 04 Sep 2019 09:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190903161655.107408-1-hridya@google.com> <20190904111934.ya37tlzqjqvt7h6a@wittgenstein>
 <CAEXW_YSj5tdykM8txae66zd0jX_aJujrnS4jG=fHWRvCH7aR7w@mail.gmail.com>
 <20190904144903.GA30432@kroah.com> <20190904151212.wolcug25ozytp4bw@wittgenstein>
In-Reply-To: <20190904151212.wolcug25ozytp4bw@wittgenstein>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Wed, 4 Sep 2019 09:51:09 -0700
Message-ID: <CA+wgaPNGPtxVUTBeNKYTd3R8uJdY8jmD8PA=uR1vvAYG2R_Ebw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Add binder state and statistics to binderfs
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        kernel-team <kernel-team@android.com>,
        Todd Kjos <tkjos@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Martijn Coenen <maco@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 8:12 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Wed, Sep 04, 2019 at 04:49:03PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Sep 04, 2019 at 10:20:32AM -0400, Joel Fernandes wrote:
> > > On September 4, 2019 7:19:35 AM EDT, Christian Brauner
> > > <christian.brauner@ubuntu.com> wrote:
> > > >On Tue, Sep 03, 2019 at 09:16:51AM -0700, Hridya Valsaraju wrote:
> > > >> Currently, the only way to access binder state and
> > > >> statistics is through debugfs. We need a way to
> > > >> access the same even when debugfs is not mounted.
> > > >> These patches add a mount option to make this
> > > >> information available in binderfs without affecting
> > > >> its presence in debugfs. The following debugfs nodes
> > > >> will be made available in a binderfs instance when
> > > >> mounted with the mount option 'stats=global' or 'stats=local'.
> > > >>
> > > >>  /sys/kernel/debug/binder/failed_transaction_log
> > > >>  /sys/kernel/debug/binder/proc
> > > >>  /sys/kernel/debug/binder/state
> > > >>  /sys/kernel/debug/binder/stats
> > > >>  /sys/kernel/debug/binder/transaction_log
> > > >>  /sys/kernel/debug/binder/transactions
> > > >
> > > >Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > >
> > > >Btw, I think your counting is off-by-one. :) We usually count the
> > > >initial send of a series as 0 and the first rework of that series as
> > > >v1.
> > > >I think you counted your initial send as v1 and the first rework as v2.
> > >
> > > Which is fine. I have done it both ways. Is this a rule written somewhere?
> >
> > No where, I can count both ways, it's not a big deal :)
>
> It isn't documented (as many things we still do are) and it's not a big
> deal. But most people seem to be counting revisions starting from 0 it
> seems. I went looking for previous version to link to in the patch cover
> letter and was confused because I was missing a v1. :)
>
> Anyway, I'm happy that Hridya landed this! It was fun helping her the
> last couple of weeks on- and off-list. Thanks for getting this done! I
> hope we'll see even more patches in the future. :)

Thank you so much Christian and Todd for the guidance and thorough
reviews on the many patches I sent your way both on and off-list :) I
really appreciate it!

>
> Christian

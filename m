Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD63C388F3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86ED3217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NWjzuJPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfI0SLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 14:11:54 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37316 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfI0SLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:11:54 -0400
Received: by mail-oi1-f196.google.com with SMTP id i16so5982300oie.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 11:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q8kRfB6Xbx6rONHxkGZUp3ildhXAQqVjOW7WQXlNe9c=;
        b=NWjzuJPo75rsgo5G56HU/2/h2qK1okO3pcWY3vt8StqVx/qozBdXqH634meZ0UGMdn
         nU4q5GfO73QiuCRk9uFpoj5a9t/dvREvcATdEIBeSvUwYdElXR8rdnxrIs7cWlnxAfSr
         6xX63Iq4slc1fSyCIjLRLqYsxovQT+S8VFelJMhcbB2A+QQ4OQgj1Ql+WgCof5ks5K0F
         7BsoWuPC/YoFI5nMFIAp74KR75NwF0piRQd5xeu9LD5QQKFhZwNe79XNK8n07x8iw5Wd
         fQXef2ZlcvYdzNVyxV19HNKy0p6DOqkAra1+uR2Ej/umCMcTegv4vjZTN8Tg6FRwoFVT
         36ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q8kRfB6Xbx6rONHxkGZUp3ildhXAQqVjOW7WQXlNe9c=;
        b=C0vN3c8bGCBQ5X5UdOj/xUtWzXtxmf80X/naEDTDg/ogox2RARxlhA6Ha4Ggx0k1TI
         SmgMc27pKDljwQKgqf/qvxKJFk2He9jCeDqdEtATBG1ixGrnSZOebMXDYlRPmBZFUcIq
         FHPh7HZKF5/yvkSmMF2yr96h0ge+4tJTU7h68j71g15vGskJmbTt1ZJ5uTMRZVBur9OQ
         5fBa9sv63zd7/tYwkNicZi/EeblczHHdMqV2CbF+xTUxZCKVLI4DFpn3wVzyKMa39hPx
         eDdPKYfCJaQBAFoqteg5A/yCqJuA8gFJEGXFQ/ZkxudmnVNYX/BbPujvkYLfaVzeIaCb
         bpCg==
X-Gm-Message-State: APjAAAUuxQXpmUrjtpMXKh3YlDV2YfHIcVWvI256f8rNt/f8pWex/Zn+
        /tfVD9emrMPNDOUKv2+et9aoMR1nhjvQSFZqYk1jvw==
X-Google-Smtp-Source: APXvYqxa/HQwyqFY+PrO8PtAIp9ocTiHRnYqhCvUg365RqzUOv4C4iCm/gM8o7RDuvh7NpN/PqvZT0SKn7GbIOJ0uNM=
X-Received: by 2002:aca:d887:: with SMTP id p129mr8394743oig.92.1569607911837;
 Fri, 27 Sep 2019 11:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190903161655.107408-1-hridya@google.com> <20190927131912.pg7xtyfforiettgx@wittgenstein>
In-Reply-To: <20190927131912.pg7xtyfforiettgx@wittgenstein>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Fri, 27 Sep 2019 11:11:15 -0700
Message-ID: <CA+wgaPOkMmVHYeKAx3bjBF_Yn=XAA8Jf7CbeJygy8xPTS06NdA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Add binder state and statistics to binderfs
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 6:19 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Tue, Sep 03, 2019 at 09:16:51AM -0700, Hridya Valsaraju wrote:
> > Currently, the only way to access binder state and
> > statistics is through debugfs. We need a way to
> > access the same even when debugfs is not mounted.
> > These patches add a mount option to make this
> > information available in binderfs without affecting
> > its presence in debugfs. The following debugfs nodes
> > will be made available in a binderfs instance when
> > mounted with the mount option 'stats=global' or 'stats=local'.
> >
> >  /sys/kernel/debug/binder/failed_transaction_log
> >  /sys/kernel/debug/binder/proc
> >  /sys/kernel/debug/binder/state
> >  /sys/kernel/debug/binder/stats
> >  /sys/kernel/debug/binder/transaction_log
> >  /sys/kernel/debug/binder/transactions
>
> I'm sitting in a talk from Jonathan about kernel documentation and what
> I realized is that we forgot to update the documentation I wrote for
> binderfs in Documentation/admin-guide/binderfs.rst to reflect the new
> stats=global mount option. Would be great if we could add that after rc1
> is out. Would you have time to do that, Hridya?

Thanks for catching that Christian, sorry about the miss! I will send
out a patch ASAP to add the documentation.

Regards,
Hridya

>
> Should just be a new entry under:
>
> Options
> -------
> max
>   binderfs instances can be mounted with a limit on the number of binder
>   devices that can be allocated. The ``max=<count>`` mount option serves as
>   a per-instance limit. If ``max=<count>`` is set then only ``<count>`` number
>   of binder devices can be allocated in this binderfs instance.
> stats
>   <description>
>
> Thanks!
> Christian

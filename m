Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E72C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE8220B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="anbss06Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbfHES3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 14:29:13 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44964 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfHES3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 14:29:12 -0400
Received: by mail-ot1-f67.google.com with SMTP id b7so36066491otl.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 11:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0M3AJraLHTVvDG0WIPnqlH8z6GNkMUc/mJzGFD1Yjx8=;
        b=anbss06ZbLzmz55bz0D6/naX3nWE2xQSBGE9YYJgEEC+c6ev+givrb1pAJElvCg8M0
         FS08Ejk+g3jEp8MPkKm9CynpgHjRLbMO+Tr5S/q3e3ocdUAuV/v54h0WDWsooNlYOxpu
         iPvCLjtb6zXOlyqxlyH/k2At9FQW2upLQEUTqPuDiX5seAB1udBnrwEEI3cuwq88drTR
         1rju25pjaJumOKGKQ5Linq1gXRZd+D2se/IfZ7Vjw1ttvRWyf+7MHUz/NeEfB/WAveFH
         kfWGtN2vvg70+8U9lMwSzORm2wh0eOCIQqwp4KXu2HK4vYeqOWOLFdBS8VzJ9M2q4b1u
         c+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0M3AJraLHTVvDG0WIPnqlH8z6GNkMUc/mJzGFD1Yjx8=;
        b=hXZgfvJTJ+DRnEvUjewabFh77oLUmGYMi+PNJ0weLh/Rtqasr0UzG2Q1RWYQnQR64n
         zFGcms+WVhD09NnCTjLF+ecN7OVpPxDrzyAJD6llYhFO8xDGomC9Pm1piu2hiiK96VXy
         Xoc4Hy45hnQE5hnuVFa+nVAdB3JMoJ4NRR0ckTH7pvbVfX47P3L1EsvXsYIT4zE3MuF8
         FSXoXNT/C3rVahlreFVq/y9whBep2pzGFGn/vBdzShwI3LbCs/l3WrfR8hRF5g6nN9KC
         p45LMwex8yR0IAIQqqEIkxkZpRcQog6gVfjg/FyhVCpiU5EtIb99XMELrI6vGkDtJ67u
         fq9g==
X-Gm-Message-State: APjAAAUwR4t2b58C22tVHRnZzs96pCClN6//Z7Kl1Uzn8D9/imiGnpR5
        +vABl1K7c/NK/fsQx7eAnY87Q5xA4IYW1oHxd7A=
X-Google-Smtp-Source: APXvYqyyDzM/BdKK7/lu8S4iauqE10dCEgom40FH/iNO9Qe61bvCJju+WUYxbL0xFIi68/khSHysUTC4oDgoK7gwqvU=
X-Received: by 2002:a9d:5f02:: with SMTP id f2mr29480658oti.148.1565029751713;
 Mon, 05 Aug 2019 11:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190731050549.GA20809@kroah.com> <20190731212933.23673-1-kaleshsingh@google.com>
 <20190801061941.GB4338@kroah.com> <CAC_TJvdUReRL-Xqq-sSOZ6w1FpEA=Uzys22Mami1USrErnkw+Q@mail.gmail.com>
In-Reply-To: <CAC_TJvdUReRL-Xqq-sSOZ6w1FpEA=Uzys22Mami1USrErnkw+Q@mail.gmail.com>
From:   Tri Vo <trong@android.com>
Date:   Mon, 5 Aug 2019 11:29:00 -0700
Message-ID: <CANA+-vBO-dE6kqgHZ843oMOkkQhXN=3JZLiJby4pR_E2bxd7Zg@mail.gmail.com>
Subject: Re: [PATCH v2] PM/sleep: Expose suspend stats in sysfs
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tri Vo <trong@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 9:34 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> On Wed, Jul 31, 2019 at 11:19 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jul 31, 2019 at 02:29:33PM -0700, Kalesh Singh wrote:
> > > Userspace can get suspend stats from the suspend stats debugfs node.
> > > Since debugfs doesn't have stable ABI, expose suspend stats in
> > > sysfs under /sys/power/suspend_stats.
> > >
> > > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > > ---
> > > Changes in v2:
> > >   - Added separate show functions for last_failed_* stats, as per Greg
> > >   - Updated ABI Documentation
> >
> > This is nice, I didn't even know some of these were in the debugfs
> > entries, so this should be more helpful to people.
> >
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Tri Vo <trong@android.com>

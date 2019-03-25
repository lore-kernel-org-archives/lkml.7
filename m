Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A361BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7684620848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6Y+17u/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfCYU3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:29:44 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33695 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfCYU3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:29:44 -0400
Received: by mail-ot1-f68.google.com with SMTP id j10so2878893otq.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 13:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4HVKSkvqlXj64ngiNJrOwxdwCEG5wGDlvxzc4uJLcso=;
        b=c6Y+17u/wRYHj5+AwhEGqo/Yof5kdHbL6L8GN/0PSi+k4eW7GundYSLiYB9HaqLfej
         aA5Ayx6aE9ocNFvPeiEqobA6snjNdU4UEgw7FzQi3EUVe33WfGTXfIFK+TNgFZY8BQ3M
         xiAUskTOWrITfxCWjVL2jF7T0KzQMQ7T3opCHnewAOu9C5wI381T9hzugBBpbSS38oRU
         ROGPvc//QEdvczyGwV49eracVRp0CaYMLySIAeL6PhcfSBx0wLxHneqrMzsGVtXxzk9S
         y7jG8IU+srQDQDbGqws67cZ/5fBCYStNriKso1XNg+SdAww1or2J+H3qbHdMMUdzmjPG
         KXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4HVKSkvqlXj64ngiNJrOwxdwCEG5wGDlvxzc4uJLcso=;
        b=BMj07rdWML4RJlF6PyOYPaMQv9hFzobH6wCddMyYFmmfSq6tWu8liNio92/JwSr58o
         PAxSMocYCf3KLNxD0qbdEiyS/wMiY8CLKHmJWo52+Lh8JFvJLpmmNo3VVHZlPHcJSgt5
         HomYYhS0o368B1k+LITBuQqEue0RWWiUH9XkkMKc3kDPMjQUejFBzGuXgvL1ivK/zwat
         GXzah2V3avFs+h3YuYPARxYFh4aX93J2P4bXw7ENXEjgwmImp+bl4Ndypios1XqcKsep
         Ox10Mz10ae2aEjEmjyGAz85lwSJDFlMJXlu+tNrf81s3TCAdArHznilpnZS3Nnr/prT8
         tQtA==
X-Gm-Message-State: APjAAAXVlXGe1Oy/5gT1GNUl1Inc8Ae6lo2TUKW6ccyEookxoD0oZWc6
        mDB9fe0FXyc64i3XbAExNNhSWslMC4q3V2Oo9N5DnGYn
X-Google-Smtp-Source: APXvYqxVYMZKmNARD9jdUuyXPYvbOAcIzgRtOoGlroL6iQ2JkOQhF0y7sS9aglb6gRKVmDUvobz6WgkdEcns3dljByk=
X-Received: by 2002:a9d:7656:: with SMTP id o22mr17800629otl.216.1553545783709;
 Mon, 25 Mar 2019 13:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190325113650.56f596f9@gandalf.local.home> <CAHk-=wiyLkyu3b6CLkeBBCq+584Bi_ukaGbVsnMtczJQUWJDVA@mail.gmail.com>
 <20190325192546.GA14506@kroah.com>
In-Reply-To: <20190325192546.GA14506@kroah.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 25 Mar 2019 20:29:07 +0000
Message-ID: <CADVatmNo8QyQbd4yxCucV0QkGiVbeVmjH=quAX9MH++53md6fA@mail.gmail.com>
Subject: Re: [REGRESSION] failed to boot: commit 1aec4211204d parport: daisy:
 use new parport device model
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Kubecek <mkubecek@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Linus,

On Mon, Mar 25, 2019 at 8:12 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Mar 25, 2019 at 11:04:49AM -0700, Linus Torvalds wrote:
> > On Mon, Mar 25, 2019 at 8:36 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > I bisected it down to this commit:
> > >
> > >   aec4211204d ("parport: daisy: use new parport device model")
> >
> > I was confused, because no such commit exists.
> >
> > But it turns out you have the right commit ID in your subject line,
> > and you just dropped the initial '1' .
> >
> > Anyway, that commit does look odd - why is the daisy_drv_init() done
> > by parport_bus_init() rather than just as a regular module init? And
> > as a result, now when daisy_drv_init() blocks, that blocks
> > parport_bus_init(). I dunno. It seems to not really have a good reason
> > for it.
> >
> > I think it should just be reverted unless Sudip can come up with a
> > trivial fix. Greg?
>
> I recommend just reverting it for now.  The parport is "odd" in how it
> has had to be converted over time to the driver model, which is why I
> thought this patch was ok.  Looks like it wasn't, sorry.

It was reported by Michal from Suse and has now been fixed and he has
tested and confirmed it is working.
It is only happening on those systems/distro who has an alias set for
"parport_lowlevel".
Will send out the patch shortly.

-- 
Regards
Sudip

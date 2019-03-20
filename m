Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6DDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBBB218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lZxWmoxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfCTUu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:50:56 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38424 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfCTUu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:50:56 -0400
Received: by mail-vs1-f67.google.com with SMTP id h132so2394575vsd.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kfgLy63hoRDNRDUjULbayuRyfYKtW57uHtlKIJTl//E=;
        b=lZxWmoxA/ClLsFNZAFe06hIbbsd4Pxd88WspBVdP2qO0IUyi1AXG4/e8RiRWkf+m1p
         Y4BpEGsA+jdfp+qzsNUcCPqZlvOUU7CJ0z6raCtCK5zkgdLxBRRG5HTEMyV6DkwzU2VK
         z14gn8Cy/ahYIcGqKHd4ZPSTWq5VZtl9wGU4kHZ678529ltQJ6G7YSwgDJ6ASrZnOel0
         xuLyktFJitNJgHCczNnW4N25LVwhJlzvFcPXbSzYjr51/8zHc0StM4ybTByShE57o+XT
         t3aIG3K6vveO5pIeUzxMu0aP9O9Du6sR2hyj9s8RORVuZrvFTClQS+cBiadlb35WkDIJ
         mKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kfgLy63hoRDNRDUjULbayuRyfYKtW57uHtlKIJTl//E=;
        b=rP9efau5NqrMqFrXXIwviqwVOZpZIM9FEhk5lHYCJxJR0ahcm6qnoktcE+YkBXWyBl
         NDSR4e6/+DjCoUjmT1/fvB1uzj9gwcupyql7lQJolTxlsLaONPEiEhlJocob61q73yhx
         mDWZ7UdFxAN8uxSvGSmOBZw8XQr4x719/cbkQVhgUuvu587BGedxI5buPq9kbGyYd2vK
         zYAI/sfaX7u67a0uDrbwD5GPx20ip2JPqNNCyU5Cpembl14o731ZEnug5EDZd2cwmUS6
         eZ1E8Es5OQdGWzICc7zZEroeLfudh6k1bgLPyX8thLDCee52lIEpNEPZA8d+5O7aM3Kb
         JDrA==
X-Gm-Message-State: APjAAAXFKca7aNN2ik1Rhx5P601iHtL8C+Tf71U/RAaS7dZMQUuWeWgY
        Gm/fmNRHxFEAnFNt05AB+njbhy/mdSlUTaaAZk7gx+CGfGk=
X-Google-Smtp-Source: APXvYqwHr7WmGoudZoMoDn+4cvAZzbKYMouzitTWqGxCAqPKUjmwpfCxDOMMruEERCdxy+6YPO6lOXgjENt+Fj79Rvw=
X-Received: by 2002:a67:fa8c:: with SMTP id f12mr6204401vsq.171.1553115054403;
 Wed, 20 Mar 2019 13:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190320200702.GA27111@avx2> <CAKOZuespjOTbaTDbgQLo=7PXTE-nYCLy7k=s+RJh_GpZ_5gwgg@mail.gmail.com>
 <20190320203910.GA2842@avx2> <20190320204736.x4p5m7gxz6rbxlo3@brauner.io>
In-Reply-To: <20190320204736.x4p5m7gxz6rbxlo3@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 20 Mar 2019 13:50:43 -0700
Message-ID: <CAKOZueudv0fnOUPFyXHakgrqjiNz3zF+xckN1xGk93wTY7sjuw@mail.gmail.com>
Subject: Re: pidfd design
To:     Christian Brauner <christian@brauner.io>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 1:47 PM Christian Brauner <christian@brauner.io> wrote:
>
> On Wed, Mar 20, 2019 at 11:39:10PM +0300, Alexey Dobriyan wrote:
> > On Wed, Mar 20, 2019 at 01:14:01PM -0700, Daniel Colascione wrote:
> > > On Wed, Mar 20, 2019 at 1:07 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > > > > What would be your opinion to having a
> > > > > /proc/<pid>/handle
> > > > > file instead of having a dirfd.
> > > >
> > > > This is even worse than depending on PROC_FS. Just for the dependency
> > > > pidfd code should be backed out immediately. Forget about /proc.
> > >
> > > We already have pidfds, and we've had them since /proc was added ages
> > > ago.
> >
> > New pidfd code (or whatever the name) should NOT depend on /proc and
> > should not interact with VFS at all at any point (other than probably
> > being a descriptor on a fake filesystem). The reason is that /proc is
> > full of crap and you don't want to spill that into new and hopefully
> > properly designed part of new code.
>
> Yes, I agree. That's why I was thinking that translate_pid() is a good
> candidate to provide that decoupling.

Then again: how do you propose fetching process metadata? If you adopt
a stance that nothing can use procfs and simultaneously adopt a stance
that we don't want to duplicate all the decades of metadata interfaces
in /proc/pid (which are useful, not "crap"), then the overall result
is that we just won't make any progress at all. There's nothing wrong
with taking a dependency on procfs: procfs is how we talk about
processes. It's completely unreasonable to say "no, you can't use the
old thing" and also "no, we can't add a new thing that would duplicate
the old thing".

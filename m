Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51D2C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938A821873
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="WcqJPV36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfE2NO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:14:57 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34210 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfE2NO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:14:56 -0400
Received: by mail-lf1-f67.google.com with SMTP id v18so2048640lfi.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 06:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zo8/tL88lhYZ8ZmjXhe5I0ivQ63AMHIIXfJiG0SngrI=;
        b=WcqJPV36GoYCJyCKWssunS/8jjCOcm7506dwRBLhvYgsNR0UdI2bR6S+PaChd3NF+e
         P+/GUrP8I1gxdIuXwHh6CxrPM6FsQK897PtueXW2sc688u6UEVtahdPaDHpbLdURczG/
         exuh5TP/Fn7NuWWJubwb5BOU06YIqB0/o8baMnCRHH/ihY5uaT1si7LXcC8p9MWXL18d
         oOzuzN3xy5AjXeHWyQmqeSM1pM2ZeR9RQEvA5xn86EDD7CpzITSwgBRLK8NSiZHIhZG2
         4dGKz3NjhIgq/QlLySTSs2ZLnXWGPjQaDD2AF5PW0kac6rHkp3GF9xtJmzZ2Gi7XnFzZ
         e6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zo8/tL88lhYZ8ZmjXhe5I0ivQ63AMHIIXfJiG0SngrI=;
        b=Ls6ULa/ri8kfVTHTQeu35CEzIVd34hD852uw4wTejDWI+bep3+hE+/afynH23jRTJ4
         CfYtQWYcGSSdXHGwsq67ri/An2vIgAhPKeUEQEruyRRqqLUK4aUVVYZt1pT+dmxdoqkj
         dgWQtU0WXnnKrZQ9REPxeoUpLdLyYBbTZZWW+fM3HiWud4t5PEbpmblpv8o1O/2llNBG
         Uh+JNmu2qzKkCNoJw+9k7iN7cWXZAtf8eysap5LXEsvsYFhxRybDnS8RE9BriGooTaDE
         CJbfgdCjrwX6pJAdqJmhU+Ehz8QxnJHvQRfbcx0QbXSPxPLH3h5NkSxnnIHq2XAEhXQG
         VyXw==
X-Gm-Message-State: APjAAAWCxAgsBnDB1tIWdtBqGUCu2Xdhg3+Nowwg9jauW0Skq21sLaiE
        wThnMUZsuaxhUDs1h7Q6lQFAkNEw6Y7BRwFIsBZN
X-Google-Smtp-Source: APXvYqw1iYjVpziXjswrmlU2rI862bFdoZ/LKvGEmuAIzGxOxKMlkrc2fuaVbN9QOa1jFVN2h6hTKGffJR8WNirL26o=
X-Received: by 2002:ac2:4358:: with SMTP id o24mr5608001lfl.13.1559135695377;
 Wed, 29 May 2019 06:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554732921.git.rgb@redhat.com> <509ea6b0-1ac8-b809-98c2-37c34dd98ca3@redhat.com>
 <CAHC9VhRW9f6GbhvvfifbOzd9p=PgdB2gq1E7tACcaqvfb85Y8A@mail.gmail.com>
 <3299293.RYyUlNkVNy@x2> <20190529004352.vvicec7nnk6pvkwt@madcap2.tricolour.ca>
In-Reply-To: <20190529004352.vvicec7nnk6pvkwt@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 29 May 2019 09:14:44 -0400
Message-ID: <CAHC9VhScO5yfnM2tn=_6OKtuU5P_LukPfmnE06E0hVE-2e++uw@mail.gmail.com>
Subject: Re: [PATCH ghak90 V6 00/10] audit: implement container identifier
To:     Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>
Cc:     Dan Walsh <dwalsh@redhat.com>, Neil Horman <nhorman@tuxdriver.com>,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        omosnace@redhat.com, dhowells@redhat.com, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        Mrunal Patel <mpatel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 8:44 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2019-05-28 19:00, Steve Grubb wrote:
> > On Tuesday, May 28, 2019 6:26:47 PM EDT Paul Moore wrote:
> > > On Tue, May 28, 2019 at 5:54 PM Daniel Walsh <dwalsh@redhat.com> wrote:

...

> > > > Mrunal Patel (maintainer of CRI-O) and I have reviewed the API, and
> > > > believe this is something we can work on in the container runtimes team
> > > > to implement the container auditing code in CRI-O and Podman.
> > >
> > > Thanks Dan.  If I pulled this into a branch and built you some test
> > > kernels to play with, any idea how long it might take to get a proof
> > > of concept working on the cri-o side?
> >
> > We'd need to merge user space patches and let them use that instead of the
> > raw interface. I'm not going to merge user space until we are pretty sure the
> > patch is going into the kernel.
>
> I have an f29 test rpm of the userspace bits if that helps for testing:
>         http://people.redhat.com/~rbriggs/ghak90/git-1db7e21/
>
> Here's what it contains (minus the last patch):
>         https://github.com/linux-audit/audit-userspace/compare/master...rgbriggs:ghau40-containerid-filter.v7.0

Yes, exactly.  Just as I plan to start making some test kernels for
people to play with (assuming v6 looks okay), I think it would be good
if Steve could make a test build of the latest audit userspace with
the audit container ID patches.  It really shouldn't be that hard, and
the benefits should far outweigh any time spent generating the
tree/builds.

-- 
paul moore
www.paul-moore.com

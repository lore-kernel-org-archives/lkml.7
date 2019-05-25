Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3426BC282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 10:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF682133D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 10:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="V+31VLVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfEYKH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 06:07:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36991 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfEYKHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 06:07:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id h19so2344891ljj.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 03:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bfhrFcakAvRPFa4ilNfgzQaeIke1aVQ4rQMw2nVHnyQ=;
        b=V+31VLVFf0iRYRwGsw5tWZHAhTFLsXaICfdGZfiZo+NyQjSI9NaoGEt1cHGfAYlRGD
         n9Qw7h7fW41Kh4bOHZcjd0TJRtCteIx3wgfQytobyyAmdaAQGu5pZwCvAcinQRpol0Vb
         Se5JGOkQkhbgVqsYnDGhDQFpuwsb2tSwPJ2sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bfhrFcakAvRPFa4ilNfgzQaeIke1aVQ4rQMw2nVHnyQ=;
        b=YIVunI5W0Nj7KRg4Gsh7X4ch/DXzIiXOfkYsXaDm94x20et08Yms3qhOHbZaV/502x
         L5dN2lfANKrTibpcp/lGzLEOlHbo7jY4MO+SME84AcZWMMAnuAy/A0pvkcX2e8sONLEc
         VR2M62C3mqXt4TSmenNbUxvcYZEn3Z0loptLkX2+J3L3iKDrby6igEOyFBo+gBkMX19Q
         8DjYFhd+/0gL/gaIOmh89BNE4fUVcx/3aTHcCQDlG9H9ZpvZXtXrJz448tqubG1p+D+g
         e2WnZDReFSLm8ypKX/o9AUaSot5B4kgRgSD6E4uj6lepXGvRnGVGKNCs8aiQLFvaZu7Y
         sENA==
X-Gm-Message-State: APjAAAWdEju0Aw2owOkgosiJjpDGqKO/6dfR+SiWi1+RbkY0hJsm54Bn
        4XQ3Fn2OISO6sl+z36nm+3mS7irvLPfIS6WmlcxKkglhKbqoHw==
X-Google-Smtp-Source: APXvYqywdt40Ja53oXe/SSQu2SKEQwGvPcmn3GlG7VOzrC7N6WqqKTni+2mVHgNtnDt4a3+auHks65LyrVBmoXXXevs=
X-Received: by 2002:a2e:9bc5:: with SMTP id w5mr17423153ljj.87.1558778843232;
 Sat, 25 May 2019 03:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190505020328.165839-1-joel@joelfernandes.org>
 <20190507000453.GB3923@linux.ibm.com> <20190508162635.GD187505@google.com> <20190508181638.GY3923@linux.ibm.com>
In-Reply-To: <20190508181638.GY3923@linux.ibm.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 25 May 2019 13:07:12 +0300
Message-ID: <CAEXW_YR69RRNZfkfFyvprs5+VKBGu29h0_-gnQmuNhN54+ReHQ@mail.gmail.com>
Subject: Re: [PATCH] doc/rcu: Correct field_count field naming in examples
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 9:16 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
[snip]
> > > And this example code predates v2.6.12.  ;-)
> > >
> > > So good eyes, but I believe that this really does reflect the ancient
> > > code...
> > >
> > > On the other hand, would you have ideas for more modern replacement
> > > examples?
> >
> > There are 3 cases I can see in listRCU.txt:
> >   (1) action taken outside of read_lock (can tolerate stale data), no in-place update.
> >                 this is the best possible usage of RCU.
> >   (2) action taken outside of read_lock, in-place updates
> >                 this is good as long as not too many in-place updates.
> >                 involves copying creating new list node and replacing the
> >                 node being updated with it.
> >   (3) cannot tolerate stale data: here a deleted or obsolete flag can be used
> >                                   protected by a per-entry lock. reader
> >                                 aborts if object is stale.
> >
> > Any replacement example must make satisfy (3) too?
>
> It would be OK to have a separate example for (3).  It would of course
> be nicer to have one example for all three, but not all -that- important.
>
> > The only example for (3) that I know of is sysvipc sempahores which you also
> > mentioned in the paper. Looking through this code, it hasn't changed
> > conceptually and it could be a fit for an example (ipc_valid_object() checks
> > for whether the object is stale).
>
> That is indeed the classic canonical example.  ;-)

FWIW just want to mention, it seems to me the ptrace task list
traversal could be a great example of "mark obsolete objects" and is
simple so I could just use that.
Neil talks about it in his article here:
https://lwn.net/Articles/610972/ . In "Group 3: Transform the way the
list is walked"

Cheers,
- Joel

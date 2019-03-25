Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF38C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697B72087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="nWZGzzrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfCYQdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:33:52 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34274 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCYQdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:33:51 -0400
Received: by mail-lf1-f67.google.com with SMTP id y18so6566529lfe.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 09:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=deBhC4WtykdeZjvbpe4XikrP/yxal5UWT11yre07fd8=;
        b=nWZGzzrsQt8f5e/nstnHJta3X24/JQZPx5ZsTwWrjpvtWlP2z23ZLk5HEnLLO+YHzA
         ndcvKGyHMwC41KeSlYYVg1ZL3dSHj9TWI+pqVfjjJLORfhzf6TqiUBzpaLTa9Dy2O6/4
         pxhGU49EGVUDj8GGqHCpyGhDE2gnP7fOVpeuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=deBhC4WtykdeZjvbpe4XikrP/yxal5UWT11yre07fd8=;
        b=E6YEWitUklEUlgSaAvw+3am4FnFrfuIw4fVHMSypSek6wHICA2lHTdmz6xSyvWbmUO
         YLv2qJl/ef8t/aoSY+1Bb0O1sKu7o99kX9CfpOM/kqvB2PmN6JNG6VGLwk2J2P+MxlxV
         kbNEavpkUP/xXJKhIfEkJrYOF0S7VjkyOh8cwBWs2pBtElPlvNzxbWV+0URccRSfqQ1n
         9SEL49a+k3A/lReDbvboohMbIZDGDpasfWR48gmQpro3xv0AbAqfOHWV8ThSUq1BGisV
         CNII3KtGT4IDCfF6FiqNuWwpwP8I9Nqyy6qn6DK77DBDx2x1+fyKTUWobY0okMA1hmDA
         /23g==
X-Gm-Message-State: APjAAAU8nJvkxIH7SnYyKehAt6os3ZEgw36Pz5M3CAuBtWQS44WkjpyN
        4GdF0HtX654YPKbyUJbYa5R1KxY2eFV/lvr002/Jlg==
X-Google-Smtp-Source: APXvYqzm2tcXB2HnO5KULcCIrt7Y8+TyBnvu1eym1PcbtPgwWeZcLsS4Yyq6+SCsbWs1CgnAgeljJDX0RVu+agaMQlU=
X-Received: by 2002:ac2:44c3:: with SMTP id d3mr12686495lfm.14.1553531629616;
 Mon, 25 Mar 2019 09:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190323034619.15792-1-joel@joelfernandes.org> <20190325150133.GA4102@linux.ibm.com>
In-Reply-To: <20190325150133.GA4102@linux.ibm.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 25 Mar 2019 12:33:37 -0400
Message-ID: <CAEXW_YRDfOEr-hdbKGDC6amRaaqTCCBsowRhVwDqJd-1BoO17g@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Select from only online CPUs
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 11:02 AM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
>
> On Fri, Mar 22, 2019 at 11:46:19PM -0400, Joel Fernandes (Google) wrote:
> > The rcutorture jitter.sh script selects a random CPU but does not check
> > if it is offline or online. This leads to taskset errors many times. On
> > my machine, hyper threading is disabled so half the cores are offline
> > causing taskset errors a lot of times. Let us fix this by checking from
> > only the online CPUs on the system.
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> Good catch!
>
> Please see below for one suggestion for simplification.
>
>                                                         Thanx, Paul
>
> > ---
> >  tools/testing/selftests/rcutorture/bin/jitter.sh | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/rcutorture/bin/jitter.sh b/tools/testing/selftests/rcutorture/bin/jitter.sh
> > index 3633828375e3..53bf9d99b5cd 100755
> > --- a/tools/testing/selftests/rcutorture/bin/jitter.sh
> > +++ b/tools/testing/selftests/rcutorture/bin/jitter.sh
> > @@ -47,10 +47,19 @@ do
> >               exit 0;
> >       fi
> >
> > -     # Set affinity to randomly selected CPU
> > +     # Set affinity to randomly selected online CPU
> >       cpus=`ls /sys/devices/system/cpu/*/online |
>
>         cpus=`grep 1 /sys/devices/system/cpu/*/online |
>

Yes, this is better. Lets do it this way :)

> >               sed -e 's,/[^/]*$,,' -e 's/^[^0-9]*//' |
> >               grep -v '^0*$'`
>
> Of course, now I have no idea why I excluded CPU 0...  :-/

Yes, I was wondering as well about that :-)

thanks,

 - Joel

Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A101BC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76EDD20643
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wz+DWmer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgAHONB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:13:01 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:32861 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgAHONB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:13:01 -0500
Received: by mail-pg1-f173.google.com with SMTP id 6so1666178pgk.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 06:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JOI5BG860h0vH7yTQCyBsKUAeChUvKx+rCYmS5SLzkw=;
        b=Wz+DWmer/jGrH1ORaA/pti5FLZBhYiqAK4WhKgaqvtUdUv2uLo//D1fV3Oyi2aL1a5
         2XBX+pUT01YDPfDSzhR5a27RYecvnf5OW7f8hFXXDvMEJd3vv62gi/0UCsANnd6vMWD/
         aWkhvhafdi/SOJjyEPFjebG39px2lwEtmwP55tRyPASRjOSb2N1MYfwfk97XHBJiaCle
         cX30ziwPyHf/50MR7leB0pDfYbyF8DkRL1zYIsqiplPcwl+STftfjXblGvuewwW1djXu
         oEVbkghL0c+Il5f+4O1XUK57kEKl5w6L7HXxfBfe/Si9nYJ+XAJpXYNDzZRv96iQK9as
         SSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOI5BG860h0vH7yTQCyBsKUAeChUvKx+rCYmS5SLzkw=;
        b=r6o/h8mfALYBTgRblItEou83VIdZ6O+8cTIcBrsregrL5FLeOGZMG19hHSQId6BEA1
         Y+qxEPgfa7vQiiZUqwWxz+jDvI2rMsli+56zEZmbI++KOzE3pfPid9U+bzwju3MqYCAc
         4UULZdK1mW3RfnHVHgbYXHyhub/HdTyCUGiMCoFgTYPgouYbCAH9Rt+3rGQPHG9hoDpf
         kxXoBSINVFeJ6hJRo8Qtis4TOHMf6Z97caqTsCd34uP7wytP+x+JmFCwHASxf3AJGZmv
         PZqlRmEAq5CtlHOxQv8+OLp9D/MO8NQqT95nFNRWV/+ijdKfvyBKHnWWP98iP/w3HDM/
         i9fQ==
X-Gm-Message-State: APjAAAVumb5GaeaZJ7vMYSNU/TbXVL81JXkmoneuZbgqLxnUsqGX576y
        p40gb4CeoRYZq6RDfdTjtig/rnj/QhtjnzLS7bswMQ==
X-Google-Smtp-Source: APXvYqxXYnISGYqhh65OlFyk1T5mmTwmrC7gpU1waoraE1dS7SopJkNW+C8vOA5O2JPuqb/lVeKX/DfbN3Cf5AUXb6A=
X-Received: by 2002:aa7:961b:: with SMTP id q27mr5233188pfg.23.1578492779096;
 Wed, 08 Jan 2020 06:12:59 -0800 (PST)
MIME-Version: 1.0
References: <CAFd5g47-wi0duBAVxvevDKT7eb7WGT9JMFoKgCJQQSa0P0h9Jw@mail.gmail.com>
 <20200107134910.20347-1-sjpark@amazon.com>
In-Reply-To: <20200107134910.20347-1-sjpark@amazon.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 8 Jan 2020 06:12:47 -0800
Message-ID: <CAFd5g45Bo=7QXw8tX6MvFHwU6sCdX8UrjMk5erbByjPvujBw1g@mail.gmail.com>
Subject: Re: Re: Re: What is the best way to compare an unsigned and a constant?
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sj38.park@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 7, 2020 at 5:49 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> On   Tue, 7 Jan 2020 05:35:21 -0800   Brendan Higgins <brendanhiggins@google.com> wrote:
>
> > Sorry for the delay, I was on vacation. (I still am, but I was too ;-).)
>
> Happy new year, Brendan :)

Happy New Year!

> >
> > On Tue, Jan 7, 2020 at 3:52 AM SeongJae Park <sjpark@amazon.com> wrote:
> > >
> > > On   Fri, 27 Dec 2019 13:52:27 +0100   Bernd Petrovitsch <bernd@petrovits=
> > ch.priv.at> wrote:

[...]

> Oh, right...  Removing the non-sense casting fixed the problem.  Thanks,
> Brendan!

No worries, I do that kind of stuff all the time :-)

Does that fix everything? It looks like there was an encoding issue
with your last email, so I wasn't sure if I got everything.

Cheers!

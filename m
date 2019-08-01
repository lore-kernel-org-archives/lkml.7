Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C98C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8AC2087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E9jIpetc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbfHAPoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:44:11 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34159 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfHAPoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:44:10 -0400
Received: by mail-io1-f67.google.com with SMTP id k8so145400818iot.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 08:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vspdYAgVGKceUPiVFKieEOMlC+LiG/ZtP0gwv4WyoMc=;
        b=E9jIpetc+G2V/zMXTRPehFZLbbQhmqsVpa1m2rKjZmgTJcxY8hrvSHpbVkT+N919ho
         zcp2WVewQn5V4gKXix7773WimA5+0lnX79+qRPETNJLA+5kqQ/3Jg8V1A9PKlVkG0A/r
         0PScnyrnPXzP+2jeTUnOeQi13mW3qBNs0zGRZYeltDT9Sx/LEa7nF7tbUPsRN5qxuw7y
         dpLC6pntECKeit7+csgOrS7Ihn1FdpwniAHgkjKxG8aAq+/PXbTkdT4GqsQBeIPQy7cd
         oV2EiGVGfMVX+rlU3Ua6piBs1OowN2ymxKX1xPpDA+OyzYvvsX2pwHLW5P5zFOKA9JY3
         uM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vspdYAgVGKceUPiVFKieEOMlC+LiG/ZtP0gwv4WyoMc=;
        b=E7lgsdIsbgTy3meO19iC9AJxvg0M0cUZXd3rsGOmyGc3IpnnvTu4i1wPKKMBj5g83r
         R3V0BQG4P+Uu2wXfSbysqpu1e5wmzBtvsqy/Cg2MUDbcZsugzijNhsU47zaIORt0WNxl
         PdhlWLxuWYVXjfUDvQeWEgq46tTEsm5fs2F7OMJlIB6H2YSGfLErnDQRnyfoSbuphvZj
         d70vtSz9RM6O6cbIBM9gKsQZVJx9ERLx3lnUyQXy39rjGQ57VkroquxPCH5vDMoH6Egn
         hXPFDg+OmSgqL2Xyu6HG/6qN5UiJ5MzFhjxRsGkjHBylSgvD7uB0UqggxXEqU4Kdzw/T
         tByQ==
X-Gm-Message-State: APjAAAWvGd6hbwAuNN+YtJT0XoDww2NNcsf+c3rW9ngJbzFyAll+wvp3
        UBqABPsAeE1mSOsz5DEEzK1vTWSF5Gqj5Vd40Xfj9Q==
X-Google-Smtp-Source: APXvYqyMI/46xUheno1G6g0K5O4v4bXDf/LowKYdBMoiZCLfzMEORfKBIz0fUZDA3SC130TyUqTArsZeQ4J1sg/1m50=
X-Received: by 2002:a5d:885a:: with SMTP id t26mr9879366ios.218.1564674249377;
 Thu, 01 Aug 2019 08:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190801111348.530242235@infradead.org> <20190801111541.917256884@infradead.org>
 <640721f8-8a20-b161-473f-98a9dbc053cc@collabora.com> <20190801121718.GE31381@hirez.programming.kicks-ass.net>
 <20190801123503.GC5488@sirena.org.uk>
In-Reply-To: <20190801123503.GC5488@sirena.org.uk>
From:   Doug Anderson <dianders@google.com>
Date:   Thu, 1 Aug 2019 08:44:01 -0700
Message-ID: <CAD=FV=UsYF1R6+XRfFFFm6PfmkTsEOfxxgCw2JxCnpyu1kGVLQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] spi: Reduce kthread priority
To:     Mark Brown <broonie@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 1, 2019 at 5:35 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Aug 01, 2019 at 02:17:18PM +0200, Peter Zijlstra wrote:
>
> > I'm thinking that isn't true 99% of the time, except of course when that
> > bandsaw emergency break is attached through SPI, but in that case the
> > admin can very well chrt the prio of this thread.
>
> The SPI thread isn't usually RT, it's only made RT if something in the
> system asks for it - the reason the ChromeOS people got CCed in is that
> some of their embedded controllers are very fragile and need super tight
> timing on some of the interactions over their control interface so
> they're one of the users here.  Of course everyone is then going to
> claim that their usage is the most critical usage in the system, and
> they may well even be right, but I do tend to agree that just any old RT
> priority is probably a sensible default since for most cases there will
> be few if any other RT tasks anyway.

For the Chrome OS case I believe that "MAX_RT_PRIO / 2" should be just
fine.  In fact in an earlier version of my work to make CrOS EC work
better at <https://crrev.com/c/1603464> I had said "We'll arbitrarily
pick a priority of "MAX_RT_PRIO / 4 - 1", AKA 24.  This seems to work
fine in practice."  I only switched to "MAX_RT_PRIO - 1" to match the
SPI code.

Mostly we just need to be a bit higher than things that request the
highest non-realtime priority, notably DM Crypt and loopback which
both schedule a bunch of work on the high priority system workqueue.
Those two things in particular seem to want high priority for
performance reasons but not for correctness reasons.  As mentioned
earlier our EC will actually fail transfers if there is too much
delay.

Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

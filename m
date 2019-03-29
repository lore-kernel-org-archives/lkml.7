Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52418C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29863217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbfC2SYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:24:10 -0400
Received: from [195.159.176.226] ([195.159.176.226]:33316 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1729956AbfC2SYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:24:10 -0400
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <glk-linux-kernel-4@m.gmane.org>)
        id 1h9wAg-000KNW-Vw
        for linux-kernel@vger.kernel.org; Fri, 29 Mar 2019 19:24:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: [PATCH v2] tty/serial: Add a serial port simulator
Date:   Fri, 29 Mar 2019 18:24:01 -0000 (UTC)
Message-ID: <q7lns1$183b$1@blaine.gmane.org>
References: <20190305171231.22133-1-minyard@acm.org>
 <eea0ad95-8344-371a-1dd0-58c8366a355b@infradead.org>
 <20190306015149.GD4290@minyard.net>
 <041e137e-0b9d-04f9-255d-b1f402b23c17@infradead.org>
 <447407be-0f49-f29d-6e81-bf4ed0a6e56b@zytor.com>
 <20190329165140.GD31733@minyard.net>
User-Agent: slrn/1.0.3 (Linux)
Cc:     linux-serial@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-29, Corey Minyard <minyard@acm.org> wrote:
> On Thu, Mar 28, 2019 at 12:39:12PM -0700, H. Peter Anvin wrote:
>
>> Dumb question: this is basically a pty on steroids. Wouldn't this be
>> better done by enhancing the pty devices?

I proposed doing that several years ago, and offered to start working
on it if there was a decent chance it would be accepted into the tree.
I got no response.

> I did look at that, but it would be pretty invasive to pty.  There's
> no modem control stuff, none of the other special serial ioctls.
> And the locking in this driver is fairly strange because you have
> two serial ports looking at each other's data for modem control.
> But that might not be a big deal.
>
> Adding the speed simulation to ptys would also be really strange.
> That's not a deal-breaker, I suppose, but it's not much of a serial
> port simulation without it.

My goal wasn't really to simulate two serial ports with a null-mode
cable in-between, so the speed simluaiton wasn't on my list. my goal
was to provide a way to implement a serial port in userspace by
attaching an application to the master end of a pty.

The pty(7) man page states "The slave end of the pseudoterminal
provides an interface that behaves exactly like a classical terminal."
But, we all know that's a pretty big lie: the pty slave end implements
only a small subset of a "classical termial" device, and there are all
sorts of applications that expect to talk to a serial port which fail
miserably when connected to a pty.

-- 
Grant Edwards               grant.b.edwards        Yow! I had a lease on an
                                  at               OEDIPUS COMPLEX back in
                              gmail.com            '81 ...


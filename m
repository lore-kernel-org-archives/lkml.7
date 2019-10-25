Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA31CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553B820684
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409497AbfJYPD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 11:03:56 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:5040 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408186AbfJYPDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 11:03:55 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x9PF3jbx023942;
        Fri, 25 Oct 2019 17:03:45 +0200
Date:   Fri, 25 Oct 2019 17:03:45 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     dev@dpdk.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Please stop using iopl() in DPDK
Message-ID: <20191025150345.GE23687@1wt.eu>
References: <CALCETrVepdYd4uN8jrG8i6iaixWp+N3MdGv5WhjOdCr9sLRK1w@mail.gmail.com>
 <20191025064225.GA22917@1wt.eu>
 <CALCETrXtKBtMx3gf2BysCeYEzDFN_wjiKCGh_onCdA=7TbBxZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXtKBtMx3gf2BysCeYEzDFN_wjiKCGh_onCdA=7TbBxZw@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 07:45:47AM -0700, Andy Lutomirski wrote:
> But, for uses like DPDK, /sys/.../resource0 seems like a *far* better
> API, since it actually uses the kernel's concept of which io range
> corresponds to which device instead of hoping that the mappings don't
> change out from under user code.  And it has the added benefit that
> it's restricted to a single device.

For certain such uses with real device management, very likely yes.
It's just that in a number of programs using hard-coded ports to
access stupid devices with no driver (and often even no name), such
an approach could be overkill, and these are typically the annoyingly
itchy ones which could require your config entry to remain enabled.
I'll add to my todo list to have a look at this as time permits.

Cheers,
Willy

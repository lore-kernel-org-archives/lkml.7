Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC18FC10F0B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A29520896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c+HClWwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfDANmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:42:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40060 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfDANmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 09:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1RyMTAX+gC7PF4PD7LHKFEus+7Q2n3U8gWXQSaAnLi4=; b=c+HClWwjns4dJVWQWEZ/nXBG3L
        8YEXG8BkRNS8OQCaj/XFKNqaGeRRiLAX+4XcKQaRsBAY0r4+EmWVDXT4ObUmQjsr9sSCbkXlkmMfg
        zurwU+7DpX01FMDZ0sg/gjYhLMICuhjmiSBpsf9JfPGEWvr4dK1Mftp6z6J5a5lKSSvhGCGfkoIxQ
        aBudUyOjJq3+7u9T7UU0L2gxeCfYdbCA56yYJ8rYyXrCMxCcF/qGNYNnsHTgdEE9fGij63pLYRz9i
        If3WHjWPQtgRIkf43EaUNFDIh8CJZWswmacnoL3avf88dnSYI2qfblYTdcCTC35whmbLReWvha+HG
        gubw8lsA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hAxCl-0001wp-Nz; Mon, 01 Apr 2019 13:42:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF85B2026BE96; Mon,  1 Apr 2019 15:42:24 +0200 (CEST)
Date:   Mon, 1 Apr 2019 15:42:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] i2c: remove use of in_atomic()
Message-ID: <20190401134224.GD12232@hirez.programming.kicks-ass.net>
References: <20190327211256.17232-1-wsa+renesas@sang-engineering.com>
 <20190401104756.GK11158@hirez.programming.kicks-ass.net>
 <20190401111323.ajvo4drongc6dtel@ninjato>
 <20190401112109.GB12232@hirez.programming.kicks-ass.net>
 <20190401115414.hxrqqjujvwczdafz@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190401115414.hxrqqjujvwczdafz@ninjato>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 01:54:14PM +0200, Wolfram Sang wrote:
>=20
> > > "This matches the use cases for atomic I2C transfers I have seen so f=
ar:
> > > very late communication (mostly to a PMIC) to powerdown or reboot the
> > > system."
> >=20
> > Ah, sorry, I missed that.
> >=20
> > > And yes, I would never recommend a HW design to use I2C for shutting
> > > down/rebooting. But such HW is out there.
> >=20
> > Can we then make the whole thing conditional on:
> >=20
> >   system_state > SYSTEM_RUNNING
> >=20
> > Such that we're sure to never trigger this under any other conditions?
>=20
> Oh, we can for sure modify the code to something else. Actually, this is
> why I was calling out to you. I was never comfortable with the old
> 'in_atomic() || irqs_disabled()' code, but wasn't sure what would be an
> adequate replacement which will not risk regressions.
>=20
> The above condition makes much more sense to me and is also much more
> readable. Can it simply replace irqs_disabled()? Are interrupts already
> disabled for system_state > SYSTEM_RUNNING? (I got a bit lost in the
> code paths when trying to figure it out)

Looking at kernel_restart_prepare(), we set SYSTEM_REBOOT in normal
context, specifically it just did a blocking notifier call.

So no, you'll have to combine the two.

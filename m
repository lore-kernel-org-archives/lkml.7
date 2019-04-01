Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFDBC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CBF20883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cgKRpTOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfDALVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:21:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38314 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDALVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TE5+pbbAeJqO5hjf4yzeACJWILQ10JbMvdyXQE+fLes=; b=cgKRpTOSCHUaEbVa+VJSXmVYDf
        uOdNCJ/DazRalDEpH3/557dEc2IYrltGLOq3U2UmepvvBz+/a9Ov8FmxLh8tog840EhAWf+XSQD65
        ADqowMVzmH+667G+RzyOOYKifl4Ia9QW3hxBHBXSgYRZi13vdKQ86g+uXGLSGc0lVx9uOmqwzJR2E
        VBdkjNweKj+nhYoWpr7aUTFDbv7eoyu/uphI9/RSnxw1yDVejz3RtF5aYzW2wf885s5qTU1nMUati
        P314PV+e4E7b+1eQnlv4KpYk2C4BszHh/FmZL+h5TOxzIosm/wLY3wpbqfe20ZggohQBFeBcul1FJ
        o2hB0CUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hAv03-00005F-1i; Mon, 01 Apr 2019 11:21:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8446320298592; Mon,  1 Apr 2019 13:21:09 +0200 (CEST)
Date:   Mon, 1 Apr 2019 13:21:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] i2c: remove use of in_atomic()
Message-ID: <20190401112109.GB12232@hirez.programming.kicks-ass.net>
References: <20190327211256.17232-1-wsa+renesas@sang-engineering.com>
 <20190401104756.GK11158@hirez.programming.kicks-ass.net>
 <20190401111323.ajvo4drongc6dtel@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190401111323.ajvo4drongc6dtel@ninjato>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 01:13:24PM +0200, Wolfram Sang wrote:

> > Why must we allow i2c usage with IRQs disabled? Just say NO?
>=20
> I'd love to. But quoting my patch description:
>=20
> "This matches the use cases for atomic I2C transfers I have seen so far:
> very late communication (mostly to a PMIC) to powerdown or reboot the
> system."

Ah, sorry, I missed that.

> And yes, I would never recommend a HW design to use I2C for shutting
> down/rebooting. But such HW is out there.

Can we then make the whole thing conditional on:

  system_state > SYSTEM_RUNNING

Such that we're sure to never trigger this under any other conditions?

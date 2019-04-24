Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E4EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6F1218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WBAubogc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732575AbfDXQec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:34:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36410 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbfDXQeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lGoXnAtmE3EO0MnC+xYpo17v/B9z+0QHXX+aUz4EiK8=; b=WBAubogcs7WRqUGGuCKAMEwNT
        T1ZYMrboK377H8DkOJFPpy7JIPp2SUQqRSpbP7Hh1PQdP7sWJmqnXVpSrchZvU/mURANmjDU9rumf
        v9OyHMGgth5pZIQFnYChO5HYYHG0+bOju4ZSGLCqjdrCt9KrTkIHPdXpHqvTGj+wlwPWsFIWlWelF
        +Lj1uh00G0kBl9mXFfs/J+/IqcWMPUEPOOB4auLNlcTEqOJfJtKWlNfjZ49IiX2GG2CAO4ZhCb3Pi
        Fm2qAuwy+RUUZS68xGtZPfTSbSMBBJNVnUS8G/UoEAONIzqbIubfoB2TYoT6Atznrf+8MJnwQYssD
        1vIWkF9rw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJKqo-0004sY-0S; Wed, 24 Apr 2019 16:34:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 80025203C0A58; Wed, 24 Apr 2019 18:34:24 +0200 (CEST)
Date:   Wed, 24 Apr 2019 18:34:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        javi.merino@kernel.org, edubezval@gmail.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        nicolas.dechesne@linaro.org, bjorn.andersson@linaro.org,
        dietmar.eggemann@arm.com, Quentin Perret <quentin.perret@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 0/3] Introduce Thermal Pressure
Message-ID: <20190424163424.GG4038@hirez.programming.kicks-ass.net>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <20190417053626.GA47282@gmail.com>
 <5CB75FD9.3070207@linaro.org>
 <20190417182932.GB5140@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417182932.GB5140@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 08:29:32PM +0200, Ingo Molnar wrote:
> Assuming PeterZ & Rafael & Quentin doesn't hate the whole thermal load 
> tracking approach. 

I seem to remember competing proposals, and have forgotten everything
about them; the cover letter also didn't have references to them or
mention them in any way.

As to the averaging and period, I personally prefer a PELT signal with
the windows lined up, if that really is too short a window, then a PELT
like signal with a natural multiple of the PELT period would make sense,
such that the windows still line up nicely.

Mixing different averaging methods and non-aligned windows just makes me
uncomfortable.


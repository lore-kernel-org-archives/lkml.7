Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EC0C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5F821872
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566854352;
	bh=HQwE/fwASOyzPHZ5mxSByd4agEzeg7VBnKqm+VUdbfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WCrba4yZJ7O9ypxHI6XK/9cTY70IxERcgTRSoH/KDJSY71CO68Sy70eiUpxce5hM/
	 x18wimKCXhIS6k/hSnhEAndgUgyTtx5hin6Q0Soi0J5+dUY2+MOAYK2vyXXha6H5lx
	 zoZTADX6e2PH7fceTRLGeVCL0YoJWVS5Ypl9FiI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfHZVTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 17:19:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfHZVTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 17:19:11 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D595520850;
        Mon, 26 Aug 2019 21:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566854350;
        bh=HQwE/fwASOyzPHZ5mxSByd4agEzeg7VBnKqm+VUdbfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BUej6MV3sObqsrc4u/mh8qaJiK50izv7MC6rwwGnA+7RX6598tQ2q3dyg8yWCxupv
         B8Ux7dwiVRIC4hYZ7OqLos9H8iIili4YdVFs9piK+UxH0hf4lT1FiQNoLSPq9IOQR7
         C61z5NfVV7T1cSUDD7Y86FP0T9axAwaoMfn/aJzY=
Date:   Mon, 26 Aug 2019 23:19:08 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 30/38] posix-cpu-timers: Respect INFINITY for hard
 RTTIME limit
Message-ID: <20190826211907.GE14309@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192922.078293002@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192922.078293002@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:17PM +0200, Thomas Gleixner wrote:
> The RTIME limit expiry code does not check the hard RTTIME limit for
> INFINITY, i.e. being disabled.  Add it.
> 
> While this could be considered an ABI breakage if something would depend on
> this behaviour. Though it's highly unlikely to have an effect because
> RLIM_INFINITY is at minimum INT_MAX and the RTTIME limit is in seconds, so
> the timer would fire after ~68 years.
> 
> Adding this obvious correct limit check also allows further consolidation
> of that code and is a prerequisite for cleaning up the 0 based checks and
> the rlimit setter code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

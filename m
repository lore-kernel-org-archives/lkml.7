Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9D0C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42183233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566476013;
	bh=YLOaLuRCDHh2QH4FiU60m7B77VChjAMGE1TWEPelH+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jgu2vmQWerpjkoV3EVghmY66nJmDH46APmgI/R5Dz2JYSxwN7VF6bHpf8VlcGERHe
	 A3Pfbf2AkGsqzvrmOMeAj+d2/IRwJu9vH4jNaycwSRNnjAe/FuOzDocLbuhAZQi9eo
	 kZ2PzWgEWiFfPql02rtyN6fFK6UiFx+W8Vnvm84c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388370AbfHVMNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 08:13:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbfHVMNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 08:13:32 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8F5921848;
        Thu, 22 Aug 2019 12:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566476011;
        bh=YLOaLuRCDHh2QH4FiU60m7B77VChjAMGE1TWEPelH+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CtAvV5dCxRms/zgsQ7N0RVbywsMoNfzdhce40kMJVXwhcKkGbcC1l179DEg7RDLfM
         ACIEe8sUNF1jKnXrVvnWViGCKWAOgRIkEAkMws4/HYkp6XucJM+cIR7JIgOORv7Hdm
         w4cWqzNUXS7Ah1GaAOwNaLtSmiJC81pSzVuTcof4=
Date:   Thu, 22 Aug 2019 14:13:28 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 04/38] posix-cpu-timers: Provide quick sample function
 for itimer
Message-ID: <20190822121327.GH22020@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192919.599658199@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192919.599658199@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:08:51PM +0200, Thomas Gleixner wrote:
> get_itimer() needs a sample of the current thread group cputime. It invokes
> thread_group_cputimer() - which is a misnomer. That function also starts
> eventually the group cputime accouting which is bogus because the
> accounting is already active when a timer is armed.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

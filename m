Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD93C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44FC423401
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566476114;
	bh=nWMIrDNyU2LMloeql2olRWEHmGhe0boEpBGVLz+m5es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TzPGPGPXDjyIk105xJT9Yt3wgiRdXYTY1EYlm9xLQZOLarul56XCbPE9nJWs7gJ6/
	 LoDpF3WeZynIcjeQoUaeFR5YASI+wKmdHf7onY/lXl3bdtZRoDQ+elEdZjeyrJpGDy
	 ECYIoVTmcT3lsAP1/7nIcH8LdEK9kK4tHcKivarM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733281AbfHVMPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 08:15:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729716AbfHVMPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 08:15:13 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A05620870;
        Thu, 22 Aug 2019 12:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566476112;
        bh=nWMIrDNyU2LMloeql2olRWEHmGhe0boEpBGVLz+m5es=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4Oq1FVCDQdYdNdDEj7qyT64wZ7QHFhIF+jafZNq1HKQZ1WPjuPiKoWmO+6QfbOEo
         Tw+ddxZW0zv/+O1BKEKkCW1/5E4UKSPWUHC6uuC2NTlu+wD6RpxZz8cNU6/Xf0B+HT
         RNSpVzlDieZtEqSr7zGPbvFI80O9J3k0iO1Ubnzc=
Date:   Thu, 22 Aug 2019 14:15:09 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 05/38] itimers: Use quick sample function
Message-ID: <20190822121509.GI22020@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192919.689713638@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192919.689713638@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:08:52PM +0200, Thomas Gleixner wrote:
> get_itimer() locks sighand lock and checks whether the timer is already
> expired. If it is not expired then the thread group cputime accounting is
> already enabled. Use the sampling function not the one which is meant for
> starting a timer.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

I've always hated the abuse of thread_group_cputimer().

Thanks!

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

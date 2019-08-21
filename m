Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4820C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77EBD2339F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566387268;
	bh=FHolW9JEn85DopRaIwCBKcKHhM6wnOQNgpFFhGawjYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aDtUFr/mGSAtsVwXYZgQb8ck5NwULq3HDFTwi46sYTsb3yVobhvTcDUbW1vNK77+f
	 EYRmtPZfWvoGwl+DDH9wLyYRiMVpxRb7l7vj3qBp6ovuecyOd/li2vYWWwu37HVCn4
	 XJS//poEeqsn4ZDiJ24NxIWUdtp4ZdNMeI1tKs3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfHULe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 07:34:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfHULe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 07:34:26 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7058C22CE3;
        Wed, 21 Aug 2019 11:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566387265;
        bh=FHolW9JEn85DopRaIwCBKcKHhM6wnOQNgpFFhGawjYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hlEMeIiZmc9E0Zj6U7TGVv3pqktX18NLHXkfQS71El1DykmlpjdYMgIgzRbT18DTo
         7wqqn+cSaa5QPmA2cuht3uLwocNKn99Rrwp+d9iQ0LAdVD9tK941WLXl6yxBrNYDtS
         q+l8JZ3JwiimiZetmxj0MR3UK2dGJHz59VrVDqjA=
Date:   Wed, 21 Aug 2019 13:34:23 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 05/44] posix-cpu-timers: Sanitize bogus WARNONS
Message-ID: <20190821113422.GB16213@lenoir>
References: <20190819143141.221906747@linutronix.de>
 <20190819143801.846497772@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819143801.846497772@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 04:31:46PM +0200, Thomas Gleixner wrote:
> Warning when p == NULL and then proceeding and dereferencing p does not
> make any sense as the kernel will crash with a NULL pointer dereference
> right away.
> 
> Bailing out when p == NULL and returning an error code does not cure the
> underlying problem which caused p to be NULL. Though it might allow to
> do proper debugging.
> 
> Same applies to the clock id check in set_process_cpu_timer().
> 
> Clean them up and make them return without trying to do further damage.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97301C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AA020659
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfJGQPA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:15:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44924 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbfJGQPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:15:00 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iHVez-0000E5-Do; Mon, 07 Oct 2019 18:14:57 +0200
Date:   Mon, 7 Oct 2019 18:14:57 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        tglx@linutronix.de, aryabinin@virtuozzo.com, rostedt@goodmis.org,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [RFC PATCH] lib/ubsan: Don't seralize UBSAN report
Message-ID: <20191007161457.zgenqi6fts3khmkg@linutronix.de>
References: <20190920100835.14999-1-julien.grall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190920100835.14999-1-julien.grall@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-20 11:08:35 [+0100], Julien Grall wrote:
> At the moment, UBSAN report will be serialized using a spin_lock(). On
> RT-systems, spinlocks are turned to rt_spin_lock and may sleep. This will
> result to the following splat if the undefined behavior is in a context
> that can sleep:
…
> So the lock usefulness seems pretty limited. Rather than trying to
> accomodate RT-system by switching to a raw_spin_lock(), the lock is now
> completely dropped.
> 
> Reported-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Julien Grall <julien.grall@arm.com>

I just applied this to my RT tree. Is someone here feeling responsible
to apply this upstream?

Sebastian

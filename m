Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0641C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCDB20693
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfD1S3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 14:29:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39409 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726940AbfD1S3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 14:29:49 -0400
Received: from callcc.thunk.org (75-104-85-194.mobility.exede.net [75.104.85.194] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x3SITUR1025319
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Apr 2019 14:29:37 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D0EFB420023; Sun, 28 Apr 2019 14:29:28 -0400 (EDT)
Date:   Sun, 28 Apr 2019 14:29:28 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH REPOST] random: Add a spinlock_t to struct batched_entropy
Message-ID: <20190428182928.GD24089@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
References: <20190426103438.g5i5cexlatlgpije@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426103438.g5i5cexlatlgpije@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 12:34:38PM +0200, Sebastian Andrzej Siewior wrote:
> The per-CPU variable batched_entropy_uXX is protected by get_cpu_var().
> This is just a preempt_disable() which protects against concurrent
> access from process context on the local CPU. It does not protect
> against users on the same CPU from another context. It is possible that
> a preemptible context reads slot 0 and then an interrupt occurs and the
> same value is read again from hard or soft IRQ context.

This patch is already on the random.git tree.  (It wasn't in
linux-next because I had forgotten that linux-next pulls from the dev
branch, as opposed to the master branch.)

Cheers,

					- Ted

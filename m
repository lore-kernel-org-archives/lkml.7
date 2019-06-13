Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBD2C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773FF20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732711AbfFMPCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:02:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732511AbfFMO0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:26:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 15A5730C34C5;
        Thu, 13 Jun 2019 14:25:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-109.rdu2.redhat.com [10.10.120.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 37E83541F0;
        Thu, 13 Jun 2019 14:25:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <20190613134317.734881240@infradead.org>
References: <20190613134317.734881240@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     dhowells@redhat.com, stern@rowland.harvard.edu, akiyks@gmail.com,
        andrea.parri@amarulasolutions.com, boqun.feng@gmail.com,
        dlustig@nvidia.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        npiggin@gmail.com, paulmck@linux.ibm.com, will.deacon@arm.com,
        paul.burton@mips.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v2 0/4] atomic: Fixes to smp_mb__{before,after}_atomic() and mips.
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1641.1560435920.1@warthog.procyon.org.uk>
From:   David Howells <dhowells@redhat.com>
Date:   Thu, 13 Jun 2019 15:25:52 +0100
Message-ID: <1674.1560435952@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 13 Jun 2019 14:26:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> wrote:

> Basically we fail for:
> 
> 	*x = 1;
> 	atomic_inc(u);
> 	smp_mb__after_atomic();
> 	r0 = *y;
> 
> Because, while the atomic_inc() implies memory order, it
> (surprisingly) does not provide a compiler barrier. This then allows
> the compiler to re-order like so:

To quote memory-barriers.txt:

 (*) smp_mb__before_atomic();
 (*) smp_mb__after_atomic();

     These are for use with atomic (such as add, subtract, increment and
     decrement) functions that don't return a value, especially when used for
     reference counting.  These functions do not imply memory barriers.

so it's entirely to be expected?

David

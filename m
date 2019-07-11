Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E9BC74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 14:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7368721019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 14:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfGKOaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 10:30:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729086AbfGKOaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:30:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B942C3001822;
        Thu, 11 Jul 2019 14:30:15 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AAB85D756;
        Thu, 11 Jul 2019 14:30:15 +0000 (UTC)
Date:   Thu, 11 Jul 2019 09:30:13 -0500
From:   David Teigland <teigland@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] dlm updates for 5.3
Message-ID: <20190711143013.GA29395@redhat.com>
References: <20190709165725.GA2190@redhat.com>
 <CAHk-=wj00gDz=tX-b5C-xwdogZSaKtRJEDh3SGB69D8W+Wsr2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj00gDz=tX-b5C-xwdogZSaKtRJEDh3SGB69D8W+Wsr2Q@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 11 Jul 2019 14:30:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 09:05:21PM -0700, Linus Torvalds wrote:
> If wait_event_interruptible() returns -ERESTARTSYS, it means that we
> have a signal pending.
> 
> And if we have a signal pending, then you can't go back and call
> wait_event_interruptible() in a loop, because the signal will
> *continue* to be pending, so now your "wait event" becomes a kernel
> busy loop.
> 
> If you don't want to react to signals, then you shouldn't use the
> "interruptible()" version of wait-event.

Right, a simple wait_event looks obvious; I'll have the submitters test
that before sending that next time around.  I'll put together another pull
with the two trivial commits.
Thanks
Dave

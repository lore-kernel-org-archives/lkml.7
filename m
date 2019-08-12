Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9D0C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CD720684
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfHLQ5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 12:57:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfHLQ5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:57:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 522CF308FBB4;
        Mon, 12 Aug 2019 16:57:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6B0DE5C28C;
        Mon, 12 Aug 2019 16:57:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 12 Aug 2019 18:57:36 +0200 (CEST)
Date:   Mon, 12 Aug 2019 18:57:34 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v5 1/2] fork: extend clone3() to support CLONE_SET_TID
Message-ID: <20190812165733.GD31560@redhat.com>
References: <20190811203327.5385-1-areber@redhat.com>
 <20190812163710.GC31560@redhat.com>
 <20190812165130.d3b5smm45dpxk6m4@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812165130.d3b5smm45dpxk6m4@wittgenstein>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 12 Aug 2019 16:57:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12, Christian Brauner wrote:
> On Mon, Aug 12, 2019 at 06:37:10PM +0200, Oleg Nesterov wrote:
> > On 08/11, Adrian Reber wrote:
> > >
> > >  include/linux/pid.h        |  2 +-
> > >  include/linux/sched/task.h |  1 +
> > >  include/uapi/linux/sched.h |  1 +
> > >  kernel/fork.c              | 22 ++++++++++++++++++++--
> > >  kernel/pid.c               | 36 +++++++++++++++++++++++++++++-------
> > >  5 files changed, 52 insertions(+), 10 deletions(-)
> > 
> > Looks good to me...
> > 
> > A couple of nits below, but I won't insist, feel free to ignore.
> > 
> > > +/*
> > > + * Different sizes of struct clone_args
> > > + */
> > > +#define CLONE3_ARGS_SIZE_V0 64
> > 
> > I don't really understand why do we want the "size < CLONE3_ARGS_SIZE_V0"
> > check in copy_clone_args_from_user(), but I won't argue.
> 
> To make sure a user can't give us a garbage sized struct that is smaller
> than the initial version of the struct.

But why do we want to detect this case?

And why CLONE3_ARGS_SIZE_V0 is special?

Oleg.


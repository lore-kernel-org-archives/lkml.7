Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D71C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721BB2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfC1Q0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:26:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfC1Q0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:26:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C89EA7F6B3;
        Thu, 28 Mar 2019 16:26:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.68])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3201B608A4;
        Thu, 28 Mar 2019 16:26:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 28 Mar 2019 17:26:45 +0100 (CET)
Date:   Thu, 28 Mar 2019 17:26:42 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>
Subject: Re: [PATCH] Convert struct pid count to refcount_t
Message-ID: <20190328162641.GC19441@redhat.com>
References: <20190327145331.215360-1-joel@joelfernandes.org>
 <CAGXu5j+nhsL_s36R0k5APUfP6cNiH-BGEJu6mV6UcsP0i3gtyA@mail.gmail.com>
 <CAG48ez1vZ5cngEKVtWTL9rz_K8K25b1sMKYrNs+jn4Va3KYucw@mail.gmail.com>
 <20190328023432.GA93275@google.com>
 <CAG48ez2bbSYpNHcC4oucx_AG=5y4K5pZfSOfN3mxGadJGpHuQQ@mail.gmail.com>
 <20190328143738.GA261521@google.com>
 <CAG48ez1-3dLvzQoxxoUzTUq8dc1wwvwPBBxX_X9FWMscWTS-FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1-3dLvzQoxxoUzTUq8dc1wwvwPBBxX_X9FWMscWTS-FQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 28 Mar 2019 16:26:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/28, Jann Horn wrote:
>
> Since we're just talking about RCU stuff now, adding Paul McKenney to
> the thread.

Since you added Paul let me add more confusion to this thread ;)

There were some concerns about the lack of barriers in put_pid(), but I can't
find that old discussion and I forgot the result of that discussion...

Paul, could you confirm that this code

	CPU_0		CPU_1

	X = 1;		if (READ_ONCE(Y))
	mb();			X = 2;
	Y = 1;		BUG_ON(X != 2);


is correct? I think it is, control dependency pairs with mb(), right?

If not, then put_pid() needs atomic_read_acquire() as it was proposed in that
discussion.

Oleg.


Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCC1C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6DF2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbfD2QGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 12:06:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728394AbfD2QGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 12:06:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2BA1D3092666;
        Mon, 29 Apr 2019 16:06:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0637C64449;
        Mon, 29 Apr 2019 16:06:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 29 Apr 2019 18:06:06 +0200 (CEST)
Date:   Mon, 29 Apr 2019 18:06:04 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] rcu/sync: simplify the state machine
Message-ID: <20190429160603.GC17715@redhat.com>
References: <20190425164054.GA21309@redhat.com>
 <20190425165055.GC21412@redhat.com>
 <20190427210230.GE3923@linux.ibm.com>
 <20190428222652.GA30908@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428222652.GA30908@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 29 Apr 2019 16:06:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/28, Paul E. McKenney wrote:
>
> And it still looks good after review, so I have pushed it.

Thanks!

> I did add
> READ_ONCE() and WRITE_ONCE() to unprotected uses of ->gp_state, but
> please let me know if I messed anything up.

Well, at least WRITE_ONCE()'s look certainly unneeded to me, gp_state
is protected by rss_lock.

WARN_ON_ONCE(gp_state) can read gp_state lockless, but even in this case
I do not understand what READ_ONCE() tries to prevent...

Nevermind, this won't hurt and as I already said I don't understand the
_ONCE() magic anyway ;)

Thanks,

Oleg.


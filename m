Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21F2C004E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64F6208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfF0URj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 16:17:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbfF0URj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 16:17:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E579F308A9E2;
        Thu, 27 Jun 2019 20:17:31 +0000 (UTC)
Received: from ovpn-116-138.phx2.redhat.com (ovpn-116-138.phx2.redhat.com [10.3.116.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 675255D71B;
        Thu, 27 Jun 2019 20:17:28 +0000 (UTC)
Message-ID: <13761fee4b71cc004ad0d6709875ce917ff28fce.camel@redhat.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
From:   Scott Wood <swood@redhat.com>
To:     paulmck@linux.ibm.com, Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 27 Jun 2019 15:17:27 -0500
In-Reply-To: <20190627184107.GA26519@linux.ibm.com>
References: <20190626135447.y24mvfuid5fifwjc@linutronix.de>
         <20190626162558.GY26519@linux.ibm.com> <20190627142436.GD215968@google.com>
         <20190627103455.01014276@gandalf.local.home>
         <20190627153031.GA249127@google.com> <20190627155506.GU26519@linux.ibm.com>
         <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
         <20190627173831.GW26519@linux.ibm.com> <20190627181638.GA209455@google.com>
         <20190627184107.GA26519@linux.ibm.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 27 Jun 2019 20:17:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-27 at 11:41 -0700, Paul E. McKenney wrote:
> On Thu, Jun 27, 2019 at 02:16:38PM -0400, Joel Fernandes wrote:
> > 
> > I think the fix should be to prevent the wake-up not based on whether we
> > are
> > in hard/soft-interrupt mode but that we are doing the rcu_read_unlock()
> > from
> > a scheduler path (if we can detect that)
> 
> Or just don't do the wakeup at all, if it comes to that.  I don't know
> of any way to determine whether rcu_read_unlock() is being called from
> the scheduler, but it has been some time since I asked Peter Zijlstra
> about that.
> 
> Of course, unconditionally refusing to do the wakeup might not be happy
> thing for NO_HZ_FULL kernels that don't implement IRQ work.

Couldn't smp_send_reschedule() be used instead?

-Scott



Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1980C5B57A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACC92183F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfF1Skf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 14:40:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37792 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfF1Skf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:40:35 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hgvnO-0004b1-Ei; Fri, 28 Jun 2019 20:40:26 +0200
Date:   Fri, 28 Jun 2019 20:40:26 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190628184026.fds6scgi2pnjnc5p@linutronix.de>
References: <20190627142436.GD215968@google.com>
 <20190627103455.01014276@gandalf.local.home>
 <20190627153031.GA249127@google.com>
 <20190627155506.GU26519@linux.ibm.com>
 <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
 <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <20190628135433.GE3402@hirez.programming.kicks-ass.net>
 <20190628153050.GU26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190628153050.GU26519@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-28 08:30:50 [-0700], Paul E. McKenney wrote:
> On Fri, Jun 28, 2019 at 03:54:33PM +0200, Peter Zijlstra wrote:
> > On Thu, Jun 27, 2019 at 11:41:07AM -0700, Paul E. McKenney wrote:
> > > Or just don't do the wakeup at all, if it comes to that.  I don't know
> > > of any way to determine whether rcu_read_unlock() is being called from
> > > the scheduler, but it has been some time since I asked Peter Zijlstra
> > > about that.
> > 
> > There (still) is no 'in-scheduler' state.
> 
> Well, my TREE03 + threadirqs rcutorture test ran for ten hours last
> night with no problems, so we just might be OK.
> 
> The apparent fix is below, though my approach would be to do backports
> for the full set of related changes.
> 
> Joel, Sebastian, how goes any testing from your end?  Any reason
> to believe that this does not represent a fix?  (Me, I am still
> concerned about doing raise_softirq() from within a threaded
> interrupt, but am not seeing failures.)

For some reason it does not trigger as good as it did yesterday.
Commit
- 23634ebc1d946 ("rcu: Check for wakeup-safe conditions in
   rcu_read_unlock_special()") does not trigger the bug within 94
   attempts.

- 48d07c04b4cc1 ("rcu: Enable elimination of Tree-RCU softirq
  processing") needed 12 attempts to trigger the bug.

> 							Thanx, Paul
> 

Sebastian

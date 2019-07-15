Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5698C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 16:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DFA2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 16:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfGOQMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 12:12:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48273 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729533AbfGOQMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 12:12:00 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hn3Zw-0000Hc-8z; Mon, 15 Jul 2019 18:11:52 +0200
Message-Id: <20190715150402.798499167@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 15 Jul 2019 17:04:02 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <clark.williams@gmail.com>,
        Julia Cartwright <julia@ni.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [patch 0/1] Kconfig: Introduce CONFIG_PREEMPT_RT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please consider to apply the following patch, which introduces the Kconfig
symbol CONFIG_PREEMPT_RT.

Rationale:

The real-time preemption patch set exists for almost 15 years now and while
the vast majority of infrastructure and enhancements have found their way
into the mainline kernel, the final integration of RT is still missing.

Over the course of the last few years, we have worked on reducing the
intrusivenness of the RT patches by refactoring kernel infrastructure to be
more real-time friendly. Almost all of these changes were benefitial to
the mainline kernel on their own, so there was no objection to integrate
them.

Though except for the still ongoing printk refactoring, the remaining
changes which are required to make RT a first class mainline citizen are
not longer arguable as immediately beneficial for the mainline kernel. Most
of them are either reordering code flows or adding RT specific functionality.
But this now has hit a wall and turned into a classic hen and egg problem:

  Maintainers are rightfully wary vs. these changes as they make only
  sense if the final integration of RT into the mainline kernel takes
  place.

Adding CONFIG_PREEMPT_RT aims to solve this as a clear sign that RT will be
fully integrated into the mainline kernel. The final integration of the
missing bits and pieces will be of course done with the same careful
approach as we have used in the past.

While I'm aware that you are not entirely enthusiastic about that, I think
that RT should receive the same treatment as any other widely used out of
tree functionality, which we have accepted into mainline over the years.

RT has become the de-facto standard real-time enhancement and is shipped by
enterprise, embedded and community distros. It's in use throughout a wide
range of industries: telecommunications, industrial automation, professional
audio, medical devices, data acquisition, automotive - just to name a
few major use cases.

RT development is backed by a Linuxfoundation project which is supported
by major stakeholders of this technology. The funding will continue over
the actual inclusion into mainline to make sure that the functionality is
neither introducing regressions, regressing itself, nor becomes subject
to bitrot. There is also a lifely user community around RT as well, so
contrary to the grim situation 5 years ago, it's a healthy project.

As RT is still a good vehicle to exercise rarely used code paths and to
detect hard to trigger issues, you could at least view it as a QA tool if
nothing else.

The current state of the RT patches against 5.2 is:

   365 files changed, 9396 insertions(+), 3209 deletions(-)

When the already queued changes, agreed on changes and the ongoing printk
work is taken out then the diffstat is reduced to:

   311 files changed, 6567 insertions(+), 1352 deletions(-)

Out of the 6567 insertions about 4000 lines are the self contained RT
infrastructure (lock substitutions, scheduler addons, etc.).

The remaining bits and pieces are smallish changes to places which need to
be slightly modified to cope with the RT semantics.

The current full RT set can be found here:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-5.2.y-rt

Note that aside of the printk changes (which are under flux due to the
ongoing review/design discussions) also a large part of the rest is
not the final state as these changes still need to be discussed with
the relevant maintainers and we are still working hard on refinining
them and reducing the impact. So while the big picture is probably
good reflected, please take the details with a grain of salt.

Thanks,

	Thomas




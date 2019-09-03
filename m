Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A26EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDF321883
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hFuIJDxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfICUxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:53:50 -0400
Received: from mail.efficios.com ([167.114.142.138]:52226 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfICUxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:53:50 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 705392B54EC;
        Tue,  3 Sep 2019 16:53:48 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id UNw4IKsBvEGJ; Tue,  3 Sep 2019 16:53:48 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 09ECF2B54E9;
        Tue,  3 Sep 2019 16:53:48 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 09ECF2B54E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1567544028;
        bh=4JOFSuvTUpZyI8QSAZlNtcJD5uggnjOQCn/8cuyTHyw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=hFuIJDxtZq790oIYxDtAJEXp2wA/OESKK/sd134H7AidHwHWFOzHqLUc1t92jwNft
         RN4vm+i/WsAobEfkZOJbW1LNg6DlyQ2ESit3K8ttfzjI5wjDAB6WNSpmfIuTm9hkzM
         4+g28ebgMErqbTZ++rX41LCkXZsw9WXBXjOz+Upd9XhUpk4vYuQZdCLvRAEWoUGkF1
         x28lRwm2+Jkx51F5vidQL/Vsfwdl6BBB7dIzzXYOQ/AdavNkjRQrq0FAobRXH4Rdl9
         65lsuOEfyr7zcGlH9xHSqBjaJQYPPlFl+89qRPZ8vwiYgTsJ4QGszhMEQJ12E1NyaM
         42coa3jHmpXnw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id FZZQi5XRjDnb; Tue,  3 Sep 2019 16:53:47 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id D29A32B54DC;
        Tue,  3 Sep 2019 16:53:47 -0400 (EDT)
Date:   Tue, 3 Sep 2019 16:53:47 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     paulmck <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Message-ID: <951669027.771.1567544027663.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAHk-=wg61zhuzhnrh_t=cAhgm+adNfsnS0A_cD=TOQAriHNDew@mail.gmail.com>
References: <20190903201135.1494-1-mathieu.desnoyers@efficios.com> <CAHk-=wg61zhuzhnrh_t=cAhgm+adNfsnS0A_cD=TOQAriHNDew@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] Fix: sched/membarrier: p->mm->membarrier_state
 racy load
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3829)
Thread-Topic: sched/membarrier: p->mm->membarrier_state racy load
Thread-Index: dBaN0rgpnv8puEsrhUG3WiqSgj/0iw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 3, 2019, at 4:27 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Tue, Sep 3, 2019 at 1:11 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> +       cpus_read_lock();
>> +       for_each_online_cpu(cpu) {
> 
> This would likely be better off using mm_cpumask(mm) instead of all
> online CPU's.

I've considered using mm_cpumask(mm) in the original implementation of
the membarrier expedited private command, and chose to stick to online
cpu mask instead.

Here was my off-list justification to Peter Zijlstra and Paul E. McKenney:

  If we have an iteration on mm_cpumask in the membarrier code,
  then we additionally need to document that memory barriers are
  required before and/or after all updates to the mm_cpumask, otherwise
  I think we end up in the same situation as with the rq->curr update.
  [...]
  So we'd be sprinkling even more memory barrier comments all over.

Considering the amount of comments that needed to be added around the
scheduler rq->curr update for membarrier, I'm concerned that the amount
of additional analysis, documentation, and design constraints required
to safely use mm_cpumask() from membarrier is not really worth it
compared to iterating on online cpus with cpu hotplug read lock held.

> 
> Plus doing the rcu_read_lock() inside the loop seems pointless. Even
> with a lot of cores, it's not going to loop _that_ many times for RCU
> latency to be an issue.

Good point! I'll keep that in mind for next round if we don't chose an
entirely different way forward.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

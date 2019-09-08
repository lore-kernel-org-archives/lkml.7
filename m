Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CD7C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC04207FC
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="VnkAPl5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbfIHNqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 09:46:06 -0400
Received: from mail.efficios.com ([167.114.142.138]:35956 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfIHNqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 09:46:06 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id F2997BB6E6;
        Sun,  8 Sep 2019 09:46:04 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id SDwi9Cc2bS1S; Sun,  8 Sep 2019 09:46:04 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 91283BB6D7;
        Sun,  8 Sep 2019 09:46:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 91283BB6D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1567950364;
        bh=RtYW8mNlt4nyumfk2QzAyZTi27oLj8xDc9s9E18+RQc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=VnkAPl5VLTdBfJxPX5n0N29js1k0OuylSmcf5ZTg5wC3Z16IrvE1dl7ocTrczZxG1
         9H8dScuRSKmZmVqCNKFldubRgnuGJuHDyDxt4EUflT5wK/pe2RXC0z7Pvb2d5aTbZD
         RgMXnmjt8DXLqfCZtbcaEkybnKEBYy6wqfWVlb2Nd8VQ0r70z4K3EHPLJjobKwJuTG
         jp9tytdZEJeqCG4QvOxzFYyNJytaxfEkDjyZVHCcnRJK7m18S5r0UJl4X+95D4cCfb
         lTmKb5jk17DhvMMA/92ql+jmTG6o0oPIY8Uy/+dZGgNz0bAiK1/ebBGgkSMc7RQZJY
         X5pjsKoQw8nyg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 8R2v8rLpzIBE; Sun,  8 Sep 2019 09:46:04 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 73183BB6CC;
        Sun,  8 Sep 2019 09:46:04 -0400 (EDT)
Date:   Sun, 8 Sep 2019 09:46:04 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     paulmck <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Message-ID: <509773035.243.1567950364367.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190904111126.GB24568@redhat.com>
References: <20190903201135.1494-1-mathieu.desnoyers@efficios.com> <20190904111126.GB24568@redhat.com>
Subject: Re: [RFC PATCH 1/2] Fix: sched/membarrier: p->mm->membarrier_state
 racy load
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3829)
Thread-Topic: sched/membarrier: p->mm->membarrier_state racy load
Thread-Index: hl0su7l7NtggmKLLVhxEGtpIeL4A9A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 4, 2019, at 12:11 PM, Oleg Nesterov oleg@redhat.com wrote:

> with or without these changes...
> 
> Why do membarrier_register_*_expedited() check get_nr_threads() == 1?
> This makes no sense to me, atomic_read(mm_users) == 1 should be enough.
> 
> 
> And I am not sure I understand membarrier_mm_sync_core_before_usermode().
> OK, membarrier_private_expedited() can race with user -> kernel -> user
> transition, but we do not care unless both user's above have the same mm?
> Shouldn't membarrier_mm_sync_core_before_usermode() do
> 
>	if (current->mm != mm)
>		return;
> 
> at the start to make it more clear and avoid sync_core_before_usermode()
> if possible?

I think I missed replying to your email. Indeed, you are right, I've added
2 cleanup patches taking care of this in my latest round.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

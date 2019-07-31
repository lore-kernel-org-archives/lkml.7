Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DD2C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B35206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfGaIp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 04:45:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:34062 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbfGaIp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:45:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3337EAE2C;
        Wed, 31 Jul 2019 08:45:58 +0000 (UTC)
Subject: Re: [patch 11/12] hrtimer: Prepare support for PREEMPT_RT
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, x86@kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190726183048.982726647@linutronix.de>
 <20190726185753.737767218@linutronix.de>
 <42299f02-ff29-f7e3-45f0-b9fef041aec9@suse.com>
 <20190729110806.57c57399@gandalf.local.home>
 <9a9bde89-e0b3-a7b9-749e-a6b35d74b729@redhat.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <0910bd2b-b5b1-aa41-7f5e-b44f51a516d3@suse.com>
Date:   Wed, 31 Jul 2019 10:45:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9a9bde89-e0b3-a7b9-749e-a6b35d74b729@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.07.19 19:30, Paolo Bonzini wrote:
> On 29/07/19 17:08, Steven Rostedt wrote:
>> On Sun, 28 Jul 2019 11:06:50 +0200
>> Juergen Gross <jgross@suse.com> wrote:
>>
>>> In case we'd want to change that I'd rather not special case timers, but
>>> apply a more general solution to the quite large amount of similar
>>> cases: I assume the majority of cpu_relax() uses are affected, so adding
>>> a paravirt op cpu_relax() might be appropriate.
>>>
>>> That could be put under CONFIG_PARAVIRT_SPINLOCK. If called in a guest
>>> it could ask the hypervisor to give up the physical cpu voluntarily
>>> (in Xen this would be a "yield" hypercall).
>>
>> Seems paravirt wants our cpu_chill() ;-)
> 
> Actually that is not really a joke! :)

As CONFIG_PARAVIRT is no longer so massive intrusive as some time ago
it might really be worth thinking of.

 From Xen perspective I'd really like a way to give up the vcpu instead
of doing a busy wait. And having another user and (even better) already
some patches addressing some (or all?) callsites sounds like a win-win
situation for me.

So +1 from me for cpu_chill() via a new paravirt op.


Juergen

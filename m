Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252D7C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0AB20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439937AbfFLO7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:59:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:51758 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437985AbfFLO7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:59:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C42B2AEEE;
        Wed, 12 Jun 2019 14:59:14 +0000 (UTC)
Subject: Re: [PATCH] x86/xen: disable nosmt in Xen guests
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20190612101228.23898-1-jgross@suse.com>
 <20190612114836.GI3436@hirez.programming.kicks-ass.net>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <74c04cc4-4b05-2bca-d788-ea3605853fcc@suse.com>
Date:   Wed, 12 Jun 2019 16:59:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190612114836.GI3436@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.06.19 13:48, Peter Zijlstra wrote:
> On Wed, Jun 12, 2019 at 12:12:28PM +0200, Juergen Gross wrote:
>> When running as a Xen guest selecting "nosmt" either via command line
>> or implicitly via default settings makes no sense, as the guest has no
>> clue about the real system topology it is running on. With Xen it is
>> the hypervisor's job to ensure the proper bug mitigations are active
>> regarding smt settings.
>>
>> So when running as a Xen guest set cpu_smt_control to "not supported"
>> in order to avoid disabling random vcpus.
> 
> If it doesn't make sense; then the topology should not expose SMT
> threads and the knob will not have any effect.

Yes, that's the theory.

I agree completely, but this is ongoing work which will need some more
time. It probably would have been ready for some time now, but some
recent processor bugs required a shift in priorities what to do first.

In order to run a new kernel on existing Xen we need that patch to avoid
disabling random cpus.


Juergen

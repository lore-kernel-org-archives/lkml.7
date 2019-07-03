Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420BDC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184D321882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfGCRf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:35:29 -0400
Received: from foss.arm.com ([217.140.110.172]:53878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfGCRf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:35:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C437344;
        Wed,  3 Jul 2019 10:35:28 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A38253F718;
        Wed,  3 Jul 2019 10:35:25 -0700 (PDT)
Subject: Re: [RFC v2 12/14] arm64/lib: asid: Allow user to update the context
 under the lock
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, marc.zyngier@arm.com,
        julien.thierry@arm.com, suzuki.poulose@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
References: <20190620130608.17230-1-julien.grall@arm.com>
 <20190620130608.17230-13-julien.grall@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <c5d1257c-b522-152f-cb2f-d23fd8110609@arm.com>
Date:   Wed, 3 Jul 2019 18:35:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620130608.17230-13-julien.grall@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On 20/06/2019 14:06, Julien Grall wrote:
> Some users of the ASID allocator (e.g VMID) will require to update the
> context when a new ASID is generated. This has to be protected by a lock
> to prevent concurrent modification.
> 
> Rather than introducing yet another lock, it is possible to re-use the
> allocator lock for that purpose. This patch introduces a new callback
> that will be call when updating the context.

You're using this later in the series to mask out the generation from the atomic64 to
leave just the vmid.

Where does this concurrent modification happen? The value is only written if we have a
rollover, and while its active the only bits that could change are the generation.
(subsequent vCPUs that take the slow path for the same VM will see the updated generation
and skip the new_context call)

If we did the generation filtering in update_vmid() after the call to
asid_check_context(), what would go wrong?
It happens more often than is necessary and would need a WRITE_ONCE(), but the vmid can't
change until we become preemptible and another vCPU gets a chance to make its vmid active.

This thing is horribly subtle, so I'm sure I've missed something here!

I can't see where the arch code's equivalent case is. It also filters the generation out
of the atomic64 in cpu_do_switch_mm(). This happens with interrupts masked so we can't
re-schedule and set another asid as 'active'. KVM's equivalent is !preemptible.


Thanks,

James

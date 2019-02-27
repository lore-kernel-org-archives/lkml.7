Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7870C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC07218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbfB0XUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:20:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728397AbfB0XUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 18:20:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 75E4D30BADAC;
        Wed, 27 Feb 2019 23:20:16 +0000 (UTC)
Received: from [10.10.121.150] (ovpn-121-150.rdu2.redhat.com [10.10.121.150])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD8C4610A3;
        Wed, 27 Feb 2019 23:20:15 +0000 (UTC)
Subject: Re: [PATCH] x86/stacktrace: export save_stack_trace_tsk_reliable
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        x86@kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>
References: <20190227211748.9545-1-joe.lawrence@redhat.com>
 <alpine.DEB.2.21.1902272219160.1644@nanos.tec.linutronix.de>
 <07491738-dfdb-deb4-7e25-f1c173dda773@redhat.com>
Message-ID: <873cd5ca-1f88-499e-e8ed-9a93f42d8239@redhat.com>
Date:   Wed, 27 Feb 2019 18:20:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <07491738-dfdb-deb4-7e25-f1c173dda773@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 27 Feb 2019 23:20:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/19 5:25 PM, Joe Lawrence wrote:
> On 2/27/19 4:31 PM, Thomas Gleixner wrote:
>> On Wed, 27 Feb 2019, Joe Lawrence wrote:
>>
>>> The ppc64le implementation of save_stack_trace_tsk_reliable() is
>>> exported, so do the same with x86.
>>
>> And what's the in tree module user of this? I can't find one and just
>> because PPC has an export with no user is not a convincing argument to add
>> another one. The proper solution is to remove the unused PPC export.
>>
> 
> Good point.
> 
> For that matter, I do see in-tree modules making use of
> save_stack_trace, but who is calling save_stack_trace_tsk (exported by
> most arches) and save_stack_trace_regs (exported by openrisc, powerpc,
> s390)?

Well, at least for save_stack_trace_tsk there is the out-of-tree kpatch 
core module[1].  (Kpatch drops that call if the kernel provides 
livepatch functionality.)

[1] https://github.com/dynup/kpatch/blob/master/kmod/core/core.c#L275

-- Joe

Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40F7C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B058C21783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfJBNmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:42:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:51522 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbfJBNmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:42:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C41EAACA4;
        Wed,  2 Oct 2019 13:42:19 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH] x86/xen: Return from panic notifier
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     james@dingwall.me.uk, xen-devel@lists.xenproject.org,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
References: <20191001151633.1659-1-boris.ostrovsky@oracle.com>
 <9b3f955c-ad76-601f-2b58-fa9dc4608c72@suse.com>
 <924f41b2-7779-9c56-9b71-56523756ecdc@oracle.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <5650904d-b616-5ee7-216a-a0ac28d7426d@suse.com>
Date:   Wed, 2 Oct 2019 15:42:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <924f41b2-7779-9c56-9b71-56523756ecdc@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.10.2019 15:24, Boris Ostrovsky wrote:
> On 10/2/19 3:40 AM, Jan Beulich wrote:
>> On 01.10.2019 17:16, Boris Ostrovsky wrote:
>>> Currently execution of panic() continues until Xen's panic notifier
>>> (xen_panic_event()) is called at which point we make a hypercall that
>>> never returns.
>>>
>>> This means that any notifier that is supposed to be called later as
>>> well as significant part of panic() code (such as pstore writes from
>>> kmsg_dump()) is never executed.
>> Back at the time when this was introduced into the XenoLinux tree,
>> I think this behavior was intentional for at least DomU-s. I wonder
>> whether you wouldn't want your change to further distinguish Dom0
>> and DomU behavior.
> 
> Do you remember what the reason for that was?

I can only guess that the thinking probably was that e.g. external
dumping (by the tool stack) would be more reliable (including but
not limited to this meaning less change of state from when the
original crash reason was detected) than having the domain dump
itself.

> I think having ability to call kmsg_dump() on a panic is a useful thing
> to have for domUs as well. Besides, there may be other functionality
> added post-notifiers in panic() in the future. Or another notifier may
> be registered later with the same lowest priority.
> 
> Is there a downside in allowing domUs to fall through panic() all the
> way to emergency_restart()?

See above.

>>> There is no reason for xen_panic_event() to be this last point in
>>> execution since panic()'s emergency_restart() will call into
>>> xen_emergency_restart() from where we can perform our hypercall.
>> Did you consider, as an alternative, to lower the notifier's
>> priority?
> 
> I didn't but that wouldn't help with the original problem that James
> reported --- we'd still not get to kmsg_dump() call.

True. I guess more control over the behavior needs to be given to
the admin, as either approach has its up- and downsides

Jan

Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7524C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8C22080A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfFNHf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 03:35:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:33738 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725802AbfFNHf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 03:35:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0473EAE1B;
        Fri, 14 Jun 2019 07:35:24 +0000 (UTC)
Subject: Re: [Xen-devel] [RFC PATCH 04/16] x86/xen: hypercall support for
 xenhost_t
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     sstabellini@kernel.org, konrad.wilk@oracle.com,
        pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <20190509172540.12398-5-ankur.a.arora@oracle.com>
 <11f8b620-11ac-7075-019a-30d6bad7583c@citrix.com>
 <fbfc0a0c-3707-7f17-9f2a-6c9d2c7b05b1@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <59f7cc19-cd9b-119a-1715-50a947cd995d@suse.com>
Date:   Fri, 14 Jun 2019 09:35:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <fbfc0a0c-3707-7f17-9f2a-6c9d2c7b05b1@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.06.19 09:20, Ankur Arora wrote:
> On 2019-06-12 2:15 p.m., Andrew Cooper wrote:
>> On 09/05/2019 18:25, Ankur Arora wrote:
>>> Allow for different hypercall implementations for different xenhost 
>>> types.
>>> Nested xenhost, which has two underlying xenhosts, can use both
>>> simultaneously.
>>>
>>> The hypercall macros (HYPERVISOR_*) implicitly use the default xenhost.x
>>> A new macro (hypervisor_*) takes xenhost_t * as a parameter and does the
>>> right thing.
>>>
>>> TODO:
>>>    - Multicalls for now assume the default xenhost
>>>    - xen_hypercall_* symbols are only generated for the default xenhost.
>>>
>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>
>> Again, what is the hypervisor nesting and/or guest layout here?
> Two hypervisors, L0 and L1, and the guest is a child of the L1
> hypervisor but could have PV devices attached to both L0 and L1
> hypervisors.
> 
>>
>> I can't think of any case where a single piece of software can
>> legitimately have two hypercall pages, because if it has one working
>> one, it is by definition a guest, and therefore not privileged enough to
>> use the outer one.
> Depending on which hypercall page is used, the hypercall would
> (eventually) land in the corresponding hypervisor.
> 
> Juergen elsewhere pointed out proxying hypercalls is a better approach,
> so I'm not really considering this any more but, given this layout, and
> assuming that the hypercall pages could be encoded differently would it
> still not work?

Hypercalls might work, but it is a bad idea and a violation of layering
to let a L1 guest issue hypercalls to L0 hypervisor, as those hypercalls
could influence other L1 guests and even the L1 hypervisor.

Hmm, thinking more about it, I even doubt those hypercalls could work in
all cases: when issued from a L1 PV guest the hypercalls would seem to
be issued from user mode for the L0 hypervisor, and this is not allowed.


Juergen

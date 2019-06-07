Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09D8C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F692089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbfFGQVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:21:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:60522 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728797AbfFGQVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:21:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C466AC9A;
        Fri,  7 Jun 2019 16:21:18 +0000 (UTC)
Subject: Re: [RFC PATCH 00/16] xenhost support
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <5649cfd1-24df-2196-2888-b00fc3ace7ad@suse.com>
 <ede6db03-121c-9ec6-f8eb-dbcc605977b4@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <c73a6ec5-687e-d3ef-e5d7-5700d240b4ec@suse.com>
Date:   Fri, 7 Jun 2019 18:21:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ede6db03-121c-9ec6-f8eb-dbcc605977b4@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.19 17:22, Joao Martins wrote:
> On 6/7/19 3:51 PM, Juergen Gross wrote:
>> On 09.05.19 19:25, Ankur Arora wrote:
>>> Hi all,
>>>
>>> This is an RFC for xenhost support, outlined here by Juergen here:
>>> https://lkml.org/lkml/2019/4/8/67.
>>
>> First: thanks for all the effort you've put into this series!
>>
>>> The high level idea is to provide an abstraction of the Xen
>>> communication interface, as a xenhost_t.
>>>
>>> xenhost_t expose ops for communication between the guest and Xen
>>> (hypercall, cpuid, shared_info/vcpu_info, evtchn, grant-table and on top
>>> of those, xenbus, ballooning), and these can differ based on the kind
>>> of underlying Xen: regular, local, and nested.
>>
>> I'm not sure we need to abstract away hypercalls and cpuid. I believe in
>> case of nested Xen all contacts to the L0 hypervisor should be done via
>> the L1 hypervisor. So we might need to issue some kind of passthrough
>> hypercall when e.g. granting a page to L0 dom0, but this should be
>> handled via the grant abstraction (events should be similar).
>>
> Just to be clear: By "kind of passthrough hypercall" you mean (e.g. for every
> access/modify of grant table frames) you would proxy hypercall to L0 Xen via L1 Xen?

It might be possible to spare some hypercalls by directly writing to
grant frames mapped into L1 dom0, but in general you are right.


Juergen

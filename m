Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA5AC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6848925920
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ddAoZJV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfE3M4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 08:56:47 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48380 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfE3M4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 08:56:47 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4UCu5DC038584;
        Thu, 30 May 2019 07:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559220965;
        bh=yfsOyzA/w0iHAo88Lim+9pYU3sP+lTVSj1gMoRm+IRc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ddAoZJV3O3SjnGH9+ATpox3dT93TWhxKCISRrbGLs9LFAbRLHysUrElN6YWYLT8QE
         d8Q7Fh7/cXQj9fMmUMZWZ+4Uzr2PLcvs60tHreblxsFmBWdfc88CcdNMTAqqPz+ifd
         +udj9djsPUutSwb+jbCQ+7rKnozfTLt8EKp4wIIQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4UCu5Kg096915
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 May 2019 07:56:05 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 30
 May 2019 07:56:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 30 May 2019 07:56:05 -0500
Received: from [10.250.93.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4UCu3Dt070901;
        Thu, 30 May 2019 07:56:03 -0500
Subject: Re: [PATCH v6 1/7] Documentation: DT: arm: add support for sockets
 defining package boundaries
To:     Morten Rasmussen <morten.rasmussen@arm.com>
CC:     Atish Patra <atish.patra@wdc.com>, <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190529211340.17087-1-atish.patra@wdc.com>
 <20190529211340.17087-2-atish.patra@wdc.com>
 <49f41e62-5354-a674-d95f-5f63851a0ca6@ti.com>
 <20190530115103.GA10919@e105550-lin.cambridge.arm.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <70639181-09d1-4644-f062-b19e06db7471@ti.com>
Date:   Thu, 30 May 2019 08:56:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530115103.GA10919@e105550-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/19 7:51 AM, Morten Rasmussen wrote:
> On Wed, May 29, 2019 at 07:39:17PM -0400, Andrew F. Davis wrote:
>> On 5/29/19 5:13 PM, Atish Patra wrote:
>>> From: Sudeep Holla <sudeep.holla@arm.com>
>>>
>>> The current ARM DT topology description provides the operating system
>>> with a topological view of the system that is based on leaf nodes
>>> representing either cores or threads (in an SMT system) and a
>>> hierarchical set of cluster nodes that creates a hierarchical topology
>>> view of how those cores and threads are grouped.
>>>
>>> However this hierarchical representation of clusters does not allow to
>>> describe what topology level actually represents the physical package or
>>> the socket boundary, which is a key piece of information to be used by
>>> an operating system to optimize resource allocation and scheduling.
>>>
>>
>> Are physical package descriptions really needed? What does "socket" imply
>> that a higher layer "cluster" node grouping does not? It doesn't imply a
>> different NUMA distance and the definition of "socket" is already not well
>> defined, is a dual chiplet processor not just a fancy dual "socket" or are
>> dual "sockets" on a server board "slotket" card, will we need new names for
>> those too..
> 
> Socket (or package) just implies what you suggest, a grouping of CPUs
> based on the physical socket (or package). Some resources might be
> associated with packages and more importantly socket information is
> exposed to user-space. At the moment clusters are being exposed to
> user-space as sockets which is less than ideal for some topologies.
> 

I see the benefit of reporting the physical layout and packaging 
information to user-space for tracking reasons, but from software 
perspective this doesn't matter, and the resource partitioning should be 
described elsewhere (NUMA nodes being the go to example).

> At the moment user-space is only told about hw threads, cores, and
> sockets. In the very near future it is going to be told about dies too
> (look for Len Brown's multi-die patch set).
> 

Seems my hypothetical case is already in the works :(

> I don't see how we can provide correct information to user-space based
> on the current information in DT. I'm not convinced it was a good idea
> to expose this information to user-space to begin with but that is
> another discussion.
> 

Fair enough, it's a little late now to un-expose this info to userspace 
so we should at least present it correctly. My worry was this getting 
out of hand with layering, for instance what happens when we need to add 
die nodes in-between cluster and socket?

Andrew

> Morten
> 

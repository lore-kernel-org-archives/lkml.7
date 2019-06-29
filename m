Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE49CC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 11:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AB620828
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 11:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfF2LXH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 07:23:07 -0400
Received: from ozlabs.org ([203.11.71.1]:59733 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbfF2LXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 07:23:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45bWTL6bJsz9s3l;
        Sat, 29 Jun 2019 21:23:02 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Qian Cai <cai@lca.pw>, Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Reza Arbab <arbab@linux.ibm.com>
Subject: Re: power9 NUMA crash while reading debugfs imc_cmd
In-Reply-To: <1561726853.5154.100.camel@lca.pw>
References: <1561670472.5154.98.camel@lca.pw> <87lfxms8r3.fsf@concordia.ellerman.id.au> <715A934D-EE3A-478B-BA77-589C539FC52D@lca.pw> <9c87dc72-54f8-8510-c400-1e89779cc88b@linux.vnet.ibm.com> <1561726853.5154.100.camel@lca.pw>
Date:   Sat, 29 Jun 2019 21:22:53 +1000
Message-ID: <87ef3ck54i.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian Cai <cai@lca.pw> writes:
> On Fri, 2019-06-28 at 17:19 +0530, Anju T Sudhakar wrote:
>> On 6/28/19 9:04 AM, Qian Cai wrote:
>> > 
>> > > On Jun 27, 2019, at 11:12 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> > > 
>> > > Qian Cai <cai@lca.pw> writes:
>> > > > Read of debugfs imc_cmd file for a memory-less node will trigger a crash
>> > > > below
>> > > > on this power9 machine which has the following NUMA layout.
>> > > 
>> > > What type of machine is it?
>> > 
>> > description: PowerNV
>> > product: 8335-GTH (ibm,witherspoon)
>> > vendor: IBM
>> > width: 64 bits
>> > capabilities: smp powernv opal
>> 
>> 
>> Hi Qian Cai,
>> 
>> Could you please try with this patch: 
>> https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-June/192803.html
>> 
>> and see if the issue is resolved?
>
> It works fine.
>
> Just feel a bit silly that a node without CPU and memory is still online by
> default during boot at the first place on powerpc, but that is probably a
> different issue. For example,

Those are there to represent the memory on your attached GPUs. It's not
onlined by default.

I don't really love that they show up like that, but I think that's
working as expected.

cheers

> # numactl -H
> available: 6 nodes (0,8,252-255)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
> 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52
> 53 54 55 56 57 58 59 60 61 62 63
> node 0 size: 126801 MB
> node 0 free: 123199 MB
> node 8 cpus: 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85
> 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108
> 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127
> node 8 size: 130811 MB
> node 8 free: 128436 MB
> node 252 cpus:
> node 252 size: 0 MB
> node 252 free: 0 MB
> node 253 cpus:
> node 253 size: 0 MB
> node 253 free: 0 MB
> node 254 cpus:
> node 254 size: 0 MB
> node 254 free: 0 MB
> node 255 cpus:
> node 255 size: 0 MB
> node 255 free: 0 MB
> node distances:
> node   0   8  252  253  254  255 
>   0:  10  40  80  80  80  80 
>   8:  40  10  80  80  80  80 
>  252:  80  80  10  80  80  80 
>  253:  80  80  80  10  80  80 
>  254:  80  80  80  80  10  80 
>  255:  80  80  80  80  80  10 
>
> # cat /sys/devices/system/node/online 
> 0,8,252-255

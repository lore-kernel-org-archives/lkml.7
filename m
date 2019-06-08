Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42835C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 05:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED8E212F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 05:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G9b4fDqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfFHFdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 01:33:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39102 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfFHFdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 01:33:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x585UAcs070273;
        Sat, 8 Jun 2019 05:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=eiAzEcwEsrXend+6SD1rxPdREd1UzGq+EuVlOEUZbFs=;
 b=G9b4fDqNvqgEhKP1VCgHDVOPH2TZn7tBWB5wVy2yQ5F5CJT/Z59JldhXNlUBRV6GjpwV
 +4MHJzRK6M2ugKuwx/pnl7jzw9U1iY9rhuHVcmSmYbeMQixGUAHYY93p9gD3HZjRdYYU
 IZB7dUn2NE5K1L+6SfhoCvgm7bMfdMQ2JZI4rG2amTLoonCQOMNXURQmvAFq6wZOC6SV
 BSV8X75dsHL5YRLu+Lo30VJ2uB8k8/g8NmaIdoJlGk93D25/909FlbMFvWSVNrwIazR9
 PkEiuPgrtooWILslFWb0I2uJjp1LaUSV5/kfp0K6lSdpYKYDWNBWaMt29q93hB9UOAKX eQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t04et87pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Jun 2019 05:33:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x585WdSB069308;
        Sat, 8 Jun 2019 05:33:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2t04bkhpur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Jun 2019 05:33:12 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x585XBVI018659;
        Sat, 8 Jun 2019 05:33:11 GMT
Received: from [192.168.0.110] (/70.36.60.91)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Jun 2019 22:33:11 -0700
Subject: Re: [RFC PATCH 00/16] xenhost support
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <5649cfd1-24df-2196-2888-b00fc3ace7ad@suse.com>
From:   Ankur Arora <ankur.a.arora@oracle.com>
Message-ID: <a5620ab0-7dc5-f75a-cc1e-9142b21570a8@oracle.com>
Date:   Fri, 7 Jun 2019 22:33:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5649cfd1-24df-2196-2888-b00fc3ace7ad@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906080042
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906080042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-07 7:51 a.m., Juergen Gross wrote:
> On 09.05.19 19:25, Ankur Arora wrote:
>> Hi all,
>>
>> This is an RFC for xenhost support, outlined here by Juergen here:
>> https://lkml.org/lkml/2019/4/8/67.
> 
> First: thanks for all the effort you've put into this series!
> 
>> The high level idea is to provide an abstraction of the Xen
>> communication interface, as a xenhost_t.
>>
>> xenhost_t expose ops for communication between the guest and Xen
>> (hypercall, cpuid, shared_info/vcpu_info, evtchn, grant-table and on top
>> of those, xenbus, ballooning), and these can differ based on the kind
>> of underlying Xen: regular, local, and nested.
> 
> I'm not sure we need to abstract away hypercalls and cpuid. I believe in
> case of nested Xen all contacts to the L0 hypervisor should be done via
> the L1 hypervisor. So we might need to issue some kind of passthrough
Yes, that does make sense. This also allows the L1 hypervisor to
control which hypercalls can be nested.
As for cpuid, what about nested feature discovery such as in
gnttab_need_v2()?
(Though for this particular case, the hypercall should be fine.)

> hypercall when e.g. granting a page to L0 dom0, but this should be
> handled via the grant abstraction (events should be similar).
> 
> So IMO we should drop patches 2-5.
For 3-5, I'd like to prune them to provide a limited hypercall
registration ability -- this is meant to be used for the
xenhost_r0/xenhost_local case.

Ankur

> 
>> (Since this abstraction is largely about guest -- xenhost communication,
>> no ops are needed for timer, clock, sched, memory (MMU, P2M), VCPU mgmt.
>> etc.)
>>
>> Xenhost use-cases:
>>
>> Regular-Xen: the standard Xen interface presented to a guest,
>> specifically for comunication between Lx-guest and Lx-Xen.
>>
>> Local-Xen: a Xen like interface which runs in the same address space as
>> the guest (dom0). This, can act as the default xenhost.
>>
>> The major ways it differs from a regular Xen interface is in presenting
>> a different hypercall interface (call instead of a syscall/vmcall), and
>> in an inability to do grant-mappings: since local-Xen exists in the same
>> address space as Xen, there's no way for it to cheaply change the
>> physical page that a GFN maps to (assuming no P2M tables.)
>>
>> Nested-Xen: this channel is to Xen, one level removed: from L1-guest to
>> L0-Xen. The use case is that we want L0-dom0-backends to talk to
>> L1-dom0-frontend drivers which can then present PV devices which can
>> in-turn be used by the L1-dom0-backend drivers as raw underlying devices.
>> The interfaces themselves, broadly remain similar.
>>
>> Note: L0-Xen, L1-Xen represent Xen running at that nesting level
>> and L0-guest, L1-guest represent guests that are children of Xen
>> at that nesting level. Lx, represents any level.
>>
>> Patches 1-7,
>>    "x86/xen: add xenhost_t interface"
>>    "x86/xen: cpuid support in xenhost_t"
>>    "x86/xen: make hypercall_page generic"
>>    "x86/xen: hypercall support for xenhost_t"
>>    "x86/xen: add feature support in xenhost_t"
>>    "x86/xen: add shared_info support to xenhost_t"
>>    "x86/xen: make vcpu_info part of xenhost_t"
>> abstract out interfaces that setup 
>> hypercalls/cpuid/shared_info/vcpu_info etc.
>>
>> Patch 8, "x86/xen: irq/upcall handling with multiple xenhosts"
>> sets up the upcall and pv_irq ops based on vcpu_info.
>>
>> Patch 9, "xen/evtchn: support evtchn in xenhost_t" adds xenhost based
>> evtchn support for evtchn_2l.
>>
>> Patches 10 and 16, "xen/balloon: support ballooning in xenhost_t" and
>> "xen/grant-table: host_addr fixup in mapping on xenhost_r0"
>> implement support from GNTTABOP_map_grant_ref for xenhosts of type
>> xenhost_r0 (xenhost local.)
>>
>> Patch 12, "xen/xenbus: support xenbus frontend/backend with xenhost_t"
>> makes xenbus so that both its frontend and backend can be bootstrapped
>> separately via separate xenhosts.
>>
>> Remaining patches, 11, 13, 14, 15:
>>    "xen/grant-table: make grant-table xenhost aware"
>>    "drivers/xen: gnttab, evtchn, xenbus API changes"
>>    "xen/blk: gnttab, evtchn, xenbus API changes"
>>    "xen/net: gnttab, evtchn, xenbus API changes"
>> are mostly mechanical changes for APIs that now take xenhost_t *
>> as parameter.
>>
>> The code itself is RFC quality, and is mostly meant to get feedback 
>> before
>> proceeding further. Also note that the FIFO logic and some Xen drivers
>> (input, pciback, scsi etc) are mostly unchanged, so will not build.
>>
>>
>> Please take a look.
> 
> 
> Juergen


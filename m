Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105ABC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FFF2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbfFGOv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:51:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:41718 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728446AbfFGOv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:51:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 81DC3AD08;
        Fri,  7 Jun 2019 14:51:56 +0000 (UTC)
Subject: Re: [RFC PATCH 00/16] xenhost support
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <5649cfd1-24df-2196-2888-b00fc3ace7ad@suse.com>
Date:   Fri, 7 Jun 2019 16:51:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509172540.12398-1-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.19 19:25, Ankur Arora wrote:
> Hi all,
> 
> This is an RFC for xenhost support, outlined here by Juergen here:
> https://lkml.org/lkml/2019/4/8/67.

First: thanks for all the effort you've put into this series!

> The high level idea is to provide an abstraction of the Xen
> communication interface, as a xenhost_t.
> 
> xenhost_t expose ops for communication between the guest and Xen
> (hypercall, cpuid, shared_info/vcpu_info, evtchn, grant-table and on top
> of those, xenbus, ballooning), and these can differ based on the kind
> of underlying Xen: regular, local, and nested.

I'm not sure we need to abstract away hypercalls and cpuid. I believe in
case of nested Xen all contacts to the L0 hypervisor should be done via
the L1 hypervisor. So we might need to issue some kind of passthrough
hypercall when e.g. granting a page to L0 dom0, but this should be
handled via the grant abstraction (events should be similar).

So IMO we should drop patches 2-5.

> (Since this abstraction is largely about guest -- xenhost communication,
> no ops are needed for timer, clock, sched, memory (MMU, P2M), VCPU mgmt.
> etc.)
> 
> Xenhost use-cases:
> 
> Regular-Xen: the standard Xen interface presented to a guest,
> specifically for comunication between Lx-guest and Lx-Xen.
> 
> Local-Xen: a Xen like interface which runs in the same address space as
> the guest (dom0). This, can act as the default xenhost.
> 
> The major ways it differs from a regular Xen interface is in presenting
> a different hypercall interface (call instead of a syscall/vmcall), and
> in an inability to do grant-mappings: since local-Xen exists in the same
> address space as Xen, there's no way for it to cheaply change the
> physical page that a GFN maps to (assuming no P2M tables.)
> 
> Nested-Xen: this channel is to Xen, one level removed: from L1-guest to
> L0-Xen. The use case is that we want L0-dom0-backends to talk to
> L1-dom0-frontend drivers which can then present PV devices which can
> in-turn be used by the L1-dom0-backend drivers as raw underlying devices.
> The interfaces themselves, broadly remain similar.
> 
> Note: L0-Xen, L1-Xen represent Xen running at that nesting level
> and L0-guest, L1-guest represent guests that are children of Xen
> at that nesting level. Lx, represents any level.
> 
> Patches 1-7,
>    "x86/xen: add xenhost_t interface"
>    "x86/xen: cpuid support in xenhost_t"
>    "x86/xen: make hypercall_page generic"
>    "x86/xen: hypercall support for xenhost_t"
>    "x86/xen: add feature support in xenhost_t"
>    "x86/xen: add shared_info support to xenhost_t"
>    "x86/xen: make vcpu_info part of xenhost_t"
> abstract out interfaces that setup hypercalls/cpuid/shared_info/vcpu_info etc.
> 
> Patch 8, "x86/xen: irq/upcall handling with multiple xenhosts"
> sets up the upcall and pv_irq ops based on vcpu_info.
> 
> Patch 9, "xen/evtchn: support evtchn in xenhost_t" adds xenhost based
> evtchn support for evtchn_2l.
> 
> Patches 10 and 16, "xen/balloon: support ballooning in xenhost_t" and
> "xen/grant-table: host_addr fixup in mapping on xenhost_r0"
> implement support from GNTTABOP_map_grant_ref for xenhosts of type
> xenhost_r0 (xenhost local.)
> 
> Patch 12, "xen/xenbus: support xenbus frontend/backend with xenhost_t"
> makes xenbus so that both its frontend and backend can be bootstrapped
> separately via separate xenhosts.
> 
> Remaining patches, 11, 13, 14, 15:
>    "xen/grant-table: make grant-table xenhost aware"
>    "drivers/xen: gnttab, evtchn, xenbus API changes"
>    "xen/blk: gnttab, evtchn, xenbus API changes"
>    "xen/net: gnttab, evtchn, xenbus API changes"
> are mostly mechanical changes for APIs that now take xenhost_t *
> as parameter.
> 
> The code itself is RFC quality, and is mostly meant to get feedback before
> proceeding further. Also note that the FIFO logic and some Xen drivers
> (input, pciback, scsi etc) are mostly unchanged, so will not build.
> 
> 
> Please take a look.


Juergen

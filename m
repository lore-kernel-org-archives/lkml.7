Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595B7C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFD6204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfFZNji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:39:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48084 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZNjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:39:37 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hg898-000208-EQ; Wed, 26 Jun 2019 15:39:34 +0200
Date:   Wed, 26 Jun 2019 15:39:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, bp@alien8.de,
        hpa@zytor.com, boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, peterz@infradead.org,
        srinivas.eeda@oracle.com
Subject: Re: [PATCH v2 0/7] misc fixes to PV extentions code
In-Reply-To: <1561377779-28036-1-git-send-email-zhenzhong.duan@oracle.com>
Message-ID: <alpine.DEB.2.21.1906261511180.32342@nanos.tec.linutronix.de>
References: <1561377779-28036-1-git-send-email-zhenzhong.duan@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2019, Zhenzhong Duan wrote:

> [PATCH v2 1/7]  x86/xen: Mark xen_hvm_need_lapic() and xen_hvm_need_lapic() as __init
> [PATCH v2 2/7]  x86/jailhouse: Mark jailhouse_x2apic_available as __init
> 
> Above two patches only add __init annotation to some functions, not
> related to other patches. I didn't split the two out as following patches
> need them to avoid conflicts.

Not really. Just the XEN one conflicts. The jailhoise one is independent.

> [PATCH v2 3/7]  x86: Add nopv parameter to disable PV extensions
> [PATCH v2 4/7]  Revert "xen: Introduce 'xen_nopv' to disable PV extensions for HVM guests."
> [PATCH v2 5/7]  x86/xen: nopv parameter support for HVM guest
> 
> Above three patches add an unified nopv prameter used for most of hypervisor
> platform except XEN PV/PVH, jailhouse. Those need PV extensions to work.
> 
> I revert 'xen_nopv' as it's same effect as nopv on XEN platform, there is also
> an issue using 'xen_nopv' with PVH, we should ignore 'xen_nopv' for PVH.

Well, command line options are ABI. You cannot nilly willy remove them as
it might break existing setups.

The fact that nopv can replace xen_nopv is not a justification.

Also if there is an issue with xen_nopv and PVH then this issue needs to be
fixed first especially if that issue exists on older kernels.

> [PATCH v2 6/7]  locking/spinlocks, paravirt, hyperv: Correct the hv_nopvspin case
> 
> This is a similar change as Commit e6fd28eb3522
> ("locking/spinlocks, paravirt, xen: Correct the xen_nopvspin case"), but for
> hyperv.

This looks like an independent bug fix. Bug fixes should either be posted
seperately or at least at the beginning of the series. And this one clearly
is self contained so why hiding it in the middle of a pile of other
patches?

> [PATCH v2 7/7]  Revert "x86/paravirt: Set up the virt_spin_lock_key after static keys get initialized"
> 
> This revert an old change which is unnecessory now, I think the original change is smarter.

Again, this has nothing to do with the meat of this series which deals with
the command line parameters and is completely independent.

So you give a list of patches with some explanation for them, but the cover
letter should provide the big picture. The details of the patches need to
be in the changelog.

  1) Describe the context

     The paravirtualization whatever lack whatever they lack and have the
     shortcoming A, B, C.

     For a consistent admin experience a common command line parameter set
     across all PV guest implementations is a better choice, yada, yada
     yada.

  2) Describe the changes as overview

     To achieve this introduce a new nopv parameter which is usable by
     all PV guest implementation.

     While analyzing the PV guest code several bugs were found and
     fixed. (Patches 1 - 3). They can be applied independent of the
     functional changes, but they are kept in the series as the functional
     changes depend on them.

Documentation/process/submitting-patches.rst clearly explains why it is a
bad idea to send random collections of patches especially if some patches
are independent and contain bug fixes.

These rules exist for a reason and are not subject to personal
interpretation. You want your patches to be reviewed and merged, so pretty
please make the life of those who need to do that as easy as possible.

It's not the job of reviewers and maintainers to distangle your randomly
ordered patch series.

Thanks,

	tglx

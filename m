Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D17C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E741A20684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbfCGKp6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:45:58 -0500
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:48912 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfCGKp6 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:8:1>);
        Thu, 7 Mar 2019 05:45:58 -0500
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Thu, 07 Mar 2019 03:45:57 -0700
Message-Id: <5C80F662020000780021C674@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date:   Thu, 07 Mar 2019 03:45:54 -0700
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Juergen Gross" <jgross@suse.com>
Cc:     "Borislav Petkov" <bp@alien8.de>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>, <tglx@linutronix.de>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>, <hpa@zytor.com>
Subject: Re: [Xen-devel] [PATCH] xen: fix dom0 boot on huge systems
References: <20190307091119.6700-1-jgross@suse.com>
In-Reply-To: <20190307091119.6700-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 07.03.19 at 10:11, <jgross@suse.com> wrote:
> Commit f7c90c2aa40048 ("x86/xen: don't write ptes directly in 32-bit
> PV guests") introduced a regression for booting dom0 on huge systems
> with lots of RAM (in the TB range).
> 
> Reason is that on those hosts the p2m list needs to be moved early in
> the boot process and this requires temporary page tables to be created.
> Said commit modified xen_set_pte_init() to use a hypercall for writing
> a PTE, but this requires the page table being in the direct mapped
> area, which is not the case for the temporary page tables used in
> xen_relocate_p2m().
> 
> As the page tables are completely written before being linked to the
> actual address space instead of set_pte() a plain write to memory can
> be used in xen_relocate_p2m().
> 
> Fixes: f7c90c2aa40048 ("x86/xen: don't write ptes directly in 32-bit PV guests")
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>



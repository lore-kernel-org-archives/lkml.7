Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BA4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C2821773
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555457635;
	bh=JsFmE01VQUz7WLH/7qpPbBL9xTQIQUqe4M00o4G3MAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VwS7iG+BLSa1YWk/xq7corCD6NRMXmcG9pI8goopOgFlE+83BjbUv2QPVnd63nG6h
	 WPG10DWoDd/HHJc77g0sw+Kp8H3IPMYtZyZCrEr7GQhw5Z8PqjCZGH7nGiAoghOyyb
	 Gksl/KhUkWQLy/y/yKif7SxsBjZZB6TUvisev7ws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbfDPXdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:33:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36672 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbfDPXdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:33:53 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5A7E4C9F;
        Tue, 16 Apr 2019 23:33:52 +0000 (UTC)
Date:   Tue, 16 Apr 2019 16:33:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alan Tull <atull@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Lameter <cl@linux.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Moritz Fischer <mdf@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>, Wu Hao <hao.wu@intel.com>,
        linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm: change locked_vm's type from unsigned long to
 atomic64_t
Message-Id: <20190416163351.5e4e075ddfad0677239fc23a@linux-foundation.org>
In-Reply-To: <20190411202807.q2fge33uoduhtehq@ca-dmjordan1.us.oracle.com>
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
        <20190402204158.27582-2-daniel.m.jordan@oracle.com>
        <614ea07a-dd1e-2561-b6f4-2d698bf55f5b@ozlabs.ru>
        <20190411095543.GA55197@lakrids.cambridge.arm.com>
        <20190411202807.q2fge33uoduhtehq@ca-dmjordan1.us.oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019 16:28:07 -0400 Daniel Jordan <daniel.m.jordan@oracle.com> wrote:

> On Thu, Apr 11, 2019 at 10:55:43AM +0100, Mark Rutland wrote:
> > On Thu, Apr 11, 2019 at 02:22:23PM +1000, Alexey Kardashevskiy wrote:
> > > On 03/04/2019 07:41, Daniel Jordan wrote:
> > 
> > > > -	dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %ld/%ld%s\n", current->pid,
> > > > +	dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %lld/%lu%s\n", current->pid,
> > > >  		incr ? '+' : '-', npages << PAGE_SHIFT,
> > > > -		current->mm->locked_vm << PAGE_SHIFT, rlimit(RLIMIT_MEMLOCK),
> > > > -		ret ? "- exceeded" : "");
> > > > +		(s64)atomic64_read(&current->mm->locked_vm) << PAGE_SHIFT,
> > > > +		rlimit(RLIMIT_MEMLOCK), ret ? "- exceeded" : "");
> > > 
> > > 
> > > 
> > > atomic64_read() returns "long" which matches "%ld", why this change (and
> > > similar below)? You did not do this in the two pr_debug()s above anyway.
> > 
> > Unfortunately, architectures return inconsistent types for atomic64 ops.
> > 
> > Some return long (e..g. powerpc), some return long long (e.g. arc), and
> > some return s64 (e.g. x86).
> 
> Yes, Mark said it all, I'm just chiming in to confirm that's why I added the
> cast.
> 
> Btw, thanks for doing this, Mark.

What's the status of this patchset, btw?

I have a note here that
powerpc-mmu-drop-mmap_sem-now-that-locked_vm-is-atomic.patch is to be
updated.


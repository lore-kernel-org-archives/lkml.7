Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E54EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258AF207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574756096;
	bh=AbbbWuscm1XFwkU+iaNgbLtgzGZzop3yUPFrFom9R94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V1UjkG+OEsf1im7wzkWQdWN6ECsl4lSCSmr6rNKi1b8si9JqXHBb6CT7hQoUTeRC8
	 G4R12RkwfWJOSLybiKdtp5qwAQYT/Aq+Z7iWPDdqGC4UlVDIRTBR/iwZKWNfAhP/Z+
	 hG3WtcdoH65477+vY0gkOsJJ02D7r2NvbV8nQ8V8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfKZIOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 03:14:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfKZIOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 03:14:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 109632073F;
        Tue, 26 Nov 2019 08:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574756094;
        bh=AbbbWuscm1XFwkU+iaNgbLtgzGZzop3yUPFrFom9R94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=icsBHROXujOxmfJd7Yy7JK3M68vUtJLCCe2lHaoeEFyuxqwdtJPWNTLXCjvevCT02
         UyuKO5l8dekopWCdA5rGSkjo0v0ox0mwc/tSIByxhnl7gqbhyHRezMS6gDWdQOCg5U
         LFqaD/KDCgR46NKPLCwZHZfG8gu91rqK5an/W3ok=
Date:   Tue, 26 Nov 2019 09:14:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.19 STABLE] KVM: MMU: Do not treat ZONE_DEVICE pages as
 being reserved
Message-ID: <20191126081450.GB1233188@kroah.com>
References: <20191125190456.28679-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125190456.28679-1-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 11:04:56AM -0800, Sean Christopherson wrote:
> [ Upstream commit a78986aae9b2988f8493f9f65a587ee433e83bc3 ]
> 
> Explicitly exempt ZONE_DEVICE pages from kvm_is_reserved_pfn() and
> instead manually handle ZONE_DEVICE on a case-by-case basis.  For things
> like page refcounts, KVM needs to treat ZONE_DEVICE pages like normal
> pages, e.g. put pages grabbed via gup().  But for flows such as setting
> A/D bits or shifting refcounts for transparent huge pages, KVM needs to
> to avoid processing ZONE_DEVICE pages as the flows in question lack the
> underlying machinery for proper handling of ZONE_DEVICE pages.
> 
> This fixes a hang reported by Adam Borowski[*] in dev_pagemap_cleanup()
> when running a KVM guest backed with /dev/dax memory, as KVM straight up
> doesn't put any references to ZONE_DEVICE pages acquired by gup().
> 
> Note, Dan Williams proposed an alternative solution of doing put_page()
> on ZONE_DEVICE pages immediately after gup() in order to simplify the
> auditing needed to ensure is_zone_device_page() is called if and only if
> the backing device is pinned (via gup()).  But that approach would break
> kvm_vcpu_{un}map() as KVM requires the page to be pinned from map() 'til
> unmap() when accessing guest memory, unlike KVM's secondary MMU, which
> coordinates with mmu_notifier invalidations to avoid creating stale
> page references, i.e. doesn't rely on pages being pinned.
> 
> [*] http://lkml.kernel.org/r/20190919115547.GA17963@angband.pl
> 
> Reported-by: Adam Borowski <kilobyte@angband.pl>
> Analyzed-by: David Hildenbrand <david@redhat.com>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Cc: stable@vger.kernel.org
> Fixes: 3565fce3a659 ("mm, x86: get_user_pages() for dax mappings")
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> [sean: backport to 4.x; resolve conflict in mmu.c]

All 3 now queued up, thanks.

greg k-h

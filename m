Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EFAC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EA9207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfLIPtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 10:49:15 -0500
Received: from mga18.intel.com ([134.134.136.126]:40719 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfLIPtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 10:49:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 07:49:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,296,1571727600"; 
   d="scan'208";a="237786846"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga004.fm.intel.com with ESMTP; 09 Dec 2019 07:49:13 -0800
Date:   Mon, 9 Dec 2019 07:49:13 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Doug Reiland <doug.reiland@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 3.16 31/72] KVM: x86: Manually calculate reserved bits
 when loading PDPTRS
Message-ID: <20191209154913.GB4042@linux.intel.com>
References: <lsq.1575813164.154362148@decadent.org.uk>
 <lsq.1575813165.887619822@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lsq.1575813165.887619822@decadent.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 08, 2019 at 01:53:15PM +0000, Ben Hutchings wrote:
> 3.16.79-rc1 review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> commit 16cfacc8085782dab8e365979356ce1ca87fd6cc upstream.

You'll also want to pull in two PAE related fixes (in this order):

  d35b34a9a70e ("kvm: mmu: Don't read PDPTEs when paging is not enabled")
  bf03d4f93347 ("KVM: x86: introduce is_pae_paging")

The "introduce is_pae_paging" has an undocumented bug fix.  IIRC it
manifests as an unexpected #GP on MOV CR3 in 64-bit mode.  Here's the blurb
I added to the backports for 4.x.

  Moving to the common helper also fixes a subtle bug in kvm_set_cr3()
  where it fails to check is_long_mode() and results in KVM incorrectly
  attempting to load PDPTRs for a 64-bit guest.


Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6A4C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADFF2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfLRAaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 19:30:06 -0500
Received: from mga07.intel.com ([134.134.136.100]:11272 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfLRAaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:30:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 16:30:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,327,1571727600"; 
   d="scan'208";a="365583730"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga004.jf.intel.com with ESMTP; 17 Dec 2019 16:30:05 -0800
Date:   Tue, 17 Dec 2019 16:30:05 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, jmattson@google.com,
        yu.c.zhang@linux.intel.com, yu-cheng.yu@intel.com
Subject: Re: [PATCH v8 4/7] KVM: VMX: Load CET states on vmentry/vmexit
Message-ID: <20191218003005.GO11771@linux.intel.com>
References: <20191101085222.27997-1-weijiang.yang@intel.com>
 <20191101085222.27997-5-weijiang.yang@intel.com>
 <20191210212305.GM15758@linux.intel.com>
 <20191211015423.GC12845@local-michael-cet-test>
 <20191211163510.GF5044@linux.intel.com>
 <20191212010423.GB17570@local-michael-cet-test.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212010423.GB17570@local-michael-cet-test.sh.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 09:04:24AM +0800, Yang Weijiang wrote:
> On Wed, Dec 11, 2019 at 08:35:10AM -0800, Sean Christopherson wrote:
> > Have you tested SMM at all?  The interaction between CR0 and CR4 may be
> > problematic for em_rsm() and/or rsm_enter_protected_mode().
> >
> Not yet, what's an easy way to test code in SMM mode?

IIRC, SeaBIOS does SMM stuff by default.

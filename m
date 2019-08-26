Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CA5C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2836B20679
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732247AbfHZOGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 10:06:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:6819 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbfHZOGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 10:06:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 07:06:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="174218747"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga008.jf.intel.com with ESMTP; 26 Aug 2019 07:06:51 -0700
Date:   Mon, 26 Aug 2019 07:06:51 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH] KVM: x86: Don't update RIP or do single-step on faulting
 emulation
Message-ID: <20190826140651.GA19381@linux.intel.com>
References: <20190823205544.24052-1-sean.j.christopherson@intel.com>
 <CALCETrXFRAmgqyxtsknpnQaMtVU-hqMRPYR=4Q5JtBgNGxuSGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXFRAmgqyxtsknpnQaMtVU-hqMRPYR=4Q5JtBgNGxuSGQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 03:46:20PM -0700, Andy Lutomirski wrote:
> On Fri, Aug 23, 2019 at 1:55 PM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> >
> > Don't advance RIP or inject a single-step #DB if emulation signals a
> > fault.  This logic applies to all state updates that are conditional on
> > clean retirement of the emulation instruction, e.g. updating RFLAGS was
> > previously handled by commit 38827dbd3fb85 ("KVM: x86: Do not update
> > EFLAGS on faulting emulation").
> >
> > Not advancing RIP is likely a nop, i.e. ctxt->eip isn't updated with
> > ctxt->_eip until emulation "retires" anyways.  Skipping #DB injection
> > fixes a bug reported by Andy Lutomirski where a #UD on SYSCALL due to
> > invalid state with RFLAGS.RF=1 would loop indefinitely due to emulation
> 
> EFLAGS.TF=1

It's always some mundane detail...

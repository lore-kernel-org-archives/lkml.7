Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CE5ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648C020B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfJIGoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 02:44:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:37246 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfJIGoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 02:44:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 23:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,273,1566889200"; 
   d="scan'208";a="368658906"
Received: from unknown (HELO localhost) ([10.239.159.128])
  by orsmga005.jf.intel.com with ESMTP; 08 Oct 2019 23:44:51 -0700
Date:   Wed, 9 Oct 2019 14:46:48 +0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v7 6/7] KVM: x86: Load Guest fpu state when accessing
 MSRs managed by XSAVES
Message-ID: <20191009064648.GD27851@local-michael-cet-test>
References: <20190927021927.23057-1-weijiang.yang@intel.com>
 <20190927021927.23057-7-weijiang.yang@intel.com>
 <CALMp9eRouyhkKeadM_w80bisWB-VSBCf3NSei5hZXcDsRR7GJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eRouyhkKeadM_w80bisWB-VSBCf3NSei5hZXcDsRR7GJg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 12:56:30PM -0700, Jim Mattson wrote:
> On Thu, Sep 26, 2019 at 7:17 PM Yang Weijiang <weijiang.yang@intel.com> wrote:
> >
> > From: Sean Christopherson <sean.j.christopherson@intel.com>
> >
 >  /*
> >   * Read or write a bunch of msrs. All parameters are kernel addresses.
> >   *
> > @@ -3009,11 +3017,23 @@ static int __msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs *msrs,
> >                     int (*do_msr)(struct kvm_vcpu *vcpu,
> >                                   unsigned index, u64 *data))
> >  {
> > +       bool fpu_loaded = false;
> >         int i;
> > +       const u64 cet_bits = XFEATURE_MASK_CET_USER | XFEATURE_MASK_CET_KERNEL;
> > +       bool cet_xss = kvm_x86_ops->xsaves_supported() &&
> > +                      (kvm_supported_xss() & cet_bits);
> 
> It seems like I've seen a lot of checks like this. Can this be
> simplified (throughout this series) by sinking the
> kvm_x86_ops->xsaves_supported() check into kvm_supported_xss()? That
> is, shouldn't kvm_supported_xss() return 0 if
> kvm_x86_ops->xsaves_supported() is false?
>
OK, let me add this check, thank you!

> > -       for (i = 0; i < msrs->nmsrs; ++i)
> > +       for (i = 0; i < msrs->nmsrs; ++i) {
> > +               if (!fpu_loaded && cet_xss &&
> > +                   is_xsaves_msr(entries[i].index)) {
> > +                       kvm_load_guest_fpu(vcpu);
> > +                       fpu_loaded = true;
> > +               }
> >                 if (do_msr(vcpu, entries[i].index, &entries[i].data))
> >                         break;
> > +       }
> > +       if (fpu_loaded)
> > +               kvm_put_guest_fpu(vcpu);
> >
> >         return i;
> >  }
> > --
> > 2.17.2
> >

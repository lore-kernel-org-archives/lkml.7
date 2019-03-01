Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC10FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DB02085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbfCACPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 21:15:30 -0500
Received: from mga12.intel.com ([192.55.52.136]:46624 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbfCACPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 21:15:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 18:15:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,425,1544515200"; 
   d="scan'208";a="147524401"
Received: from lxy-dell.sh.intel.com ([10.239.159.147])
  by fmsmga002.fm.intel.com with ESMTP; 28 Feb 2019 18:15:28 -0800
Message-ID: <80d077f35a867b4315da76918f69ba4aca8a76ad.camel@linux.intel.com>
Subject: Re: [PATCH v3 2/8] KVM:CPUID: Define CET CPUID bits and CR4.CET
 master enable bit.
From:   Xiaoyao Li <xiaoyao.li@linux.intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>,
        Jim Mattson <jmattson@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, yu-cheng.yu@intel.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Date:   Fri, 01 Mar 2019 10:15:30 +0800
In-Reply-To: <20190226075734.GB10256@local-michael-cet-test.sh.intel.com>
References: <20190225132716.6982-1-weijiang.yang@intel.com>
         <20190225132716.6982-3-weijiang.yang@intel.com>
         <CALMp9eRJ_ayTPbDC5nOuJ00GjRxqd+je0qAyCoeyU9zT698XhA@mail.gmail.com>
         <20190226075734.GB10256@local-michael-cet-test.sh.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-26 at 15:57 +0800, Yang Weijiang wrote:
> On Tue, Feb 26, 2019 at 11:48:59AM -0800, Jim Mattson wrote:
> > On Mon, Feb 25, 2019 at 10:32 PM Yang Weijiang <weijiang.yang@intel.com>
> > wrote:
> > > 
> > > Guest queries CET SHSTK and IBT support by CPUID.(EAX=0x7,ECX=0),
> > > in return, ECX[bit 7] corresponds to SHSTK feature, and EDX[bit 20]
> > > corresponds to IBT feature.
> > > CR4.CET[bit 23] is CET master enable bit, it controls CET feature
> > > availability in guest OS.
> > > 
> > > Note: Although SHSTK or IBT can be enabled independently,
> > >       either of the features is controlled by CR4.CET.
> > > 
> > > Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> > > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > 
> > Am I missing something? X86_CR4_CET and X86_FEATURE_SHSTK and
> > X86_FEATURE_IBT don't appear to be defined in Linus' tree.
> 
> The patch-set has dependency on this CET Kernel patch-set:
> https://lkml.org/lkml/2018/11/20/203
> I reused some definitions from the kernel patches.

Right, the definitions should be defined by the kernel patches.
However, I have checked the latest kernel patches and found it didn't define 
the related CPUID feature bits. 



Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0538CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 04:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A712080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 04:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfJaEVR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 00:21:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:19141 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfJaEVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 00:21:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 21:21:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,250,1569308400"; 
   d="scan'208";a="204086732"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga006.jf.intel.com with ESMTP; 30 Oct 2019 21:21:15 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 30 Oct 2019 21:21:10 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 30 Oct 2019 21:21:09 -0700
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 30 Oct 2019 21:21:09 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.127]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.63]) with mapi id 14.03.0439.000;
 Thu, 31 Oct 2019 12:21:08 +0800
From:   "Kang, Luwei" <luwei.kang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: RE: [PATCH v1 7/8] KVM: x86: Expose PEBS feature to guest
Thread-Topic: [PATCH v1 7/8] KVM: x86: Expose PEBS feature to guest
Thread-Index: AQHVjLd7lPe74bngJEyQFMJJsvDDF6dxNRGAgAFBajD///ljAIABnNRg
Date:   Thu, 31 Oct 2019 04:21:08 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E1738361DB@SHSMSX104.ccr.corp.intel.com>
References: <1572217877-26484-1-git-send-email-luwei.kang@intel.com>
 <1572217877-26484-8-git-send-email-luwei.kang@intel.com>
 <20191029150531.GN4097@hirez.programming.kicks-ass.net>
 <82D7661F83C1A047AF7DC287873BF1E173835B45@SHSMSX104.ccr.corp.intel.com>
 <20191030095214.GT4097@hirez.programming.kicks-ass.net>
In-Reply-To: <20191030095214.GT4097@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzk5YzY4YjktNzUwZi00N2EwLThkMzEtYzhhMTE2ZmQ3MTM0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSXloeDFuM3JwOVdoaXBsWEJZcEQyOVN5UnhCblN1UDk5ODlUT2hoR2poRWdpNXE1clFseStRdGwzWk1IQ1VGOCJ9
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Expose PEBS feature to guest by IA32_MISC_ENABLE[bit12].
> > > > IA32_MISC_ENABLE[bit12] is Processor Event Based Sampling (PEBS)
> > > > Unavailable (RO) flag:
> > > > 1 = PEBS is not supported; 0 = PEBS is supported.
> > >
> > > Why does it make sense to expose this on SVM?
> >
> > Thanks for the review. This patch won't expose the pebs feature to SVM and return not supported.
> 
> AFAICT it exposes/emulates an Intel MSR on AMD, which is just weird.

I checked with the "AMD64 Architecture Programmer's Manual" and didn't found this register (IA32_MISC_ENABLE).
Will move this register to vmx.c in next version.

Thanks,
Luwei Kang


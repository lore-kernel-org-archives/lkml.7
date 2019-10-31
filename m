Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D20CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 07:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D320C2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 07:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfJaHjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 03:39:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:26720 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbfJaHjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 03:39:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 00:39:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,250,1569308400"; 
   d="scan'208";a="401792868"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by fmsmga006.fm.intel.com with ESMTP; 31 Oct 2019 00:39:25 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     "Kang\, Luwei" <luwei.kang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini\@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar\@redhat.com" <rkrcmar@redhat.com>,
        "Christopherson\, Sean J" <sean.j.christopherson@intel.com>,
        "vkuznets\@redhat.com" <vkuznets@redhat.com>,
        "wanpengli\@tencent.com" <wanpengli@tencent.com>,
        "jmattson\@google.com" <jmattson@google.com>,
        "joro\@8bytes.org" <joro@8bytes.org>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "mingo\@redhat.com" <mingo@redhat.com>,
        "bp\@alien8.de" <bp@alien8.de>, "hpa\@zytor.com" <hpa@zytor.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "ak\@linux.intel.com" <ak@linux.intel.com>,
        "thomas.lendacky\@amd.com" <thomas.lendacky@amd.com>,
        "acme\@kernel.org" <acme@kernel.org>,
        "mark.rutland\@arm.com" <mark.rutland@arm.com>,
        "jolsa\@redhat.com" <jolsa@redhat.com>,
        "namhyung\@kernel.org" <namhyung@kernel.org>,
        alexander.shishkin@linux.intel.com
Subject: RE: [PATCH v1 8/8] perf/x86: Add event owner check when PEBS output to Intel PT
In-Reply-To: <82D7661F83C1A047AF7DC287873BF1E173836317@SHSMSX104.ccr.corp.intel.com>
References: <1572217877-26484-1-git-send-email-luwei.kang@intel.com> <1572217877-26484-9-git-send-email-luwei.kang@intel.com> <20191029151302.GO4097@hirez.programming.kicks-ass.net> <82D7661F83C1A047AF7DC287873BF1E173835B6A@SHSMSX104.ccr.corp.intel.com> <20191030095400.GU4097@hirez.programming.kicks-ass.net> <82D7661F83C1A047AF7DC287873BF1E173836317@SHSMSX104.ccr.corp.intel.com>
Date:   Thu, 31 Oct 2019 09:39:24 +0200
Message-ID: <87bltxfjo3.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Kang, Luwei" <luwei.kang@intel.com> writes:

>> Then how does KVM deal with the host using PT? You can't just steal PT.
>
> Intel PT in virtualization can work in system and host_guest mode.
> In system mode (default), the trace produced by host and guest will be saved in host PT buffer. Intel PT will not be exposed to guest in this mode.
>  In host_guest mode, Intel PT will be exposed to guest and guest can use PT like native. The value of host PT register will be saved and guest PT register value will be restored during VM-entry. Both trace of host and guest are exported to their respective PT buffer. The host PT buffer not include guest trace in this mode.

IOW, it will steal PT from the host.

Regards,
--
Alex

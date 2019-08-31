Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAA7C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 17:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D5522D37
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 17:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbfHaRxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 13:53:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:17103 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728456AbfHaRxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 13:53:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2019 10:53:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,451,1559545200"; 
   d="scan'208";a="206420548"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga004.fm.intel.com with ESMTP; 31 Aug 2019 10:53:36 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id B5D0F301247; Sat, 31 Aug 2019 10:53:37 -0700 (PDT)
Date:   Sat, 31 Aug 2019 10:53:37 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [RESEND PATCH V3 3/8] perf/x86/intel: Support hardware TopDown
 metrics
Message-ID: <20190831175337.GB5447@tassilo.jf.intel.com>
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-4-kan.liang@linux.intel.com>
 <CABPqkBTS8bRjSwOBm2HxtuDWhxeZrTGa_E8mqfRfEJPzX1BNhw@mail.gmail.com>
 <20190831003110.GA5447@tassilo.jf.intel.com>
 <CABPqkBSPfZ6iQ_t1ESZf334q+dNVf=RvoNHdmKZSs5GLokbjFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBSPfZ6iQ_t1ESZf334q+dNVf=RvoNHdmKZSs5GLokbjFQ@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2019 at 02:13:05AM -0700, Stephane Eranian wrote:
> Andi,
> 
> On Fri, Aug 30, 2019 at 5:31 PM Andi Kleen <ak@linux.intel.com> wrote:
> >
> > > the same manner. It would greatly simplify the kernel implementation.
> >
> > I tried that originally. It was actually more complicated.
> >
> > You can't really do deltas on raw metrics, and a lot of the perf
> > infrastructure is built around deltas.
> >
> How is RAPL handled? No deltas there either. It uses the snapshot model.

RAPL doesn't support any context switch or CPU context.
Also it has no concept of "accumulate with clear on read"

-Andi

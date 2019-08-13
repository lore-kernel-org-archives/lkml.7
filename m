Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD10C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243112054F
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfHMQVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 12:21:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:9598 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728172AbfHMQVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 12:21:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 09:21:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="205137067"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.183])
  by fmsmga002.fm.intel.com with ESMTP; 13 Aug 2019 09:21:39 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, Adrian Hunter <adrian.hunter@intel.com>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v6 7/7] perf intel-pt: Add brief documentation for PEBS via Intel PT
In-Reply-To: <20190813141453.GB3754@redhat.com>
References: <20190806084606.4021-1-alexander.shishkin@linux.intel.com> <20190806084606.4021-8-alexander.shishkin@linux.intel.com> <20190813135149.GA3754@redhat.com> <87imr12m9x.fsf@ashishki-desk.ger.corp.intel.com> <20190813141453.GB3754@redhat.com>
Date:   Tue, 13 Aug 2019 19:21:39 +0300
Message-ID: <87ftm52fzg.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo <acme@redhat.com> writes:

> I've just blindly followed the provided documentation :)

Yes, I should have checked it also before I sent it out. :)

> So you say I should have tried this instead:
>
>   # perf record -c 10000 -e '{intel_pt/branch=0/,cycles/aux-output/ppp}' uname

Right. For the purposes of illustrating the error condition, you can
probably drop the '-c ...' and 'branch=0' also, but either way is fine.

>   Error:
>   The 'aux_output' feature is not supported, update the kernel.

Or it's not supported by the hardware. I don't think we make a
distinction at the moment. You can tell if it's available from dmesg,
but not otherwise.

>   #
>
> Or with leader sampling?
>
>   # perf record -c 10000 -e '{intel_pt/branch=0/,cycles/aux-output/ppp}:S' uname

Not sure if we should even allow this. Maybe Adrian can chime in.

Thanks,
--
Alex

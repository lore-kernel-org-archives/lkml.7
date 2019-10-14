Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7507AC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5551C206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388936AbfJNTqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 15:46:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:11869 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730254AbfJNTqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 15:46:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 12:46:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; 
   d="scan'208";a="199501034"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga006.jf.intel.com with ESMTP; 14 Oct 2019 12:46:19 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 07FE93001C0; Mon, 14 Oct 2019 12:46:19 -0700 (PDT)
Date:   Mon, 14 Oct 2019 12:46:19 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 3/3] perf tools: Make 'struct map_shared' truly shared
Message-ID: <20191014194619.GS9933@tassilo.jf.intel.com>
References: <20191013151427.11941-1-jolsa@kernel.org>
 <20191013151427.11941-4-jolsa@kernel.org>
 <20191014031054.GJ9933@tassilo.jf.intel.com>
 <20191014192049.GB15890@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014192049.GB15890@krava>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > We may need a COW operation for this (hopefully rare) case.
> 
> so the jitted mmaps are inserted into the data file
> and processed during report where they can overload
> existing maps - thats detected before addition in:
> 
>   thread__insert_map
>     map_groups__fixup_overlappings
>       - which uses COW way -> map__clone(map, false);
>         to create new map
> 
> other fixups to maps are being done only for kernel maps,
> where we dont have a problem, because there's only one copy

I assume the same is true for /tmp/perf-* processing?

Thanks for looking into it.



-Andi

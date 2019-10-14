Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA9EC4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 03:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F1C20640
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 03:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbfJNDKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 23:10:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:15106 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729626AbfJNDKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 23:10:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Oct 2019 20:10:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,294,1566889200"; 
   d="scan'208";a="201358850"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Oct 2019 20:10:54 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 878A4301AEA; Sun, 13 Oct 2019 20:10:54 -0700 (PDT)
Date:   Sun, 13 Oct 2019 20:10:54 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 3/3] perf tools: Make 'struct map_shared' truly shared
Message-ID: <20191014031054.GJ9933@tassilo.jf.intel.com>
References: <20191013151427.11941-1-jolsa@kernel.org>
 <20191013151427.11941-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013151427.11941-4-jolsa@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2019 at 05:14:27PM +0200, Jiri Olsa wrote:
> Andi reported that maps cloning is eating lot of memory and
> it's probably unnecessary, because they keep the same data.
> 
> Changing 'struct map_shared' to be a pointer inside 'struct map',
> so it can be shared on fork. Changing the map__clone function to
> actually share 'struct map_shared' for cloned maps.
> 
> The 'struct map_shared' carries its own refcnt counter, which is
> incremented when it's assigned to new 'struct map' and decremented
> when 'struct map' gets deleted in map__delete (its refcnt is 0).
> 
> This 'maps sharing' seems to save lot of heap for reports with
> many forks/cloned mmaps (over 60% in example below).

The one case I wasn't sure about is with JIT support. So if
a map gets modified with fixup/start from /tmp/perf-%d 
in one process, would it impact the other too?

We may need a COW operation for this (hopefully rare) case.

-Andi

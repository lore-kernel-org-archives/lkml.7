Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3300C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1D9215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbfJDXtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 19:49:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:42487 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbfJDXtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 19:49:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 16:49:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,258,1566889200"; 
   d="scan'208";a="205963748"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga001.fm.intel.com with ESMTP; 04 Oct 2019 16:49:03 -0700
Date:   Sat, 5 Oct 2019 07:48:45 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        jglisse@redhat.com, mike.kravetz@oracle.com, riel@surriel.com,
        khlebnikov@yandex-team.ru, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap.c: reuse mergeable anon_vma as parent when fork
Message-ID: <20191004234845.GB15415@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191004160632.30251-1-richardw.yang@linux.intel.com>
 <20191004161120.GI32665@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004161120.GI32665@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 09:11:20AM -0700, Matthew Wilcox wrote:
>On Sat, Oct 05, 2019 at 12:06:32AM +0800, Wei Yang wrote:
>> After this change, kernel build test reduces 20% anon_vma allocation.
>
>But does it have any effect on elapsed time or peak memory consumption?

Do the same kernel build test and record time:


Origin

real	2m50.467s
user	17m52.002s
sys	1m51.953s    

real	2m48.662s
user	17m55.464s
sys	1m50.553s    

real	2m51.143s
user	17m59.687s
sys	1m53.600s    


Patched

real	2m43.733s
user	17m25.705s
sys	1m41.791s    

real	2m47.146s
user	17m47.451s
sys	1m43.474s    

real	2m45.763s
user	17m38.230s
sys	1m42.102s    


For time in sys, it reduced 8.5%.

-- 
Wei Yang
Help you, Help me

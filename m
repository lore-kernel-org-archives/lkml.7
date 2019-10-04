Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C15C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD0020873
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbfJDWin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 18:38:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:63124 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728172AbfJDWim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 18:38:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 15:38:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,257,1566889200"; 
   d="scan'208";a="186395689"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga008.jf.intel.com with ESMTP; 04 Oct 2019 15:38:40 -0700
Date:   Sat, 5 Oct 2019 06:38:22 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        jglisse@redhat.com, mike.kravetz@oracle.com, riel@surriel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap.c: reuse mergeable anon_vma as parent when fork
Message-ID: <20191004223822.GB32588@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191004160632.30251-1-richardw.yang@linux.intel.com>
 <b5a8b1ba-c698-257f-854b-33f4fd922091@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5a8b1ba-c698-257f-854b-33f4fd922091@yandex-team.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 07:33:53PM +0300, Konstantin Khlebnikov wrote:
>On 04/10/2019 19.06, Wei Yang wrote:
>> In function __anon_vma_prepare(), we will try to find anon_vma if it is
>> possible to reuse it. While on fork, the logic is different.
>> 
>> Since commit 5beb49305251 ("mm: change anon_vma linking to fix
>> multi-process server scalability issue"), function anon_vma_clone()
>> tries to allocate new anon_vma for child process. But the logic here
>> will allocate a new anon_vma for each vma, even in parent this vma
>> is mergeable and share the same anon_vma with its sibling. This may do
>> better for scalability issue, while it is not necessary to do so
>> especially after interval tree is used.
>> 
>> Commit 7a3ef208e662 ("mm: prevent endless growth of anon_vma hierarchy")
>> tries to reuse some anon_vma by counting child anon_vma and attached
>> vmas. While for those mergeable anon_vmas, we can just reuse it and not
>> necessary to go through the logic.
>> 
>> After this change, kernel build test reduces 20% anon_vma allocation.
>> 
>
>Makes sense. This might have much bigger effect for scenarios when task
>unmaps holes in huge vma as red-zones between allocations and then forks.
>
>Acked-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>

Thanks


-- 
Wei Yang
Help you, Help me

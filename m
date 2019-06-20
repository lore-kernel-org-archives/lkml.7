Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0318C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A977E2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfFTVbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:31:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:57486 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfFTVbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 17:31:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 14:31:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,398,1557212400"; 
   d="scan'208";a="181950299"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jun 2019 14:31:48 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 8001B300FFA; Thu, 20 Jun 2019 14:31:48 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Nadav Amit <namit@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Borislav Petkov <bp@suse.de>,
        Toshi Kani <toshi.kani@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Kleen\, Andi" <andi.kleen@intel.com>
Subject: Re: [PATCH 3/3] resource: Introduce resource cache
References: <20190613045903.4922-1-namit@vmware.com>
        <20190613045903.4922-4-namit@vmware.com>
        <20190617215750.8e46ae846c09cd5c1f22fdf9@linux-foundation.org>
        <98464609-8F5A-47B9-A64E-2F67809737AD@vmware.com>
        <8072D878-BBF2-47E4-B4C9-190F379F6221@vmware.com>
        <CAErSpo5eiweMk2rfT81Kwnpd=MZsOa01prPo_rAFp-MZ9F2xdQ@mail.gmail.com>
        <CAPcyv4iAbWnWUT2d2VhnvuHvJE0-Vxgbf1TYtOPjkR6j3qROtw@mail.gmail.com>
Date:   Thu, 20 Jun 2019 14:31:48 -0700
In-Reply-To: <CAPcyv4iAbWnWUT2d2VhnvuHvJE0-Vxgbf1TYtOPjkR6j3qROtw@mail.gmail.com>
        (Dan Williams's message of "Wed, 19 Jun 2019 14:53:54 -0700")
Message-ID: <8736k49c57.fsf@firstfloor.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:
>
> The underlying issue is that the x86-PAT implementation wants to
> ensure that conflicting mappings are not set up for the same physical
> address. This is mentioned in the developer manuals as problematic on
> some cpus. Andi, is lookup_memtype() and track_pfn_insert() still
> relevant?

There have been discussions about it in the past, and the right answer
will likely differ for different CPUs: But so far the official answer
for Intel CPUs is that these caching conflicts should be avoided.

So I guess the cache in the original email makes sense for now.

-Andi


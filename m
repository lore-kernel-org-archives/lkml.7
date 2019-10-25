Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B59CA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 03:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3727E21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 03:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392122AbfJYDat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 23:30:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:25912 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390875AbfJYDas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 23:30:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 20:30:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,227,1569308400"; 
   d="scan'208";a="398638072"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by fmsmga005.fm.intel.com with ESMTP; 24 Oct 2019 20:30:46 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jonathan Adams <jwadams@google.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Williams\, Dan J" <dan.j.williams@intel.com>,
        "Verma\, Vishal L" <vishal.l.verma@intel.com>,
        Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [RFC] Memory Tiering
References: <c3d6de4d-f7c3-b505-2e64-8ee5f70b2118@intel.com>
        <CA+VK+GMAqMVXKQqjGzSj9P+-TKr_Jn6qQ1cHSyxhDsoChorm_w@mail.gmail.com>
        <bab0848c-3229-bcb5-8921-d150939a7ce2@intel.com>
Date:   Fri, 25 Oct 2019 11:30:46 +0800
In-Reply-To: <bab0848c-3229-bcb5-8921-d150939a7ce2@intel.com> (Dave Hansen's
        message of "Thu, 24 Oct 2019 09:33:01 -0700")
Message-ID: <87o8y5h57d.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@intel.com> writes:

> On 10/23/19 4:11 PM, Jonathan Adams wrote:
>> we would have a bidirectional attachment:
>> 
>> A is marked "move cold pages to" B
>> B is marked "move hot pages to" A
>> C is marked "move cold pages to" D
>> D is marked "move hot pages to" C
>> 
>> By using autonuma for moving PMEM pages back to DRAM, you avoid
>> needing the B->A  & D->C links, at the cost of migrating the pages
>> back synchronously at pagefault time (assuming my understanding of how
>> autonuma works is accurate).
>> 
>> Our approach still lets you have multiple levels of hierarchy for a
>> given socket (you could imaging an "E" node with the same relation to
>> "B" as "B" has to "A"), but doesn't make it easy to represent (say) an
>> "E" which was equally close to all sockets (which I could imagine for
>> something like remote memory on GenZ or what-have-you), since there
>> wouldn't be a single back link; there would need to be something like
>> your autonuma support to achieve that.
>> 
>> Does that make sense?
>
> Yes, it does.  We've actually tried a few other approaches separate from
> autonuma-based ones for promotion.  For some of those, we have a
> promotion path which is separate from the demotion path.
>
> That said, I took a quick look to see what the autonuma behavior was and
> couldn't find anything obvious.  Ying, when moving a slow page due to
> autonuma, do we move it close to the CPU that did the access, or do we
> promote it to the DRAM close to the slow memory where it is now?

Now in autonuma, the slow page will be moved to the CPU that did the
access.  So I think Jonathan's requirement has been covered already.

Best Regards,
Huang, Ying

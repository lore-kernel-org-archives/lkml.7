Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E548C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFB720652
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404569AbfFKIOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 04:14:32 -0400
Received: from foss.arm.com ([217.140.110.172]:54794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403996AbfFKIOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 04:14:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C22C346;
        Tue, 11 Jun 2019 01:14:31 -0700 (PDT)
Received: from [10.162.43.135] (p8cg001049571a15.blr.arm.com [10.162.43.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 706593F73C;
        Tue, 11 Jun 2019 01:14:28 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] mm: soft-offline: return -EBUSY if
 set_hwpoison_free_buddy_page() fails
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "Chen, Jerry T" <jerry.t.chen@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1560154686-18497-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1560154686-18497-2-git-send-email-n-horiguchi@ah.jp.nec.com>
 <8e8e6afc-cddb-9e79-c8ae-c2814b73cbe9@oracle.com>
 <20190611005715.GB5187@hori.linux.bs1.fc.nec.co.jp>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <67bb5891-d0be-ffb8-3161-092c8167a960@arm.com>
Date:   Tue, 11 Jun 2019 13:44:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190611005715.GB5187@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/11/2019 06:27 AM, Naoya Horiguchi wrote:
> On Mon, Jun 10, 2019 at 05:19:45PM -0700, Mike Kravetz wrote:
>> On 6/10/19 1:18 AM, Naoya Horiguchi wrote:
>>> The pass/fail of soft offline should be judged by checking whether the
>>> raw error page was finally contained or not (i.e. the result of
>>> set_hwpoison_free_buddy_page()), but current code do not work like that.
>>> So this patch is suggesting to fix it.
>>>
>>> Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>>> Fixes: 6bc9b56433b76 ("mm: fix race on soft-offlining")
>>> Cc: <stable@vger.kernel.org> # v4.19+
>>
>> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> Thank you, Mike.
> 
>>
>> To follow-up on Andrew's comment/question about user visible effects.  Without
>> this fix, there are cases where madvise(MADV_SOFT_OFFLINE) may not offline the
>> original page and will not return an error.
> 
> Yes, that's right.

Then should this be included in the commit message as well ?

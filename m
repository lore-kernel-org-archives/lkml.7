Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAB5C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D1720851
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfFNF11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 01:27:27 -0400
Received: from foss.arm.com ([217.140.110.172]:55028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfFNF11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 01:27:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 937E2367;
        Thu, 13 Jun 2019 22:27:26 -0700 (PDT)
Received: from [10.162.41.168] (p8cg001049571a15.blr.arm.com [10.162.41.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CC353F246;
        Thu, 13 Jun 2019 22:27:22 -0700 (PDT)
Subject: Re: [PATCH] mm/vmalloc: Check absolute error return from
 vmap_[p4d|pud|pmd|pte]_range()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Roman Penyaev <rpenyaev@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1560413551-17460-1-git-send-email-anshuman.khandual@arm.com>
 <7cc6a46c50c2008bfb968c5e48af5a49@suse.de>
 <406afc57-5a77-a77c-7f71-df1e6837dae1@arm.com>
 <20190613153141.GJ32656@bombadil.infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <4b5c0b18-c670-3631-f47f-3f80bae8fe4b@arm.com>
Date:   Fri, 14 Jun 2019 10:57:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190613153141.GJ32656@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/13/2019 09:01 PM, Matthew Wilcox wrote:
> On Thu, Jun 13, 2019 at 08:51:17PM +0530, Anshuman Khandual wrote:
>> acceptable ? What we have currently is wrong where vmap_pmd_range() could
>> just wrap EBUSY as ENOMEM and send up the call chain.
> 
> It's not wrong.  We do it in lots of places.  Unless there's a caller
> which really needs to know the difference, it's often better than
> returning the "real error".

I can understand the fact that because there are no active users of this
return code, the current situation has been alright. But then I fail to
understand how can EBUSY be made ENOMEM and let the caller to think that
vmap_page_rage() failed because of lack of memory when it is clearly not
the case. It is really surprising how it can be acceptable inside kernel
(init_mm) page table functions which need to be thorough enough.

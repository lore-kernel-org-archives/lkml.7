Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD82C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6533C2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732734AbfFMPVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:21:09 -0400
Received: from foss.arm.com ([217.140.110.172]:42282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732104AbfFMPVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:21:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77F3B367;
        Thu, 13 Jun 2019 08:21:02 -0700 (PDT)
Received: from [10.162.40.191] (p8cg001049571a15.blr.arm.com [10.162.40.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15B0F3F718;
        Thu, 13 Jun 2019 08:20:58 -0700 (PDT)
Subject: Re: [PATCH] mm/vmalloc: Check absolute error return from
 vmap_[p4d|pud|pmd|pte]_range()
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1560413551-17460-1-git-send-email-anshuman.khandual@arm.com>
 <7cc6a46c50c2008bfb968c5e48af5a49@suse.de>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <406afc57-5a77-a77c-7f71-df1e6837dae1@arm.com>
Date:   Thu, 13 Jun 2019 20:51:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7cc6a46c50c2008bfb968c5e48af5a49@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/13/2019 03:03 PM, Roman Penyaev wrote:
> On 2019-06-13 10:12, Anshuman Khandual wrote:
>> vmap_pte_range() returns an -EBUSY when it encounters a non-empty PTE. But
>> currently vmap_pmd_range() unifies both -EBUSY and -ENOMEM return code as
>> -ENOMEM and send it up the call chain which is wrong. Interestingly enough
>> vmap_page_range_noflush() tests for the absolute error return value from
>> vmap_p4d_range() but it does not help because -EBUSY has been merged with
>> -ENOMEM. So all it can return is -ENOMEM. Fix this by testing for absolute
>> error return from vmap_pmd_range() all the way up to vmap_p4d_range().
> 
> I could not find any real external caller of vmap API who really cares
> about the errno, and frankly why they should?  This is allocation path,

map_vm_area() which is an exported symbol suppose to provide the right
error code regardless whether it's current users care for it or not.

> allocation failed - game over.  When you step on -EBUSY case something
> has gone completely wrong in your kernel, you get a big warning in
> your dmesg and it is already does not matter what errno you get.

Its true that vmap_pte_range() does warn during error conditions. But if
we really dont care about error return code then we should just remove
specific error details (ENOMEM/EBUSY) and instead replace them with simple
boolean false/true or (0/1/-1) return values at each level. Will that be
acceptable ? What we have currently is wrong where vmap_pmd_range() could
just wrap EBUSY as ENOMEM and send up the call chain.

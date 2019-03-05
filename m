Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F013AC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FE320675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfCEVmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:42:02 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:56345 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfCEVmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 16:42:02 -0500
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.11] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 49734FF804;
        Tue,  5 Mar 2019 21:41:56 +0000 (UTC)
From:   Alex Ghiti <alex@ghiti.fr>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Rientjes <rientjes@google.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4] mm/hugetlb: Fix unsigned overflow in
 __nr_hugepages_store_common()
References: <388cbbf5-7086-1d04-4c49-049021504b9d@oracle.com>
 <alpine.DEB.2.21.1902241913000.34632@chino.kir.corp.google.com>
 <8c167be7-06fa-a8c0-8ee7-0bfad41eaba2@oracle.com>
 <13400ee2-3d3b-e5d6-2d78-a770820417de@oracle.com>
 <alpine.DEB.2.21.1902251116180.167839@chino.kir.corp.google.com>
 <5C74A2DA.1030304@huawei.com>
 <alpine.DEB.2.21.1902252220310.40851@chino.kir.corp.google.com>
 <e2bded2f-40ca-c308-5525-0a21777ed221@oracle.com>
 <20190226143620.c6af15c7c897d3362b191e36@linux-foundation.org>
 <086c4a4b-a37d-f144-00c0-d9a4062cc5fe@oracle.com>
 <20190305000402.GA4698@hori.linux.bs1.fc.nec.co.jp>
 <8f3aede3-c07e-ac15-1577-7667e5b70d2f@oracle.com>
 <20190305131643.94aa32165fecdb53a1109028@linux-foundation.org>
 <9a23edc9-b2e5-839e-30d6-0723cb98246d@oracle.com>
Message-ID: <8d77e5ba-3de6-801c-8497-6a219665bc57@ghiti.fr>
Date:   Tue, 5 Mar 2019 16:41:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <9a23edc9-b2e5-839e-30d6-0723cb98246d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/19 4:35 PM, Mike Kravetz wrote:
> On 3/5/19 1:16 PM, Andrew Morton wrote:
>> On Mon, 4 Mar 2019 20:15:40 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>>> Andrew, this is on top of Alexandre Ghiti's "hugetlb: allow to free gigantic
>>> pages regardless of the configuration" patch.  Both patches modify
>>> __nr_hugepages_store_common().  Alex's patch is going to change slightly
>>> in this area.
>> OK, thanks, I missed that.  Are the changes significant?
>>
> No, changes should be minor.  IIRC, just checking for a condition in an
> error path.
I will send the v5 of this patch tomorrow, I was waiting for architecture
maintainer remarks. I still miss sh, but I'm confident on this change.

Alex

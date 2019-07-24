Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4819C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B9E20693
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ndoC/wHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfGXURa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:17:30 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3155 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbfGXTuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:50:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d38b6730000>; Wed, 24 Jul 2019 12:50:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 24 Jul 2019 12:50:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 24 Jul 2019 12:50:10 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Jul
 2019 19:50:10 +0000
Subject: Re: [PATCH 2/2] mm/hmm: make full use of walk_page_range()
To:     Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@lst.de>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <20190723233016.26403-1-rcampbell@nvidia.com>
 <20190723233016.26403-3-rcampbell@nvidia.com> <20190724065146.GA2061@lst.de>
 <20190724115338.GA30264@mellanox.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <098df586-0713-1aaa-e546-5dc39ec30341@nvidia.com>
Date:   Wed, 24 Jul 2019 12:50:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190724115338.GA30264@mellanox.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563997811; bh=o1DvH7PppcliFCYzQ16HV/ZAX4qVLsHxUniBpxQa/jY=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ndoC/wHwyfVcpAyH7LNSBQ5MX2jPUvphaKjtuXWIn8VrEDengx2WT/DuMJm+WRXZ3
         PiR4+0PG/Pz7ee56d8OyGQsZxJrZ5A2V7MZNvqZFis7ml6ohw5wa2st0Jos9Y5kzNg
         g7l59/dvj6EoVy3z/aqFWJkaHBONxVgSCLNiVzM1kbOQVnxb90IhOdJwRwq7tIF3Nz
         VTUbGNfNBtyYlE2MTJQqJo5UKSiGbulBDq2IqNDlhVCGvx3Zaw1r9V4fRXoJzXuuX4
         XQ0Dj9tUsa6iuS/8rbbUIOWUSVWpCP9NT4pEBjYNLvTsPg7WnHGyQ1yAE8U20LnIxq
         qc3g1j1fB5DSg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/24/19 4:53 AM, Jason Gunthorpe wrote:
> On Wed, Jul 24, 2019 at 08:51:46AM +0200, Christoph Hellwig wrote:
>> On Tue, Jul 23, 2019 at 04:30:16PM -0700, Ralph Campbell wrote:
>>> hmm_range_snapshot() and hmm_range_fault() both call find_vma() and
>>> walk_page_range() in a loop. This is unnecessary duplication since
>>> walk_page_range() calls find_vma() in a loop already.
>>> Simplify hmm_range_snapshot() and hmm_range_fault() by defining a
>>> walk_test() callback function to filter unhandled vmas.
>>
>> I like the approach a lot!
>>
>> But we really need to sort out the duplication between hmm_range_fault
>> and hmm_range_snapshot first, as they are basically the same code.  I
>> have patches here:
>>
>> http://git.infradead.org/users/hch/misc.git/commitdiff/a34ccd30ee8a8a3111d9e91711c12901ed7dea74
>>
>> http://git.infradead.org/users/hch/misc.git/commitdiff/81f442ebac7170815af7770a1efa9c4ab662137e
> 
> Yeah, that is a straightforward improvement, maybe Ralph should grab
> these two as part of his series?

Sure, no problem.
I'll add them in v2 when I fix the other issues in the series.

>> That being said we don't really have any users for the snapshot mode
>> or non-blocking faults, and I don't see any in the immediate pipeline
>> either.
> 
> If this code was production ready I'd use it in ODP right away.
> 
> When we first create a ODP MR we'd want to snapshot to pre-load the
> NIC tables with something other than page fault, but not fault
> anything.
> 
> This would be a big performance improvement for ODP.
> 
> Jason
> 

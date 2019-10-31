Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A595BCA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 06:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C912083E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 06:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfJaGzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 02:55:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5235 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726479AbfJaGzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 02:55:15 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E01DC2C04A56620C2F94;
        Thu, 31 Oct 2019 14:55:12 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 31 Oct
 2019 14:55:07 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: bio_alloc should never fail
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Gao Xiang <hsiangkao@aol.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20191030035518.65477-1-gaoxiang25@huawei.com>
 <20aa40bd-280d-d223-9f73-d9ed7dbe4f29@huawei.com>
 <20191030091542.GA24976@architecture4>
 <19a417e6-8f0e-564e-bc36-59bfc883ec16@huawei.com>
 <20191030104345.GB170703@architecture4> <20191030151444.GC16197@mit.edu>
 <20191030155020.GA3953@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20191030162243.GA18729@mit.edu>
 <20191030163313.GB34056@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0ef44e01-13a6-2519-bce2-075ca14a0cb9@huawei.com>
Date:   Thu, 31 Oct 2019 14:55:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191030163313.GB34056@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/31 0:33, Jaegeuk Kim wrote:
> On 10/30, Theodore Y. Ts'o wrote:
>> On Wed, Oct 30, 2019 at 11:50:37PM +0800, Gao Xiang wrote:
>>>
>>> So I'm curious about the original issue in commit 740432f83560
>>> ("f2fs: handle failed bio allocation"). Since f2fs manages multiple write
>>> bios with its internal fio but it seems the commit is not helpful to
>>> resolve potential mempool deadlock (I'm confused since no calltrace,
>>> maybe I'm wrong)...
>>
>> Two possibilities come to mind.  (a) It may be that on older kernels
>> (when f2fs is backported to older Board Support Package kernels from
>> the SOC vendors) didn't have the bio_alloc() guarantee, so it was
>> necessary on older kernels, but not on upstream, or (b) it wasn't
>> *actually* possible for bio_alloc() to fail and someone added the
>> error handling in 740432f83560 out of paranoia.
> 
> Yup, I was checking old device kernels but just stopped digging it out.
> Instead, I hesitate to apply this patch since I can't get why we need to
> get rid of this code for clean-up purpose. This may be able to bring
> some hassles when backporting to android/device kernels.

Jaegeuk,

IIUC, as getting hint from commit 740432f83560, are we trying to fix potential
deadlock like this?

In low memory scenario:

- f2fs_write_checkpoint()
 - block_operations()
  - f2fs_sync_node_pages()
   step 1) flush cold nodes, allocate new bio from mempool
   - bio_alloc()
    - mempool_alloc()
   step 2) flush hot nodes, allocate a bio from mempool
   - bio_alloc()
    - mempool_alloc()
   step 3) flush warm nodes, be stuck in below call path
   - bio_alloc()
    - mempool_alloc()
     - loop to wait mempool element release, as we only
       reserved memory for two bio allocation, however above
       allocated two bios never getting submitted.

#define BIO_POOL_SIZE 2

If so, we need avoid using bioset, or introducing private bioset, at least
enlarging mempool size to three (adapt to total log headers' number)...

Thanks,

> 
>>
>> (Hence my suggestion that in the ext4 version of the patch, we add a
>> code comment justifying why there was no error checking, to make it
>> clear that this was a deliberate choice.  :-)
>>
>> 						- Ted
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 

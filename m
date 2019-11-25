Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50100C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 23:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE3620740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 23:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="f8JuR9ii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfKYXpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 18:45:19 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3045 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfKYXpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 18:45:18 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ddc67910000>; Mon, 25 Nov 2019 15:45:21 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 25 Nov 2019 15:45:18 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 25 Nov 2019 15:45:18 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 Nov
 2019 23:45:17 +0000
Subject: Re: [PATCH] bpf: fix a no-mmu build failure by providing a stub
 allocator
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
CC:     Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
References: <20191125234103.1699950-1-jhubbard@nvidia.com>
 <20191125234103.1699950-2-jhubbard@nvidia.com>
 <8c4d892a-73b5-b4d5-be15-bc81e8297de9@iogearbox.net>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <735f27ed-65dd-d132-e6b4-20ba5749876c@nvidia.com>
Date:   Mon, 25 Nov 2019 15:45:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8c4d892a-73b5-b4d5-be15-bc81e8297de9@iogearbox.net>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574725521; bh=WMDeAcbZMWSPJMBANRYNfknq2XJvnNPf3T3fbDniwfE=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=f8JuR9ii0ljL+Rl9x2Epbdw3yXw2DiLEhV4ImlGOXOb2aEMhIxpnhMyxcOodL7KKS
         3sCS/OSXJ5rBN910/7NLXae6d1kMXDHY5I8Kp9T/grvpttQkqodE1Gyf+ocjE0qbm/
         pt8XKSvPtWYzQYmRMdGFjJUZ7I8S8qcMXcq0UmLVrSuhdPGoDnXt4HIkned6uY3L5k
         m9LPTdpvBxb5/wUWAmik2+rrxlN1Nnohx+fIREjzS3SOYZkLw3J8qLVSLmrswxvmDU
         PBFALk1N8P/TjfFzmIP09qtwosruAeG9YZTGaW4P455xmvL07vLGmhaDZ5PMqTLN6c
         8MyrithA3laFg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/19 3:43 PM, Daniel Borkmann wrote:
> On 11/26/19 12:41 AM, John Hubbard wrote:
>> Commit fc9702273e2e ("bpf: Add mmap() support for BPF_MAP_TYPE_ARRAY")
>> added code that calls vmalloc_user_node_flags() and therefore requires
>> mm/vmalloc.c. However, that file is not built for the !CONFIG_MMU case.
>> This leads to a build failure when using ARM with the config provided
>> by at least one particular kbuild test robot report [1].
>>
>> [1] https://lore/kernel.org/r/201911251639.UWS3hE3Y%lkp@intel.com
>>
>> Fix the build by providing a stub function for __bpf_map_area_alloc().
>>
>> Fixes: fc9702273e2e ("bpf: Add mmap() support for BPF_MAP_TYPE_ARRAY")
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Cc: Andrii Nakryiko <andriin@fb.com>
>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>> Cc: Song Liu <songliubraving@fb.com>
>> Cc: John Fastabend <john.fastabend@gmail.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> 
> Thanks for the patch, already fixed via:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=ed81745a4c96841937f1da35c0eb66ac312e1480

OK, good, that's a better fix, too. Appreciate the quick answers!


thanks,
-- 
John Hubbard
NVIDIA

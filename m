Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5332C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2C4229F9
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfGYScr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:32:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:57967 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfGYScr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:32:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 11:32:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,307,1559545200"; 
   d="scan'208";a="181555504"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.202.8]) ([10.254.202.8])
  by orsmga002.jf.intel.com with ESMTP; 25 Jul 2019 11:32:45 -0700
Subject: Re: linux-next: build failure after merge of the rdma tree
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Doug Ledford <dledford@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kamenee Arumugam <kamenee.arumugam@intel.com>
References: <20190708125725.25c38fa7@canb.auug.org.au>
 <20190708160823.GH23966@mellanox.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <0ccdc302-210f-7551-fcd4-f2bd453436a2@intel.com>
Date:   Thu, 25 Jul 2019 14:32:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190708160823.GH23966@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/2019 12:08 PM, Jason Gunthorpe wrote:
> On Mon, Jul 08, 2019 at 12:57:25PM +1000, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the rdma tree, today's linux-next build (x86_64
>> allmodconfig) failed like this:
>>
>> In file included from <command-line>:32:
>> ./usr/include/rdma/rvt-abi.h:13:10: fatal error: rdma/ib_verbs.h: No such file or directory
>>   #include <rdma/ib_verbs.h>
>>            ^~~~~~~~~~~~~~~~~
>>
>> Caused by commits
>>
>>    dabac6e460ce ("IB/hfi1: Move receive work queue struct into uapi directory")
>>
>> interacting with commit
>>
>>    0c422a3d4e1b ("kbuild: compile-test exported headers to ensure they are self-contained")
>>
>> from the kbuild tree.
>>
>> You can't reference the include/linux headers from uapi headers ...
>>
>> I have used the rmda tree from 20190628 again today (given the previous
>> errors).
> 
> This is a bug that will break our userspace package too, we must fix
> it, very happy to see the functionality in "kbuild: compile-test
> exported headers to ensure they are self-contained"
> 
> Dennis, you must put stuff in rdma-core and run the rdma-core CI if
> you are messing with the uapi headers.

Sorry for the delay, I've been on vacation the past few weeks, just now 
seeing this...

I'm pretty sure Kamenee did when she prepared the patches in the first 
place and sent the PR. Not sure where things went off the rails but 
we'll be more careful in the future. Thanks for fixing.

-Denny

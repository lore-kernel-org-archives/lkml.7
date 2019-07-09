Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE69C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40AB72086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfGICjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 22:39:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:35075 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfGICjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 22:39:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 19:39:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,468,1557212400"; 
   d="scan'208";a="165631313"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.239.196.152]) ([10.239.196.152])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jul 2019 19:39:21 -0700
Subject: Re: [LKP] [SUNRPC] 0472e47660: fsmark.app_overhead 16.0% regression
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "rong.a.chen@intel.com" <rong.a.chen@intel.com>
Cc:     "lkp@01.org" <lkp@01.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190520055434.GZ31424@shao2-debian>
 <f1abba58-5fd2-5f26-74cc-f72724cfa13f@linux.intel.com>
 <9a07c589f955e5af5acc0fa09a16a3256089e764.camel@hammerspace.com>
 <d796ac23-d5d6-cdfa-89c8-536e9496b551@linux.intel.com>
 <9753a9a4a82943f6aacc2bfb0f93efc5f96bcaa5.camel@hammerspace.com>
 <2bbe636a-14f1-4592-d1f9-a9f765a02939@linux.intel.com>
 <81fb0e7d-1879-9267-83da-4671fec50920@linux.intel.com>
 <DM5PR13MB1851813BBEA446E25C5001C2B8F60@DM5PR13MB1851.namprd13.prod.outlook.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <e29f82e0-6847-b264-300b-130bb31399d1@linux.intel.com>
Date:   Tue, 9 Jul 2019 10:39:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <DM5PR13MB1851813BBEA446E25C5001C2B8F60@DM5PR13MB1851.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

On 7/8/2019 7:44 PM, Trond Myklebust wrote:
> I've asked several times now about how to interpret your results. As far 
> as I can tell from your numbers, the overhead appears to be entirely 
> contained in the NUMA section of your results.
> IOW: it would appear to be a scheduling overhead due to NUMA. I've been 
> asking whether or not that is a correct interpretation of the numbers 
> you published.
Thanks for your feedback. I used the same hardware and the same test 
parameters to test the two commits:
    e791f8e938 ("SUNRPC: Convert xs_send_kvec() to use iov_iter_kvec()")
    0472e47660 ("SUNRPC: Convert socket page send code to use iov_iter()")

If it is caused by NUMA, why only commit 0472e47660 throughput is 
decreased? The filesystem we test is NFS, commit 0472e47660 is related 
with the network, could you help to check if have any other clues for 
the regression. Thanks.

-- 
Zhengjun Xing

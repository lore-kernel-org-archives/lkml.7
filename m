Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063B8C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CB02189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfGCPyI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 11:54:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:28237 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbfGCPyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 11:54:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 08:54:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,446,1557212400"; 
   d="scan'208";a="315615600"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.63])
  by orsmga004.jf.intel.com with ESMTP; 03 Jul 2019 08:54:05 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alexander.shishkin@linux.intel.com
Subject: Re: [GIT PULL 1/9] intel_th: msu: Fix unused variable warning on arm64 platform
In-Reply-To: <20190703154551.GA19371@kroah.com>
References: <20190627125152.54905-1-alexander.shishkin@linux.intel.com> <20190627125152.54905-2-alexander.shishkin@linux.intel.com> <20190703154551.GA19371@kroah.com>
Date:   Wed, 03 Jul 2019 18:54:05 +0300
Message-ID: <87muhvt8pu.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Thu, Jun 27, 2019 at 03:51:44PM +0300, Alexander Shishkin wrote:
>> From: Shaokun Zhang <zhangshaokun@hisilicon.com>
>> 
>> Commit ba39bd8306057 ("intel_th: msu: Switch over to scatterlist")
>> introduced the following warnings on non-x86 architectures, as a result
>> of reordering the multi mode buffer allocation sequence:
>> 
>> > drivers/hwtracing/intel_th/msu.c: In function ‘msc_buffer_win_alloc’:
>> > drivers/hwtracing/intel_th/msu.c:783:21: warning: unused variable ‘i’
>> > [-Wunused-variable]
>> > int ret = -ENOMEM, i;
>> >                    ^
>> > drivers/hwtracing/intel_th/msu.c: In function ‘msc_buffer_win_free’:
>> > drivers/hwtracing/intel_th/msu.c:863:6: warning: unused variable ‘i’
>> > [-Wunused-variable]
>> > int i;
>> >     ^
>> 
>> Fix this compiler warning by factoring out set_memory sequences and making
>> them x86-only.
>> 
>> Suggested-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>> Fixes: ba39bd8306057 ("intel_th: msu: Switch over to scatterlist")
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> ---
>>  drivers/hwtracing/intel_th/msu.c | 40 +++++++++++++++++++++-----------
>>  1 file changed, 27 insertions(+), 13 deletions(-)
>
> Does not apply to my tree :(

It's the same one as the one in the fixes series. I just put it here for
completeness.

Regards,
--
Alex

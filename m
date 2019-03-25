Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2121BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBD520811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbfCYKEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:04:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:29025 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730362AbfCYKEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:04:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 03:04:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="134499773"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by fmsmga008.fm.intel.com with ESMTP; 25 Mar 2019 03:04:00 -0700
Subject: Re: [bug report][stable] perf probe: failed to add events
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        luto@kernel.org, Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Xu Yu <xuyu@linux.alibaba.com>, peterz@infradead.org,
        mingo@redhat.com
References: <1a4240a8-288b-45d0-073d-d5cb8f0c63eb@linux.alibaba.com>
 <20190226090505.GA24409@kroah.com>
 <c7ccd9cb-3a66-98a9-faa1-7ee5ed20ff88@linux.alibaba.com>
 <20190226130802.GA10343@kroah.com> <20190226142009.GC26786@kernel.org>
 <3b233ff2-e87a-1c61-d516-6c4cdecb4f01@intel.com>
 <8e798942-0e71-c88f-866f-88e55177e286@linux.alibaba.com>
 <fea29ce5-b410-27cc-045e-feeecbc4a7f5@intel.com>
 <20190321101029.GA3650@kroah.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <cf860b89-5678-c113-f8b1-bfb4d19bc6fb@intel.com>
Date:   Mon, 25 Mar 2019 12:02:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190321101029.GA3650@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/19 12:10 PM, Greg KH wrote:
> On Thu, Feb 28, 2019 at 09:19:08AM +0200, Adrian Hunter wrote:
>> On 28/02/19 4:07 AM, Joseph Qi wrote:
>>> Hi Adrian,
>>>
>>> On 19/2/27 20:39, Adrian Hunter wrote:
>>>> Seems to be fixed by this:
>>>>
>>>> From: Adrian Hunter <adrian.hunter@intel.com>
>>>> Date: Wed, 27 Feb 2019 05:35:25 +0200
>>>> Subject: [PATCH] perf probe: Fix getting the kernel map
>>>>
>>>> Since commit 4d99e4136580 ("perf machine: Workaround missing maps for x86
>>>> PTI entry trampolines"), perf tools has been creating more than one kernel
>>>> map, however 'perf probe' assumed there could be only one.
>>>>
>>>> Fix by using machine__kernel_map() to get the main kernel map.
>>>>
>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>> Fixes: 4d99e4136580 ("perf machine: Workaround missing maps for x86 PTI entry trampolines")
>>>
>>> Below is my investigation result before, FYI.
>>> the first bad commit (v4.18 ~ v4.19):
>>> d83212d5dd67 kallsyms, x86: Export addresses of PTI entry trampolines
>>
>> Yes we should add a fixes tag for that also.
> 
> So, what do I need to do here for the stable tree(s) to resolve this
> issue?

Nothing.

Patch was re-sent with a stable tag so will go through like normal:

	https://lore.kernel.org/lkml/2ed432de-e904-85d2-5c36-5897ddc5b23b@intel.com/


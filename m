Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3D3C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 04:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28D42464E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 04:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLFEjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 23:39:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:15890 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfLFEjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 23:39:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 20:39:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,282,1571727600"; 
   d="scan'208";a="201992748"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 05 Dec 2019 20:39:54 -0800
Received: from [10.226.38.71] (unknown [10.226.38.71])
        by linux.intel.com (Postfix) with ESMTP id B08735802C8;
        Thu,  5 Dec 2019 20:39:51 -0800 (PST)
Subject: Re: [PATCH v1 1/2] clk: intel: Add CGU clock driver for a new SoC
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        robhkernel.org@smile.fi.intel.com, mark.rutland@arm.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com
References: <cover.1566975410.git.rahul.tanwar@linux.intel.com>
 <6a3c26bc6e25d883686287883528dbde30725922.1566975410.git.rahul.tanwar@linux.intel.com>
 <20190828150951.GS2680@smile.fi.intel.com>
 <e4a1fd0a-b179-92dd-fb81-22d9d7465a33@linux.intel.com>
 <20190902122030.GE2680@smile.fi.intel.com>
 <20190902122454.GF2680@smile.fi.intel.com>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <db9b8978-b9ae-d1bf-2477-78a99b82367a@linux.intel.com>
Date:   Fri, 6 Dec 2019 12:39:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902122454.GF2680@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andy,

On 2/9/2019 8:24 PM, Andy Shevchenko wrote:
> On Mon, Sep 02, 2019 at 03:20:30PM +0300, Andy Shevchenko wrote:
>> On Mon, Sep 02, 2019 at 03:43:13PM +0800, Tanwar, Rahul wrote:
>>> On 28/8/2019 11:09 PM, Andy Shevchenko wrote:
>>>> On Wed, Aug 28, 2019 at 03:00:17PM +0800, Rahul Tanwar wrote:
>>>> Does val == 0 follows the table, i.e. makes div == 1?
>>> 0 val means output clock is ref clock i.e. div ==1. Agree that adding
>>> .val = 0, .div =1 entry will make it more clear & complete.
>>>
>>>>> +	{ .val = 0, .div = 1 },
>>>>> +	{ .val = 1, .div = 2 },
>>>>> +	{ .val = 2, .div = 3 },
>> 1
>>
>>>>> +	{ .val = 3, .div = 4 },
>>>>> +	{ .val = 4, .div = 5 },
>>>>> +	{ .val = 5, .div = 6 },
>> 1
>>
>>>>> +	{ .val = 6, .div = 8 },
>>>>> +	{ .val = 7, .div = 10 },
>>>>> +	{ .val = 8, .div = 12 },
>> 2
>>
>>>>> +	{ .val = 9, .div = 16 },
>>>>> +	{ .val = 10, .div = 20 },
>>>>> +	{ .val = 11, .div = 24 },
>> 4
>>
>>>>> +	{ .val = 12, .div = 32 },
>>>>> +	{ .val = 13, .div = 40 },
>>>>> +	{ .val = 14, .div = 48 },
>> 8
>>
>>>>> +	{ .val = 15, .div = 64 },
>> 16
>>
>>
>> So, now we see the pattern:
>>
>> 	div = val < 3 ? (val + 1) : (1 << ((val - 3) / 3));
> It's not complete, but I think you got the idea.
>
>> So, can we eliminate table?

In the desperation to eliminate table, below is what i can come up with:

        struct clk_div_table div_table[16];
        int i, j;

        for (i = 0; i < 16; i++)
                div_table[i].val = i;

        for (i = 0, j=0; i < 16; i+=3, j++) {
                div_table[i].div = (i == 0) ? (1 << j) : (1 << (j + 1));
                if (i == 15)
                        break;

                div_table[i + 1].div = (i == 0) ? ((1 << j) + 1) :
                                        (1 << (j + 1)) + (1 << (j - 1));
                div_table[i + 2].div = (3 << j);
        }

To me, table still looks a better approach. Also, table is more extendable &
consistent w.r.t. clk framework & other referenced clk drivers.

Whats your opinion ?

Regards,
Rahul


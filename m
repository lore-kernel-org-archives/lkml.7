Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE72ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E683220663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbfJNJlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 05:41:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:45375 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730916AbfJNJlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:41:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 02:41:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,295,1566889200"; 
   d="scan'208";a="194175820"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 14 Oct 2019 02:41:04 -0700
Received: from [10.226.39.36] (unknown [10.226.39.36])
        by linux.intel.com (Postfix) with ESMTP id DA73B580108;
        Mon, 14 Oct 2019 02:41:01 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] reset: Reset controller driver for Intel LGM SoC
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>,
        cheol.yong.kim@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        robh@kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
References: <34336c9a-8e87-8f84-2ae8-032b7967928f@linux.intel.com>
 <CAFBinCDfM3ssHisMBKXZUFkfoAFw51TaUuKt_aBgtD-mN+9fhg@mail.gmail.com>
 <657d796d-cb1b-472d-fe67-f7b9bf12fd79@linux.intel.com>
 <CAFBinCA5sRp1-siqZqJzFL2nuD3BtjrbD65QtpWbnTgtPNXY1A@mail.gmail.com>
 <cebd8f1d-90ab-87e7-9a34-f5c760688ce5@linux.intel.com>
 <CAFBinCCXo50OX6=8Fz-=nRKuELU_fMOCX=z6iwAcw0_Tfgn1ug@mail.gmail.com>
 <da347f1c-864c-7d68-33c8-045e46651f45@linux.intel.com>
 <CAFBinCDhLYmiORvHdZJAN5cuUjc6eWJK5n9Qg26B0dEhhqUqVQ@mail.gmail.com>
 <389f360a-a993-b9a8-4b50-ad87bcfec767@linux.intel.com>
 <CAFBinCBwrTajCrSf-UqZY5gHqUSn0UTmbc_TLPNVZrPyY5jpOA@mail.gmail.com>
 <20191003141955.zi5wqjqf4wa7lhv7@pengutronix.de>
 <CAFBinCAEzBk7tT5M-F3H4kLnKURRkK2oSSAmKkrjAn7_wdAROA@mail.gmail.com>
 <1570550166.18914.12.camel@pengutronix.de>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <7db54ec8-b770-f22f-c711-52d58cae2fe3@linux.intel.com>
Date:   Mon, 14 Oct 2019 17:41:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1570550166.18914.12.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On 10/8/2019 11:56 PM, Philipp Zabel wrote:
> Hi Martin,
>
> On Mon, 2019-10-07 at 21:53 +0200, Martin Blumenstingl wrote:
>> Hi Philipp,
>>
>> On Thu, Oct 3, 2019 at 4:19 PM Philipp Zabel <pza@pengutronix.de> wrote:
>> [...]
>>>> because the register layout was greatly simplified for the newer SoCs
>>>> (for which there is reset-intel) compared to the older ones
>>>> (reset-lantiq).
>>>> Dilip's suggestion (in my own words) is that you take his new
>>>> reset-intel driver, then we will work on porting reset-lantiq over to
>>>> that so in the end we can drop the reset-lantiq driver.
>>> Just to be sure, you are suggesting to add support for the current
>>> lantiq,reset binding to the reset-intel driver at a later point? I
>>> see no reason not to do that, but I'm also not quite sure what the
>>> benefit will be over just keeping reset-lantiq as is?
>> according to Chuan and Dilip the current reset-lantiq implementation
>> is wrong [0].
> The only issue seems to be the .reset callback, which doesn't have any
> users anway.
The DT binding of reset-lantiq driver is also having issue. I have 
explained here [1].
>
>> my understanding is that the Lantiq and Intel LGM reset controllers
>> are identical except:
>> - the Lantiq variant uses a weird register layout (reset and status
>> registers not at consecutive offsets)
>> - the bits of the reset and status registers sometimes don't match on
>> the Lantiq variant
> Thank you, so these are a good explanation for why the DT bindings
> should be different.
>
>> - the Intel variant has a dedicated registers area for the reset
>> controller registers, while the Lantiq variant mixes them with various
>> other functionality (for example: USB2 PHYs)
> I'm not quite sure I understand why the intel driver is using syscon,
> then. Either way, it shouldn't make a big difference if regmap is used
> anyway.
Yes, we decided to remove the syscon and use the regmap.[2]
>
>>>> This approach means more work for me (as I am probably the one who
>>>> then has to do the work to port reset-lantiq over to reset-intel).
>>> More work than what alternative?
>> compared to "fixing" the existing reset-lantiq driver (reset callback)
> That is still something you could do, or just drop the .reset callback
> because there are no reset consumers using it anyway.
>
> One correct thing to do would be to identify those self-clearing reset
> bits and to disallow calling assert/deassert on them.
>
>> and then (instead of adding a new driver) integrating Intel LGM
>> support into reset-lantiq
> Since at this point I'm not even sure whether merging the two at all is
> better than keeping them separate, I have no opinion on whether merging
> intel support into the lantiq driver or the other way around is
> preferable.
>
>>>> I'm happy to do that work if you think that it's worth following this
>>>> approach.  So I want your opinion on this before I spend any effort on
>>>> porting reset-lantiq over to reset-intel.
>>> Reset drivers are typically so simple, I'm not quite sure whether it is
>>> worth to integrate multiple drivers if it complicates matters too much.
>>> In this case though I expect it would just be adding support for a
>>> custom .of_xlate and lantiq specific register property parsing?
>> yes, that's how I understand the Lantiq and Intel reset controllers:
>> - reset/status/assert/deassert callbacks would be shared across all variants
>> - register parsing and of_xlate are SoC specific
> Ok. If that turns out to be less rather than more boilerplate than two
> separate drivers, that should be fine.

Thanks Philipp for your time and briefly explaining your view.

Regards,
Dilip

[1]: https://www.spinics.net/lists/devicetree/msg308930.html
[2]: https://lkml.org/lkml/2019/9/2/289

> regards
> Philipp

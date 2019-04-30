Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C97C04AA8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2AE2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jrPz5vGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfD3HBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 03:01:42 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:16122 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfD3HBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 03:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556607702; x=1588143702;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=8n6EaeW48PrrWrI6O68nRWKHHFqtIgZH5h/jIZE2emA=;
  b=jrPz5vGNw7hmJ6AcOtUOnTqcTX3tnS/LqU7CiXxB2imH+bad4eecxwQm
   VjE9oCo1dY92dQQYrlpw7m0xFxBQf1jwNon+wMeDbLRB6gOylxYjgKz1F
   PzmeNJ+YHRj+uokiBaa02G86mjiowqzRRA8EhyragTMcPIp7XLP5+H8iv
   /kbdcgbPC7yMrXs+1pW0G7VD4v+88EOO/Vk8kKXBP/gfXz8hS7q3m92I7
   qOO19qsvsqwJgXY2pahE99ot+YVqupmzVvohjsPyl85Gz7Z5YeDckPaGg
   Bg4VUwOcBIOq8jSz2XEEvrcuapGf0SAJ4KSvGghKF0LYrCVFehFpiY0B+
   g==;
X-IronPort-AV: E=Sophos;i="5.60,412,1549900800"; 
   d="scan'208";a="107145493"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2019 15:01:42 +0800
IronPort-SDR: bruMh6I6csUkEXfbQIX4ByDBVCcXqcYIgJFYD8hNRfD5ONENELPfeOoemW7N8cbhekGex0vUIL
 pL+WNTdAAkf5EkBBwE36sC4o17r34OveMiXA5PyLIFyMhWqVReq9iJ6V5qbsEn904UuFbpG3w3
 aQNf56ly3FxOG+n2wMIGbwxrHwReXlb0Y+V17I89tLBAc7p4U/uSYeOAN8MCTGx1oVeEW17Br7
 T/Jbl/EKvXYqAviQHsmdJZHK6KRrVWCENTOtoTpPNl8V5ZsfipIlH7dva7t1vp2HTwlYsDwBNz
 ow2pml8bjbl0MNxUoxI9eLcH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 29 Apr 2019 23:40:11 -0700
IronPort-SDR: V8FpbIILrmZlEWNywzIIeFQ6p3eKpRlWYNxEzYReZWV47Wtf3woyAd35c375i1ie32Y5Z6Qcnx
 Q1dfbi/+PngtaitPYuYIcAVPrRNhXuBHYMvZD8R6ie0fFh4jo8hJd5IlJk8QkI10eAkph3MELg
 kmi6oF4sMx6rNn1Tj5pRNWwXqHSEJEhRHUjcKhjk/JEz0ydelWS7hhkZOiOqk0R2IyFkW6HpYt
 XV4NbsSbbdewTu1FvOHFupBDCe68lDQTAMaax0CVsvI3a5w0LYtNNBB5T+31zE0GcbutkfZ8lK
 PJI=
Received: from ind005306.ad.shared (HELO [10.86.55.35]) ([10.86.55.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Apr 2019 00:01:41 -0700
Subject: Re: [PATCH v3 3/3] clk: sifive: add a driver for the SiFive FU540
 PRCI IP block
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Paul Walmsley <paul@pwsan.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Stephen Boyd <sboyd@kernel.org>,
        "Wesley W . Terpstra" <wesley@sifive.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Megan Wachs <megan@sifive.com>
References: <20190411082733.3736-2-paul.walmsley@sifive.com>
 <20190411082733.3736-4-paul.walmsley@sifive.com>
 <256b9312-4740-e7b1-84ac-c0cc1ff4bc77@wdc.com>
 <alpine.DEB.2.21.9999.1904292258000.7063@viisi.sifive.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <67a4a4b6-e0d7-efc2-c318-a1138cddc9c7@wdc.com>
Date:   Tue, 30 Apr 2019 00:01:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.9999.1904292258000.7063@viisi.sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/19 11:20 PM, Paul Walmsley wrote:
> Hi Atish,
> 
> On Sat, 27 Apr 2019, Atish Patra wrote:
> 
>> On 4/11/19 1:28 AM, Paul Walmsley wrote:
>>> Add driver code for the SiFive FU540 PRCI IP block.  This IP block
>>> handles reset and clock control for the SiFive FU540 device and
>>> implements SoC-level clock tree controls and dividers.
> 
> [...]
> 
>>> +static const struct of_device_id sifive_fu540_prci_of_match[] = {
>>> +	{ .compatible = "sifive,fu540-c000-prci", },
>>
>> All the existing unleashed devices have prci clock compatible string as
>> "sifive,aloeprci0" or "sifive,ux00prci0". Should it be added to maintain
>> backward compatibility?
> 
> As you note, just adding the old (unreviewed) compatible string isn't
> enough.
> 
>> Even after adding the compatible string (just for my testing purpose), I get
>> this while booting.
>>
>> [    0.104571] sifive-fu540-prci 10000000.prci: expected only two parent
>> clocks, found 1
>> [    0.112460] sifive-fu540-prci 10000000.prci: could not register clocks: -22
>> [    0.119499] sifive-fu540-prci: probe of 10000000.prci failed with error -22
>>
>> Looking at the DT entries, your DT patch has
>>
>> +		prci: clock-controller@10000000 {
>> +			compatible = "sifive,fu540-c000-prci";
>> +			reg = <0x0 0x10000000 0x0 0x1000>;
>> +			clocks = <&hfclk>, <&rtcclk>;
>> +			#clock-cells = <1>;
>> +		};
>>
>>
>> while current DT from FSBL
>> (https://github.com/sifive/freedom-u540-c000-bootloader/blob/master/fsbl/ux00_fsbl.dts)
>>
>> prci: prci@10000000 {
>> 			compatible = "sifive,aloeprci0", "sifive,ux00prci0";
>> 			reg = <0x0 0x10000000 0x0 0x1000>;
>> 			reg-names = "control";
>> 			clocks = <&refclk>;
>> 			#clock-cells = <1>;
>> 		};
>>
>> This seems to be the cause of error. It looks like this patch needs a complete
>> different DT (your DT patch) than FSBL provides.
> 
> That's right.  That old data was completely out of tree and unreviewed.
> It's part of the reason why we're going through the process of posting DT
> data to the kernel and devicetree lists and getting that data reviewed:
> 
> https://lore.kernel.org/linux-riscv/20190411084242.4999-1-paul.walmsley@sifive.com/
> 
>> This means everybody must upgrade the FSBL to use your DT patch in their
>> boards once this driver is merged. Is this okay?
> 
> People can continue to use the out-of-tree DT data if they want.  They'll
> just have to continue to patch their kernels to add out-of-tree drivers,
> as they do now.
> 

There were some concerns about the breaking the existing setup in the past.

> Otherwise, if people want to use the upstream PRCI driver in the upstream
> kernel, then it's necessary to use DT data that aligns with what's in the
> upstream binding documentation.
> 

Personally, it makes sense to me. I am okay with upgrading FSBL to 
update the DT once the patches are in mainline. In fact, I used to do 
that for topology patch series. This will help to add any new DT entry 
in future as well.

However, if SiFive can share a prebuilt FSBL image for everybody to 
upgrade, that would be very helpful.

Regards,
Atish
> 
> - Paul
> 


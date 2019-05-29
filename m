Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07E9C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A393920665
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TXb3gGTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfE2HuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 03:50:18 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:48034 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfE2HuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559116217; x=1590652217;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=KUVsQw7OgW/kdN3Vvw/e1KcDS8jMukqEr8h0mTR4QQk=;
  b=TXb3gGTAnjroO+ro2iRDvBsatmWNHW646zDmwZyn9d9nXQbhYfTq/d5z
   GcIO0cyMRoH0FROfIF5DwjC4hzBPFrgQHnb7Ln5v8/U1elM+f7Qn5hoEq
   rwFWj2NCxbvbyKNb08yxmg3H4DZ+KoX2G4saS6dfJVfyxH/6+TNLbGI2x
   ktkkJehtsi1UyATAXWVYUqF0kscSNUqDerGXfSpI0SLL0oXy1TSXlujRl
   De1Htx6crluJFajBqgheuoWX8t1AZLgrvlUHXs+muU5LXqEJW0DB1dYUn
   W2zVyD8B8peL+x7WcukXhklKBY6Ku1kYDQBCnLINGyNHgOKQCMVrlU8xl
   w==;
X-IronPort-AV: E=Sophos;i="5.60,526,1549900800"; 
   d="scan'208";a="215531276"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2019 15:50:16 +0800
IronPort-SDR: tWGaSU8anzwuhC93Hh/lDH4Dvpm+pzymcPo4WVh++eSeY4ufPROP5yOmekwOZ8OtI96j04NJcR
 6YbtABjEk+UObacjVNiL1BK/0WNcmlJsMDdw+fvg+wq7Izdvdlp7Df1McKL83MSFltU5zxCaBI
 3667C8Phr1yAsom47bd9uoNPT0DRZFmM48m/9A6S2ismIs0yeAy+Lgz8sl0FyY6mmsPJHyLh/U
 RHHcNGDIrab52bUSluV3BcDFSwl8uPdMkiMEitF107nDssAtnmc3O8/kiffw4TkOc+FQhZgRwj
 ylthN1QLbNRQOuLf2JZryhWk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 29 May 2019 00:25:28 -0700
IronPort-SDR: xgvvJZ5deWaOIO4dZ++h7DKDc/Cjk9TLmq5ZqsgkARLjYeR5t1clzE+y3g3BB3DHU8MlAVzV4b
 9WMG7D6ByQ04ssYtfwwIApBxqODRk50i9uq+dfWugwiyuDihWnS+2hN9hpQ1dbI0kPCLbgK5GV
 zTdm7+HrMdleOrbFpAQG0zB0TWtagGba4wytnnbwkjvb5ZZ7ssoT59+mPxZwFP/wFQPRnQW7Th
 IdPRKcXLjTcCK6wXmO1paOgSnqDfeAAjgmxrTmEdWJCRmbd0dcV4+KbckZRYDLNhVbxTqKCsyN
 4gI=
Received: from unknown (HELO [10.225.100.40]) ([10.225.100.40])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 May 2019 00:50:16 -0700
Subject: Re: Testing the recent RISC-V DT patchsets
To:     Karsten Merker <merker@debian.org>,
        Loys Ollivier <lollivier@baylibre.com>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <alpine.DEB.2.21.9999.1904221705170.18377@viisi.sifive.com>
 <alpine.DEB.2.21.9999.1905280105110.20842@viisi.sifive.com>
 <86o93mpqbx.fsf@baylibre.com>
 <20190528153542.jfkkwycyc3vu6hld@excalibur.cnev.de>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <081611ea-a0d3-b0c9-3e08-8946513f2174@wdc.com>
Date:   Wed, 29 May 2019 00:50:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528153542.jfkkwycyc3vu6hld@excalibur.cnev.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/19 8:36 AM, Karsten Merker wrote:
> On Tue, May 28, 2019 at 05:10:42PM +0200, Loys Ollivier wrote:
>> On Tue 28 May 2019 at 01:32, Paul Walmsley <paul.walmsley@sifive.com> wrote:
>>
>>> An update for those testing RISC-V patches: here's a new branch of
>>> riscv-pk/bbl that doesn't try to read or modify the DT data at all, which
>>> should be useful until U-Boot settles down.
> [...]
>>> Here is an Linux kernel branch with updated DT data that can be booted
>>> with the above bootloader:
>>>
>>>     https://github.com/sifive/riscv-linux/tree/dev/paulw/dts-v5.2-rc1-experimental
>>>
>>> A sample boot log follows, using a 'defconfig' build from that branch.
>>
>> Thanks Paul, I can confirm that it works.
>>
>> Something is still unclear to myself.
>> Using FSBL + riscv-pk/bbl the linux kernel + device tree boots.
>> Neither FSBL nor riscv-pk/bbl are modifying the DT.
>>
>> Using FSBL + OpenSBI + U-Boot the same kernel + device tree hangs on
>> running /init.
>>
>> Would you have any pointer on what riscv-pk does that OpenSBI/U-boot doesn't ?
>> Or maybe it is the other way around - OpenSBI/U-boot does something that
>> extra that should not happen.
> 
> Hello,
> 
> I don't know which version of OpenSBI you are using, but there is
> a problem with the combination of kernel 5.2-rc1 and OpenSBI
> versions before commit
> 
>    https://github.com/riscv/opensbi/commit/4e2cd478208531c47343290f15b577d40c82649c
> 
> that can result in a hang on executing init, so in case you
> should be using an older OpenSBI build that might be the source
> of the problem that you are experiencing.
> 
> Regards,
> Karsten
> 

I verified the updated DT with upstream kernel for the boot flow OpenSBI 
+ U-Boot + Linux or OpenSBI + Linux.

OpenSBI should be compiled for sifive platform with following additional 
argument

FW_PAYLOAD_FDT_PATH=<linux kernel 
source>/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dtb

FYI: It will only work when kernel is given a payload to U-Boot/OpenSBI 
directly.

Network booting is still not working as the clock driver probe doesn't 
happen because of the updated DT.

-- 
Regards,
Atish

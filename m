Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57637C04AAE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 00:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2750620835
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 00:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZRB9fBjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfEGAuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 20:50:15 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:23406 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfEGAuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 20:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557190215; x=1588726215;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=gaTToYrYt6I9SvIYk6GVO8CEXs+H6f8hXxyYKOJG7lc=;
  b=ZRB9fBjM+ZNSTVKV8xnGT+At6Xq6A7mofguWIb0MCvSQlt9TftoJQrQT
   s5JXv9aD4Sw5HQ05sYQXMopjMSr6X+6uhAxQPP27mNuuXrEAb2GPGKwRL
   b+kk8xI6BI//eGo63p3N9epoY8qzDaHGaNYazc27fvje4DoKAHZj7ybxH
   sV37WRwokYwxiVU1KygX6mGUltTLkiwh+hg/78G/lni/VFtSYzDDRJXG4
   2Ik2PsQZg/l3crUIl9g5QefUkGT0kCUXL1lst/bTg8+bZEvPC7QLCVfTR
   pBlNluSgLG8c928vPY/nSnLGpnck4lR5L7T7BVwElnaKvMkSa8v0uGtFm
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,440,1549900800"; 
   d="scan'208";a="109370139"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2019 08:50:15 +0800
IronPort-SDR: JiI+MVqZZGUc8sMb36ctON3YuIoPWk2zGaFRZ42AMAvJLNQcaZVrhsfG9vVQm+L+BQS3Tk+q79
 oJHk0X2DNXgW77vznsNPK3gCqERqY/JcVNj86PO/WC/QXyy9BRT6XIiNohKFWgqponXQSryhhe
 rSp4H0V3kzOgK6n/KeYt64Ciz/BWS61gXP+VBuLDKWI2m6Ja60c4YX8XahO6NjKgENM8cpxj8/
 dnqsD6x+8SCaWCKnn2Ce0xZdbSr/kKuyuuHc+4BkC8J7EFe8OcQnVTDHgoYHEh1ti5E79K+vOP
 fprkxy3m4QoyWy0tRM/mKlrn
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 06 May 2019 17:28:30 -0700
IronPort-SDR: zDSZycrSkej1TvMSwsQxAWimbp8Ywg7lOHD2izeELWDUuhtCeHDHHVJ+yacnNk4nbwhtk1gIf5
 JqavRRC+derPRozHe8v1yVD2BzW8eCvdFlJ9M1AEv/lBcsniFTwqUtJv8vkRCO6bXIdL42en1W
 J1FKw3KHl+lI82diuP8GfgQgEF6oMRAdoXpZNGNdY9IPPQ4g+gDNd/wxxC1Gz0EpZLCtisWojK
 qnoFtfqljHwDNrpPrr/g+COy0tocTk/Mf5DbpDs8YxPeYVsMZcQ0z7MP6/Kf6Vv4cfEQRVcdyQ
 frc=
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.66.167]) ([10.111.66.167])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 May 2019 17:50:14 -0700
Subject: Re: [U-Boot] [v4 PATCH] RISCV: image: Add booti support
To:     Tom Rini <trini@konsulko.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Karsten Merker <merker@debian.org>, linux-kernel@vger.kernel.org,
        Alexander Graf <agraf@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Joe Hershberger <joe.hershberger@ni.com>,
        Lukas Auer <lukas.auer@aisec.fraunhofer.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rick Chen <rick@andestech.com>, Simon Glass <sjg@chromium.org>,
        u-boot@lists.denx.de
References: <20190506181134.9575-1-atish.patra@wdc.com>
 <251ea152-6407-02e2-076c-7ee377f6181d@gmx.de>
 <20190506203956.ty6gkmhm4dlylld4@excalibur.cnev.de>
 <d1c63af6-e1e0-4ec3-e97a-4c3e9ec11623@gmx.de>
 <20190506212709.GD31207@bill-the-cat>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <0aa4327d-d9b1-b3ef-5882-01411392b75b@wdc.com>
Date:   Mon, 6 May 2019 17:50:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506212709.GD31207@bill-the-cat>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/19 2:27 PM, Tom Rini wrote:
> On Mon, May 06, 2019 at 11:10:57PM +0200, Heinrich Schuchardt wrote:
>> On 5/6/19 10:39 PM, Karsten Merker wrote:
>>> On Mon, May 06, 2019 at 10:06:39PM +0200, Heinrich Schuchardt wrote:
>>>> On 5/6/19 8:11 PM, Atish Patra wrote:
>>>>> This patch adds booti support for RISC-V Linux kernel. The existing
>>>>> bootm method will also continue to work as it is.
>>> [...]
>>>>> +	"boot arm64/riscv Linux Image image from memory", booti_help_text
>>>>
>>>> %s/Image image/image/
>>>>
>>>> "arm64/riscv" is distracting. If I am on RISC-V I cannot boot an ARM64
>>>> image here. Remove the reference to the architecture, please.
>>>
>>> Hello,
>>>
>>> I'm not sure about the last point - ISTR (please correct me if my
>>> memory betrays me here) that an arm64 U-Boot can in principle be
>>> used to boot either an arm64 or an armv7 kernel, but the commands
>>> are different in those cases (booti for an arm64 "Image" format
>>> kernel and bootz for an armv7 "zImage" format kernel), so having
>>> the information which kernel format is supported by the
>>> respective commands appears useful to me.  If the arm64 kernel
>>> image format would have a distinctive name (like "zImage" on
>>> armv7 or "bzImage" on x86) that would be less problematic, but
>>> with the confusion potential of "boot a Linux Image" (as in the
>>> arm64/riscv-specific "Image" format) vs "boot a Linux image" (as
>>> in generally some form of kernel image), I think explicitly
>>> mentioning the supported architectures makes sense.
>>
>> In this case you have to ensure that only the *supported* architectures
>> are mentioned. RISC-V is not supported on ARM64.
> 
> The help should be re-worded to be both architecture agnostic and clear
> that it is for the Linux Kernel 'Image' format images.
> 
Done.

Regards,
Atish

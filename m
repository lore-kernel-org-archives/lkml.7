Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC7BC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F008F22BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="STZQWw4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfGZUSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 16:18:34 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32707 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfGZUSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 16:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564172314; x=1595708314;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=AngrC8jvuImhLFWkJW1/1VV7s6vc+iNx2vnmGpjsvD0=;
  b=STZQWw4rtMcdld27+dpjE5glYfajwm1VeT2COWjIIgGL0sEDfR1BerEV
   U4BiyH6oyLCWElYQko51ThnC8xguU5MGYHbnRaxWcoWyy7LOUfHFHNVGP
   V8ItG0BYI3BR/2l0mssFrGV3WnwbZvqZMvWMauUe8nIX9hI87Zu6TXT0q
   3U+812zZq+ioaN96WCGG0Lf7+5Zi4R3BUV4z1298oWSJiD5nTzwaSBsBG
   ytWqB058UnK67OWCPzUdsutSeS6iEpIyU8pr+VVQs5Zos6SeYJppSbd5O
   g7F7ZV/8Nx8VCsS56j2qq7WwJOfpdjaPT0mufn71OVTJTY8UmQbsUuzj0
   Q==;
IronPort-SDR: WXFEIb9o1QYJwm1BJhSJA+NoH4waEnwVgNCkTqXvAqwHFjVs1IAo7ymikYrp7dxZB+7s03QlBF
 I6TDCpAym1AuZyEEcJ7+NUIXtg/SYKfiJDCXUEJgFO21TCDsn2R02xCdYeT/M32G3Sb7xz7pq0
 AvNPBGBPZdR1x8pIoYK1vEgTjRfo23h7JbIBxdBP6o0QKRWibkuZ+6KavUOtq4FeH1/oIYYghL
 2PK9fL5TwJkCgRVMwa0EZVyUyJGQ09iH5uKz5jurXbNiBCWsfV8YJHDlaegR3mQLtu1TTjW2po
 Quo=
X-IronPort-AV: E=Sophos;i="5.64,312,1559491200"; 
   d="scan'208";a="115276021"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2019 04:18:33 +0800
IronPort-SDR: fvJ7mH/YqLg1iQqRi7xbrxXl5ItmhYgiiaUfW6basIp+7R6CN6DqzCDAosFd908u35xpbMmzMf
 5sY+x8QAk+nOTNlBwn6NJGdg4DhEmuE5XRfaf5U3L9m5JMicrXh2Jj+qgHT0EmgauiWGvd0G9n
 9e9imtQOKq/l5h7WK0C9EjDNrGfBwq4qcy4n/GT6IPzEOANLut1qlqs8YikhISQuxW+c/fzV3i
 lnbxQKdoSAYWwoAFFH6o07ph1c4mNRxd0OkVvFzqyiJtse57ns976SPQhoxIieFJc8/WkrrzdE
 5ZXGUswmRNFFgwObf01Tg6vr
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 26 Jul 2019 13:16:42 -0700
IronPort-SDR: 8NkVZ9+WldyDrtOMJztKxi/Kh1+rvBTTfOmH5xE6uB24ORokOVOnLAEcG/xJ/N6p5gdx2r+KaO
 zVkk3ycg1Usy7gq7fbwxOE3frcBs6HF91c3liv/u0hb+apT2ph4o6d+rmlwZ+IFn7/WZPeVfkP
 EW6+xrcLWOVKpgQpcARVLNRxGJCcD8FvLfapzYqJsYplk8iykMzcsiI3qmAnEujqL0Zj0azldW
 dY0Q5CN5OCbu9TAfnpb+qaFWz+CHDQ8m9CKsIwHiwbqkmnGGeniw97ychWjZjlASUq2nInYUcP
 T6I=
Received: from unknown (HELO [10.225.104.231]) ([10.225.104.231])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Jul 2019 13:18:33 -0700
Subject: Re: [PATCH 0/7] Fix broken references to files under Documentation/*
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?=c5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
References: <cover.1564140865.git.mchehab+samsung@kernel.org>
 <04794d40-0b39-0223-c91e-03b46cb6e2db@wdc.com>
 <20190726171352.5eaa4d83@coco.lan>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <57eaa99a-d644-7b79-7177-a45d3ef1e71a@wdc.com>
Date:   Fri, 26 Jul 2019 13:18:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726171352.5eaa4d83@coco.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/19 1:14 PM, Mauro Carvalho Chehab wrote:
> Em Fri, 26 Jul 2019 12:55:36 -0700
> Atish Patra <atish.patra@wdc.com> escreveu:
> 
>> On 7/26/19 4:47 AM, Mauro Carvalho Chehab wrote:
>>> Solves most of the pending broken references upstream, except for two of
>>> them:
>>>
>>> 	$ ./scripts/documentation-file-ref-check
>>> 	Documentation/riscv/boot-image-header.txt: Documentation/riscv/booting.txt
>>> 	MAINTAINERS: Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt
>>>
>>> As written at boot-image-header.txt, it is waiting for the addition of
>>> a future file:
>>>
>>> 	"The complete booting guide will be available at
>>> 	  Documentation/riscv/booting.txt."
>>>    
>>
>> Yeah. We don't have complete booting guide defined in RISC-V land.
>> Documentation/riscv/booting.txt will be available once we have that.
>>
>> In the mean time, do we need to convert boot-image-header.txt to
>> boot-image-header.rst and fix the reference to
>> Documentation/riscv/booting.rst as well ?
> 
> Well, in the mean time, every time someone builds the Kernel with
> COMPILE_TEST enabled, a warning will be produced.
> 
> So, my suggestion would be to write it on a different way, like:
> 
> 	"A complete booting guide is being written and should be
> 	 available on future versions."
> 
> Or:
> 	TODO:
> 	   Write a complete booting guide.
> 
> And update this once the guide is finished. This should be enough
> to prevent the warning.
> 

Sounds good to me.

> With regards to converting it to ReST, that's recommended. I suspect
> we could be able to finish the entire doc conversion in a couple
> Kernel versions.
> 
Sure.

> Also, it should be really trivial to convert this one to ReST.
> 

Yes. Let me know if you prefer to update it along with your series or I 
will send the patch.

> Thanks,
> Mauro
> 


-- 
Regards,
Atish

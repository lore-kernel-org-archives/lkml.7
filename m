Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A98C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 22:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB48921880
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 22:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BCzb9eXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbfGZWQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 18:16:42 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52545 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfGZWQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 18:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564179401; x=1595715401;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=IauWsVnQycBlvgwPCS2OKZLCRZCdcsAGAQB72OLCEAc=;
  b=BCzb9eXHA6Kt2FlbKJmT8BxUyxljwpFcMv1Pa8scE51/HD/xQz9BmuvE
   lobv0V9nGd6ssbIeBdbub9nQdyJTFcbUwaafStDD/sAhSOBzLKpV/d+1B
   pzLKuNctqcqH6gkAkjRPWYHxVsTzuueXrCmJd0RoX0ySCP/u5dvZIkyyJ
   ZDtRGNlfiHI/oLCx1JVdzOFKCYSMNnGkxcrF4eniIoW3iGKyzjO29L756
   OUpPvfAEMvJgKi5Sbxbyo+cEyWVyQvIH3Y07jFuaK0mucwE5rs6dGr560
   lEg/I29RZ6+0ti37pOlU/5sdvAOnTXevUryaA7yVreDMD86neHynCIFhi
   A==;
IronPort-SDR: 0MfrN9x1IVDn4ROJX3Bjlv29nWXxJCRVx7UkZ3RxMbowQjxLoqs/Ns0CAJhGL7C9HgBO3VILK2
 sR0ItxXXzu75i+SEYIBaKOedR2rPdcKdIiUyK3D2MqDuxmtrl9FIuBlkzN9zbFqksOllbTi7Os
 EnYvGDi6FsbG20JBvZeVIeeImld38mLmwTT0bQMin3AOtW7OEvgA7vr22Dla5Au3ZdoCQNGX8B
 toG3oFvPjUDJ1QigjBRLqiLB6eNOaZNxx7QwMkAhVl1TrKlNyUDE+UCj2umsRu09w9tABxqwhK
 kA4=
X-IronPort-AV: E=Sophos;i="5.64,312,1559491200"; 
   d="scan'208";a="118942854"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2019 06:16:41 +0800
IronPort-SDR: 0YLlMvdrAOEcS3r0MZdl0my8c3YoWs09kQy8J3ajn6pgxoGZ9c/UpWBxB7bPiHiTSbA1deNScF
 o3epm3GrDx4d4LyttBWPwgkTKatSWIavepcoyai/CpxuPPMedjXZd4Yrju03HTEOjaWiO1AYo/
 9Ors4eg2bXPMdJiLsx9e5WnWYYV5k4tGwY2o1W7cyIuiws9LJ2oXkMzBuw5ZqJvfWBE8stfZkd
 kFAdD2CfT6h/JSNPp5VlJ736l/Iw7s0O7xxy2d/54UfSN+ExmWlwOtI+yhsXWwiUJB2r3qyjBG
 MmixGKZ0dKAxT8lnUTivv41+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 26 Jul 2019 15:14:49 -0700
IronPort-SDR: mvVjxZAXMfQh1VfDTBfz4dPD/565Ax5AYIKjxTjIiqVmLRWGe2+W0MVwBgEulxK1mOj/W7J+U3
 u6KgOFNFaIujD2lWePFSBXc4u3Az7sJW+pKKF+ocvkZ5zcKxw2p19LdoM7+ZVnlb/47Ym85LYS
 wtBrOkRg+wACGyYOR27dj9mEyXz2WDrAbStQi9UdlyRvHCmSmulLEVVWng1ydkk5XBrFN2fCXR
 Dbq3l/Tcr5HcAX+rwwDAQhGMC9GF52HArT0lK5L60SCLKoq/bnhfMmYrssBs2/xwqwb/hV8q8H
 9Z4=
Received: from unknown (HELO [10.225.104.231]) ([10.225.104.231])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Jul 2019 15:16:41 -0700
Subject: Re: [PATCH 0/7] Fix broken references to files under Documentation/*
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?=c5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
References: <cover.1564140865.git.mchehab+samsung@kernel.org>
 <04794d40-0b39-0223-c91e-03b46cb6e2db@wdc.com>
 <20190726171352.5eaa4d83@coco.lan>
 <57eaa99a-d644-7b79-7177-a45d3ef1e71a@wdc.com>
 <20190726180109.56d1db35@coco.lan>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <0d25d488-781e-a89e-62d2-21349a976d83@wdc.com>
Date:   Fri, 26 Jul 2019 15:16:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726180109.56d1db35@coco.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/19 2:01 PM, Mauro Carvalho Chehab wrote:
> Em Fri, 26 Jul 2019 13:18:30 -0700
> Atish Patra <atish.patra@wdc.com> escreveu:
> 
>> On 7/26/19 1:14 PM, Mauro Carvalho Chehab wrote:
>>> Em Fri, 26 Jul 2019 12:55:36 -0700
>>> Atish Patra <atish.patra@wdc.com> escreveu:
>>>    
>>>> On 7/26/19 4:47 AM, Mauro Carvalho Chehab wrote:
>>>>> Solves most of the pending broken references upstream, except for two of
>>>>> them:
>>>>>
>>>>> 	$ ./scripts/documentation-file-ref-check
>>>>> 	Documentation/riscv/boot-image-header.txt: Documentation/riscv/booting.txt
>>>>> 	MAINTAINERS: Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt
>>>>>
>>>>> As written at boot-image-header.txt, it is waiting for the addition of
>>>>> a future file:
>>>>>
>>>>> 	"The complete booting guide will be available at
>>>>> 	  Documentation/riscv/booting.txt."
>>>>>       
>>>>
>>>> Yeah. We don't have complete booting guide defined in RISC-V land.
>>>> Documentation/riscv/booting.txt will be available once we have that.
>>>>
>>>> In the mean time, do we need to convert boot-image-header.txt to
>>>> boot-image-header.rst and fix the reference to
>>>> Documentation/riscv/booting.rst as well ?
>>>
>>> Well, in the mean time, every time someone builds the Kernel with
>>> COMPILE_TEST enabled, a warning will be produced.
>>>
>>> So, my suggestion would be to write it on a different way, like:
>>>
>>> 	"A complete booting guide is being written and should be
>>> 	 available on future versions."
>>>
>>> Or:
>>> 	TODO:
>>> 	   Write a complete booting guide.
>>>
>>> And update this once the guide is finished. This should be enough
>>> to prevent the warning.
>>>    
>>
>> Sounds good to me.
>>
>>> With regards to converting it to ReST, that's recommended. I suspect
>>> we could be able to finish the entire doc conversion in a couple
>>> Kernel versions.
>>>    
>> Sure.
>>
>>> Also, it should be really trivial to convert this one to ReST.
>>>    
>>
>> Yes. Let me know if you prefer to update it along with your series or I
>> will send the patch.
> 
> I suspect it would be quicker if I write it. I'm sending it in a
> few.
> 
Thanks!!

> Thanks,
> Mauro
> 


-- 
Regards,
Atish

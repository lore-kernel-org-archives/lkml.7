Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AACC76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 01:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752EA21901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 01:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="D3QuifCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfGYBY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 21:24:26 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52961 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfGYBY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 21:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564017866; x=1595553866;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=p+jTfu4cIazD5eixTiPopv5has0130QcUTKO/yKoUes=;
  b=D3QuifCWvZS6icOtQ87nXQcroQJQUn3LW6ymqpc5EIqwowcxVF2E6ow9
   hbOyGJXDwHZWTL/HoB4RK7tD6vMbW6/glAmjrHv46ixZPQzUVSzyGmJrL
   k0RKwad1PHQYZ5TF/SK47oDKNLbZCZQ0Beo55SCP4vrvnlHiRgAmZ0f3H
   hxAp6NZluMyumuH8pGEYUevlhliyuT1pbhO3k6DV3Dh/3vDYK4jpB0/W0
   yGpPcbdBSQe7QWuFEX0ZxTSifJbAXNI8MCAtRADvAiRMht5b0lPoPhsxU
   esph9IQxLTPvKJ1MUKM4SMLZe+zjM1y3jt39MTAaPZ48mq0xZi9hi2I+C
   g==;
IronPort-SDR: cW0BElLLnCTpzNBGZPQr9PHZ7dHM/ut4Tb4mhvEyKrJqmnsRfLb1eztM8kxUsrPW3IsaoKgd3N
 vlfXWJPO336YC7XAKFEy28jMx/wga2pUj6oldYZ7+eZTKNFw+OsSAK786vcyk7etwDeJ32S/Gu
 LTAcTU06AFPFD1hgCJmstMYjDf/VSOd7m4mJJuw0WCpSZDwfGc/7uxAl8QsxsBq22l37wI3W8U
 dKKARjJ4V13lHBsxl+U2tt9PKmVz7n4iPcPHdWxqFdgGiBmMkSAlARsUSLGNJgMXzQxBkini2u
 siU=
X-IronPort-AV: E=Sophos;i="5.64,304,1559491200"; 
   d="scan'208";a="118681832"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jul 2019 09:24:26 +0800
IronPort-SDR: J7qUuy2KO4+m2pnPnLLxGvsIj/7q3AE8v2o/lvvqVqMI+hmlTVF0J+flbNQmjKDGR9Zm1aUvT8
 dkI1rgCsnL+uvlV3nr72LJcpdj7m/jYpQK37kfocuDtdl8uJ8R37OL/upu2zXl4zGIuguElOLw
 3yOhBas6GNrI9tjDVnfPgm6nEHkSXE2P6WIRo/1G1c0nLVhxnhArqT9scqkFyK3Eaj4kNSNEM8
 P/DDuIvXZrF5Sbf1ekjqzoSyQagVRyViaJV4d0v3+MPsqw1CJykHsq6nVMK7/bqgAB/1Iyjbwg
 5H9EAuEnfOvYWVhPWCBt2kXI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 24 Jul 2019 18:22:37 -0700
IronPort-SDR: V40xfE9gili+44NnP3tPlPZ2UZfyLw5G2k1ffUp3o9aNa94g6a0EQQzDNiFNIxamCt67BvNlyN
 ZGvjsXZempGW2czFlejGBR0PiLWWQ4yDXhugkuGPBv9/uk+J7VPYqwZAAbktNZCMUFnKT+3hn3
 /sfby85RS1py25X+dAL4O6KmG/qeVSPieHigi0K0Y1S1wB2ZAnHQykLenqJL5RQjpChOQpUYrV
 pes/KNeXeL28/On8K5wifkMeeQnVLcCOOZmbtYE8vB3ccGhofWq+D1uFHJxa1UXS+9DbKpCq5c
 O0I=
Received: from r6220.sdcorp.global.sandisk.com (HELO [192.168.1.2]) ([10.196.157.143])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Jul 2019 18:24:23 -0700
Subject: Re: [PATCH v8 0/7] Unify CPU topology across ARM & RISC-V
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>
References: <20190627195302.28300-1-atish.patra@wdc.com>
 <alpine.DEB.2.21.9999.1907121012050.2267@viisi.sifive.com>
 <alpine.DEB.2.21.9999.1907221224170.23563@viisi.sifive.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <ea88d4f4-eff8-adba-3135-0d480f501d48@wdc.com>
Date:   Wed, 24 Jul 2019 18:24:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.9999.1907221224170.23563@viisi.sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/19 12:25 PM, Paul Walmsley wrote:
> On Fri, 12 Jul 2019, Paul Walmsley wrote:
> 
>> On Thu, 27 Jun 2019, Atish Patra wrote:
>>
>>> The cpu-map DT entry in ARM can describe the CPU topology in much better
>>> way compared to other existing approaches. RISC-V can easily adopt this
>>> binding to represent its own CPU topology. Thus, both cpu-map DT
>>> binding and topology parsing code can be moved to a common location so
>>> that RISC-V or any other architecture can leverage that.
>>> different config for the architectures that do not support them.
>>
>> Once v5.3-rc1 is released, let's plan to get these patches rebased and
>> reposted and into linux-next as soon as possible.
> 
> These CPU topology patches are now queued for v5.4-rc1.  They should enter
> linux-next shortly.
> 
> 
> - Paul
> 

Thanks!!

-- 
Regards,
Atish

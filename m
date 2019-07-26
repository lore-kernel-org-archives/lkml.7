Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F46DC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 22:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1D722C7E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 22:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o0ksJZo1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbfGZWUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 18:20:52 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:3258 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfGZWUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 18:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564179652; x=1595715652;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=2Pp7soz5T65+2MFGSxtLJF8/y1h3Zy8XLJbl/hXcT98=;
  b=o0ksJZo1sM6luBzgCLZAfElThu65wZwN8YDmCfu8f3STdFI2WhMnvZm5
   MHihwJHAzktZhg/zw2TQQWmib0k15XHcTn/h8PLcRrzjbdgTTRakchZO/
   fiuuBVsbHfAGoUem1YJFV/46pq2Ota64XPE0JrPx1cs5raE8i7uAOFbqh
   H6Rxt2YBROEKL5twAI9/hVdwsYOX60Z1OaP8bcDu5xKGskL0kV6EQ+/JZ
   z8OFklzqZKxN78bEo6/kdEG30jPQPZKh4ttf79hu7faPu92Zp7rid7CC3
   ziU8GFzLTRFoawvKlPEY71idUvnPXR6C480kiJYTMcokuKOSXY1r5cEnH
   g==;
IronPort-SDR: HLP3a60RI6UP05q2IlxNOgWElva8c0VkfRegoCaNRJMekx0X+YngvFsGmfjeOi8Vx0zkdxXQqW
 FM0JjFZ9LWqyophf/8LiH+WDkQzHMkDPZhECmkhdxBBec51Sl51n9jEy5eEZAaZoDUfqdzI9+u
 48srHOXizI7Q/5sXnA5rZ+zM7QuswJeDOJXrAyOF1uLNHNurdvUfKKjre6nks3+QmCiYJ4dfHX
 rz6NLiZsUxkgEfsizM+t8w3RgQSVqL5ffe8kneH6B0Lz2FM8BpzhjnMvLwM75TJfjp2E0EpBg5
 PUw=
X-IronPort-AV: E=Sophos;i="5.64,312,1559491200"; 
   d="scan'208";a="115280748"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2019 06:20:52 +0800
IronPort-SDR: 0vsAFPFKckuK6EENiuX1YZ9bRL1GwUYij56pPsYA/Q8LsRkVQUMqeW6taj0Oqi+3zeNUwunsDQ
 YeoIV/pO/aOnUes1i+ybWMkPLnVccmVRVt7clzB988iuKiwaIkZhzx7P7vFCP1h7Jr/VzT0Lsd
 XPpr4ROqa42g5DHO3aOVtE40ZAymRZls9Q6qIwywMuq+VYVbEcvdJZ+uRf7MVGXnY3s26KNGiL
 rc0rLoCWe2P5tkTlwpWMdZnCdH2vhHisdpMc8PtWGYaWkoE4R1MqN396BBx9Y/5RAcXv632t23
 zyZS1aGL1wapxJKjTb9k3kre
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 26 Jul 2019 15:19:00 -0700
IronPort-SDR: DTvqt9Mfx3sEEJcaEIx2FzJIgmQZ2mIv8hWErAdPzRFMdP8MEQzAeRV/QyvsCeRPRd2OXjP7h1
 R5ZcVL7wgYNM/8gkkzOacIbRzpp/FRBnOST3Ily25tSBf7loEKaXkgRK7T23DqAwMooO0TxvoO
 xrb6+4c0kBv5ZzD9Uv4ZSosSoW8ld/+z3IlmYo2nc57WLNikT60H/TKXaM/9x701mObj1g1bgA
 nNwGP5ZN4ut/H4GcPqBuphfvr2IjI2GJsS9+xBio/aHuG804X+YShuM6HmLZALhiSQgEklZGG2
 yw0=
Received: from unknown (HELO [10.225.104.231]) ([10.225.104.231])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Jul 2019 15:20:51 -0700
Subject: Re: [PATCH 3/4] RISC-V: Support case insensitive ISA string parsing.
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <Anup.Patel@wdc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190726194638.8068-1-atish.patra@wdc.com>
 <20190726194638.8068-3-atish.patra@wdc.com>
 <alpine.DEB.2.21.9999.1907261346560.26670@viisi.sifive.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <a8a6be2c-2dcb-fe58-2c32-e3baa357819c@wdc.com>
Date:   Fri, 26 Jul 2019 15:20:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.9999.1907261346560.26670@viisi.sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/19 1:47 PM, Paul Walmsley wrote:
> On Fri, 26 Jul 2019, Atish Patra wrote:
> 
>> As per riscv specification, ISA naming strings are
>> case insensitive. However, currently only lower case
>> strings are parsed during cpu procfs.
>>
>> Support parsing of upper case letters as well.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> 
> Is there a use case that's driving this, or 

Currently, we use all lower case isa string in kvmtool. But somebody can 
have uppercase letters in future as spec allows it.


can we just say, "use
> lowercase letters" and leave it at that?
> 

In that case, it will not comply with RISC-V spec. Is that okay ?

> 
> - Paul
> 


-- 
Regards,
Atish

Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FFFC49ED8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67446218AF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568128958;
	bh=3bmua+7sTEe8QXyCL+R29XkE+26bKrUqjv62ypVyE7g=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=PevRugNaK40Jm3gibVs4Qs90MfKf2qX795FUhROiqaOcCvRv8BOF0IdMGiWM3L7wo
	 mTEqVAg9ak3KpOAkX6eWCzNbT6PKDwck1dWX00nrTG+GQE6Y21Yjj/SY+kls23F02N
	 hyD8x6NCM6JFegbj8xhzZGI0+2N+r8oqWm30wrGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392145AbfIJPWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:22:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731043AbfIJPWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:22:36 -0400
Received: from [192.168.1.23] (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7EAA2168B;
        Tue, 10 Sep 2019 15:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568128955;
        bh=3bmua+7sTEe8QXyCL+R29XkE+26bKrUqjv62ypVyE7g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=1gbXKIFHCazZ5Ss1c041nEqJAy/UqbQ1MtTMfjgMwM8tYWCynOpIDzBoLv484oMsQ
         kI5x5CeuIqW5YdQXJrpvUQWdix4Hc4SlECXw3Zv2dpmXXnhMs6L7igpGRGvfAyqqCi
         YnC8e9vSHgCBanSeB5fBhKEXydbYunhb7cWGf8ME=
Subject: Re: mtd raw nand denali.c broken for Intel/Altera Cyclone V
To:     Tim Sander <tim@krieglstein.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
References: <5143724.5TqzkYX0oI@dabox>
 <CAK7LNAR8xtURiCoJC0eWLFw0q+78Eb_axoOzWH+JNugf-24Qig@mail.gmail.com>
 <3020870.hsMMj5ogRZ@dabox>
From:   Dinh Nguyen <dinguyen@kernel.org>
Openpgp: preference=signencrypt
Autocrypt: addr=dinguyen@kernel.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9bb2fb0e-a9e7-c389-f9b7-42367485ff83@kernel.org>
Date:   Tue, 10 Sep 2019 10:22:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3020870.hsMMj5ogRZ@dabox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/10/19 8:48 AM, Tim Sander wrote:
> Hi
> 
> I have noticed that my SPF records where not in place after moving the server,
> so it seems the mail didn't go to the mailing list. Hopefully that's fixed now.
> 
> Am Dienstag, 10. September 2019, 09:16:37 CEST schrieb Masahiro Yamada:
>> On Fri, Sep 6, 2019 at 9:39 PM Tim Sander <tim@krieglstein.org> wrote:
>>> Hi
>>>
>>> I have noticed that there multiple breakages piling up for the denali nand
>>> driver on the Intel/Altera Cyclone V. Unfortunately i had no time to track
>>> the mainline kernel closely. So the breakage seems to pile up. I am a
>>> little disapointed that Intel is not on the lookout that the kernel works
>>> on the chips they are selling. I was really happy about the state of the
>>> platform before concerning mainline support.
>>>
>>> The failure starts with kernel 4.19 or stable kernel release 4.18.19. The
>>> commit is ba4a1b62a2d742df9e9c607ac53b3bf33496508f.
>>
>> Just for clarification, this corresponds to
>> 0d55c668b218a1db68b5044bce4de74e1bd0f0c8 upstream.
>>
>>> The problem here is that
>>> our platform works with a zero in the SPARE_AREA_SKIP_BYTES register.
>>
>> Please clarify the scope of "our platform".
>> (Only you, or your company, or every individual using this chip?)
> The company i work for uses this chip as a base for multiple products.
> 
>> First, SPARE_AREA_SKIP_BYTES is not the property of the hardware.
>> Rather, it is about the OOB layout, in other words, this parameter
>> is defined by software.
>>
>> For example, U-Boot supports the Denali NAND driver.
>> The SPARE_AREA_SKIP_BYTES is a user-configurable parameter:
>> https://github.com/u-boot/u-boot/blob/v2019.10-rc3/drivers/mtd/nand/raw/Kcon
>> fig#L112
>>
>>
>> Your platform works with a zero in the SPARE_AREA_SKIP_BYTES register
>> because the NAND chip on the board was initialized with a zero
>> set to the SPARE_AREA_SKIP_BYTES register.
>>
>> If the NAND chip had been initialized with 8
>> set to the SPARE_AREA_SKIP_BYTES register, it would have
>> been working with 8 to the SPARE_AREA_SKIP_BYTES.
>>
>> The Boot ROM is the only (semi-)software that is unconfigurable by users,
>> so the value of SPARE_AREA_SKIP_BYTES should be aligned with
>> the boot ROM.
>> I recommend you to check the spec of the boot ROM.
> We boot from NOR flash. That's why i didn't see a problem booting probably.
> 
>> (The maintainer of the platform, Dihn is CC'ed,
>> so I hope he will jump in)
> Yes i hope so too.
>  

I don't have access to a NAND device at the moment. I'll try to find one
and debug.

Dinh

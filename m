Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80B8C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB893208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLgMXanV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbfFYOpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:45:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38708 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbfFYOpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:45:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id r9so16538402ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 07:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=19byvgMooTxDLIKVTh81InKh4X1Q8jthyNGnpMWPTR8=;
        b=lLgMXanVjEQcfCC9RLZP8uBcI+qZDhEJK3RhnXgJnRkmp8YmdmIanryeO/DXIyTczA
         Qau20L/HQc5RzI56ASZ/J+q/SQyssmS80dEaB4v/jDB8ZrlWWu7TZZn6VEZg4Oh8DOux
         VG4cG5O9G5SZGToAPJd4pMsri0a9UmL8H/UNlJgRSraTm1zQpI4cFVrqD5pzZWimcSsg
         bu8fZQuw1RE69f00e1pRjQ0gFVWuGHkV9Q7Cjvt/pKdP/uNW5fJc4OZgowREyYzx6x0k
         cVK0bs5DJSd2EkDG2csK+VrVn3P8CNa6+KcEUyuJy75LugOBVUPdU62yydCuAOOlfZd2
         cd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=19byvgMooTxDLIKVTh81InKh4X1Q8jthyNGnpMWPTR8=;
        b=AsqPQa/vwEPjYCMsLqbW9mKsK8iaS4avLzFLC4F1+f4Oj3m7BxPwa3E18U6CORJoUs
         PCZDiT86Cs/b69IKMNo5BHcob6txNldy33WqDl/rfAf9Tsp523KFo06nGYGPAriy1Gub
         gFfSQrlh+4JcANAssH1JkjWXvt4+jtJKO1lmp5OBfn0kQ+BbgO9Xw46MCXdtl3FyJMi8
         G5qlcKs5s9UsjLPGLwBSlyJOrmi33aLxzWzb8GXEedM4feJydnDwRPls6hWFccv/r4aa
         Z6cgJfBTPu8Eru8zeC81tWjUNX7/qLmP3id7R9qMKDjYiW7D/6Uf9ymaZw8dRuA5SNYE
         PobQ==
X-Gm-Message-State: APjAAAXB0UDhPH5Ka2bImXb0Prcnm5t4/LZCkGEP4BhHRa00PCOtNRKG
        87jFo/R04dHFNE4t2+QWdUk=
X-Google-Smtp-Source: APXvYqzE+mgvqcRuw0XLGzJPuIidwv1afsSu+J/Ue9GwMrC/8NbuQdpemiOsmTQmluXQ0eeNwVCDOQ==
X-Received: by 2002:a2e:970d:: with SMTP id r13mr73976367lji.126.1561473908776;
        Tue, 25 Jun 2019 07:45:08 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id b62sm2287608ljb.71.2019.06.25.07.45.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:45:07 -0700 (PDT)
Subject: Re: [v3 1/2] mtd: nand: Add Cadence NAND controller driver
To:     Piotr Sroka <piotrs@cadence.com>
Cc:     linux-kernel@vger.kernel.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>, linux-mtd@lists.infradead.org
References: <20190614150638.28383-1-piotrs@cadence.com>
 <20190614150956.31244-1-piotrs@cadence.com>
 <dd96bd1b-e944-e95d-31c9-6dd1d0b5720f@gmail.com>
 <20190625130231.GA31865@global.cadence.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <20110899-d456-8403-f9be-663be5fcd07e@gmail.com>
Date:   Tue, 25 Jun 2019 17:45:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190625130231.GA31865@global.cadence.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.06.2019 16:02, Piotr Sroka пишет:
> Hi Dmitry
> 
> The 06/16/2019 16:42, Dmitry Osipenko wrote:
>> EXTERNAL MAIL
>>
>>
>> 14.06.2019 18:09, Piotr Sroka пишет:
>>
>> Commit description is mandatory.
>>
>>> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
>>> ---
>>
>> [snip]
>>
>>> +
>>> +/* Cadnence NAND flash controller capabilities get from driver data. */
>>> +struct cadence_nand_dt_devdata {
>>> +    /* Skew value of the output signals of the NAND Flash interface. */
>>> +    u32 if_skew;
>>> +    /* It informs if aging feature in the DLL PHY supported. */
>>> +    u8 phy_dll_aging;
>>> +    /*
>>> +     * It informs if per bit deskew for read and write path in
>>> +     * the PHY is supported.
>>> +     */
>>> +    u8 phy_per_bit_deskew;
>>> +    /* It informs if slave DMA interface is connected to DMA engine. */
>>> +    u8 has_dma;
>>
>> There is no needed to dedicate 8 bits to a variable if you only care about a single
>> bit. You may write this as:
>>
>> bool has_dma : 1;
> I modified it locally but it looks that checkpatch does not like such
> notation
> "WARNING: Avoid using bool as bitfield.  Prefer bool bitfields as
> unsigned int or u<8|16|32>"
> So maybe I will leave it as is.

You may also use the "u8 : 1" form then, to satisfy the checkpatch. Probably
"unsigned int : 1" will be the best in this case, it's up to you.

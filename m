Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E58FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBE5208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="YjjsLPA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfCHRch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:32:37 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45715 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfCHRcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:32:36 -0500
Received: by mail-lj1-f195.google.com with SMTP id d24so18053436ljc.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 09:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=04OEvy0xZ5LcQH0OJqrzsCA8osIPKjgjUbd8tX0Kghs=;
        b=YjjsLPA93wIGoIgNkb103Q3G/j/k+9I4c0VFFdo7mBpadNUKe5yEOkVQ6nj1Yl8Ay3
         lfaa4VZSJfPwFqSLx1mJbb6dNFk4ceMky3BiD+wY8IWhBM9NvMJ2ayQ1A7TQcLpPnoFY
         19khDqCwUNMogpSp0hwoIQuF0B6nKREpydIbrPmB9yOHPbHZC0NgNrNNP9YSXHVnHY/1
         d2fCAxvFbu9PRpzqwr4IX/dtwwTCkoQA53nxRGKb+JtdMLCiBsv38dPmYovbptdOS7r+
         3XNj1PaaTuvfuWfMHDup9yXPN+GXys0SII2767fmaRGyAZe25A7SoujJqkosAvlwYoNp
         b9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=04OEvy0xZ5LcQH0OJqrzsCA8osIPKjgjUbd8tX0Kghs=;
        b=rexPM2FrkxQRTITjr1CaosFBDNfplE/IkGzvttWjL0FxkUZon080NYs1MkEN5HiEfa
         4wZ/VS01CVKrgEHXGwWQfJpPdqWI6sFD9UEMQb+DdT83QNJYPoscO+9kuG/tDCP++OEa
         QLJwFmicohGrb4J7n8lpvBIQ2rlrCr5/P2ndUtAJnQiBKXa4KqejQO6VJW+xz45sqZok
         b9M6sqDMySrJs7OzTmmEfBAcOokwWgNSiI6vhLRGFtDOUgIouecPJTNLFkpV2hDO+OGX
         bj1bOfl3TOOr9N2+epcbc1PBSLaLhxedVdV2SIfXCpHZ8J6pGhPV8+jQ4wCAYmRjpTus
         ojqw==
X-Gm-Message-State: APjAAAXEW+f1++obvt/aU5l20W4ROfNvP6RN2yYbnY96dTWOQYZiboqc
        crvFdeGA8GWhjC3R9Sv4PRxdug==
X-Google-Smtp-Source: APXvYqz3wB91MUVB0uy0sHCimDL1sOS3O9t9ZU9NABwG1mdmpIrntTeW9qgW+Lk34VO4teylF/snSA==
X-Received: by 2002:a2e:2e05:: with SMTP id u5mr9801643lju.85.1552066354148;
        Fri, 08 Mar 2019 09:32:34 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.80.248])
        by smtp.gmail.com with ESMTPSA id b64sm1527386ljf.82.2019.03.08.09.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 09:32:32 -0800 (PST)
Subject: Re: [PATCH v8 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mason Yang <masonccyang@mxic.com.tw>,
        Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1548658158-5460-1-git-send-email-masonccyang@mxic.com.tw>
 <1548658158-5460-2-git-send-email-masonccyang@mxic.com.tw>
 <0c54ee2c-016a-bc8e-33ae-fbd04191cc49@cogentembedded.com>
 <CAMuHMdVjgWNw4fnzJV=Qxs6zyNiBPubJUL-4WDOy26N4TkQ4gQ@mail.gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <b469bffe-b5b2-0b03-b6fb-49bfc8ba74ab@cogentembedded.com>
Date:   Fri, 8 Mar 2019 20:32:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVjgWNw4fnzJV=Qxs6zyNiBPubJUL-4WDOy26N4TkQ4gQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 03/08/2019 12:14 PM, Geert Uytterhoeven wrote:

>>> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
>>>
>>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> [...]
>>> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
>>> new file mode 100644
>>> index 0000000..ea12017
>>> --- /dev/null
>>> +++ b/drivers/spi/spi-renesas-rpc.c
>>> @@ -0,0 +1,804 @@
>> [...]
>>> +static void rpc_spi_hw_init(struct rpc_spi *rpc)
>>> +{
>>> +     //
>>> +     // NOTE: The 0x260 are undocumented bits, but they must be set.
>>> +     //      RPC_PHYCNT_STRTIM is strobe timing adjustment bit,
>>> +     //      0x0 : the delay is biggest,
>>> +     //      0x1 : the delay is 2nd biggest,
>>> +     //      On H3 ES1.x, the value should be 0, while on others,
>>> +     //      the value should be 6.
>>> +     //
>>> +     regmap_write(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL |
>>> +                               RPC_PHYCNT_STRTIM(6) | 0x260);
>>> +
>>> +     //
>>> +     // NOTE: The 0x1511144 are undocumented bits, but they must be set
>>> +     //       for RPC_PHYOFFSET1.
>>> +     //       The 0x31 are undocumented bits, but they must be set
>>> +     //       for RPC_PHYOFFSET2.
>>> +     //
>>> +     regmap_write(rpc->regmap, RPC_PHYOFFSET1, RPC_PHYOFFSET1_DDRTMG(3) |
>>> +                  0x1511144);
>>> +     regmap_write(rpc->regmap, RPC_PHYOFFSET2, 0x31 |
>>> +                  RPC_PHYOFFSET2_OCTTMG(4));
>>> +     regmap_write(rpc->regmap, RPC_SSLDR, RPC_SSLDR_SPNDL(7) |
>>> +                  RPC_SSLDR_SLNDL(7) | RPC_SSLDR_SCKDL(7));
>>> +     regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD | RPC_CMNCR_SFDE |
>>> +                  RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
>>> +                  RPC_CMNCR_BSZ(0));
>>> +}
>>
>>    We clearly need runtime PM get/put() calls around this code. Otherwise,
>> we're dependant on U-Boot leaving the clocks enabled...
> 
> Even that would be futile, as the common clock framework disables all
> unused clocks at late boot time.

   This code is executed during the probing time and it indeed works. The clocks seem
to be disabled somewhat later...

> Gr{oetje,eeting}s,
> 
>                         Geert

MBR, Sergei


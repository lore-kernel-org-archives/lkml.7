Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBB4C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281B420818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTaYgCJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfDJIDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:03:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42098 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfDJIDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:03:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so1706728wrx.9;
        Wed, 10 Apr 2019 01:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GQH8JFqh6sM8sVbIsYsn30rw1WmQp8nI6/CYWzs9PiU=;
        b=PTaYgCJC9LoT3IpHAZGyi8bt6f2lic3ssJ8/9MVsWQhhmNMNhU2Pt02wrEKL0V2Azi
         dAU5rw5j2pniDshR5ZzOBMNiY2xGKXIypnhrBxNJl1EFVz94TQ/8PlwiDAiFchUI38vj
         igx8raM3XpANz7jQHUI0E54wnnAH74pM9rt1jGnhY9jSo8sJJmBW6go4ExrtKRekJvos
         Bnk1I3ysCeCb5ZdfgmHApUCWBAqezmGeXdtgAKZhXreCDhsT1qlLKqP6Te3Pvoa7V5zZ
         bM68KQ+7WJVIXRcIktTt+0HzUWeCurmkVtBsKhOmhbq7PBcnDxE1VbQLEEhFXAyKiT8l
         iewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GQH8JFqh6sM8sVbIsYsn30rw1WmQp8nI6/CYWzs9PiU=;
        b=t4Y+aZGQXOyJyfX9AyLYITa1NgEIOJvs9LjRSGMki6006lcemX4BP27QNJWF38b2ew
         zD49jnKyb3jzb26GBN/oemYkViBSuCnN3Fg9uBy7OJpY3sa2hK4wNU8yC277Xfdba93+
         wa6UXbpZSnWDX+gp7hzUQRijmUQ5vrn93QUBdiJPj+eC/v4wcwVs8cLjLwzH5SZj9+Oi
         l7XLyrmKw1DuJbJ3ilXWNgwKEzcWaYnUCZ69hF9jkN8se9rYXeFodm6FUp7MMWbMCXu4
         qXWp95e/ClvlSlN+zOqRnG2T153l3/L7zuqrDceshQ5BvLv1QoXpP1kjspMjvFo42yx/
         yIaQ==
X-Gm-Message-State: APjAAAWZLzb97p5oBNjennGZJFDoIQFzGMMzG3ooBC8bJqXXTmOonbPG
        SYndvCLNac14b6UcZkX7Qn4=
X-Google-Smtp-Source: APXvYqw4+gPXZ05OLqspW7NFTQGetalhmUfzc24DxCupxCpc4ByzPVguwioyRdcdseQsTSa8YyDNgQ==
X-Received: by 2002:adf:dd8c:: with SMTP id x12mr27148242wrl.262.1554883432349;
        Wed, 10 Apr 2019 01:03:52 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id d7sm1440381wmf.31.2019.04.10.01.03.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 01:03:51 -0700 (PDT)
Subject: Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        zhengxunli@mxic.com.tw
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
 <a2dc294f-f2a1-2469-1f44-db67f9b8cc10@cogentembedded.com>
 <OFC7F0028A.CFF6BD04-ON482583D8.00084FA1-482583D8.0008985F@mxic.com.tw>
 <2095d059-8276-a01a-7c3a-da4647f7b7df@gmail.com>
 <OF75EDBF48.5C308F1B-ON482583D8.0027A537-482583D8.002C0A64@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <a6b534c8-25c3-fe29-6266-0a29a862610d@gmail.com>
Date:   Wed, 10 Apr 2019 10:03:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <OF75EDBF48.5C308F1B-ON482583D8.0027A537-482583D8.002C0A64@mxic.com.tw>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 10:01 AM, masonccyang@mxic.com.tw wrote:
> Hi,
>  
>> Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
> driver
>>
>> On 4/10/19 3:33 AM, masonccyang@mxic.com.tw wrote:
>> > Hi Sergei,
>> >
>> >> > +static ssize_t rpc_spi_mem_dirmap_write(struct spi_mem_dirmap_desc
>> > *desc,
>> >> > +               u64 offs, size_t len, const void *buf)
>> >> > +{
>> >> > +   struct rpc_spi *rpc =
>> >> > +         spi_controller_get_devdata(desc->mem->spi->controller);
>> >> > +   int ret;
>> >> > +
>> >> > +   if (offs + desc->info.offset + len > U32_MAX)
>> >> > +      return -EINVAL;
>> >> > +
>> >> > +   if (len > RPC_WBUF_SIZE)
>> >> > +      len = RPC_WBUF_SIZE;
>> >> > +
>> >> > +   ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
>> >> > +   if (ret)
>> >> > +      return ret;
>> >> > +
>> >> > +   rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
>> >> > +                &desc->info.op_tmpl, &offs, &len);
>> >> > +
>> >> > +   regmap_update_bits(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD,
>> > RPC_CMNCR_MD);
>> >> > +
>> >> > +   regmap_write(rpc->regmap, RPC_SMDRENR, 0);
>> >> > +
>> >> > +   regmap_update_bits(rpc->regmap, RPC_PHYCNT,
> RPC_PHYCNT_STRTIM(7) |
>> >> > +            RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF,
>> >> > +            RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF);
>> >> > +
>> >> > +   memcpy_toio(rpc->wbuf, buf, len);
>> >>
>> >>    Wait, doesn't the manual say that the whole 256-byte buffer
> should be
>> >> filled?
> 
> it could be less than 256 bytes, i.e., 128 bytes to rpc->wbuf !
> 
>  I think that short chunks have to be written w/o WBUF (done,
>> > in fact,
>> >> by the HF driver).
>> >>
>> >
>> > From spi-nor.c layer always transfer 256 bytes data with page program
>> > command.
>>
>> Does that apply even for flashes with not-256-byte pages ?
>>
> 
> I think it needs to patch in case of nor->page_size = 512 bytes.

There are also flashes with page size < 256 bytes :)

-- 
Best regards,
Marek Vasut

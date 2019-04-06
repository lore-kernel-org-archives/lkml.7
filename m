Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07435C282DC
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 19:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0D62171F
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 19:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="DyUpNqKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfDFT7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 15:59:41 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34811 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfDFT7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 15:59:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id j89so7996211ljb.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 12:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8EoY4E+zgTj6Q4a5jQreky8OFMQSbhywxdKKa+6Bhw8=;
        b=DyUpNqKwyIkdP+97YYVMV2S/nTpHkJJiqqxKyyq0Ja+wQo9QpumaNfsr3/E7cPw8KV
         c702+kT9JCBHnnXb46wYzXvN48u5RodcbABTfAiRQ7pjjnIsulnE9irG7TvHA/Tua31k
         teUotVBpzxyQFwqloNOV8l6ruWSAGIqvDansJJq2NovA6tbsXvu+7vUWi/hJQcEvOyC9
         I8MeM1MNUfnZPR7ZTMC7+M2NLyTHE0PajI+KlzHexyhQxvE4LJ3Gi8O5qzEtCddsqud1
         0EKHcI2l6yVTCKgzQF4L0d2mu+0cEF4nL4CrFBjhLcGKl44WpfjmUVHdHjNOmXgXb9V/
         uoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8EoY4E+zgTj6Q4a5jQreky8OFMQSbhywxdKKa+6Bhw8=;
        b=QEeNrhvwsgiBRmIOev6e3wO81idVB/0n3cKLvgKYD1tJXC0paBVYHvzawK+Icqv5XC
         gOVBPva5W0l/xFn6bu1Qevs5IYkmhexJif+hS0W2rT6krG5GsueYhoCfKVbRiEN3g5mw
         iKdayzoXsPB7Nh3/s3mJvKZmy/j63jqoNk+HLLyhSI5pjU5Hc/PIOzjFfqzOKmNXHh2s
         fobBVSbA+hYAZO4izz2xXvW2eaJXOF4BQ57AmBCvdDlt3YkCKSGTJF9uQZktpxJu8JbA
         BMbMhFPq4CCpsrlysTSrtPsZ4KMqRy8Cnn//tUtIXSoq+o78NBj7VQnf/lvHRVldqx3K
         zIRA==
X-Gm-Message-State: APjAAAW0rFAFv/azelWv+6uldIBRm7FB19ZB+KyYJ3w7PPuTAFn7BguP
        9SksvNubOKsmTrAMPD7skrglYg==
X-Google-Smtp-Source: APXvYqzRggslbjwr6iDixsfnUIw24DgseOUXXNQ5DhWmCSX6rv48lVFYG+tzjIaZ+kWbmjbN3cMTPA==
X-Received: by 2002:a2e:9682:: with SMTP id q2mr10783137lji.168.1554580777355;
        Sat, 06 Apr 2019 12:59:37 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.86.164])
        by smtp.gmail.com with ESMTPSA id c15sm5219115lfi.14.2019.04.06.12.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 12:59:36 -0700 (PDT)
Subject: Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     masonccyang@mxic.com.tw, bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org,
        zhengxunli@mxic.com.tw
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
 <231f7423-bf13-99f8-427b-530f5446348b@cogentembedded.com>
 <OF7F1B534F.B934A9FE-ON482583D0.001DC618-482583D0.001FE84B@mxic.com.tw>
 <6d60bbef-a8ef-849e-33f3-3db35cefc09f@cogentembedded.com>
 <OFAEA16021.C7F7B095-ON482583D1.0031A13D-482583D1.00335085@mxic.com.tw>
 <7467d695-8922-16b2-03d4-fb4bbdda125a@cogentembedded.com>
 <20190404211234.5468e7a4@collabora.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <724feb3b-2ef9-3ff4-8cad-586162fbc471@cogentembedded.com>
Date:   Sat, 6 Apr 2019 22:59:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190404211234.5468e7a4@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2019 10:12 PM, Boris Brezillon wrote:

[...]
>>>>>>> +static ssize_t rpc_spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
>>>>>>> +                   u64 offs, size_t len, void *buf)
>>>>>>> +{
>>>>>>> +   struct rpc_spi *rpc =
>>>>>>> +         spi_controller_get_devdata(desc->mem->spi->controller);
>>>>>>> +   int ret;
>>>>>>> +
>>>>>>> +   if (offs + desc->info.offset + len > U32_MAX)
>>>>>>> +      return -EINVAL;
>>>>>>> +
>>>>>>> +   if (len > 0x4000000)
>>>>>>> +      len = 0x4000000;  
>>>>>>
>>>>>>    Ugh...  
>>>>>
>>>>> by mtd->size ?  
>>>>
>>>>   That'd be better, yes.
>>>>  
>>>
>>> Oops, it seems hard to get mtd->size info. from spi_mem_dirmap,  
>>
>>    It's in desc->info.length, no?
> 
> It's the lengths of the mapping which not necessarily mtd->size, but in
> the SPI NOR case it is :-). Anyway, you should not assume
> dirmapdesc->info.length == memory_device->size.
> 
>>
>>> I would like to keep 0x4000000.  
>>
>>    I'm seeing Boris in the CC's... Boris, is it legitimate to limit
>> a single dirmap read by the memory "window" size? Or should we try to 
>> serve any valid transfer length?
> 
> If by memory window you're talking about the memory region reserved in

   Yes, we have 64 MiB window thru which we can "look into" the large MTD chips.

> the CPU address space, then no. It should not be limited to this size
> if possible.

   Mhm, so we're expected to loop incrementing the window address register
in order to serve the full xfer request?

> Most HW have a way to configure an offset to apply to the spi-mem operation,
> and in that case, the driver should change this
> offset on the fly when one tries to access a region that's outside of
> the currently configured window.

   Well, my question wasn't about that actually -- that seemed quite obvious.

>>>>>>> +
>>>>>>> +   ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
>>>>>>> +   if (ret)
>>>>>>> +      return ret;
>>>>>>> +
>>>>>>> +   rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
>>>>>>> +                &desc->info.op_tmpl, &offs, &len);
>>>>>>> +
>>>>>>> +   regmap_update_bits(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD, 0);
>>>>>>> +   regmap_write(rpc->regmap, RPC_DRCR, RPC_DRCR_RBURST(32) |
>>>>>>> +           RPC_DRCR_RBE);
>>>>>>> +
>>>>>>> +   regmap_write(rpc->regmap, RPC_DRCMR, rpc->cmd);
>>>>>>> +   regmap_write(rpc->regmap, RPC_DREAR, RPC_DREAR_EAC(1));  
>>>>>>
>>>>>>    So you're not even trying to support flashes larger than the  
>>>> read dirmap?  
>>>>>> Now I don't think it's acceptable (and I have rewritten this code  
>>>> internally).  
>>>>>
>>>>> what about the size comes form mtd->size ?  
>>>>
>>>>    I'm not talking about size here; we should use the full address.
>>>> I'm attaching
>>>> my patch...  
>>>
>>> okay,got it!
>>> what about just
>>> -      regmap_write(rpc->mfd->regmap, RPC_DREAR, RPC_DREAR_EAC(1));
>>> +      regmap_write(rpc->mfd->regmap, RPC_DREAR,
>>> +                   RPC_DREAR_EAV(offs >> 25) | RPC_DREAR_EAC(1));
>>>
>>> because only > 64MByte size make RPC_DREAR_EAV() work.  
>>
>>    Boris, what's your opinion on this?
>>    Note that for the write dirmap we have just 256-byte buffer (reusing
>> the read cache). Is it legitimate to limit the served length to 256 bytes?

> I don't know what the HW is capable of,

   As I said, there's 64 MiB read window, and for the writes we can re-use the
read cache to write (exactly) 256 bytes at a time...

> but drivers should use any try
> they have to dynamically move the memory map window (make it point at a
> different spi-mem offset on demand). Note that dirmap_read/write() are
> allowed to return less than the amount of data requested, in that case
> the caller should continue reading at the offset where things stopped.
> This avoids having to implement a loop that splits things in several
> accesses when the access cannot be done in one step.

   Ah, this somewhat contradicts what you said earlier but seems clear now.
I'll go remove the loops. :-)

MBR, Sergei

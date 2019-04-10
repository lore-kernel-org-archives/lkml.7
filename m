Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C607C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFE52084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="fIK5TCou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbfDJRxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:53:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38064 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbfDJRxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:53:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id p14so2948045ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 10:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6NgXb4kZM1uwK5ZFibwxHkoqw1VKIFp5ONJCw3uE6LI=;
        b=fIK5TCouWfq9BD8TdTH2saWF9EmWhmihRzHS2hc9hLWg8gmNHZwtlmtMexRCVXHATc
         C6eAi1RzS0QGNer1Y2pJI4pEurP/crOfJRONgz9BZxOhcJxNGp5K8Afgn4hq39cINdww
         1I6qESS+pdARKSQa3wwiCRDRvyweQmpXJeoZbArqpCW8AQ2ZzdiLmtYcNT6sQceVp8ZS
         Ur+uOXSO3V+ULjj9bT/gRqZ8BJSP1BRZ5eeikKqWDPxMLABOYHmvokBPH7lnN52viARj
         UocsWjRBMti1WyYgGBUAnPTWWV5HFP7yC/TzBbtXsUCAjavtSwkdu712Zb1jTWqSOTYK
         ap4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6NgXb4kZM1uwK5ZFibwxHkoqw1VKIFp5ONJCw3uE6LI=;
        b=APJIMy23YsrZmYqEvJ3NgpYK1NzEEFYISlWyM6rFa244P6emedjUmJ/S5G1TEUXAyi
         Gbpuft34+hDtzhDvCvp0XqN9FkUz2BQbEUID7UHENVaBa6KewS/+vFwPwRNBpKT+r3UV
         ZOWmhnaACHd0BA4SzO5fAbXNIaRio0enjwpDUrbHJkg0L6fZSCnHEd8ZtsnrQLJqyvkm
         cuIOcI7w+JeI+1ONaodueafoOCzFTyr8U1W8syhTQWvLfMW1t/BmXeXu6NqIUJSGPJRO
         vmWQkW1ok8KQ+gfTf6V3thTsIcj1rp1wNeJtyWttLLL9yZTA8zdLpyfC7Q5CeFovyrq6
         u2bQ==
X-Gm-Message-State: APjAAAXPg43huzc2euBYrjckqlNDWazadIPH/yU5qGlTg3XyLVVbu0Kh
        fsiBTXimh425q++uH9YQ9FSStQ==
X-Google-Smtp-Source: APXvYqxhNGjd0drHimrd/jJmMbwctgvxLemPxaDnWpDoCaw14zp1BhWOjxCeFaK60Va+UUyE82d41Q==
X-Received: by 2002:a2e:7005:: with SMTP id l5mr24269781ljc.13.1554918794925;
        Wed, 10 Apr 2019 10:53:14 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.84.172])
        by smtp.gmail.com with ESMTPSA id f21sm6345236ljk.94.2019.04.10.10.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:53:13 -0700 (PDT)
Subject: Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     masonccyang@mxic.com.tw, Marek Vasut <marek.vasut@gmail.com>
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, zhengxunli@mxic.com.tw
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
 <a2dc294f-f2a1-2469-1f44-db67f9b8cc10@cogentembedded.com>
 <OFC7F0028A.CFF6BD04-ON482583D8.00084FA1-482583D8.0008985F@mxic.com.tw>
 <2095d059-8276-a01a-7c3a-da4647f7b7df@gmail.com>
 <OF75EDBF48.5C308F1B-ON482583D8.0027A537-482583D8.002C0A64@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <3f4a77a9-0c2a-b3c3-c97e-a3c84df90ef0@cogentembedded.com>
Date:   Wed, 10 Apr 2019 20:53:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OF75EDBF48.5C308F1B-ON482583D8.0027A537-482583D8.002C0A64@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 04/10/2019 11:01 AM, masonccyang@mxic.com.tw wrote:

>> >> > +static ssize_t rpc_spi_mem_dirmap_write(struct spi_mem_dirmap_desc
>> > *desc,
>> >> > +               u64 offs, size_t len, const void *buf)
>> >> > +{
>> >> > +   struct rpc_spi *rpc =
>> >> > +         spi_controller_get_devdata(desc->mem->spi->controller);
>> >> > +   int ret;
>> >> > +
>> >> > +   if (offs + desc->info.offset + len > U32_MAX)
>> >> > +      return -EINVAL;
>> >> > +
>> >> > +   if (len > RPC_WBUF_SIZE)
>> >> > +      len = RPC_WBUF_SIZE;
>> >> > +
>> >> > +   ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
>> >> > +   if (ret)
>> >> > +      return ret;
>> >> > +
>> >> > +   rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
>> >> > +                &desc->info.op_tmpl, &offs, &len);
>> >> > +
>> >> > +   regmap_update_bits(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD,
>> > RPC_CMNCR_MD);
>> >> > +
>> >> > +   regmap_write(rpc->regmap, RPC_SMDRENR, 0);
>> >> > +
>> >> > +   regmap_update_bits(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_STRTIM(7) |
>> >> > +            RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF,
>> >> > +            RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF);
>> >> > +
>> >> > +   memcpy_toio(rpc->wbuf, buf, len);
>> >>
>> >>    Wait, doesn't the manual say that the whole 256-byte buffer should be
>> >> filled?
> 
> it could be less than 256 bytes, i.e., 128 bytes to rpc->wbuf !

   The gen3 manual 1.50 contradicts:

Note: This area should be accessed sequentially from the start address and transfer size
to the device is 256-byte unit. All Write Buffer area should be filled with transfer data
in every transfer. When accessing non-sequentially or at random, the operation is not
guaranteed. After Write Buffer Operation, this cache area must be cleared by DRCR.RCF bit.

>  I think that short chunks have to be written w/o WBUF (done,
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

   What needs to patch what? :-)

> thanks & best regards,
> Mason

MBR, Sergei

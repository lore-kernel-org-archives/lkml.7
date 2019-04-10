Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244F5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43492084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+GwKOwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfDJG2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:28:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36806 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDJG17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:27:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id y13so1429341wrd.3;
        Tue, 09 Apr 2019 23:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vNqa9/DXQLZ/6iaq1hvBGg66rzJeqjewVzc/6LYjDcA=;
        b=C+GwKOwdiQhbDb3kDpEoF6CwW+2ohGilXyAt9reUtPIm+7gEjtq2xJE+JcyI5bgEx5
         oVDXKjGC3BK6x1cWeenVKSoRCoYDtk08gZEhyC1x+rXiOicrycp19ICqAkTOVfX77BJh
         k6IVjEo4ZN1r1SkXczcV+m8L0dY/HDpX14PxqT3SqcL3EWIo1k0OaN0XfW0gb7XXCiCi
         U40dXOsxUUxlXK3IC5ncUhSN0vwFAQyTivVqiXYdMWtnwEAMw05mFuGCNrLo8oFl4VOL
         XNSJCxLADaJ/eNS/rssFg6NIgViyHVDRcYDl3UYaKT1CmIQUfEZCTW2z0xYf9FEqZirh
         PoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vNqa9/DXQLZ/6iaq1hvBGg66rzJeqjewVzc/6LYjDcA=;
        b=nF7sYPVWHG0jZdU+uawBzCC1ZZ/SDmPDTXVLLrzyiOmBrQisLjRC79Ihk1Vp9bpKwg
         CUueoZFNdKRkQMVM4b7TYgFPrQoMsv1ySZuJpx6DeqD0r9yXXlKJn+faf25Qd4OQCpd/
         mrZMe+jVTkeQ3ZfqULvcdQuWWA0QdoL55X3QwsRliAQVOzon2g2NYHbqGC+R+6/t9Lb/
         TzYLeGbmWPZzNYbQJy6Bq7F3GYv9jlibX4W9cB63pTM9d9TvNbI4uCkL62w9oOfVe/36
         UVvF49QRGhvhZMT+f3VS/f8DyCjVU9POs01y0mB6XWEiWlaa9EovKCVS5Dykjod+ucSd
         napQ==
X-Gm-Message-State: APjAAAUd2GrQAHA0dsMk5rq/A0UOoDuQiO9hwGSqqLEnWCLV9pWjfEHj
        5vBzUkNSLuGt6dEB2q68UWY=
X-Google-Smtp-Source: APXvYqwfiSPq/X9lrGoNGOi7IYHZIkkD1hnlmYbCV0B41s7nSdVpiSa0UQNAq3VZ0VKl9uyavBUovQ==
X-Received: by 2002:a5d:6988:: with SMTP id g8mr26019436wru.117.1554877677087;
        Tue, 09 Apr 2019 23:27:57 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id s189sm2478754wmf.45.2019.04.09.23.27.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 23:27:56 -0700 (PDT)
Subject: Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     masonccyang@mxic.com.tw,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
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
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <2095d059-8276-a01a-7c3a-da4647f7b7df@gmail.com>
Date:   Wed, 10 Apr 2019 08:27:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <OFC7F0028A.CFF6BD04-ON482583D8.00084FA1-482583D8.0008985F@mxic.com.tw>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 3:33 AM, masonccyang@mxic.com.tw wrote:
> Hi Sergei,
> 
>> > +static ssize_t rpc_spi_mem_dirmap_write(struct spi_mem_dirmap_desc
> *desc,
>> > +               u64 offs, size_t len, const void *buf)
>> > +{
>> > +   struct rpc_spi *rpc =
>> > +         spi_controller_get_devdata(desc->mem->spi->controller);
>> > +   int ret;
>> > +
>> > +   if (offs + desc->info.offset + len > U32_MAX)
>> > +      return -EINVAL;
>> > +
>> > +   if (len > RPC_WBUF_SIZE)
>> > +      len = RPC_WBUF_SIZE;
>> > +
>> > +   ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
>> > +   if (ret)
>> > +      return ret;
>> > +
>> > +   rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
>> > +                &desc->info.op_tmpl, &offs, &len);
>> > +
>> > +   regmap_update_bits(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD,
> RPC_CMNCR_MD);
>> > +
>> > +   regmap_write(rpc->regmap, RPC_SMDRENR, 0);
>> > +
>> > +   regmap_update_bits(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_STRTIM(7) |
>> > +            RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF,
>> > +            RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF);
>> > +
>> > +   memcpy_toio(rpc->wbuf, buf, len);
>>
>>    Wait, doesn't the manual say that the whole 256-byte buffer should be
>> filled?  I think that short chunks have to be written w/o WBUF (done,
> in fact,
>> by the HF driver).
>>
> 
> From spi-nor.c layer always transfer 256 bytes data with page program
> command.

Does that apply even for flashes with not-256-byte pages ?

-- 
Best regards,
Marek Vasut

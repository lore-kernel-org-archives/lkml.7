Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B6CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926E92075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="Oj6L+RzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbfDDS4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:56:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46437 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729848AbfDDS4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:56:24 -0400
Received: by mail-lj1-f196.google.com with SMTP id h21so3009120ljk.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 11:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IGdEIicP+8t1C6mcNdRJsCFZdpqVhcHRqcsl11vseHI=;
        b=Oj6L+RzS4yQZiEvlfHOGLxrCEft8Qj6IEYeLHaobP9ePYwpuVmTK95BgUcBamXeY1o
         U8Sv+a8CtA37aWDGXV5PX5gcX7wWHdOxBK+xPSngdcwhbF/iOy0En9eCevpdIGl2ccml
         iEcxmx78XvZAL1Wg866gUqVKfFDFLsgIX/uIWD7dHXSf736LoDlf0jyCjMBpcVqSmDHd
         rRo7tH+cQGGpVwzqAyAbHx7OkIDnVGwyDd/hBRAAZu1R3+6n38qgcK/WJztNB7wLGYor
         covhvKrqPgci+YZ8j1Hy6YPT/mHFW3IzOLSgKgocUTGnQZHQuWqJqrQ7Quq2V/4mfjyg
         cSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IGdEIicP+8t1C6mcNdRJsCFZdpqVhcHRqcsl11vseHI=;
        b=EqSDDsxCJ4h/O3bo9BfruRuLPvZDoDZb7T8AJJKnzkShrq3uLJSNcARF4W4n1q5XV9
         YjGqmcv0IrQPsWG6fhnvmkeUk4l73/BN8i+T84+1Z/U9Fug55luu71eHUFSetiCKapDD
         GdRjuQOrwf4y4zRwLJc4STXypZZsXvUrLyet3cfBoFvKoZsc0+nGwPTQb7/QkVlNMrd2
         gJwe/8CBsPLFwSmcJkMRuvm3zOCHGvp5tzZEPhStZo9z+15N0ZVxw/ukOzenC7lyBCvX
         NtWWMvbmdChx8vUY2YHvt/0MJQ0XjbnMXOGfC8CkKKHLdy0kNSWQWCiWyofGl5bT9sCr
         yM6g==
X-Gm-Message-State: APjAAAX++5J6NwZ3AXeNwIQtedo/WOXNXaVbr2sYwlStLmRQSCkw4tEP
        ITUKT+9cCaPdWK1+DMsgvivWRQ==
X-Google-Smtp-Source: APXvYqwy7XHAlYWcABaU/Uq7GC2g/PEW3KnxIc/VcIeseMD+v3OprtWGNpFuebdscCm8J8T+eWB7xQ==
X-Received: by 2002:a2e:5518:: with SMTP id j24mr4251148ljb.167.1554404182072;
        Thu, 04 Apr 2019 11:56:22 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.80.163])
        by smtp.gmail.com with ESMTPSA id k10sm4223792ljh.86.2019.04.04.11.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 11:56:21 -0700 (PDT)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
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
Organization: Cogent Embedded
Message-ID: <7467d695-8922-16b2-03d4-fb4bbdda125a@cogentembedded.com>
Date:   Thu, 4 Apr 2019 21:56:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OFAEA16021.C7F7B095-ON482583D1.0031A13D-482583D1.00335085@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 04/03/2019 12:20 PM, masonccyang@mxic.com.tw wrote:

>> >> > +static void rpc_spi_mem_set_prep_op_cfg(struct spi_device *spi,
>> >> > +               const struct spi_mem_op *op,
>> >> > +               u64 *offs, size_t *len)
>> >> > +{
>> >> > +   struct rpc_spi *rpc = spi_controller_get_devdata(spi->controller);
>> >> > +
>> >> > +   rpc->cmd = RPC_SMCMR_CMD(op->cmd.opcode);
>> >> > +   rpc->smenr = RPC_SMENR_CDE |
>> >> > +           RPC_SMENR_CDB(ilog2(op->cmd.buswidth));
>> >> > +   rpc->totalxferlen = 1;
>> >> > +   rpc->xfer_dir = SPI_MEM_NO_DATA;
>> >> > +   rpc->xferlen = 0;
>> >> > +   rpc->addr = 0;
>> >> > +
>> >> > +   if (op->addr.nbytes) {
>> >> > +      rpc->smenr |= RPC_SMENR_ADB(ilog2(op->addr.buswidth));
>> >> > +      if (op->addr.nbytes == 4)
>> >> > +         rpc->smenr |= RPC_SMENR_ADE(0xf);
>> >> > +      else
>> >> > +         rpc->smenr |= RPC_SMENR_ADE(0x7);
>> >> > +
>> >> > +      if (offs && len)
>> >> > +         rpc->addr = *offs;
>> >> > +      else
>> >> > +         rpc->addr = op->addr.val;
>> >> > +      rpc->totalxferlen += op->addr.nbytes;
>> >> > +   }
>> >> > +
>> >> > +   if (op->dummy.nbytes) {
>> >> > +      rpc->smenr |= RPC_SMENR_DME;
>> >> > +      rpc->dummy = RPC_SMDMCR_DMCYC(op->dummy.nbytes);
>> >>
>> >>    So you haven't fixed this bug? I repeat, the driver doesn't work right
>> >> w/o this fixed!
>> >
>> > Do you mean
>> >
>> > rpc->dummy = RPC_SMDMCR_DMCYC(op->dummy.nbytes) * 8;   ?
>>
>>    Yes. Or some other code that amounts to it.

   Oops, I wasn't attentive enough, I was proposing:

	rpc->dummy = RPC_SMDMCR_DMCYC(op->dummy.nbytes * 8);

> why not setting "op->dummy.nbytes = 7" from spi-nor.c protocol layer ?

   We want 8 dummy clocks, not 8 dummy bytes. And if you'd looked into
spi_nor_read_sfdp(), you'd have seen that it requests 8 dummy clocks already.

> driver may check device ID or something else to setup op->dummy.nbytes.

   The RDSFDP command is not chip specific.

> I think it is not a good idea to *8 in spi host driver.

>> > What is your flash part number?
>>
>>    Spansion/Cypress S25FS512S. The datasheet says there must be 8 dummy cycles
>> for the RSFDP command...
>>
>> > The problem you found is in 1 bit or 4 bits width ?
>>
>>    1-bit, I think.
>>
>> >>
>> >> [...]
>> >> > +static ssize_t rpc_spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
>> >> > +                   u64 offs, size_t len, void *buf)
>> >> > +{
>> >> > +   struct rpc_spi *rpc =
>> >> > +         spi_controller_get_devdata(desc->mem->spi->controller);
>> >> > +   int ret;
>> >> > +
>> >> > +   if (offs + desc->info.offset + len > U32_MAX)
>> >> > +      return -EINVAL;
>> >> > +
>> >> > +   if (len > 0x4000000)
>> >> > +      len = 0x4000000;
>> >>
>> >>    Ugh...
>> >
>> > by mtd->size ?
>>
>>   That'd be better, yes.
>>
> 
> Oops, it seems hard to get mtd->size info. from spi_mem_dirmap,

   It's in desc->info.length, no?

> I would like to keep 0x4000000.

   I'm seeing Boris in the CC's... Boris, is it legitimate to limit
a single dirmap read by the memory "window" size? Or should we try to 
serve any valid transfer length?

>> >> > +
>> >> > +   ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
>> >> > +   if (ret)
>> >> > +      return ret;
>> >> > +
>> >> > +   rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
>> >> > +                &desc->info.op_tmpl, &offs, &len);
>> >> > +
>> >> > +   regmap_update_bits(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD, 0);
>> >> > +   regmap_write(rpc->regmap, RPC_DRCR, RPC_DRCR_RBURST(32) |
>> >> > +           RPC_DRCR_RBE);
>> >> > +
>> >> > +   regmap_write(rpc->regmap, RPC_DRCMR, rpc->cmd);
>> >> > +   regmap_write(rpc->regmap, RPC_DREAR, RPC_DREAR_EAC(1));
>> >>
>> >>    So you're not even trying to support flashes larger than the
>> read dirmap?
>> >> Now I don't think it's acceptable (and I have rewritten this code
>> internally).
>> >
>> > what about the size comes form mtd->size ?
>>
>>    I'm not talking about size here; we should use the full address.
>> I'm attaching
>> my patch...
> 
> okay,got it!
> what about just
> -      regmap_write(rpc->mfd->regmap, RPC_DREAR, RPC_DREAR_EAC(1));
> +      regmap_write(rpc->mfd->regmap, RPC_DREAR,
> +                   RPC_DREAR_EAV(offs >> 25) | RPC_DREAR_EAC(1));
> 
> because only > 64MByte size make RPC_DREAR_EAV() work.

   Boris, what's your opinion on this?
   Note that for the write dirmap we have just 256-byte buffer (reusing
the read cache). Is it legitimate to limit the served length to 256 bytes?

> thanks & best regards,
> Mason

MBR, Sergei

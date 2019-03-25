Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDF0C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2147620854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="PJ0j7D3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbfCYTMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:12:14 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45774 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729552AbfCYTMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:12:14 -0400
Received: by mail-lf1-f66.google.com with SMTP id 5so6824679lft.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 12:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nxeN+I2Sn1SQmMtA5hqUZfutWoWefVTjxJdbXNva3OE=;
        b=PJ0j7D3IJUdSdydPjcL9OYtBRN7cuROwz4geph+U5FEqwskK5sGVGKGGepmTdMkUNi
         PDirk/z0slq55/eCXOe9bb+0j//BuMcIPqOaM4cd5rrETvq1tDIDy9+/rhxMMHOIRa8P
         uBMgJT3luUsZ+cM2tAloOCqyMgo/XGDeG1eczVO2cbUdk8d9o8yvJD5wX/OCSz3rlIKu
         4tieTAOsD7QOYkw9WAKzCPcPdtgEheZyuvShqQWLq7OYJ89dx/PtotSiveihQf2WwoqZ
         s8yXnw98e9VtsG+VXXNwydKZaSTHuVp28imhmhLaRdoei89cnVtrMviZfIfy1F5q6n5h
         pTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nxeN+I2Sn1SQmMtA5hqUZfutWoWefVTjxJdbXNva3OE=;
        b=WxdGbPHowPywDNGgacTUXttezdjpuM92us5kXCwYaEDojrCG+LWxckYV9O8ne9/1yY
         skBMyNNDA1+XwxT2J5dLbj+yhjqJ3i2ddtuH/+IDePZeqS8YTw4CaheXiWUS6Mrbg3pX
         +YxMF9WTVMCv/uy/ZSm6/RwwtDVRE607tQVF53Grve9DvpCPhOcrPOHrw2CNYH4G/0jS
         gb+HpDsdoGmHR4qZpCR4th0MV5l3istqPG1ttLwB/wFa1u0XJcJfk6LQVlSw2oKIXacE
         y8LSjbyaanIdnpTIyT0w6lCfiJtVibzZkoJAsy6idF7ewCqBmMbQUTfSbQJgb3C4KNmU
         LlCA==
X-Gm-Message-State: APjAAAXgiqfHqXgtgWrSrTadlkqPLCZeRKAf14YlDjtXeyHZ6UtHP1nN
        KRiM2uYf4rmaBMAweYLz/2iIOg==
X-Google-Smtp-Source: APXvYqyraT7vThji+MH6t3/LlK40iaDRDRiVDQv29arIypo8rbZePyPuLE5x9wUmiyUu73694XYarQ==
X-Received: by 2002:a19:4283:: with SMTP id p125mr13421842lfa.3.1553541132291;
        Mon, 25 Mar 2019 12:12:12 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.83.129])
        by smtp.gmail.com with ESMTPSA id t81sm3467841lff.21.2019.03.25.12.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 12:12:11 -0700 (PDT)
Subject: Re: [PATCH v8 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        zhengxunli@mxic.com.tw
References: <1548658158-5460-1-git-send-email-masonccyang@mxic.com.tw>
 <1548658158-5460-2-git-send-email-masonccyang@mxic.com.tw>
 <75c4642b-536e-f596-158d-387a63a5f6c5@cogentembedded.com>
 <OF7C1EB3FC.1ABCD2C2-ON482583C8.002D7A69-482583C8.002E899C@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <2fa6af66-de08-be37-7cdf-ccbf1e50ceb0@cogentembedded.com>
Date:   Mon, 25 Mar 2019 22:12:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OF7C1EB3FC.1ABCD2C2-ON482583C8.002D7A69-482583C8.002E899C@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 03/25/2019 11:28 AM, masonccyang@mxic.com.tw wrote:

>> > +static void rpc_spi_mem_set_prep_op_cfg(struct spi_device *spi,
>> > +               const struct spi_mem_op *op,
>> > +               u64 *offs, size_t *len)
>> > +{
>> > +   struct rpc_spi *rpc = spi_controller_get_devdata(spi->controller);
>>
>> > +   if (op->dummy.nbytes) {
>> > +      rpc->smenr |= RPC_SMENR_DME;
>> > +      rpc->dummy = RPC_SMDMCR_DMCYC(op->dummy.nbytes);
>>
>>    SMDMCR.DMCYC is in bits -- you forgot to multiply by 8.
> 
> ?
> 
> It's dummy cycles setting, i.e,. 0 is 1 cycle dummy and

   Yeah, I should've written "cycles", sorry about that.

> max is 0x13 for 20 cycle dummy, depends on transfer bit size setting = 1, 4 or 8.
> right ?

   Probably...

[...]

MBR, Sergei

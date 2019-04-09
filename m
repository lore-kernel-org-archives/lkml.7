Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC178C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE00B2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="dwS8iufe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfDILUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:20:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32835 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfDILUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 07:20:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id f23so14135850ljc.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 04:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XMjd+Z5TtJWiBstpifowsSf8F98Fkajedt9xyTgHezs=;
        b=dwS8iufejUMq4NnHxJ9L6WbEsbPHr+tzS5DPwjFJ8vibc6CeBI7nOc3IwOwx/hwxz6
         tpn2sUqbIgRbkcvCB/ptA23ibezwywfnkRS7tFzMh4CJoY6eBzdP49RGlklBbDTPsnCs
         tjwucuVN9qMshrSMJ5J1JvX0aYg6rXsUnGi3/bsdzi2jdxi9v5j9YioY8RWkF96Qmvn0
         94AmyGu8KTcaoWGPR1NxCNb1+5rtonersI9Jq1NOeczchslSGIzR88jaqH1/wiTKkm0x
         dlRwkogtRWVch9B1ligXdyPuVoLcHHCbt73K7nFCHVolfmg5whQ8xHLaGKN0vk5RdlMb
         JcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XMjd+Z5TtJWiBstpifowsSf8F98Fkajedt9xyTgHezs=;
        b=lv398j4AMmORG1/DMi/wkX+8fCCSQhb5QZwSHRl1zW2IwiW4f/Rvov7AkvN4RIvAGG
         RPxwCo/Go6lRtK/gxVES/jXAYFDa7ljsRzj2zZchhZIBXKQFT+4JmAL3TbShh+oGTRLm
         XlpX0XoKlN4lYplEhm5WlTJK12sQNEknXZIlA0hOEkc4P2RaAS8pjbytOEl93HHsf9oA
         bGTFdGd30E+/RE9Q0MLXsV2H5azphrK5OziBdXOjsT7dH8hySxkEZMVuTit5KwPHYdL4
         0P5yKSNVtOMgyfPCwjHAEdaYFR6w6mHNAMbzQZo5mui50pHrLDG+i1RoS7ef6Wj1M+HR
         orSw==
X-Gm-Message-State: APjAAAUW4xAdedfbJCPUWeb5diqnVsFZRMlbwvAS38djrEXUUWuhfCDr
        dCDxTtHIA6ReLYw75Om6m1Zwf9xyuOQ=
X-Google-Smtp-Source: APXvYqz0lLlr731+aUdxcZ03qBu5LLhB5ej7vVepKh81oDLEjZKKW8NWqtEcIwITXdPWwHzpYVIYWA==
X-Received: by 2002:a2e:91cb:: with SMTP id u11mr18656359ljg.64.1554808852787;
        Tue, 09 Apr 2019 04:20:52 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.87.225])
        by smtp.gmail.com with ESMTPSA id d16sm630906lfi.75.2019.04.09.04.20.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 04:20:51 -0700 (PDT)
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
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <869a1c6d-cfa6-35e9-592b-4e0937530e31@cogentembedded.com>
Date:   Tue, 9 Apr 2019 14:20:50 +0300
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

On 04/03/2019 12:20 PM, masonccyang@mxic.com.tw wrote:

[...]
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

   Seems OK now, after Boris' reply.

> thanks & best regards,
> Mason

[...]

MBR, Sergei

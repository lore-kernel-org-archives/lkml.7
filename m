Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502BFC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2660020862
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="wrWjZS1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbfEVRXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 13:23:08 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40153 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730171AbfEVRXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 13:23:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id h13so2291338lfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lBNMJ6UCxXT/YF+lFUeXussSr2NQJ1IFe7JSJtDJqb8=;
        b=wrWjZS1VcTFTBBgUzyHp1/AOCa/Nvm+zWwLMEzSDn4IFs2OMmIFs3ZM6B5WYEdlz+T
         xTjM5Jpr7BQp/By25fuYTpsMVTbxjhJUAEUohHCWk/Fl+mJKUwOcUQdnxd7YCDNL5iyr
         f5FSXooSRFOS5410Qxlcetg7xH/tX8DWAJzbNbvkViyT1p9Z0CQ770BJNLppHNvpaNN3
         9spTlhk2OnceN0iLWNU6MRzwajsAHsd3C26hFA1m42GIwSb6zjTwGoqA+Jm9YPm/4U4e
         jdORvkaReWF5CemOF59O3jAWFTzX/p4e+PsdWbIgYtG3qvPILUN2OR9neqdRve9RvrBn
         9IGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lBNMJ6UCxXT/YF+lFUeXussSr2NQJ1IFe7JSJtDJqb8=;
        b=hZrknCdoPdO2Po6EzUxBRfgQc4K22+OQs9cPyZWH/AAYaofmlr9qm6SwfnAqYUaj8k
         kfxyAeJEDbcuPavH1GjmyZmettV8138SHU59MnqjEMnejSjhHLeSWgiOxPPZ7MLIzHlK
         kMqy0NmVcdZgSZ8MM3KGmcriqUXSfiXEUMA6F68IY/Rjm/dwdDM7rJFyURx+LSh0OfAu
         KtlXuLmalktAA7i2uLWyDiFZu/sINqgho9fX+iWb0HLLib4ybHmHWUWAHwJX1ewhF1qa
         gels2Lkb5M2VInFPXn7QIP/jK1QrlrSbquRyNCv6FYvNJSmCwy7BUy+NV+sLAMW1m1uK
         qTVw==
X-Gm-Message-State: APjAAAWr/KY19SCRzunxH0zzNqVVHX1ECi4uAtu32EOGsnAYVl5uJfiZ
        0FX6i1+JXtncFVySBiIZDby9Sg==
X-Google-Smtp-Source: APXvYqxh6z0c+HMItpmjk7oDLYnEBiKv2gMrikNxJClquOF/OVRMup6KVFeHonqCNSkGHl69ulKwBQ==
X-Received: by 2002:ac2:483c:: with SMTP id 28mr26309353lft.93.1558545786181;
        Wed, 22 May 2019 10:23:06 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.80.150])
        by smtp.gmail.com with ESMTPSA id r19sm4762708lji.87.2019.05.22.10.23.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 10:23:05 -0700 (PDT)
Subject: Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF MFD bindings
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mason Yang <masonccyang@mxic.com.tw>,
        Lee Jones <lee.jones@linaro.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>, zhengxunli@mxic.com.tw,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw>
 <20190424212356.GA27103@bogus>
 <65853dc2-6f3c-1494-7e72-54877797cdd2@gmail.com>
 <20190507125730.GD29524@dell>
 <OF08A5650B.8AE8977C-ON482583F4.000E5B1E-482583F4.000F7215@mxic.com.tw>
 <d229b19e-351c-c576-b5c4-716d10dad1a0@gmail.com> <20190508061119.GB7627@dell>
 <OFE86674B9.06D723A0-ON482583F5.000AD50C-482583F5.000BA075@mxic.com.tw>
 <a05cff8f-7df2-1938-c0e7-f9366bece607@cogentembedded.com>
 <OFB19BCE91.6EBBAA77-ON482583F6.000234E2-482583F6.00061290@mxic.com.tw>
 <CAMuHMdUP8KU3Dbv6cwOvrY0hWOcm1xqVcsi20+GvazYMDLGGZg@mail.gmail.com>
 <OFD932ABFC.E3FFCEB8-ON482583F9.003412B1-482583F9.0034D5CA@mxic.com.tw>
 <b51d1cb7-b3b5-208f-ab4c-145ecb57805d@cogentembedded.com>
 <44bc8f0a-cbdc-db4a-9a46-b8bae5cc37a2@cogentembedded.com>
 <OF5AF00898.3CE87C98-ON48258400.00259B16-48258400.0028A4F5@mxic.com.tw>
 <5e718d9f-3aeb-c2ef-0723-400497b2b98f@cogentembedded.com>
 <CAMuHMdUWNqkZz5DEWFJsoHLmC86ziLjWKHpz=A-EmvMDDgnSNQ@mail.gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <bba153f8-051c-9880-eacf-2ff698cc0171@cogentembedded.com>
Date:   Wed, 22 May 2019 20:23:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUWNqkZz5DEWFJsoHLmC86ziLjWKHpz=A-EmvMDDgnSNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/2019 08:05 PM, Geert Uytterhoeven wrote:

>> On 05/20/2019 10:23 AM, masonccyang@mxic.com.tw wrote:
>>> +- clocks: should contain 1 entries for the module's clock
>>
>>    1 entry (clock node phandle and specifier).
> 
> Doesn't "specifier" mean "phandle + optional arguments"?

   No.
   E.g. when specifying the IRQs, the "interrupts" prop contains one or more
interrupt specifiers, the phandle is specified in the "interrupt-parent"
prop (see the DT spec). 

> Gr{oetje,eeting}s,
> 
>                         Geert

MBR, Sergei

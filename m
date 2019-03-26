Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CCEC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A862075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="J/PzijmW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbfCZQmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:42:23 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42145 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfCZQmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:42:22 -0400
Received: by mail-lf1-f65.google.com with SMTP id b7so4636003lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fQqDceRSF84Gr4469DOlDRRMz3eSXeQewVj2Ep3MhjA=;
        b=J/PzijmWjYNpaGS9kac+B5xSWUcXaQMJ5hTQhiRkfcXT7+UKa/tbKbtghtNyDgR1yy
         ic+VvlbeTlhP9tY7zv676KUiLKd8fDG1NANhl33vRfcR2Niccl7nvW08Lg+Ltd64GNxD
         FTWgsHhyWJG0QRt0ABaVf1ZJPxPpNKbWoH0Mt1+FtFYPt8GJc92FLx3MpRbXWyvt3cQF
         5Y1QZuVf+sJD4EX0E83GS11vdwejFjrIDHNVHJttMs4gcmYeMLE8aPXxBhTxsxhEOXsf
         9v6vYmjhnMfeymfooid4uepcavAXIDFHZucIuWpRQuPmzrpMG9gEMHqZ1VODSZ10XZiv
         IOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fQqDceRSF84Gr4469DOlDRRMz3eSXeQewVj2Ep3MhjA=;
        b=orGZeP66R+TjMlPreUEL5dKffLJKo2prjrIeFoZFWhczZB+2Wq+U+35me5vyYuTuQi
         AsDzW0R3TetDqh0TvHsRb16AGTKm/aGYCS2J18DeHWF+vw4mPc50G9UDM00yVVwjeYNn
         Rj6EPaSBlk+xAbf5JaQNBvK+WvTABSUwbzEAig1PAZ5NHc5NddicCTefvPdIyXx4H0eO
         uJTPJB/aeFt1LNMzTcY4qclHeKVTFMM/sonJal7CF3oxPwaGK+BZL56VtBIPNQQucPAl
         Cl1rZqJ4q1D3rgMYc0Uma079KTjQlVCsamolDUFdRSq9Q2Ba8IpqApvzkRbZZr5QPf7d
         /Hww==
X-Gm-Message-State: APjAAAXkohWttVDuj3Bcxp5PzJADmBR6V93cN1ugg6lObuyHYgzrdPWK
        iAZYo1EcMWMvcemdqXnFyBHK4g==
X-Google-Smtp-Source: APXvYqwbLJxpJ63gBUx/ndvtbVp+N0jZ0XtQb5QpnCds9r5Yl2pSdOXIU0LI82XusfN2VrWTxDFTfQ==
X-Received: by 2002:a19:f50f:: with SMTP id j15mr16826974lfb.126.1553618540256;
        Tue, 26 Mar 2019 09:42:20 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.80.251])
        by smtp.gmail.com with ESMTPSA id x20sm3749393lfc.94.2019.03.26.09.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 09:42:19 -0700 (PDT)
Subject: Re: [PATCH v8 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
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
 <2fa6af66-de08-be37-7cdf-ccbf1e50ceb0@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <86e65614-814a-e8b8-fdbe-4b7b033e4938@cogentembedded.com>
Date:   Tue, 26 Mar 2019 19:42:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <2fa6af66-de08-be37-7cdf-ccbf1e50ceb0@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/25/2019 10:12 PM, Sergei Shtylyov wrote:

>>>> +static void rpc_spi_mem_set_prep_op_cfg(struct spi_device *spi,
>>>> +               const struct spi_mem_op *op,
>>>> +               u64 *offs, size_t *len)
>>>> +{
>>>> +   struct rpc_spi *rpc = spi_controller_get_devdata(spi->controller);
>>>
>>>> +   if (op->dummy.nbytes) {
>>>> +      rpc->smenr |= RPC_SMENR_DME;
>>>> +      rpc->dummy = RPC_SMDMCR_DMCYC(op->dummy.nbytes);
>>>
>>>    SMDMCR.DMCYC is in bits -- you forgot to multiply by 8.
>>
>> ?
>>
>> It's dummy cycles setting, i.e,. 0 is 1 cycle dummy and
> 
>    Yeah, I should've written "cycles", sorry about that.

   I also should've mentioned that w/o this change the "read SFDP" command
returns garbage and the flash doesn't work.

[...]

MBR, Sergei

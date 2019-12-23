Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E79BC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23447205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+t1T8f/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfLWPo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 10:44:56 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39612 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfLWPo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 10:44:56 -0500
Received: by mail-lj1-f196.google.com with SMTP id l2so18142395lja.6;
        Mon, 23 Dec 2019 07:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2lALFLqIheLEgHIom7mAgKB0pZF1q4wqqt0Xf8KC/5k=;
        b=F+t1T8f/odmPzTeWRutRZxrRMBiD4W7vGnaiMemNWGLu9vhNsfXsQQnsoi3SioIkeA
         Kv7qGootjoia5FiW7NE0XAK4XiGXnfXsfz07IZX7tUVtH7pJUEKQBPiIJqPJHPhYSqah
         D+khuic8IqTB0+ohtEE4jJXzgV2I+ER7dRekTkD1kK6dD4EVdR+WUidMB9t4gH4HQEfZ
         ysqGtrVtbiQXBPjO6eJx4b/jnhGeDITTY/XxnKcyYZC0/K7PItaELcyvHa7HViOZjnc5
         X4pvqn/kaVX92uTADclg7X6RS8xvYuRrh2sDFur9NDdn2o/E2jrL4l8IUNfOHxCTA7hT
         drXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2lALFLqIheLEgHIom7mAgKB0pZF1q4wqqt0Xf8KC/5k=;
        b=TXdcGBo6tjdeUU1+StHhA+jvB9H4ARU2sdJ7ppxiOgMSw4+SDVzw1p3CCUqFvRtvqU
         VUXxmJaXHkAl+xQnzojUM6M83e+sSMZQbN1CgEV/PDan4IxyBz7TEC84yPGKvmuuKFQ2
         8nyudMJttSL3EKGLOiEvY0bRW4/vfsS62RSmqikUFgQKXNJUu69gOqI50X/dtVgT3+L6
         hMY4IbgBIeOMHVqgzgvB1y7JnSxmn8ByoXVgghlMAI4b6e/kuHNsneX6rG2CL1bcvVqg
         1HW1944Pr7gpvWb34G7qj9/VkpQ1rd1nSVEMab9uD39MkhXF92Emm6JVGX881HL8qsKY
         kDeQ==
X-Gm-Message-State: APjAAAXIiE0NMxM+zAWFUwDtGJo3S8nwlp1gbp8qg8RAh89Btx2ghISv
        88mSbMvJRVEb/I6OTGk7LK5Jowiv
X-Google-Smtp-Source: APXvYqwCeMb4P6fTo5DY4lhAVMql6DOsA6uHHbcjjpLG3OVynOKOvEBNHbpvrDATFxq7x3aiUb8DPg==
X-Received: by 2002:a2e:9e16:: with SMTP id e22mr1077005ljk.220.1577115893563;
        Mon, 23 Dec 2019 07:44:53 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id w17sm8494314lfn.22.2019.12.23.07.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2019 07:44:53 -0800 (PST)
Subject: Re: [PATCH 1/2] ARM: dts: tegra20: add labels to i2c nodes
To:     Richard Leitner <richard.leitner@skidata.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191219130431.30458-1-richard.leitner@skidata.com>
 <01ac756c-1e51-5d62-ca45-9e0b4f106a29@gmail.com>
 <27d4c933-8117-f38e-d4da-e58326fc6ee4@skidata.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1a93a7a6-c3a1-0b94-ce3e-de8971487de5@gmail.com>
Date:   Mon, 23 Dec 2019 18:44:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <27d4c933-8117-f38e-d4da-e58326fc6ee4@skidata.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

23.12.2019 10:46, Richard Leitner пишет:
> Hi,
> thanks for the reply.
> 
> On 20/12/2019 15:00, Dmitry Osipenko wrote:
>> 19.12.2019 16:04, Richard Leitner пишет:
>>> Add numbered labels to the i2c nodes of the Tegra20 SoC so we just need
>>> to alias it from derived boards.
>>>
>>> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
>>> ---
>>>   arch/arm/boot/dts/tegra20.dtsi | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> ...
> 
>>
>> Hello Richard,
>>
>> Why derived boards couldn't label nodes by themselves? That's what all
>> derived boards are doing already.
> 
> Of course they can, but IMHO its more useful to have the same labels for
> all derived boards.
> 
>>
>> BTW, upstream should benefit from the submitted changes. This is not a
>> very useful change for upstream if you're not updating the actual DTs of
>> any of the boards in arch/arm/boot/dts/*.
> 
> That's true. I thought of also patching the actual DTs but wasn't sure
> if that should be in the same series...
> Based on your answer I guess it should be.
> 
> Therefore I'll send a v2 soon.
> 
> Thanks again & regards;richard.l

Seeing the full picture will be very helpful, thanks.

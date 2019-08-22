Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50D9C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF6922CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pqw3Tx0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393299AbfHVUpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:45:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33764 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730839AbfHVUpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:45:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so6666624wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 13:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z38L1LbtkDwqSlnb2AxRpEWGcGzkq1fhYXo9J8r1ADY=;
        b=Pqw3Tx0tuUJ4rbh9hmqJEpjEUNIRzpD0VB8ScZaYDX66uXWfFYdvxdZuGoyyEkQqvQ
         HRs7xZrlXQJj5mSmolOcCQMCdVqFUHUqmZ9hcmksP+L42EyTfkvJeQuuH2WJ9+OPgZDb
         NhX49pAb3aKmtxrWYRvqowak0m8raH5HvI6QbVsmKKtO4AA6P6rN3yU0zZfxifgS3qNf
         fbkvmMRKGnlMUDOG9skav/H7zvnxP3siQsR+ejhjbY4a16FWvvJMOsK+PyAI2Y8ib4rZ
         SRgCuo6IZAWt+B5KX2AO0Q1aBV9kcDZCQ7hcuIWRPiMTHyiLhIOitcP25aQGrGG2vngS
         V16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z38L1LbtkDwqSlnb2AxRpEWGcGzkq1fhYXo9J8r1ADY=;
        b=sqfBssv66tDNYSgbjNChqrn72n1kOThvxkrBHX8PDWaA85Ylozglfr9PuxwoDYu1Qv
         /CgFxY9spJZF5iJWHHDbz8LRQ/xkr+DR2pWBsFeQBwrYt/i6kwGSkQkjqTZK+yeKqdGy
         22WI7JyV7RcI6I6zzpdDqXV9VCDN1UiNKehZrCNCyCXqdZ/ueXzhaRocQbeCmh8jXJhq
         sthKkCoXu1aR8vHvpWVmI+SYXCsseCLFZjEVWomutd2BQlkejce70P0jX64HPJN1j2+O
         AHzG2rHby5Kknt4lSHx/m3XwLQ7MUUYxEiBQHc014kTaLxSLB58pQDua9aA/Og9gpEgy
         hbRg==
X-Gm-Message-State: APjAAAVkGgnxduZIl9Yd9D8GvSv2Jvw4s3Z8t1M2V0nYb+F+Ks37l6xR
        OBifqU0kh1xZg2E9EbDj110=
X-Google-Smtp-Source: APXvYqzy4xhMTMOPearBfcoIurmKVvT1DSEF8CCco3VRkPpa4X5bcW062QVfakLsNqLXfVgDJryJ3A==
X-Received: by 2002:a5d:6b84:: with SMTP id n4mr940661wrx.118.1566506703097;
        Thu, 22 Aug 2019 13:45:03 -0700 (PDT)
Received: from [192.168.1.67] (host81-157-241-155.range81-157.btcentralplus.com. [81.157.241.155])
        by smtp.gmail.com with ESMTPSA id f197sm1373147wme.22.2019.08.22.13.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 13:45:02 -0700 (PDT)
Subject: Re: [RFC v4 07/18] objtool: Introduce INSN_UNKNOWN type
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        raph.gault+kdev@gmail.com
References: <20190816122403.14994-1-raphael.gault@arm.com>
 <20190816122403.14994-8-raphael.gault@arm.com>
 <20190822200406.jc3yf77pomxxwep6@treble>
From:   Julien <julien.thierry.kdev@gmail.com>
Message-ID: <3c4e3227-eeb3-371a-d015-a0e0e60e5332@gmail.com>
Date:   Thu, 22 Aug 2019 21:45:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190822200406.jc3yf77pomxxwep6@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

On 22/08/19 21:04, Josh Poimboeuf wrote:
> On Fri, Aug 16, 2019 at 01:23:52PM +0100, Raphael Gault wrote:
>> On arm64 some object files contain data stored in the .text section.
>> This data is interpreted by objtool as instruction but can't be
>> identified as a valid one. In order to keep analysing those files we
>> introduce INSN_UNKNOWN type. The "unknown instruction" warning will thus
>> only be raised if such instructions are uncountered while validating an
>> execution branch.
>>
>> This change doesn't impact the x86 decoding logic since 0 is still used
>> as a way to specify an unknown type, raising the "unknown instruction"
>> warning during the decoding phase still.
>>
>> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> 
> Is there a reason such data can't be moved to .rodata?  That would seem
> like the proper fix.
> 

Raphaël can confirm, if I remember correctly, that issue was encountered 
on assembly files implementing crypto algorithms were some 
words/double-words of data were in the middle of the .text. I think it 
is done this way to make sure the data can be loaded in a single 
instruction. So moving it to another section could impact the crypto 
performance depending on the relocations.

That was my understanding at least.

Cheers,

-- 
Julien Thierry

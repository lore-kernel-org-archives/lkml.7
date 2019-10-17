Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E275DECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF3220872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8XikbH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440718AbfJQRZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:25:45 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35669 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbfJQRZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:25:44 -0400
Received: by mail-yb1-f195.google.com with SMTP id i6so956263ybe.2;
        Thu, 17 Oct 2019 10:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nWD5b0MoHbCvknNDVqGUV4RSB9C7rG67yURZlZ2XgzA=;
        b=Z8XikbH2kKqHlcdWTq2QIIbLlUSDX/B2oHZLUObTv0rBEsOrumWXRzudmwQW4zfmWr
         KVdOdZlOes8/9Sac5RM3G3OziBnfyqfzB564WFUFY3/VWhPXyBLWmEzPlZ/y3nR2vr+s
         YNberX7IP0ygJfoFWsMXLCwpPov7b+f0aCO29uCle8XqXI8eW+9Srt3ACm9S/3UbSZZ2
         enigaXnxyNSpLEElb+EfWPGHBCkpZ1h/VTj2DE/8rAtbQ7Volb0K0O6tRRhsNM7WJcEd
         DEVo+lKrwDRHAnhRWoWbmbJrVSDjo1VNmfgGefWNilULpJQ6y7SfY7hGPUwutCLhSanZ
         krMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWD5b0MoHbCvknNDVqGUV4RSB9C7rG67yURZlZ2XgzA=;
        b=sbnUD/0w2awEvEikqPAt4Mu/cc4fuHIhiVHtOkqXmdzLsGehrICQrHQ5mn+6k6MeQR
         /Sdi5d46BpK0UAv3t6KB1kUCRa4p4Iv0S/pLSoDnQ0hUiLYA/ebFE2pHQO4RPGUF046U
         gpeKPR/ZLELCO0voBEN+erP5McPf/geLRgaoNLK9VRhRCPRURCdXk+//p76uLwvsmfBE
         +12ZGbxoYGxedpiuXv9LShJbmgYwV5oZizhRCukzpjjWa2mvQCkBAKlDqeB4FwSUf8Mc
         AE7JzF5G4QtTxIzM5guQwWh21uxGyTFdwgBYKvBof431DxYKNQk4KbRyWdb+rn1ahU6S
         hx3A==
X-Gm-Message-State: APjAAAXZqIUHINtW/dE9FnE/maseqnzFx7imqnbc+QK15+jhaKOMh/Ip
        CHZBhjrUmoaOifrasuG642Y=
X-Google-Smtp-Source: APXvYqy2XqFyvoko2lzT+4eV2PuLy4fUgikaTdLvK0VHRBqXvVAnllKP2ZFhRSq8ubkCvFkDzH1TBQ==
X-Received: by 2002:a25:d24b:: with SMTP id j72mr3062785ybg.158.1571333143962;
        Thu, 17 Oct 2019 10:25:43 -0700 (PDT)
Received: from [192.168.1.62] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id 80sm697943ywp.56.2019.10.17.10.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 10:25:43 -0700 (PDT)
Subject: Re: [PATCH] libfdt: reduce the number of headers included from
 libfdt_env.h
To:     Rob Herring <robh@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
References: <20190617162123.24920-1-yamada.masahiro@socionext.com>
 <CAK7LNATtqhxPcDneW0QOkw-5NyPNP06Qv0bYTe7A_gCiHMiU7A@mail.gmail.com>
 <CAK7LNASMwqy0ZUZ=kTJ7MJ6OJNa=+vbj5444xzmubJ8+6vO=sg@mail.gmail.com>
 <CAK7LNAS=9yGqMQ9eoM4L0hhvuFRYhg6S4i6J3Ou9vcB1Npj4BQ@mail.gmail.com>
 <20191017163414.GA4205@bogus>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <5b5ece90-0b9f-38e4-8c23-3c9ea4105c79@gmail.com>
Date:   Thu, 17 Oct 2019 12:25:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20191017163414.GA4205@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2019 11:34, Rob Herring wrote:
> On Wed, Oct 16, 2019 at 08:01:46PM +0900, Masahiro Yamada wrote:
>> Hi Andrew,
>>
>> Could you pick up this to akpm tree?
>> https://lore.kernel.org/patchwork/patch/1089856/
>>
>> I believe this is correct, and a good clean-up.
>>
>> I pinged the DT maintainers, but they did not respond.
> 
> Sorry I missed this. Things outside my normal paths fall thru the 
> cracks.
> 
> I'll apply it now.
> 
> Rob
> 

Looks like my reply crossed with Rob's.  Rob, shouldn't
scripts/dtc/update-dtc-source.sh make this change?

-Frank

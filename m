Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA40DECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986BD2089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nt6Lz1vJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406801AbfJQSqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 14:46:16 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34875 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388823AbfJQSqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 14:46:15 -0400
Received: by mail-yb1-f193.google.com with SMTP id i6so1035601ybe.2;
        Thu, 17 Oct 2019 11:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OM/S3lsFh+azFkd7x8LBwq6ZVZrV5M0QSAG7uJDmnRk=;
        b=Nt6Lz1vJUocf3260cbfS+m4Ma8HkJwjhVujx1dzWZRaeHi2gaDr5WJJEl+D8Sy/7kA
         3+C1eyDt9stz/AqFoXOwX6ws+UzvvkmV2GrEPvxaHThc8O3wWD2AHgjTg34u6VpCXSUx
         wkdZQ+tXKLMKZ4x72KHKzTWbj/ChMnjaNLGg2K0jKKIbyu6ESc51cte0qWIBs1TtgRj+
         ZjzL6vn8JfJ6Oxgvx4nki8ndGF4Ycn9wkQ7vIWsooSGRog0zExm/gUgB7YXhRme+5HQQ
         DGwCNySlNBrkStUIDfnLr4JJSGQr6Lghzl0PAJvNbifUqA6Y7KWvXf3SkB0Q3kTdnyEZ
         IwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OM/S3lsFh+azFkd7x8LBwq6ZVZrV5M0QSAG7uJDmnRk=;
        b=q01cIqinVOCsy88DZ9qszpDd2BCNTvbLjrZixslt3ONdavhP8Pdw1rXVRWacEU8QxY
         2wOBNCJDYP8lxBll9tIBzo7BAiLhcHSTw9OrttH0VGRxzCwZrf+71m/3CWRihWkJj+Ch
         lsnvKdQQt9UMpLT6jo0jBg10nuHeoLe5qvBPVkq61OkdjTosGRpHXWL6+/IKHPwCu+67
         XT6pyNUJlJWNpcHIMkQkgsnk0J1avQ+aJ7NQkPU5yEukSbipzMEmDMzvDDZjh/dIKD1g
         BL6FKx3TKpTk7kSShYVcOvjEZ6nu+TkjglkxQ7xafa4nGoqO3tph1zKl9sS1dlPFo7xC
         dePw==
X-Gm-Message-State: APjAAAW7sGpxsy2QziyVNPk0WcE7IY1/srbKj+sRz/21MRG909reeU3O
        vT/gKqTj4iVyenANVeB1DII=
X-Google-Smtp-Source: APXvYqwudHjq2c/EpVr+nuwySedX+dRgV0lUf5486GSBdOemPI2HmAgVLe0pRZjtkUb1YrrJPawlew==
X-Received: by 2002:a25:248a:: with SMTP id k132mr3464263ybk.243.1571337974592;
        Thu, 17 Oct 2019 11:46:14 -0700 (PDT)
Received: from [192.168.1.62] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id y63sm698731ywg.5.2019.10.17.11.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 11:46:14 -0700 (PDT)
Subject: Re: [PATCH] libfdt: reduce the number of headers included from
 libfdt_env.h
To:     Rob Herring <robh@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <20190617162123.24920-1-yamada.masahiro@socionext.com>
 <CAK7LNATtqhxPcDneW0QOkw-5NyPNP06Qv0bYTe7A_gCiHMiU7A@mail.gmail.com>
 <CAK7LNASMwqy0ZUZ=kTJ7MJ6OJNa=+vbj5444xzmubJ8+6vO=sg@mail.gmail.com>
 <CAK7LNAS=9yGqMQ9eoM4L0hhvuFRYhg6S4i6J3Ou9vcB1Npj4BQ@mail.gmail.com>
 <20191017163414.GA4205@bogus>
 <5b5ece90-0b9f-38e4-8c23-3c9ea4105c79@gmail.com>
 <CAL_JsqJHGcbf-p7D=MvSRiX_7CVY0Kj9bRKybhbWG=4MxaxGiw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <fcba8d22-008a-58b7-57ae-ef5fbc6234bc@gmail.com>
Date:   Thu, 17 Oct 2019 13:46:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJHGcbf-p7D=MvSRiX_7CVY0Kj9bRKybhbWG=4MxaxGiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2019 12:52, Rob Herring wrote:
> On Thu, Oct 17, 2019 at 12:25 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 10/17/2019 11:34, Rob Herring wrote:
>>> On Wed, Oct 16, 2019 at 08:01:46PM +0900, Masahiro Yamada wrote:
>>>> Hi Andrew,
>>>>
>>>> Could you pick up this to akpm tree?
>>>> https://lore.kernel.org/patchwork/patch/1089856/
>>>>
>>>> I believe this is correct, and a good clean-up.
>>>>
>>>> I pinged the DT maintainers, but they did not respond.
>>>
>>> Sorry I missed this. Things outside my normal paths fall thru the
>>> cracks.
>>>
>>> I'll apply it now.
>>>
>>> Rob
>>>
>>
>> Looks like my reply crossed with Rob's.  Rob, shouldn't
>> scripts/dtc/update-dtc-source.sh make this change?
> 
> No, the includes in include/linux are kernel files which wrap/replace
> the upstream ones.
> 
> Rob
> 

Right you are, I overlooked the "include/linux" in the file name
instead of "scripts/dtc/libfdt/".

-Frank

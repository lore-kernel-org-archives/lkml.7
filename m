Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE54C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67110206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="QIoixCtM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfKKHd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 02:33:57 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45438 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfKKHd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 02:33:57 -0500
Received: by mail-lf1-f66.google.com with SMTP id v8so9004857lfa.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 23:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=11XyuX75h6wLXlM8eIF2c6GY+p1TuOaj5FL64Q+XyMA=;
        b=QIoixCtMLQtH5ivP/i+BLVDDT85cUSsT96NwuYXO3sqDavMb8qbqaQ1rEt/1rhsQA7
         9bKf54a4NzkBgFwDRc6SljVSQAg1BpYhc8pdaWjO7e6h4+yXUcxfj4fCMA6hFTn/pwYL
         UTkRBuhH71NZcBtzr9R67ULNVOR+UkkeOxlpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=11XyuX75h6wLXlM8eIF2c6GY+p1TuOaj5FL64Q+XyMA=;
        b=ZewmN01XooC6ZYwg+1+qPl47+hz9Og6pKalXLvI9tZG+/7aq3VRPxfu25abijzNgK8
         /8J1Kp+rfEyZswvxEaHolg32xxh+Xmd58zflPChH+vP7ub6X+HWItolXLM2H9GGuEgbu
         lw2Zi/7h2fd4GpmY9PF0yMvxQQqJv6tpHF8RpghLxPq8ZAjw+2xXqSildLRZSjYazVOy
         +zDP/MQw1JyqI+bcn4yK1M71h3wBuUQ0C4M4vaFjsWlrdqicP7PzXxvQ8CBpfo/n1TXn
         x8XLDns7ki4f3Du/fgn+0F7l5UaDU6De274ZfusYnhihfa4E/P9s3TSKtWxCStEeH41q
         jzrg==
X-Gm-Message-State: APjAAAWOPvOtbAaLY8gA6zRwE5y91NNAdOj8avTnas/3pW1qPSxxm/H4
        w3nZpfXMoj01pxCIowN49kzgnQ==
X-Google-Smtp-Source: APXvYqwWjm4XW5IM/KA1VQfUmHJXZcUSfm6veYrOgywqCu+f4k/Fz0EK4oxRy/gcrvKaSfQ4yzaE2Q==
X-Received: by 2002:a19:855:: with SMTP id 82mr14378120lfi.44.1573457634762;
        Sun, 10 Nov 2019 23:33:54 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id z127sm5941129lfa.19.2019.11.10.23.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 23:33:54 -0800 (PST)
Subject: Re: [PATCH v4 47/47] soc: fsl: qe: remove PPC32 dependency from
 CONFIG_QUICC_ENGINE
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
 <20191108130123.6839-48-linux@rasmusvillemoes.dk>
 <CADRPPNQwnmPCh8nzQ5vBTLoieO-r2u0huh17mwcinhfhNgo04A@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <14894529-a6bd-9b7e-eacc-06d5e49cc8e8@rasmusvillemoes.dk>
Date:   Mon, 11 Nov 2019 08:33:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CADRPPNQwnmPCh8nzQ5vBTLoieO-r2u0huh17mwcinhfhNgo04A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2019 00.48, Li Yang wrote:
> On Fri, Nov 8, 2019 at 7:05 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> There are also ARM and ARM64 based SOCs with a QUICC Engine, and the
>> core QE code as well as net/wan/fsl_ucc_hdlc and tty/serial/ucc_uart
>> has now been modified to not rely on ppcisms.
>>
>> So extend the architectures that can select QUICC_ENGINE, and add the
>> rather modest requirements of OF && HAS_IOMEM.
>>
>> The core code as well as the ucc_uart driver has been tested on an
>> LS1021A (arm), and it has also been tested that the QE code still
>> works on an mpc8309 (ppc).
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>>  drivers/soc/fsl/qe/Kconfig | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
>> index cfa4b2939992..f1974f811572 100644
>> --- a/drivers/soc/fsl/qe/Kconfig
>> +++ b/drivers/soc/fsl/qe/Kconfig
>> @@ -5,7 +5,8 @@
>>
>>  config QUICC_ENGINE
>>         bool "QUICC Engine (QE) framework support"
>> -       depends on FSL_SOC && PPC32
>> +       depends on OF && HAS_IOMEM
>> +       depends on PPC32 || ARM || ARM64 || COMPILE_TEST
> 
> Can you also add PPC64?  It is also used on some PPC64 platforms
> (QorIQ T series).

Sure, but if that's the only thing in the whole series, perhaps you
could amend it when applying instead of me sending all 47 patches again.

Should PPC32 || PPC64 be spelled PPC?

Rasmus

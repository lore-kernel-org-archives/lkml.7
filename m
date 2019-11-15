Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD35C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF22420740
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="bhvYGZ1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfKOILr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 03:11:47 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35310 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOILp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 03:11:45 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so7351146lfl.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 00:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cSkg4y8vQ0fWUekpUvYTG37APlVQNKH+BU4UyQZbeZs=;
        b=bhvYGZ1lTQHiSLEBGy316WOg8uJmr19WMwnbnCNIAe+g9dECIpGAveiykIv51Zsp5H
         q5H02EIco+WEDC56pAH5UpavswZnVJ6/TzgN01/XvbZ3WOk6dfiSFEIqLOP91nIopmjO
         i5sekMVyCaqS+WJFufl8nVmciwx4GpUp4vHh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cSkg4y8vQ0fWUekpUvYTG37APlVQNKH+BU4UyQZbeZs=;
        b=r2cd7sG/S1dxYXIgmAGLx/SeAoNiGupwu13CmaDz8REU2qDacvBfmfCYOiUHy1RSRT
         uDfC4FUdWUR5A4GiMbgAMtU0O0OKslpPvNYisMj/LbErypNbApAgEXap+8WBddt6bNpZ
         b3v5tR2K8WiG6bH9YhH6Z2YGX9PckSJe7/vt/FUnJryK7sohwbxPvM4jedKOspwAMGvM
         xcrDh8N8TlVSE4xRE9GKnQwiBcdsnck6h3YR6uZJLGEQAlYwC8wjFU4K5+WrYXfgc49d
         nb+inl689p3Evme83j3/kXIiNHnv6QssYlxXRvoSFJgZqLREPjCMz2zphDE07eN72IyP
         YiOw==
X-Gm-Message-State: APjAAAXFGXq9lL8Ohs1bmq+d3wrx8aII/FlBwyReJAVkr7XlzZ46hMKW
        cNnEwIkhM20KnpiVcWVV1kcX11lVPPdw8WiN
X-Google-Smtp-Source: APXvYqx6iGcHvwJhuRwgIveFwGhIs3bltyGjSHCtX4coi17em4/eMuEjk9toc+eYfX3AS6UqL2gs4g==
X-Received: by 2002:a19:8104:: with SMTP id c4mr317478lfd.165.1573805503320;
        Fri, 15 Nov 2019 00:11:43 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m8sm3414243ljj.80.2019.11.15.00.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 00:11:42 -0800 (PST)
Subject: Re: [PATCH v4 07/47] soc: fsl: qe: qe.c: guard use of
 pvr_version_is() with CONFIG_PPC32
To:     Timur Tabi <timur@kernel.org>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
 <20191108130123.6839-8-linux@rasmusvillemoes.dk>
 <CAOZdJXXHK9U_Y7_VgVmuOFKDAh4OqBJ7hZx58hisZZ6Cz6xE2w@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <027c2b7a-a235-cecf-9f08-f71736f2ea55@rasmusvillemoes.dk>
Date:   Fri, 15 Nov 2019 09:11:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAOZdJXXHK9U_Y7_VgVmuOFKDAh4OqBJ7hZx58hisZZ6Cz6xE2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2019 05.50, Timur Tabi wrote:
> On Fri, Nov 8, 2019 at 7:04 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> +static bool qe_general4_errata(void)
>> +{
>> +#ifdef CONFIG_PPC32
>> +       return pvr_version_is(PVR_VER_836x) || pvr_version_is(PVR_VER_832x);
>> +#endif
>> +       return false;
>> +}
>> +
>>  /* Program the BRG to the given sampling rate and multiplier
>>   *
>>   * @brg: the BRG, QE_BRG1 - QE_BRG16
>> @@ -223,7 +231,7 @@ int qe_setbrg(enum qe_clock brg, unsigned int rate, unsigned int multiplier)
>>         /* Errata QE_General4, which affects some MPC832x and MPC836x SOCs, says
>>            that the BRG divisor must be even if you're not using divide-by-16
>>            mode. */
> 
> Can you also move this comment (and fix the comment formatting so that
> it's a proper function comment) to qe_general4_errata()?
> 

I actually thought of doing that, but decided against it because the
comment not only mentions the SOCs affected, but also explains the
following math/logic. I mean, without that comment nearby, the code is

  if (qe_general4_errata())
     if (some weird condition)
        divisor++;

In contrast, I think the qe_general4_errata() is pretty self-explanatory
- is this a SOC affected by that errata (whatever that errata may be
about and what the software workaround is).

Rasmus

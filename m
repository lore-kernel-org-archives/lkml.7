Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6BFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431AF20823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="iQTNsGtR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfC1P6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:58:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36558 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfC1P6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:58:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so4671683wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 08:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=to:references:from:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RwulVR+fvKq6vVJdowgQoJclqQ3Dv1qZouc2Y1YIUtI=;
        b=iQTNsGtRibUM+UyIrzIVd/SUgDHeOlaqKWG1Ro00D/Bt1O7fN9EATXW4M0+uHY/PA6
         rVHwp7uIjngQhUld7oVWRb5I+dsovgVvcEI9yhSr/Apot+OCGScczsX8KjRNEXambkpw
         HLm6k52eMJ4EtpvK1/hEfmMv4Ti7u0WZ43vJLT9AqL0qiDQhad5QiAMpvfqZHhbJ/bC5
         x4Vmhnq0dKDnhr8wVdlf3fBOAF/jq93vGlS9wZU8wRC1Pj2SJXvlYHH40owqCMfhUaOu
         uSt6DsD4oFWrFid+OCkaBfPHWLxPfvn8fwOw0L33qWljlJV9vAaOEDAxlNKtOlD3NYsm
         +uoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RwulVR+fvKq6vVJdowgQoJclqQ3Dv1qZouc2Y1YIUtI=;
        b=VnZ9xt+OtiTdE+SdbWiy2H+Xza1dV7zVkKAsm5pvbtaZD4auELFpMbJ3Q76pv0q6lA
         1sXPNOi8Iky5y9L8JM25MUcwKVo183lpmZ13V0ra4ZBAS57z+K8tzohBK1DJzi7a/0Fa
         pSIRh5CcbYNe1Gt9khoCNRpituInJ7hQNWmx8qNmwGJZKfxkXyBvohy2gNxQhvwetqoC
         DII3AB88qgpBqR47QeRgrJxj5xvhxtFH1wkS6dyHpQ6TTK/5GqVQ70Zui3oEmadhqBxv
         3JFeuEsi04g4oqQWlVJUOJDvNtj9FSKfoOxpgSMAt9qQTnf+sgbvADUG2uZKoHUtRdY3
         X5YA==
X-Gm-Message-State: APjAAAXiEjPqrb4knHXECiMF1CTVPrxu5xyDLY7Qazo/gAW9Zq53Zcfc
        6umNvNt+QF/oBB8UqVhRXkcRCg/Ys/Y=
X-Google-Smtp-Source: APXvYqw+ynclNeHhv9AIVtCxVLtYiUYacNugn5uGfyYrW/KLd5j+2DQh+5/r5XP/oXTdiqyowuAl3A==
X-Received: by 2002:a1c:e90f:: with SMTP id q15mr472472wmc.112.1553788694320;
        Thu, 28 Mar 2019 08:58:14 -0700 (PDT)
Received: from [172.20.1.105] ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id f128sm4334975wme.28.2019.03.28.08.58.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 08:58:13 -0700 (PDT)
To:     David Laight <David.Laight@ACULAB.COM>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "kafai@fb.com" <kafai@fb.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "yhs@fb.com" <yhs@fb.com>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "df@google.com" <df@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190328141652.wssqboyekxmp6tkw@yubo-2>
 <d870f83e-48fa-7372-7664-e268aa1acf6c@netronome.com>
 <ebf3f6b747cb4400b8357e361b1f522a@AcuMS.aculab.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quentin.monnet@netronome.com; prefer-encrypt=mutual; keydata=
 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
 RHhSHGnKaQ6MfrTge5Q0h5A=
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gYnBmOiBicGZ0b29sOiBjb252ZXJ0IOKAmGNvbnN0?=
 =?UTF-8?Q?_char_*=e2=80=99_type_into_=27char_*=27_in_assignment?=
Message-ID: <4c015f97-b5f0-68a0-2a6b-9333fe1bcb62@netronome.com>
Date:   Thu, 28 Mar 2019 15:58:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ebf3f6b747cb4400b8357e361b1f522a@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019-03-28 15:08 UTC+0000 ~ David Laight <David.Laight@ACULAB.COM>
> From: Quentin Monnet
>> Sent: 28 March 2019 14:31
>> 2019-03-28 10:16 UTC-0400 ~ Bo YU <tsu.yubo@gmail.com>
>>> When compiling with check flag: make -C tools/bpf/bpftool/
>>> gcc will warning:
>>>
>>> jit_disasm.c:119:29: warning: assignment discards ‘const’ qualifier from
>>> pointer target type [-Wdiscarded-qualifiers]
>>>   info.disassembler_options = disassembler_options;
>>>
>>> So convert 'const char *' type into 'char *' to fix the warning.
>>>
> ...
>>> --- a/tools/bpf/bpftool/jit_disasm.c
>>> +++ b/tools/bpf/bpftool/jit_disasm.c
>>> @@ -116,7 +116,7 @@ void disasm_print_insn(unsigned char *image, ssize_t
>>> len, int opcodes,
>>>     info.arch = bfd_get_arch(bfdf);
>>>     info.mach = bfd_get_mach(bfdf);
>>>     if (disassembler_options)
>>> -        info.disassembler_options = disassembler_options;
>>> +        info.disassembler_options = (char *)disassembler_options;
>>>     info.buffer = image;
>>>     info.buffer_length = len;
> 
> At some point someone may decide to build with -Wcast-const
> at which point you've just generated a different error.
> 
> The (probably) correct fix is to make info.disassempler_options 'const char *'.
> 
> 	David
> 

Which is what this binutils commit I cited does :)

Quentin

Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D0EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429AD217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="I2TYYvHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfC1Oao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:30:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43109 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfC1Oal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:30:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id k17so15220073wrx.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 07:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=to:references:from:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6jQgM82Ak5gxLhS3TfKaZNhwSGamDF9BZjyuXbzy7po=;
        b=I2TYYvHdYLI5v04eLYujn1x2cWpHmnM6U2OylMgbiXfP0nQQ2qTjMBllIvxyfhW06/
         SgfavnGc7zKVQQX7T6G+xOmP51fMFEdsQhdgW62O0toe3h/94sqXsAcV71rzqls0g5s/
         i1G2HCxfMjA7qD7QMONDcfR1ZM1FRY6XFpR7G5xfkW6HrW9SAKjvqbhnJPaYqi/0Bh79
         EnrndujjBIK3KXdGoKDqfbNn5sFRQC4xi0J/kH+6DRA6clVmId4rPdx56/BbGcCEK2gs
         6vfV3tU860HFDWzeIU5EueKc9UA6gQ1rSb/GnGZMcOs21UVxX1u8STKY/ezr3sqFju4P
         hUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6jQgM82Ak5gxLhS3TfKaZNhwSGamDF9BZjyuXbzy7po=;
        b=E2mXsy8as+U8lE7Rm/ApBIHJqFWqRsWqluQnfdwRuMjWPW4LcA5PEs+X63prE4Xnek
         vdcib0pWwDQoWvMxuu/dpNi1vOFlUdmG5be+DWrIDMlCyd7lTN/pSSVJ4ER+cCaHaXYz
         ywEbfllcqnpl8pE9s7zcU+HbOM5E/tTv7hWpkRPTsLApb7BKv0u59W+zq6iTP18TK8TB
         ZpTX5pMg+POzl7W5DD38xd5Zi9ylt5VW6eQWfS13/lzvAo//JBgFpOY8gKiovjwZqNqT
         Ts1MO1hIriS28vRHss/LOcl09C9iVOvuuusQtikymm6zwmDJ9vWHbq/Z7JgszB/0uKCe
         w/tw==
X-Gm-Message-State: APjAAAVBdzO/Uq3TusNKGf0JC2mfXpqibpg4j5IlDX139ydlAs06cwLX
        MlCkIEyNy7xlsZ/111SJOWWUiGa255Y=
X-Google-Smtp-Source: APXvYqwjdtSiE09zZ+sAwdGFJz30gUjn2rQbdaDVBWLauCB9YFubkoXZ6rrOiN806nTCL2ZP4ycDeA==
X-Received: by 2002:adf:ef91:: with SMTP id d17mr28888906wro.78.1553783438561;
        Thu, 28 Mar 2019 07:30:38 -0700 (PDT)
Received: from [172.20.1.105] ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id n1sm2256394wmc.19.2019.03.28.07.30.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 07:30:37 -0700 (PDT)
To:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, jakub.kicinski@netronome.com,
        df@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190328141652.wssqboyekxmp6tkw@yubo-2>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quentin.monnet@netronome.com; prefer-encrypt=mutual; keydata=
 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
 RHhSHGnKaQ6MfrTge5Q0h5A=
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gYnBmOiBicGZ0b29sOiBjb252ZXJ0IOKAmGNvbnN0?=
 =?UTF-8?Q?_char_*=e2=80=99_type_into_=27char_*=27_in_assignment?=
Message-ID: <d870f83e-48fa-7372-7664-e268aa1acf6c@netronome.com>
Date:   Thu, 28 Mar 2019 14:30:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328141652.wssqboyekxmp6tkw@yubo-2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019-03-28 10:16 UTC-0400 ~ Bo YU <tsu.yubo@gmail.com>
> When compiling with check flag: make -C tools/bpf/bpftool/
> gcc will warning:
> 
> jit_disasm.c:119:29: warning: assignment discards ‘const’ qualifier from
> pointer target type [-Wdiscarded-qualifiers]
>   info.disassembler_options = disassembler_options;
> 
> So convert 'const char *' type into 'char *' to fix the warning.
> 
> Fixes:3ddeac6705aba(tools: bpftool: use 4 context mode for the NFP disasm)
> Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> ---
> tools/bpf/bpftool/jit_disasm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/jit_disasm.c
> b/tools/bpf/bpftool/jit_disasm.c
> index 3ef3093560ba..40b46e46454a 100644
> --- a/tools/bpf/bpftool/jit_disasm.c
> +++ b/tools/bpf/bpftool/jit_disasm.c
> @@ -116,7 +116,7 @@ void disasm_print_insn(unsigned char *image, ssize_t
> len, int opcodes,
>     info.arch = bfd_get_arch(bfdf);
>     info.mach = bfd_get_mach(bfdf);
>     if (disassembler_options)
> -        info.disassembler_options = disassembler_options;
> +        info.disassembler_options = (char *)disassembler_options;
>     info.buffer = image;
>     info.buffer_length = len;
> 


Hi, the warning does not show with latest versions of binutils, it was
fixed with this (binutils) commit:

    commit f995bbe8e62fdb5607acb1ee127240cfe50d2b8f
    Author: Pedro Alves <palves@redhat.com>
    Date:   Wed Apr 5 19:21:33 2017 +0100

        -Wwrite-strings: Constify struct disassemble_info's
		disassembler_options field

Distributions with recent binutils (Ubuntu 18.04, Fedora 29 at least)
should not have this message. I thought about sending the same patch
some time ago, but in the end Jakub and I decided that it may not be
worth casting the const away to silence the warning just for older
distributions. Daniel also shared the same opinion at the time (but that
was off the mailing-list).

Quentin

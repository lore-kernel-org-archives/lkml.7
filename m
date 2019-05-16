Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903F2C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 19:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C9420818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 19:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558034326;
	bh=9VtDgxBgSZUAq5u89e8QiTuoiyLbcq7MVy1eVChkY4I=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=TW6rv40T8fZxay2kmx18OA8y4Lnf6R+IXpFsJe+k4ayYzAkJUarD0oY/0rumxX8EN
	 5U1xmsYYz6iF4lZSPYK6vcpCf4yx7C2t4SoO66+b38skYGTjE5ygj08G10Upa4yPqj
	 JECSYACzx5rZXkiLFGKlvfsZRDPXgzavNet1m4X8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbfEPTSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 15:18:45 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54722 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfEPTSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 15:18:43 -0400
Received: by mail-it1-f195.google.com with SMTP id a190so7990500ite.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 12:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y3s8+3+RBFZB3vYT3Jrj2lvbVDFl/Na95NcJWfjATK0=;
        b=SPb3+d/JuecxS6r8yq8gBnnYYldervfuwNcRCeyhTdCAR12LhLw+mPFdIEU+ZhvM+O
         6/9GkCG9nrbE96UXSrHATtjfOAK9f9sb+hlmRa8ofAyZ/qAtnLLOiQAJ3AXAydWRq5YC
         Rsi8oLBij5CuGtU5qlbjuBketYG2fk38MjwCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y3s8+3+RBFZB3vYT3Jrj2lvbVDFl/Na95NcJWfjATK0=;
        b=oWCtbNzT/4K0TJXN6ulb+rhPsm9Ofj/j5bJL4MPR2R0XBC9vm9XIv+VZEF8cqCfWd4
         CqwNiAgrOxDuumJa0j1cp4XUPKtOspS6ynSO3L9FBu01rlkZRQs4WMoZ2zZ9QG67Ei9w
         mNjxTbxWJDU5JP959qxoAPh250cTw0XU8FtJN5JFDvw0bWvJ5Opf19Qo1y3Oo7N6eabC
         XPFaMYxDTiJ/zpqyeVT5w0Nss0rIyMPeRZtlQ8CD4gQ/UFOAX9WI9LvJmi6/ySaSyjSX
         XvehTf535xawb5T8fdLfO7RZecdmVCPcDsGdUTRaTlGX1FqM0SA/DsRLzD1FwQiMxmgW
         vtrw==
X-Gm-Message-State: APjAAAWC4IbhmDK4s1UqUYude/0gk0bIv+dEaRLyj2z65HU1/U2NDhix
        WYTij3VEXk2LUuw1cjvdxZUuNZwcmLE=
X-Google-Smtp-Source: APXvYqwax9luuLVEpDiRgvFjJqjCLOBRqZuw5XBpIha4imoJI4EiC7oScANCzXkTFNzOx11ON/G3rA==
X-Received: by 2002:a24:2f42:: with SMTP id j63mr14194515itj.108.1558034322766;
        Thu, 16 May 2019 12:18:42 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y97sm2031212ita.19.2019.05.16.12.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 12:18:42 -0700 (PDT)
Subject: Re: [PATCH] selftests: fix bpf build/test workflow regression when
 KBUILD_OUTPUT is set
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, skhan@linuxfoundation.org
References: <20190511025249.32678-1-skhan@linuxfoundation.org>
 <20190511043729.3o4enh35lrmne3kd@ast-mbp>
 <CAADnVQK2eyFdEULS6z-M1R77d-AKe5sACKCHxHShJFOqhqy0rw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7d34df4b-88f4-9be9-624c-dfcb8b82e87d@linuxfoundation.org>
Date:   Thu, 16 May 2019 13:18:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAADnVQK2eyFdEULS6z-M1R77d-AKe5sACKCHxHShJFOqhqy0rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/19 12:36 PM, Alexei Starovoitov wrote:
> On Fri, May 10, 2019 at 9:37 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Fri, May 10, 2019 at 08:52:49PM -0600, Shuah Khan wrote:
>>> commit 8ce72dc32578 ("selftests: fix headers_install circular dependency")
>>> broke bpf build/test workflow. When KBUILD_OUTPUT is set, bpf objects end
>>> up in KBUILD_OUTPUT build directory instead of in ../selftests/bpf.
>>>
>>> The following bpf workflow breaks when it can't find the test_verifier:
>>>
>>> cd tools/testing/selftests/bpf; make; ./test_verifier;
>>>
>>> Fix it to set OUTPUT only when it is undefined in lib.mk. It didn't need
>>> to be set in the first place.
>>>
>>> Fixes: commit 8ce72dc32578 ("selftests: fix headers_install circular dependency")
>>>
>>> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>
>> 'git am' couldn't apply this patch because "sha1 information is lacking",
>> but the patch itself looks good.
>> Acked-by: Alexei Starovoitov <ast@kernel.org>
>> Thanks for the quick fix.
> 
> Ping! What is the status of the fix?
> 

Sending pull request this afternoon.

thanks,
-- Shuah

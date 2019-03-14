Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364C8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A912063F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="SCe7d/FG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfCNLH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:07:28 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35904 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfCNLH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:07:27 -0400
Received: by mail-lf1-f66.google.com with SMTP id d18so3913204lfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 04:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FEbkt1SNF3ru+IYVGJ38lijFQry78UHQKpKjHvW6nH0=;
        b=SCe7d/FGSOCnW71v9V1hW+2z+1uqMYF65vMTUwJrBnJHesbi9A27BuPSp/6JLgUXFB
         rY64Mhsodv+Q/mQ8PcatDeWLpKFg5PI/86rwgH/u3nMYYuPiQQqqTOyPfHcrgXUq3mRj
         yAOHDse9iu7iLl4s7JMF/9q8ParKhSxjXBLdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FEbkt1SNF3ru+IYVGJ38lijFQry78UHQKpKjHvW6nH0=;
        b=ubnhQhcQoKZ6p4ki+69ocU2oyea/tnqqBLKBa9HYsltEY7wu73XONI8pK3f5r6R1DD
         HX/NObW2FFLWfmHNwtK5cC4ya4jCaGy1y9dXJvn/2729ii/LIGD14VqT8wjTvIu1HSLo
         D2aurPAz91HHZRCvisuyo+lLyWNM0BArzZv+waCeJvEFqFmmhtP7KYTgrHLZytCaibdF
         qi1K+qOr3RvfZVGX9srF8TLn4nS/XdTMQjPNObrtjDP8czUgOPI4lfPkDeF+8EVIGAA1
         56tdkvYFXjTLJA13yIAb7kZHMrXcVn+NCCbaq/yn91mlzNCT/39KUMe4XPJrl9q19AsO
         E7AA==
X-Gm-Message-State: APjAAAUxkgpQ7TcRZczQPXAmk2rD2IoyitZml/JQr75eXdd21qm37gWX
        /QPCIpb7XBYVMBlXhHLcaQELIs39uN1mxHrTZEs=
X-Google-Smtp-Source: APXvYqywWNSWvJPPec/wwIRMd4owWVSgiRsK8TcCSKz9ZC3EbMR1gCemkFuxhobCN0EXBHXO9CKEig==
X-Received: by 2002:ac2:41cb:: with SMTP id d11mr27144758lfi.3.1552561644554;
        Thu, 14 Mar 2019 04:07:24 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g20sm785870lfg.97.2019.03.14.04.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 04:07:24 -0700 (PDT)
Subject: Re: [PATCH v4] lib/string.c: implement a basic bcmp
To:     David Laight <David.Laight@ACULAB.COM>,
        'Nick Desaulniers' <ndesaulniers@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Y Knight <jyknight@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <7549EE7E-4172-467D-815A-63664A33D410@goodmis.org>
 <20190313211335.165605-1-ndesaulniers@google.com>
 <953400721b6c4b869b9278c44e0aa796@AcuMS.aculab.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <2899ec10-2ab6-d3a3-37f5-d52395c03a8e@rasmusvillemoes.dk>
Date:   Thu, 14 Mar 2019 12:07:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <953400721b6c4b869b9278c44e0aa796@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2019 10.57, David Laight wrote:
> From: Nick Desaulniers
>> Sent: 13 March 2019 21:14
> ...
>> diff --git a/include/linux/string.h b/include/linux/string.h
>> index 7927b875f80c..6ab0a6fa512e 100644
>> --- a/include/linux/string.h
>> +++ b/include/linux/string.h
>> @@ -150,6 +150,9 @@ extern void * memscan(void *,int,__kernel_size_t);
>>  #ifndef __HAVE_ARCH_MEMCMP
>>  extern int memcmp(const void *,const void *,__kernel_size_t);
>>  #endif
>> +#ifndef __HAVE_ARCH_BCMP
>> +extern int bcmp(const void *,const void *,__kernel_size_t);
>> +#endif
> 
> Shouldn't that prototype always be present?

Yes and no. The problem is that asm/string.h may decide to implement
bcmp (or memcpy, memset, strcpy, ...) as a macro, which would break
rather badly when used to declare the function. And we can't undef the
macro temporarily. So I think the convention is that asm/string.h
provides the prototype before it #defines the macro, see e.g.
arch/x86/include/asm/string_32.h which has a #define of memcpy.

There is a fix for the "may be defined as a function-like macro", which is

extern int (bcmp)(const void *,const void *,__kernel_size_t);

I'd like to see that used rather than the ad hoc convention, but it is
of course somewhat unconventional C.

Rasmus

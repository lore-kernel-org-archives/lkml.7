Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0C1C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8FA214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633990AbfIYHsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 03:48:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442570AbfIYHsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 03:48:38 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 270703CBC1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 07:48:38 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id l6so1908311wrn.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 00:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IS7JBZ9zrqGVDeRJNFg8m1nKnd2cfm4f/OwgwdjTPRw=;
        b=udYcnStajUDlsSrd5AnX1sdkv7mIr70p4wcq9p0Mn2lyC6XMWjsPYJZ7ozNrF4K3k9
         93FLSg8STP59EjJFu0fFlUF5GE6CyULQudfqxQU7W4w6oBULGhi2yIevIaOlu885a+TX
         +KU5CT9fxSQzBMy2BMi9xVYMge2Uyueoh0x1wcdwn9iGjBa0k2el+kK70QfdicVf2u4k
         tl2znjDITG+A6+QH6GcBRbFOBNTKZjEP0soKKifyONIoHtUWJWv+F7Z/QouAD+AtE1FT
         84SJ7NxJ6ruKERRjRk6nn+sq1ttO5PrnjpfIQtBTUb3D8gsAXjcMw6WonoNuJDvWZjXe
         2OTw==
X-Gm-Message-State: APjAAAUx0YcKlfNnRb1TmaeuaF0U4XbWAEfxzM0RUBpWtOp57d2Nfi4P
        CnxJ75/24IP6uNdTpH2XgxmiN3Egn91wXxjdwe9CNjBmYG3nN4JFUCxIwpHL9/irvH/+93TPOcy
        Jmy9D4xqZTJh62qgWqPYGfAoh
X-Received: by 2002:a5d:4307:: with SMTP id h7mr7531879wrq.393.1569397716630;
        Wed, 25 Sep 2019 00:48:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxEpJogKzLfOpsHXL9nPwehQ4M6oLQikRQicx68vJp+AA1DzSOcYm+nBkEmeMRY8Vw9e5ddRg==
X-Received: by 2002:a5d:4307:: with SMTP id h7mr7531843wrq.393.1569397716293;
        Wed, 25 Sep 2019 00:48:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id d28sm7228325wrb.95.2019.09.25.00.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 00:48:35 -0700 (PDT)
Subject: Re: [PATCH] selftests: kvm: Fix libkvm build error
To:     Shuah Khan <skhan@linuxfoundation.org>, rkrcmar@redhat.com,
        shuah@kernel.org
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190924201451.31977-1-skhan@linuxfoundation.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <dbfb9d46-488a-b940-c86f-79ad750a324a@redhat.com>
Date:   Wed, 25 Sep 2019 09:48:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924201451.31977-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/19 22:14, Shuah Khan wrote:
> Fix the following build error:
> 
> libkvm.a(assert.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a PIE object; recompile with -fPIC
> 
> Add -fPIC to CFLAGS to fix it.

This is wrong, these testcases cannot be position-independent 
executables.  Can you include the failing command line from "V=1" 
output?

The problem seems to be that these definitions are not working properly:

no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
        $(CC) -Werror $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -no-pie -x c - -o "$$TMP", -no-pie)

LDFLAGS += -pthread $(no-pie-option)

Thanks,

Paolo

> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  tools/testing/selftests/kvm/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 62c591f87dab..b4a55d300e75 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -44,7 +44,7 @@ INSTALL_HDR_PATH = $(top_srcdir)/usr
>  LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
>  LINUX_TOOL_INCLUDE = $(top_srcdir)/tools/include
>  CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
> -	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
> +	-fno-stack-protector -fPIC -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
>  	-I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -Iinclude/$(UNAME_M) -I..
>  
>  no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
> 


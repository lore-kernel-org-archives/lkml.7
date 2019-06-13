Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117FBC31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1AC2080A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="o6aVXpjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387773AbfFMPl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:41:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38550 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387534AbfFMPlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:41:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id a186so12081769pfa.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 08:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mWJyZbm7F3Ahz/ql/XF8euQ1ksW5Cu4zLDVBU8U4GDo=;
        b=o6aVXpjqvNPmGOyOlXbaR8Zo2sjLjrACsvivGycW9GMFCBZxRG+Giv9O1YysXycFpR
         36efE76JYm0/qUZIYkJ8E/5xHl/zIQDBAxcZFm7df4gRFn92NVCHGd7RMoUe4jCeKYdg
         ah6tzVeUt1temIghkERv5YTXkb3gJlcKj9AquTF0HfKWqYh9/ZYXYCAC8ZNWZ8z7XZa0
         xY8CvRkfk8wTNYTCECshfLGPOJccuAvmQ2fwGbYINT4izbMXhOJ646s5DgeMB20iLzzT
         fKeVbj9TYL//xAu2cpuoxoQzHwqQTI9DB/FIt7Ensd9XV/FEnVK5ZJJF6EcP9EKnT8z0
         JuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mWJyZbm7F3Ahz/ql/XF8euQ1ksW5Cu4zLDVBU8U4GDo=;
        b=PcDVWypBEQIzd+KgGxi3dUus1kgGJe5ksvzPt6YxxNVHCaBLk3P4Ud9aNlHvuf42+v
         laKzIzfmEgzXXGj/yimZb2eoB+HDoc6cy75aTcyNrLsHTuegN/JNRTOd+ZUrQCULdKD3
         OaTW+bNXOD7p3l+Ocgc4IhFBPWi7KSXg4nUrQvq8Gc1qnXcHfrR5AEadAtz6+Un8ke/L
         vDfraJGvGP9auSX+eXTY8fJs3QSorSKiCeiCglATmXJ+IXXFK6Rrc4Dh0+KZc1yqFvsX
         4JJtju2oVM5Bcryn/CHn2wlg3jfFQColDFChAKEfqPNqoh+j5aqgI9jnhSnNalAdWT3Z
         DaXg==
X-Gm-Message-State: APjAAAUIJb2VIxPVTR91f6TQhFJ3WZaZMDpU5hi7hORDv5ZXVivJqI0W
        RpLC2LeLxB+hSJZMzyuHxtmy1Q==
X-Google-Smtp-Source: APXvYqz665NIJnk8Z4SVgLXBrXMXtYkxyBLHoq/yncNrUZ0q/8CMlIVoc2MY1UgABSwK3TkEspaEgw==
X-Received: by 2002:a17:90b:d8b:: with SMTP id bg11mr6287697pjb.30.1560440514297;
        Thu, 13 Jun 2019 08:41:54 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id x6sm111580pfx.17.2019.06.13.08.41.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 08:41:53 -0700 (PDT)
Date:   Thu, 13 Jun 2019 08:41:52 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Arthur Fabre <afabre@cloudflare.com>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: selftests: Fix warning in flow_dissector
Message-ID: <20190613154152.GA9636@mini-arch>
References: <20190613112709.7215-1-afabre@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190613112709.7215-1-afabre@cloudflare.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13, Arthur Fabre wrote:
> Building the userspace part of the flow_dissector resulted in:
> 
> prog_tests/flow_dissector.c: In function ‘tx_tap’:
> prog_tests/flow_dissector.c:176:9: warning: implicit declaration
> of function ‘writev’; did you mean ‘write’? [-Wimplicit-function-declaration]
>   return writev(fd, iov, ARRAY_SIZE(iov));
>          ^~~~~~
>          write
> 
> Include <sys/uio.h> to fix this.
Wasn't it fixed already?

See
https://lore.kernel.org/netdev/20190528190218.GA6950@ip-172-31-44-144.us-west-2.compute.internal/

> Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/flow_dissector.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> index fbd1d88a6095..c938283ac232 100644
> --- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> +++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> @@ -3,6 +3,7 @@
>  #include <error.h>
>  #include <linux/if.h>
>  #include <linux/if_tun.h>
> +#include <sys/uio.h>
>  
>  #define CHECK_FLOW_KEYS(desc, got, expected)				\
>  	CHECK_ATTR(memcmp(&got, &expected, sizeof(got)) != 0,		\
> -- 
> 2.20.1
> 

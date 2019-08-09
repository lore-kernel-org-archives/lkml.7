Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2494CC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0664206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405843AbfHIHja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 03:39:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32893 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405674AbfHIHja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 03:39:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id p77so5607153wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 00:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xaUE+b2Ivx2DbXYmJvLDQ+HYNnryuMwKv4SoNgWueQs=;
        b=FeKVh1ZzX7spdQZ/Wdo1oMEup9aMWVuQGx2v7EfBCRbA9jTXBg+yp+JAVjqsp8g01n
         39HD26Biu4vYjA4V0UW54QMTbQATqcNnmQIfMVMcDRP2fSp6N4SdQ8cyRHHnjLUrdug+
         mvkriZCzleXtxQsDzeJzxDS69d2kMBNhXJSYognhN/x1R6JU1hPHdEr0+KsbJIZvQrNn
         7D6Og/B4khqBx55Xiea+yow98rCO0rOTJhNI80fS1E0rFntaZEclmLvzTDTyw2U1hlyW
         OfP7xwWdTBsyyW0gAdMwoyMyC+mUnjbZwkhZSpMzpDzKyfjQWCRgoJ8wd4GWpEtmxPo3
         rsCQ==
X-Gm-Message-State: APjAAAXxLNKE1AlZjohIILDF5msNMlMD1p4rBiNgnRKo216UaQS5Vz54
        0D6TzSNepQK5qqQQt/B9eB7ExQ==
X-Google-Smtp-Source: APXvYqxytvGnBCzeMG9C+zJI7RJIXc4jYF8EQLjKxY1xmaERR0icUaDIN9Wz/zR8CgJLJXbU7OMqZQ==
X-Received: by 2002:a1c:f913:: with SMTP id x19mr9078528wmh.139.1565336368260;
        Fri, 09 Aug 2019 00:39:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b42d:b492:69df:ed61? ([2001:b07:6468:f312:b42d:b492:69df:ed61])
        by smtp.gmail.com with ESMTPSA id m7sm80941667wrx.65.2019.08.09.00.39.27
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 00:39:27 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] selftests: kvm: Adding config fragments
To:     Naresh Kamboju <naresh.kamboju@linaro.org>, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, drjones@redhat.com,
        sean.j.christopherson@intel.com, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org
References: <20190809072415.29305-1-naresh.kamboju@linaro.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0a0e0563-aba7-e59c-1fbd-547126d404ed@redhat.com>
Date:   Fri, 9 Aug 2019 09:39:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809072415.29305-1-naresh.kamboju@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/19 09:24, Naresh Kamboju wrote:
> selftests kvm all test cases need pre-required kernel config for the
> tests to get pass.
> 
> CONFIG_KVM=y
> 
> The KVM tests are skipped without these configs:
> 
>         dev_fd = open(KVM_DEV_PATH, O_RDONLY);
>         if (dev_fd < 0)
>                 exit(KSFT_SKIP);
> 
> Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  tools/testing/selftests/kvm/config | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 tools/testing/selftests/kvm/config
> 
> diff --git a/tools/testing/selftests/kvm/config b/tools/testing/selftests/kvm/config
> new file mode 100644
> index 000000000000..14f90d8d6801
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/config
> @@ -0,0 +1 @@
> +CONFIG_KVM=y
> 

I think this is more complicated without a real benefit, so I'll merge v2.

Paolo

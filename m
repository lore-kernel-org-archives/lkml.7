Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F6AC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C6D217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732094AbfEXTY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 15:24:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53031 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732008AbfEXTY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 15:24:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id y3so10460282wmm.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 12:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yvn6Z+8CNLO1tsaW5/zxMotanzz8ExB5H3ow81Rb1J8=;
        b=ElaL0hDd6Q5iW+iz/qBlmKutHPnU82tAST+j3F9TAdnyiVPgsWs2iTEssOSxbG6CGO
         DP1+mgOX2lyy33yKi6BasIwT5zb6rhKz0mqGLYj7U2ogf95QgGombXYaum06Er+0HoIA
         CzWdnT/Giga/cmpshMOQ8Mx5yUoyR+9qMMMjmNgbYPlSSOm/6tNP67ABrVgSpl0Ek6Op
         Xm2KCq1eAQgPAbcWDL6Hdow45SwjNIsENCJ25//74qZ5U/eeEYkaPZ2tXXDpiw3GXRAh
         dTjRKkJEimPhw2cRzT7JuR7zcuLE7EXkkPSp88Hi3jEZoyAa1RMdTLkXLfNN8V16hzQ6
         oxHg==
X-Gm-Message-State: APjAAAWDzzUMIQGsr5PIeLrhXlgdiQF1xJhw5732ZRXBlNdlv2eGizs3
        LutJ1hReopNF1RZV05BTJ0qYhUPtOh0=
X-Google-Smtp-Source: APXvYqzfqL+E+LxIXGZhopDTwiNLeQSCRmfercctqPmlnf0LEtgtnNgAywaKzY5YC3KvCOvA4KPUcQ==
X-Received: by 2002:a7b:c344:: with SMTP id l4mr18350497wmj.25.1558725865276;
        Fri, 24 May 2019 12:24:25 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id 74sm3410408wma.7.2019.05.24.12.24.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 12:24:24 -0700 (PDT)
Subject: Re: [PATCH] KVM: selftests: Wrap vcpu_nested_state_get/set functions
 with x86 guard
To:     Thomas Huth <thuth@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Andrew Jones <drjones@redhat.com>, kvm@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190523093114.18182-1-thuth@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1cb9f031-3483-b721-2e74-b12664b705ec@redhat.com>
Date:   Fri, 24 May 2019 21:24:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523093114.18182-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/19 11:31, Thomas Huth wrote:
> struct kvm_nested_state is only available on x86 so far. To be able
> to compile the code on other architectures as well, we need to wrap
> the related code with #ifdefs.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tools/testing/selftests/kvm/include/kvm_util.h | 2 ++
>  tools/testing/selftests/kvm/lib/kvm_util.c     | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 8c6b9619797d..a5a4b28f14d8 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -118,10 +118,12 @@ void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
>  		     struct kvm_vcpu_events *events);
>  void vcpu_events_set(struct kvm_vm *vm, uint32_t vcpuid,
>  		     struct kvm_vcpu_events *events);
> +#ifdef __x86_64__
>  void vcpu_nested_state_get(struct kvm_vm *vm, uint32_t vcpuid,
>  			   struct kvm_nested_state *state);
>  int vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
>  			  struct kvm_nested_state *state, bool ignore_error);
> +#endif
>  
>  const char *exit_reason_str(unsigned int exit_reason);
>  
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index cf62de377310..633b22df46a4 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1248,6 +1248,7 @@ void vcpu_events_set(struct kvm_vm *vm, uint32_t vcpuid,
>  		ret, errno);
>  }
>  
> +#ifdef __x86_64__
>  void vcpu_nested_state_get(struct kvm_vm *vm, uint32_t vcpuid,
>  			   struct kvm_nested_state *state)
>  {
> @@ -1279,6 +1280,7 @@ int vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
>  
>  	return ret;
>  }
> +#endif
>  
>  /*
>   * VM VCPU System Regs Get
> 

Queued, thanks.

Paolo

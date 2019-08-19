Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8547FC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B61820651
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfHSPSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:18:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbfHSPSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:18:32 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB2978125C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 15:18:31 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id a17so5435503wrw.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 08:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0/2t4hS8FqXThVER+v2A5JOFUnGhu/vf2ajPY5A6Uf4=;
        b=XCwRgjRpO7GIpsS4XzRc1dhIHMHn9H5KwvyZzDTkwTRVfYTeSKRSL/puQd68+WtP0A
         9N6MupCd/YAgWoo6S7fW0UhLC7P0dtWuzDswCvTl9rDhvof5otYoFrpGq/qSeHjcmHmu
         4m5gZGQG/i/AU+BPmsiypsm5qXtWkmoRf6od3WTK05h4mfk1mE6D0Bbytf/t+BsiInW8
         LfpyeXjh11+yB4p4Wi8fy4lfxXpQCqBvqzrQuRyqlxsbRNhPzl0cbnpRRAOcHQEnGQ7b
         Og5n+e1S8EiKUf21jJgbbYTY9IVV2M3PSl7OUCT2FrWndPNyVAJyUpc1UjFrUAd8l+rE
         Z3OQ==
X-Gm-Message-State: APjAAAU+Ifc8MXWHiXS7u/PCN/jVWtL/KZcBp/8eIoYcu3jINK+B4b3C
        zACNERREpKGE0Y+xQNlQKXGJ6yuW2N9kqec0jAhc2pDN9yJTQ6vFelcUnuQDDbnyGN1Ypx265ji
        XnS/UVysoZP6uTjszDSttILqP
X-Received: by 2002:a5d:65ca:: with SMTP id e10mr10917605wrw.267.1566227910391;
        Mon, 19 Aug 2019 08:18:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy2TMYfv7mIazOQe72riCVUkHV+60Qy7yTDJQyIB9kc6T5c0Kk0L1QXICVeLMbYFZlY9buLJA==
X-Received: by 2002:a5d:65ca:: with SMTP id e10mr10917573wrw.267.1566227910127;
        Mon, 19 Aug 2019 08:18:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8033:56b6:f047:ba4f? ([2001:b07:6468:f312:8033:56b6:f047:ba4f])
        by smtp.gmail.com with ESMTPSA id f197sm27675081wme.22.2019.08.19.08.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 08:18:29 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: Fix x86_decode_insn() return when fetching insn
 bytes fails
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190815162032.6679-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9bf79098-703c-e82b-7e7d-1c0a6a1023c2@redhat.com>
Date:   Mon, 19 Aug 2019 17:18:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815162032.6679-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/19 18:20, Sean Christopherson wrote:
> Jump to the common error handling in x86_decode_insn() if
> __do_insn_fetch_bytes() fails so that its error code is converted to the
> appropriate return type.  Although the various helpers used by
> x86_decode_insn() return X86EMUL_* values, x86_decode_insn() itself
> returns EMULATION_FAILED or EMULATION_OK.
> 
> This doesn't cause a functional issue as the sole caller,
> x86_emulate_instruction(), currently only cares about success vs.
> failure, and success is indicated by '0' for both types
> (X86EMUL_CONTINUE and EMULATION_OK).
> 
> Fixes: 285ca9e948fa ("KVM: emulate: speed up do_insn_fetch")
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/emulate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 8e409ad448f9..6d2273e71020 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -5126,7 +5126,7 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len)
>  	else {
>  		rc = __do_insn_fetch_bytes(ctxt, 1);
>  		if (rc != X86EMUL_CONTINUE)
> -			return rc;
> +			goto done;
>  	}
>  
>  	switch (mode) {
> 

Queued, thanks.

Paolo

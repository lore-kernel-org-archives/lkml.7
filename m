Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7140BC742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6FC2053B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfGLRrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 13:47:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39877 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfGLRrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 13:47:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so10788781wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 10:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=33ROaBIziKCKc1mhqPdQtlXJvh7o/Q/v1uM0fuHCI78=;
        b=DG//oUn90DZ5O2LCctn0nr2nQI44OVs3s1z1riWyh1ithn++pM9x8iTz2IwEdV7gI3
         mbY/to7xwARinzrRkOSBCIg4Awcu+blHLzIzEocxWgKNBrbZTZNwhwOw6MFBWphXkVMW
         KDYsKjgxSYj6g2UNkwBC+nV3AmZkHQzU5uuMAT32xYRrD5cGf+i15nyUb8H+auNi0Hty
         2DR4TlO8V3PvooJzI23BaznRP5H7peAJpObBSzBMpZzPgrlfmh6i3puOoGJIJNrz8p0a
         oYDr91T/YRCxt9Rfa/crxj5/1T6FETuMSvp7QIhuuKSvalxIHccpBX4Dt66HdO1KDUwX
         abVw==
X-Gm-Message-State: APjAAAUxJNbhiixhVOr66lxfd55gxv/DT3uETHTh6dCP7PItb6qJz3Pg
        D52aHbex9cdfDeTSG2lOaPWbFA==
X-Google-Smtp-Source: APXvYqy0VccFEaWxyCvOu8o97Zs2IK189UrDn3tEQwntg06bZ/SCw2MqMFM2tnF/rz4ZFV2mwp5EkQ==
X-Received: by 2002:adf:9c83:: with SMTP id d3mr226717wre.160.1562953627498;
        Fri, 12 Jul 2019 10:47:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab? ([2001:b07:6468:f312:d066:6881:ec69:75ab])
        by smtp.gmail.com with ESMTPSA id d10sm11228180wro.18.2019.07.12.10.47.06
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 10:47:06 -0700 (PDT)
Subject: Re: [PATCH 2/2] x86: kvm: avoid constant-conversion warning
To:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Junaid Shahid <junaids@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Kai Huang <kai.huang@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20190712091239.716978-1-arnd@arndb.de>
 <20190712091239.716978-2-arnd@arndb.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4694728a-a2bc-a681-7084-476a7bc28dfd@redhat.com>
Date:   Fri, 12 Jul 2019 19:47:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712091239.716978-2-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/19 11:12, Arnd Bergmann wrote:
> clang finds a contruct suspicious that converts an unsigned
> character to a signed integer and back, causing an overflow:

I like how the commit message conveys the braindead-ness of the warning.

Queued, thanks.

Paolo

> arch/x86/kvm/mmu.c:4605:39: error: implicit conversion from 'int' to 'u8' (aka 'unsigned char') changes value from -205 to 51 [-Werror,-Wconstant-conversion]
>                 u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
>                    ~~                               ^~
> arch/x86/kvm/mmu.c:4607:38: error: implicit conversion from 'int' to 'u8' (aka 'unsigned char') changes value from -241 to 15 [-Werror,-Wconstant-conversion]
>                 u8 uf = (pfec & PFERR_USER_MASK) ? ~u : 0;
>                    ~~                              ^~
> arch/x86/kvm/mmu.c:4609:39: error: implicit conversion from 'int' to 'u8' (aka 'unsigned char') changes value from -171 to 85 [-Werror,-Wconstant-conversion]
>                 u8 ff = (pfec & PFERR_FETCH_MASK) ? ~x : 0;
>                    ~~                               ^~
> 
> Add an explicit cast to tell clang that everything works as
> intended here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/x86/kvm/mmu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index 17ece7b994b1..aea7f969ecb8 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -4602,11 +4602,11 @@ static void update_permission_bitmask(struct kvm_vcpu *vcpu,
>  		 */
>  
>  		/* Faults from writes to non-writable pages */
> -		u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
> +		u8 wf = (pfec & PFERR_WRITE_MASK) ? (u8)~w : 0;
>  		/* Faults from user mode accesses to supervisor pages */
> -		u8 uf = (pfec & PFERR_USER_MASK) ? ~u : 0;
> +		u8 uf = (pfec & PFERR_USER_MASK) ? (u8)~u : 0;
>  		/* Faults from fetches of non-executable pages*/
> -		u8 ff = (pfec & PFERR_FETCH_MASK) ? ~x : 0;
> +		u8 ff = (pfec & PFERR_FETCH_MASK) ? (u8)~x : 0;
>  		/* Faults from kernel mode fetches of user pages */
>  		u8 smepf = 0;
>  		/* Faults from kernel mode accesses of user pages */
> 


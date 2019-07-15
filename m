Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C40C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D85620665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732170AbfGOSQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 14:16:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45484 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729513AbfGOSQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 14:16:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so18089769wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 11:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ULUvK341hvn/WVD94+/w5FpFalZi6ybB8mp8aYxx41s=;
        b=tYlmyJL+devsAbW695Td57YI/TsDm10JCphXipCM2Z3lXnJYf05GCAqiah6emhkAFy
         bgkzoBcnxN80g4hbphzvhTRJXJMVr7NIW/TJjJFMINUA17M+xi2VqtNcdzjZwtF8va20
         OgQpJyPa62apmW9R1C2LixPMOFkhIvp6h0WglvJXXJrkOiVkcyjCdrOdaXFjrHRN2Bv9
         4Ku1mRbTGXsbB06l2QVveA16TCvOovz10iTRm2NhfAJvn3pRXYCLLwdd5NvmzdtVLZKA
         dv+a0T7BQVevD7yy+n6YMt7RDufSEhJohz1Jlvj070oI356iH7wb7QqyFTGDcLmzYzqE
         681Q==
X-Gm-Message-State: APjAAAUqihDSDo0mlPuR1LaOIYxUxVI376T4DYLa3FBgw/VRFmyXOJBK
        TCnxTJPpwTvY46NnGH+YMuLZpg==
X-Google-Smtp-Source: APXvYqznrygYZYXvxnBJW/EQVpFqDmUk3eqK8UeHQYEXQDrFj5qR+73dJUiRhh2O4JvVK3DPeziBGg==
X-Received: by 2002:a5d:4403:: with SMTP id z3mr31085287wrq.29.1563214605321;
        Mon, 15 Jul 2019 11:16:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b159:8d52:3041:ae0d? ([2001:b07:6468:f312:b159:8d52:3041:ae0d])
        by smtp.gmail.com with ESMTPSA id u18sm14954783wmd.19.2019.07.15.11.16.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 11:16:44 -0700 (PDT)
Subject: Re: [PATCH 04/22] x86/kvm: Don't call kvm_spurious_fault() from
 .fixup
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <cover.1563150885.git.jpoimboe@redhat.com>
 <1f37a9e42732c224bc5299dbc827b4101c9deb22.1563150885.git.jpoimboe@redhat.com>
 <07b8513a-d8f7-f8cf-daf6-83a80ade987a@redhat.com>
 <20190715124025.prcetv24oyjnuvip@treble>
 <29d30d81-bcbe-5261-b34d-12bd62df9116@redhat.com>
 <20190715132555.3tz4ciogkv3xlkta@treble>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <585a6828-8a34-143e-52c6-bf2b7f8d2b64@redhat.com>
Date:   Mon, 15 Jul 2019 20:16:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715132555.3tz4ciogkv3xlkta@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/19 15:25, Josh Poimboeuf wrote:
> On Mon, Jul 15, 2019 at 03:05:33PM +0200, Paolo Bonzini wrote:
>> On 15/07/19 14:40, Josh Poimboeuf wrote:
>>>>>   * Hardware virtualization extension instructions may fault if a
>>>>>   * reboot turns off virtualization while processes are running.
>>>>> - * Trap the fault and ignore the instruction if that happens.
>>>>> + * If that happens, trap the fault and panic (unless we're rebooting).
>>>> Not sure the comment is better than before, but apar from that
>>> The previous comment didn't seem to match the code, since we only ignore
>>> the instruction if we're rebooting.
>>>
>>
>> "If that happens" refers to "a reboot turns off virtualization while
>> processes are running".
> 
> Ah, makes sense now.  I was reading "if that happens" to mean the fault.
> 
>>  * Usually after catching the fault we just panic; during reboot
>>  * instead the instruction is ignored.
> 
> Yes, that's much clearer.  Assuming you meant to replace the entire
> comment.

No, I didn't. :)  I meant only the last line (otherwise it removes
information on why the fault may happen and the simplest choice is to
ignore).  Thanks for taking care of this!

Paolo


  I also moved it to directly above the macro it's describing:
> 
> 
> asmlinkage void __noreturn kvm_spurious_fault(void);
> 
> /*
>  * Usually after catching the fault we just panic; during reboot
>  * instead the instruction is ignored.
>  */
> #define ____kvm_handle_fault_on_reboot(insn, cleanup_insn)		\
> 
> 


Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CD5C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC841206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfG2JUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 05:20:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33626 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfG2JUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 05:20:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so61084134wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 02:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uXbHp4eBJvOivXe3gCAiTk5IMqXsOx6plzKSBZNiGpQ=;
        b=ZXg41ZBd57akSc5MyQ/G8Ib8s+ogudl6IpJM94ZHB0A0uwyMazRID0/42dJy9fIZN1
         qBPdQzXccVo49/PBRDn5J5o7EOoA9VKTDu/S6YViHVXIdbIRE6qRY1OG4Gx2vA0ZtktD
         v2ehrtsrXNAqNQkAytDKD0Ghhfl9xVbtq+w7+EKaQOSgGm35KorZJa8F7epKNyf+oJLL
         5yGTYwvJoeTtL3LgP4MObE9CrYtww11eo2fqmOQpVGZZnbUTt04MDu3O0UMqwl2C976E
         lwhiSW9jo96/INT+paXk58jnzldM+94+IO/WS678+vWs1/d2/oBimfdAzc2LOGXiGNUX
         Y66Q==
X-Gm-Message-State: APjAAAV9ok5Oqy0sXDoCJ0zFuLhxcjdImoM0CLIoJUXntk9v7yZggaJi
        cWCHeUqWT7Nof1QvB7Gv2bguKbr0Va4=
X-Google-Smtp-Source: APXvYqyLDdpNaY9V1WepUQO0fPV/p+GwAXZPJm4OXn15VZtBt43XB+wYaq6vIkAZVLbjYIdAAle3aw==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr124260124wrm.235.1564392014705;
        Mon, 29 Jul 2019 02:20:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29d3:6123:6d5f:2c04? ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
        by smtp.gmail.com with ESMTPSA id w7sm69866212wrn.11.2019.07.29.02.20.13
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 02:20:14 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] KVM: VMX: Add error handling to VMREAD helper
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190719204110.18306-1-sean.j.christopherson@intel.com>
 <20190719204110.18306-4-sean.j.christopherson@intel.com>
 <20190728193641.mjxrtcc6ps72z3sp@treble>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <abcf50fc-0037-446f-36a3-1bd00091ce4f@redhat.com>
Date:   Mon, 29 Jul 2019 11:20:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190728193641.mjxrtcc6ps72z3sp@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/19 21:36, Josh Poimboeuf wrote:
> On Fri, Jul 19, 2019 at 01:41:08PM -0700, Sean Christopherson wrote:
>> @@ -68,8 +67,22 @@ static __always_inline unsigned long __vmcs_readl(unsigned long field)
>>  {
>>  	unsigned long value;
>>  
>> -	asm volatile (__ex_clear("vmread %1, %0", "%k0")
>> -		      : "=r"(value) : "r"(field));
>> +	asm volatile("1: vmread %2, %1\n\t"
>> +		     ".byte 0x3e\n\t" /* branch taken hint */
>> +		     "ja 3f\n\t"
>> +		     "mov %2, %%" _ASM_ARG1 "\n\t"
>> +		     "xor %%" _ASM_ARG2 ", %%" _ASM_ARG2 "\n\t"
>> +		     "2: call vmread_error\n\t"
>> +		     "xor %k1, %k1\n\t"
>> +		     "3:\n\t"
>> +
>> +		     ".pushsection .fixup, \"ax\"\n\t"
>> +		     "4: mov %2, %%" _ASM_ARG1 "\n\t"
>> +		     "mov $1, %%" _ASM_ARG2 "\n\t"
>> +		     "jmp 2b\n\t"
>> +		     ".popsection\n\t"
>> +		     _ASM_EXTABLE(1b, 4b)
>> +		     : ASM_CALL_CONSTRAINT, "=r"(value) : "r"(field) : "cc");
> 
> Was there a reason you didn't do the asm goto thing here like you did
> for the previous patch?  That seemed cleaner, and needs less asm.  

It's because asm goto doesn't support outputs.

Paolo

> I think the branch hints aren't needed -- they're ignored on modern
> processors.  Ditto for the previous patch.
> 
> Also please use named asm operands whereever you can, like "%[field]"
> instead of "%2".  It helps a lot with readability.
> 


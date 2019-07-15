Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD37C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B876E20868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfGOJEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 05:04:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35640 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729394AbfGOJEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 05:04:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id y4so16213342wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 02:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zaW9Ln2eViteis0SzN8eDS27HJJtwmEpY/UJ4Ot2aDg=;
        b=Z1lpo2wk0k4TkcVcj0dxFFaPqtui3zpkYwRZct8JMotgkxl38q7If9uXINjLFd9wqt
         JojIkH3OGBy8QqiyugIlXAmoybLb7e+ZSJz2uPeXVZVVa/ni4WZZBO835A5+CP0+bd8G
         p4C348ZsKRela9oD/UDEVbW9T4f/VnwdXlYDH/eKyvsTw0y5dBgLmtQJeUN0X++8PXj0
         TH3Nm9zq0021YR/wcnlJwAHIG8qP2g0SKW+QKOC+bRSL1zq+uGdfYkcb3cEJP83bYP3J
         7VoUuuTZJEnDV+PeK4QFZ0ovrQW1z4Hx2Qu4onEEhNx7CyHucXpKCCR3rw2K/vS9sf9p
         fDAg==
X-Gm-Message-State: APjAAAUSanz5ZmekUAWl9qoKhWKB0T0Hs4EVTOdUMwAzHecfZlw2PvZF
        HtzJjh8HZ97jDYx6YHZCD96vmw==
X-Google-Smtp-Source: APXvYqzCbHKbiWKZPwHQkIK1QRMRaZPl1mK+IkeVteiND7mvCxwwLL7IFCtkWhS9otBCQftFyrZJow==
X-Received: by 2002:a5d:6b11:: with SMTP id v17mr27217363wrw.323.1563181444853;
        Mon, 15 Jul 2019 02:04:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e983:8394:d6:a612? ([2001:b07:6468:f312:e983:8394:d6:a612])
        by smtp.gmail.com with ESMTPSA id j189sm16472543wmb.48.2019.07.15.02.04.03
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 02:04:04 -0700 (PDT)
Subject: Re: [PATCH 03/22] x86/kvm: Fix frame pointer usage in vmx_vmenter()
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <cover.1563150885.git.jpoimboe@redhat.com>
 <299fe4adb78cff0a182f8376c23a445b94d7c782.1563150885.git.jpoimboe@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0b37031b-1043-8274-a086-2b5d0b02b5ef@redhat.com>
Date:   Mon, 15 Jul 2019 11:04:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <299fe4adb78cff0a182f8376c23a445b94d7c782.1563150885.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/19 02:36, Josh Poimboeuf wrote:
> With CONFIG_FRAME_POINTER, vmx_vmenter() needs to do frame pointer setup
> before calling kvm_spurious_fault().
> 
> Fixes the following warning:
> 
>   arch/x86/kvm/vmx/vmenter.o: warning: objtool: vmx_vmenter()+0x14: call without frame pointer save/setup
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

This is not enough, because the RSP value must match what is computed at
this place:

        /* Adjust RSP to account for the CALL to vmx_vmenter(). */
        lea -WORD_SIZE(%_ASM_SP), %_ASM_ARG2
        call vmx_update_host_rsp

Is this important since kvm_spurious_fault is just BUG()?  There is no
macro currently to support CONFIG_DEBUG_BUGVERBOSE in assembly code, but
it's also fine if you just change the call to ud2.

Paolo

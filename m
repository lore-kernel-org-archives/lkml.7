Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EC1C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C31E2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfGONFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:05:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54440 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730048AbfGONFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:05:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so15077570wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 06:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4IkpEIRyxTphY4AHIBJmmlbcwMrkgGFJBoEkjGVA36A=;
        b=fVKde8VM1VvjZdKfU7XsdMwLWwuYldzFHzcnNGr96TKJD5wbaHsztJ2VNZvY4TBy0s
         uxR0ddzn1b8Kp4Xcwpv02KPzb2aoDZSwNBz6oAOwhl/ZOu3eubNqjULk/zRClUm+h2gg
         1IA77DRzF6EdIGNFrA3aCUPFEtHbuQM35aikukh7Gat+WlosActLY7lAJFi8CGhgDIhA
         CwMZUtrD3QJtJ/hK6OvSpkEeN7Glfq9IruLx/BRfG3JfkcKm+jhRvTZCgkcA8OZQ87xU
         A1SvEia6L6NLjvkkzUZGw2H+9KtilQgdeFSEHZqWnYwna2KhlgOFj6WySX9oEZsJlwzf
         nRjw==
X-Gm-Message-State: APjAAAWwIaG4sc8P6ClXFLBykJgTq8C/xHABWXrmefKrLkD5oVtg9oHc
        WJr6fJDalo9vIIPf1zSA2W9XOw==
X-Google-Smtp-Source: APXvYqxgGsTksSywgyrRHsQXv3t+Rd7r4vdMOlKwU+lYO7CkTQYdi3hA7dF5XFSeqjisRCWDXeLYkQ==
X-Received: by 2002:a05:600c:214e:: with SMTP id v14mr25351143wml.96.1563195935198;
        Mon, 15 Jul 2019 06:05:35 -0700 (PDT)
Received: from [192.168.178.40] ([151.20.129.151])
        by smtp.gmail.com with ESMTPSA id 91sm34867134wrp.3.2019.07.15.06.05.34
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 06:05:34 -0700 (PDT)
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
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <29d30d81-bcbe-5261-b34d-12bd62df9116@redhat.com>
Date:   Mon, 15 Jul 2019 15:05:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715124025.prcetv24oyjnuvip@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/19 14:40, Josh Poimboeuf wrote:
>>>   * Hardware virtualization extension instructions may fault if a
>>>   * reboot turns off virtualization while processes are running.
>>> - * Trap the fault and ignore the instruction if that happens.
>>> + * If that happens, trap the fault and panic (unless we're rebooting).
>> Not sure the comment is better than before, but apar from that
> The previous comment didn't seem to match the code, since we only ignore
> the instruction if we're rebooting.
> 

"If that happens" refers to "a reboot turns off virtualization while
processes are running".  Perhaps

 * Usually after catching the fault we just panic; during reboot
 * instead the instruction is ignored.

Paolo

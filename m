Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516A4C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F4D21479
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbfEUS2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 14:28:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54778 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbfEUS2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 14:28:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id i3so3955884wml.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 11:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qU0oxwfZcLk0iOxgnO8VPxDjgRoJbZAj9hi3V2Z/tgY=;
        b=cQPO7/UQbMhClECuzv/x40WLa4kz3nYyyPsUKJXtSD2mTc5nswgKOcdiA84CFdEM3Z
         4fQ2mT1p7E1DqZqJRBEfwFJcCWVadc3Doat1Y7Vd0gfDi7TwlKzp3vmg39VBVE5JlFfR
         /zfcNDUhlfr6zRHiNxfT3ToF7HYa/yylRAhbDl7Kk0pt6ZpxGTjPAGpjEbKODUvMwvL4
         ubxwZ/TgOv5NeEIU7DyjyBuHhQ6ZLMqi7o20IPdAPTr/hVeG77AAtnbWOQj/B1XkgUiK
         2MOY7eyeS306GrnJ0SADBJxl9yoK2HX/1dFLpWO6ClzAWzOWQVA0lJnf2n7K/H4YJQH3
         2eqQ==
X-Gm-Message-State: APjAAAUO0e673EpoxtYkDy1e+p1r84LgqKv5g/JHu5N8NC/LNNur7spP
        zNWyZ2+nuS8QDq8VgguaaBb9LQ==
X-Google-Smtp-Source: APXvYqwpgoOcFRBOuD+emvtSHwHvjFqbmvhCKA8yAEUXDBfyEAFz6snlp9ZCWQRBAMU4YbulNx7dtg==
X-Received: by 2002:a1c:ed07:: with SMTP id l7mr4253630wmh.148.1558463317936;
        Tue, 21 May 2019 11:28:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844? ([2001:b07:6468:f312:ac04:eef9:b257:b844])
        by smtp.gmail.com with ESMTPSA id s127sm4011028wmf.48.2019.05.21.11.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 11:28:37 -0700 (PDT)
Subject: Re: [PATCH] kvm: change KVM_REQUEST_MASK to reflect vcpu.requests
 size
To:     Rik van Riel <riel@surriel.com>
Cc:     kernel-team@fb.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20190521132200.2b45c029@imladris.surriel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ae5402e2-b748-b144-c1ea-715357529621@redhat.com>
Date:   Tue, 21 May 2019 20:28:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521132200.2b45c029@imladris.surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/19 19:22, Rik van Riel wrote:
> The code using KVM_REQUEST_MASK uses a pattern reminiscent of a bitmask:
> 
> 	set_bit(req & KVM_REQUEST_MASK, &vcpu->requests);
> 
> However, the first argument passed to set_bit, test_bit, and clear_bit
> is a bit number, not a bitmask. That means the current definition would
> allow users of kvm_make_request to overflow the vcpu.requests bitmask,
> and is confusing to developers examining the code.

This is true, but the meaning of the masking is that bits above 7 define
extra things to do when sending a request (wait for acknowledge, kick
the recipient CPU).  The fact that the "request number" field is 8 bits
rather than 5 or 6 is just an implementation detail.

If you change it to BITS_PER_LONG-1, the obvious way to read the code
would be that requests 0, 64, 128 are all valid and map to the same request.

Paolo

> Redefine KVM_REQUEST_MASK to reflect the number of bits that actually
> fit inside an unsigned long, and add a comment explaining set_bit and
> friends take bit numbers, not a bitmask.


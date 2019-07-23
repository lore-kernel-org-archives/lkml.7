Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64796C76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372652251B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388395AbfGWHfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 03:35:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39171 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731234AbfGWHfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:35:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id u25so27146460wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 00:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=weeVjf/Jly+Inq7rrMi7gHQ0j/OuLTL5EFdg7avawSo=;
        b=fXMSDMYaCepUAKwBuWlvLl5h/OTWWxtudttNMn8mGJ0lrJb6HRjoEXi4BgbtSOdNf5
         GMh40MFe64N4zeTDC+QjDfXQXx6mSdvmx1zY4x9LdIwUQNFUXZlTZlxXyEOGnuqwXdeK
         kOqlrpvUK3eKhfrJHaq/dh54iBPBKkIuOJ60+HQzaxUPFB9++5zXFKj9S38d4U+LBAJI
         CIgdZdu0nzTiXb1AWygR35pvEwyixnhABu9tYer5P2ZElid6K5inDOXaVlcuwUOrLQkn
         28g8jg2+iUdLx0/EM4Xheozp+DOkn8sdqknpkJc+f+fnZMus+U/M6O3CqZoweatzsG9N
         tjsQ==
X-Gm-Message-State: APjAAAVrGVCHDAq5cqad5UE45lQuVpaFGvr7Hf+tktpr7DQyaDPerKOh
        Xij60YhURkPS3hC1qbHFtKdLYw==
X-Google-Smtp-Source: APXvYqyWvaMO5IsmxLwfIf/M3f3J+BPyluUZ9RtI3u69i6rj0Wg7FwJpPmGYV2DVsW5IwZS6ldTMwg==
X-Received: by 2002:a1c:3cc4:: with SMTP id j187mr64455922wma.36.1563867307765;
        Tue, 23 Jul 2019 00:35:07 -0700 (PDT)
Received: from [10.201.49.73] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
        by smtp.gmail.com with ESMTPSA id r14sm37030867wrx.57.2019.07.23.00.35.06
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 00:35:07 -0700 (PDT)
Subject: Re: [PATCH] Revert "kvm: x86: Use task structs fpu field for user"
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <1563796594-25317-1-git-send-email-pbonzini@redhat.com>
 <20190723043132.556EC2239E@mail.kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e30db831-6498-95df-031d-908b18cf37f3@redhat.com>
Date:   Tue, 23 Jul 2019 09:35:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723043132.556EC2239E@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/19 06:31, Sasha Levin wrote:
> 
> v5.2.2: Build OK!
> v5.1.19: Failed to apply! Possible dependencies:
>     0cecca9d03c9 ("x86/fpu: Eager switch PKRU state")
>     2722146eb784 ("x86/fpu: Remove fpu->initialized")
>     4ee91519e1dc ("x86/fpu: Add an __fpregs_load_activate() internal helper")
>     5f409e20b794 ("x86/fpu: Defer FPU state load until return to userspace")
> 
> 
> NOTE: The patch will not be queued to stable trees until it is upstream.
> 
> How should we proceed with this patch?

I have 5-6 pending stable patches and I will send a backport for all of
them.

Paolo

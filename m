Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD30C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830722070D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="RNl7bEjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfDBIRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:17:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44773 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfDBIRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:17:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id h16so10683742ljg.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 01:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S34Xh/i0jY80x4DLROdLv9iTDl4FcSi06ggEqytqr3k=;
        b=RNl7bEjSiQdc9tMM2xbWu/9NB72uIC6QQcvybKSy1pAkvHy3Dy6bCz3W++W/R5iAep
         fE3hARUetZCwjbeDikAMkkDVxKLS098mMmHqw5WG9sWMcOvM1o3Bp5e5u4sXmeCMsJz6
         EeIHUXVtSijs6et0dXI0D50odXR/6citZJfTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S34Xh/i0jY80x4DLROdLv9iTDl4FcSi06ggEqytqr3k=;
        b=eFxk5DmWRmyaIErdn7Wv+kQ80Dbq4Iyd7J63caKxextU9W/xIOD2GdsHxFRuafEsDv
         Uw6RlxN4qB7N4baQkZWTjisYxZjrNuUPew5k72oUZlEPhkf8Jr6eR3qC9dHbGLADnxml
         FVYYLOYyabRht03+Rx2jx6LTqzFu3gMFG6QiiGtIF83GA3hTW8fqdCYhR81q9OagCcxK
         BKVfDUllyV/Z0tgOSlTRCkAiROEGsjy2+0X1Tg6nzBibyySBsyl8uf8XxUYYW8OWBAPz
         Rq6IprJzWgqNHk/JgYDNjX16QoD1bnVFslcNeOqo0KmKRWDnQkFvK9onr9h4WpvXxF7s
         buGQ==
X-Gm-Message-State: APjAAAXjVTcU43iIjoRtFj8XTpwWtibkT/uC+EvAyrRZgRHAUEVXlNIF
        cGjk6sOUdyfDm8iq6WU8Q0xIKGNLwABRhpk/
X-Google-Smtp-Source: APXvYqwTfTUQl+EzEfr4kgr+vOznnP1IxmZzYSNDypie4YCApiDNdUu0xaV9Fz1fjaWJjEoa1wTnuA==
X-Received: by 2002:a2e:8089:: with SMTP id i9mr3941553ljg.137.1554193049834;
        Tue, 02 Apr 2019 01:17:29 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d17sm2342213lfb.60.2019.04.02.01.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 01:17:29 -0700 (PDT)
Subject: Re: [RFCv2] string: Use faster alternatives when constant arguments
 are used
To:     Sultan Alsawaf <sultan@kerneltoast.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
References: <20190324014445.28688-1-sultan@kerneltoast.com>
 <20190324022406.GA18988@sultan-box.localdomain>
 <2293c54f-40b1-1e59-665a-bd8f2cb957d2@rasmusvillemoes.dk>
 <20190324223202.GA875@sultan-box.localdomain>
 <8672b98c-bf71-7b5b-625e-2f241807d46c@rasmusvillemoes.dk>
 <20190330225941.GA7456@sultan-box.localdomain>
 <ec88d9a2-272e-973e-55ce-f3d411aafcd1@rasmusvillemoes.dk>
 <20190401235536.GA874@sultan-box.localdomain>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <74d768ce-d2fe-5c02-42b7-9559cd503e50@rasmusvillemoes.dk>
Date:   Tue, 2 Apr 2019 10:17:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401235536.GA874@sultan-box.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2019 01.55, Sultan Alsawaf wrote:
> On Mon, Apr 01, 2019 at 10:43:13PM +0200, Rasmus Villemoes wrote:

>> No. First, these are concerns for all arches. Second, if you can find
>> some particular place where string parsing/matching is in any way
>> performance relevant and not just done once during driver init or
>> whatnot, maybe the maintainers of that file would take a patch
>> hand-optimizing some strcmps to memcmps, or, depending on what the code
>> does, perhaps replacing the whole *cmp logic with a custom hash table.
> 
> FWIW, I didn't have a specific place in the kernel in mind that heavily relied
> on str* operations and needed optimization. I just thought it could be a "free"
> optimization, but apparently not.

Well, it wouldn't be completely free; at the very least, .text size
would usually increase, and for the majority of sites that are
execute-at-most-once-per-full-moon that's actually a small overall
pessimization. But the point is moot, I think.

>> But a patch implicitly and silently touching thousands of lines of code,
>> without an analysis of why none of the above is a problem for any of
>> those lines, for any .config, arch, compiler version? No.
> 
> Well, I thought it could be proven to be correct regardless of the context,
> which would imply that making such a global change touching thousands lof lines
> of code would be safe. But sadly it isn't.
> 
> This does bring into question a greater problem though: usage of memcmp
> throughout the kernel where the size provided is not the size of the smaller
> container being compared. This usage of memcmp (which is quite easy to find all
> across the kernel) could run into the unaligned memory access across a page
> boundary that you gave as an example, no?

Yes, as I said, I think you may have identified some actual bugs. In
some cases, the runtime string is known to live in an array of
sufficient size, so we would at most be reading uninitialized bytes (but
not making decisions based on them) - that could cause a sanitizer
warning, but otherwise harmless (stuff like this is a rather common
source of false positives with valgrind). In other cases, there's no
such guarantee. It really needs to be decided on a case-by-case basis.
And if in doubt, I'd change the code to use strcmp(), strncmp(),
strstarts() as appropriate - that's _much_ more readable, and avoids
having to worry, and would usually avoid duplicating the literal string
(which is error-prone when the code gets copy-pasted to handle a new
option).

Rasmus

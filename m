Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD45C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 06:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3FE21855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 06:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="KFFQIST8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfI3GQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 02:16:55 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39370 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfI3GQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 02:16:54 -0400
Received: by mail-lf1-f66.google.com with SMTP id 72so6071897lfh.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 23:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9OcRc//3J5qf9vDujCaVU16jyNO92dJpMooBFg7biKw=;
        b=KFFQIST8D3PBBuoT23rME4FvvUo4KNAZtNe+SxEW4heEpyDVXtS088c8HpfTuRRPfU
         U7T0Gqm2ubZ0RnxfRuHR16NxUl5+B3Ph6uNrvd3n+Rdi9x96ao0T5uzf9aKTDXW/Cgxt
         8Ldl2k1WLDYJgYA/EJE52H6D/6OjnnqIWGcEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9OcRc//3J5qf9vDujCaVU16jyNO92dJpMooBFg7biKw=;
        b=Bg31lCBzp0jyC+0vuy9fFmrHqlPRhsQLzPQF1QkcLnEBWsNcUT71gdOjbYHn8MauWL
         0fvUKbq7tK7vgsAr9V3sk7Xm3Ml8G4cgDgvO73rmccWT6lCncEIUlpf3gsxysdgoc9VN
         RqsXfFoXA2pMLqOHoDQBnnfwAU5BV1mBuGD9A+8bYGGpZ1zjNwceIAS4jvTHRpDeR59Y
         ljXlwgzOGjqn9K2u2f5h1eoLkC3Pbv1XihLEpkjIDY2MT4u6+8XT4pbCS7vv3TXHpPUo
         ythRFaE4fL4mRQ3jK+pgdHGmXoFKgwea2K64ofqAlAQ4DN7JJibE75br9C6hq+znTLk+
         GHLA==
X-Gm-Message-State: APjAAAV71M22LKtGSkmv/hiaUkj8eUbpZTg0tzr18/rXXdqezz15/STr
        iCd8LCCEHekvGSZVCVQNdahQXA==
X-Google-Smtp-Source: APXvYqyxQaRLCYgkpTQufRin+7rYfQJukdWqENA2nJNMEsmGLeCJoEyQfsYOUne0fnqy0d9a1XXPTw==
X-Received: by 2002:ac2:5196:: with SMTP id u22mr10413960lfi.130.1569824211443;
        Sun, 29 Sep 2019 23:16:51 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id i128sm3033381lji.49.2019.09.29.23.16.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Sep 2019 23:16:50 -0700 (PDT)
Subject: Re: [PATCH] Make is_signed_type() simpler
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        rostedt@goodmis.org, mingo@redhat.com
References: <20190929200619.GA12851@avx2>
 <f99ca43d-1ba2-95fb-b90f-6706a06f8ce6@rasmusvillemoes.dk>
 <20190929210908.GA14456@avx2>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <91c5c649-9c9d-6c36-76c1-19208f9ad9a9@rasmusvillemoes.dk>
Date:   Mon, 30 Sep 2019 08:16:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190929210908.GA14456@avx2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2019 23.09, Alexey Dobriyan wrote:
> On Sun, Sep 29, 2019 at 10:21:48PM +0200, Rasmus Villemoes wrote:
>> On 29/09/2019 22.06, Alexey Dobriyan wrote:
>>> * Simply compare -1 with 0,
>>> * Drop unnecessary parenthesis sets
>>>
>>> -#define is_signed_type(type)       (((type)(-1)) < (type)1)
>>> +#define is_signed_type(type)       ((type)-1 < 0)
>>
>> NAK. I wrote it that way to avoid -Wtautological-compare when type is
>> unsigned.
> 
> Was is W=1?
> 
> godbolt doesn't show it with just -Wall
> 
> 	https://godbolt.org/z/kCA7mm
> 
> And the warning which found i915 case is -Wextra not -Wtautological-compare.
> 

Yeah, it's usually disabled/not enabled in the kernel. I did most of the
prototyping/testing in userspace with my default Cflags, and decided to
keep it this way in case somebody copy-pastes it to a code base that
does enable -Wtautological-compare. I see it's been copy-pasted to
tools/, who knows what they do. IMO, "it may be copy-pasted" would not
be valid reason for a transform the other way, but I really don't see a
reason for changing it now. Especially since it seems to require some
tree-wide adaptation.

Rasmus

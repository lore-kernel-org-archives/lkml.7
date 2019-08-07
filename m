Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338A2C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DCD22297
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZj2SSzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389005AbfHGQwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:52:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36160 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388986AbfHGQwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:52:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so41684259plt.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 09:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/BNEOnD3kNJF0VrY9wYsSdWMPn0667PaljBpwtb9RT4=;
        b=YZj2SSzDbfQAYhcRUjuZSApcb8ev5eBRkPsjtGzbnznWb+XK5uGJKbYYgYwFXrXjYU
         Ip0dw7muflAPX8SjDpctDMcQY0CE127hm7HNxguDn1TAaOWQHfcVa1iRsB5sU/HPL/19
         VdZ+9RutOAJV6sD7fbRduk/kkoNiE6UYtFYHcwh4odeSrm782J0/z7JH9Tp1QbuQ0qZv
         jbMLXWZzV6BbWPlDO6LgLQjs3VxypG70xKeTD30CbEFOI7iquTr34b77jt60THxQsSIC
         DZ8gNqqnyNSYFKeP9B6FGIWuehT/9Q1NCtZ/q54qNRCCdgbj1tgutgvl61PR/YLTdIDl
         abSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/BNEOnD3kNJF0VrY9wYsSdWMPn0667PaljBpwtb9RT4=;
        b=kcVWOqPtRSyCsHSMQ6LsnJTXWFu9cP+kxCq0F2DxvTWfkKo7PUct1jyPAECnesaK2r
         BHMLImmYQXxFGi0iVox8mVP7CtyqHyXYm0ZsPy1ieKQ8gb10fWFE3vIjHXEoH16X1bXT
         zIy3eQP6mzc7stf8AqZ6uTxNFkqqotf7IWULqayxKhcrz/PnibsM4Kg4Y5qGoplB/Z/J
         qyTDgqFFD5dSE5CLWeG//geN3/J2+nK2YKmUFCpXROgJ6cEVExTtjXaCgCvhWyWdv0Fa
         3AoWQf8YD2eo54VMaqIwm7jTbqW5ifLayPLaCiWlgq5DFKa7Hdbr8sv0I/2+7HEkLdw+
         VfzQ==
X-Gm-Message-State: APjAAAX8xo8FHferPzhtQP4h+cMzz2X269qm8+4F4BUU95Oz7izR+zUg
        UJ5bNx6y+MJcLQ+lA1TC2ai2idyM
X-Google-Smtp-Source: APXvYqzuuW9X6hywIknhRS4SY+F+uaRWj6Fnf4AlJyoFAYVjVDpYWMCETmI/plIo9ObTp0e43Af6pQ==
X-Received: by 2002:a65:514c:: with SMTP id g12mr8596858pgq.76.1565196755287;
        Wed, 07 Aug 2019 09:52:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j16sm387440pjz.31.2019.08.07.09.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 09:52:34 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] linux/bits.h: Add compile time sanity check of
 GENMASK inputs
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190731190309.19909-1-rikard.falkeborn@gmail.com>
 <20190801230358.4193-1-rikard.falkeborn@gmail.com>
 <20190801230358.4193-2-rikard.falkeborn@gmail.com>
 <20190807142728.GA16360@roeck-us.net>
 <CAK7LNATGuO0D0a-sTvWw5Pzkn5C7jrLiS=rCwiRsEqaS86KbuQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d1bd1c05-3e92-1a7f-ebd3-3b26981a6f8e@roeck-us.net>
Date:   Wed, 7 Aug 2019 09:52:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNATGuO0D0a-sTvWw5Pzkn5C7jrLiS=rCwiRsEqaS86KbuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/19 7:55 AM, Masahiro Yamada wrote:
> On Wed, Aug 7, 2019 at 11:27 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Fri, Aug 02, 2019 at 01:03:58AM +0200, Rikard Falkeborn wrote:
>>> GENMASK() and GENMASK_ULL() are supposed to be called with the high bit
>>> as the first argument and the low bit as the second argument. Mixing
>>> them will return a mask with zero bits set.
>>>
>>> Recent commits show getting this wrong is not uncommon, see e.g.
>>> commit aa4c0c9091b0 ("net: stmmac: Fix misuses of GENMASK macro") and
>>> commit 9bdd7bb3a844 ("clocksource/drivers/npcm: Fix misuse of GENMASK
>>> macro").
>>>
>>> To prevent such mistakes from appearing again, add compile time sanity
>>> checking to the arguments of GENMASK() and GENMASK_ULL(). If both the
>>> arguments are known at compile time, and the low bit is higher than the
>>> high bit, break the build to detect the mistake immediately.
>>>
>>> Since GENMASK() is used in declarations, BUILD_BUG_ON_ZERO() must be
>>> used instead of BUILD_BUG_ON(), and __is_constexpr() must be used instead
>>> of __builtin_constant_p().
>>>
>>> If successful, BUILD_BUG_OR_ZERO() returns 0 of type size_t. To avoid
>>> problems with implicit conversions, cast the result of BUILD_BUG_OR_ZERO
>>> to unsigned long.
>>>
>>> Since both BUILD_BUG_ON_ZERO() and __is_constexpr() only uses sizeof()
>>> on the arguments passed to them, neither of them evaluate the expression
>>> unless it is a VLA. Therefore, GENMASK(1, x++) still behaves as
>>> expected.
>>>
>>> Commit 95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends
>>> available in assembly") made the macros in linux/bits.h available in
>>> assembly. Since neither BUILD_BUG_OR_ZERO() or __is_constexpr() are asm
>>> compatible, disable the checks if the file is included in an asm file.
>>>
>>
>> Who is going to fix the fallout ? For example, arm64:defconfig no longer
>> compiles with this patch applied.
>>
>> It seems to me that the benefit of catching misuses of GENMASK is much
>> less than the fallout from no longer compiling kernels, since those
>> kernels won't get any test coverage at all anymore.
> 
> 
> We cannot apply this until we fix all errors.
> 
> I do not understand why Andrew picked up this so soon.
> 

The same was done with the fallthrough warning in mainline, which still results
in all "sh" builds failing there (and in -next, obviously). I don't understand
the logic either, but maybe it is the new normal.

Guenter

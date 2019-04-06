Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A986C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 11:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D168520879
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 11:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="L/MtJ+ez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbfDFLci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 07:32:38 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35716 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 07:32:38 -0400
Received: by mail-ed1-f68.google.com with SMTP id s39so7704771edb.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 04:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4wofAvxBdno8u0MyRmCZ9O1rpYe4pkKpNfg/nhiNm3U=;
        b=L/MtJ+ez5XPfpQjGtml4QmjJdqgmvPgeQH6WiTbQ6J9AUJFvpJgg8NPx0gwWjKq7hk
         CdK5XOZGsF1Ft5YFMGtYQJ3vaOAOqWToxVbVimThgCKF475D4SQCUwqoApFI4N7Pe93e
         PAOMjY66BE2gRMXNvkpPNx2c1vX7jSp1kApO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4wofAvxBdno8u0MyRmCZ9O1rpYe4pkKpNfg/nhiNm3U=;
        b=Q0+Vkd0hh85sNU/BV6mEN49TYuZPAkCcyfe1Rarx3+aKLNqgaO2OXnCU/nfXr3V07d
         mb1MCfBT1inylC1mz8B5HM8pQS1J+az1BY9b9mxRdUOOqntVuS8IaTZ1vRAuu2Tqy4gX
         4KINO6/oLeKxdDrqvFS0U2mVVVPckz8/VdOgF0LX5aG2t1fGyANtyz3T0tvuKu8oOgzC
         x98WDQM1EFnNtXxQsdR+YF8C/xHVPxMMqzyHAYRyCEQd9xJVWO1QDqf6V/oczAV4eLF0
         dwLY7AAYlw4mKtYUeYGht1DvXT0iVXopYwT6873eotpJ4s7m7Iz+biCKTXYaHJLgLauh
         DK0w==
X-Gm-Message-State: APjAAAWVBUBXhWwDikno+tLUjcEUpYI73F/KaaHUI4FVF1E7OAf6036J
        Q1lQVPd0istDc4Ckjv5nwwQr8Y27JPcg0rxX
X-Google-Smtp-Source: APXvYqyVue+CBBd0mQciYy0jTI6PWYqgXNlFgDCTYLqQLRyEAqbZGBcKQrTc1M5SR8cxatrup70J1A==
X-Received: by 2002:a50:b1bc:: with SMTP id m57mr11854613edd.116.1554550356175;
        Sat, 06 Apr 2019 04:32:36 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id i9sm856304edr.76.2019.04.06.04.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:32:35 -0700 (PDT)
Subject: Re: [PATCH] overflow.h: Rename __ab_c_size() to __calc_size()
To:     Borislav Petkov <bp@alien8.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190405045711.30339-1-bp@alien8.de>
 <d2e7ee85-50a7-7026-82f9-2169656bd4f9@rasmusvillemoes.dk>
 <20190405075251.GC23348@zn.tnic>
 <3fefb03d-3ea0-5a08-f00c-09a47b17f2a8@rasmusvillemoes.dk>
 <20190405082447.GD23348@zn.tnic>
 <CAGXu5jK6+ZcJQqchySsMicEy-Kd=TFRTE1M_JdhX4TaJDAPiaQ@mail.gmail.com>
 <20190405162527.GP22763@bombadil.infradead.org>
 <20190406093201.GB14245@zn.tnic>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <ab412726-f63f-57cc-ed23-ae1a4944539f@rasmusvillemoes.dk>
Date:   Sat, 6 Apr 2019 13:32:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190406093201.GB14245@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2019 11.32, Borislav Petkov wrote:
> On Fri, Apr 05, 2019 at 09:25:27AM -0700, Matthew Wilcox wrote:
>> I don't think that's a good idea; we should only document functions we
>> want other people to use.
> 
> Yap.

Exactly, not kernel-doc'ing was a deliberate choice.

>> I could also go for renaming this to __size_ab_plus_c.
> 
> Let's just leave it short as it is now - the comment should be good
> enough.
> 
> Btw, is anyone picking this up or should I?

I'm fine with you picking it up. Here's a real changelog, feel free to edit.

overflow.h: add comment documenting __ab_c_size()

__ab_c_size() is a somewhat opaque name. Document its purpose, and while
at it, rename the parameters to actually match the abc naming.


Rasmus

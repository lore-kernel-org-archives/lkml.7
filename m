Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428BEC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BAD20673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ujDS9k2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfI0MgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 08:36:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45018 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfI0MgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 08:36:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id i18so2518471wru.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 05:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VRuu/jOQ4Zp+zYJZfIF9hFDwWbv4EjPC9iKOvfai/Ug=;
        b=ujDS9k2OFc0WreqK2y/fe3R6tAVOaH4UfeF+TiT42v8swDKFwVKCk6zo4b9m6X2ZT3
         oSCGFDePMAAvuxW/GcldxxlJNycLBYIKPzBg5kyUBHv5TAg4ydQJM5TGuDGiXigA1AOD
         zPOmFNnzjOL2vDIMvtZIty3Uoq1A3Al6TZ75BjLi91HdQIPMOlf0l6EHW6MjwxftMhq9
         S0W5MQPBlcFgCSpub7F21j9+GhnXqS9sLn3TEpPuBpAqCqhmJ9Tl3vgzGn8c6Z7Y1Ctk
         kwP/lIrLn1T3o1A7/a0SeLZ4v2XrOLsg7VG1UZZs6I5tLFLaGR8cbBmMZ/l/zt9ecSBM
         9UWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VRuu/jOQ4Zp+zYJZfIF9hFDwWbv4EjPC9iKOvfai/Ug=;
        b=cxFADLIrH3bPuUB86mj+sapK6zzJJFnJVjmjA99Z1Cc4Iup2E3G4r+ztrWMiMUfA64
         +GyvB81cIX/TvJngwWGKvK+MAQ6aXhqdZmWzSgqqrQk4gQ68aOMKokGwL4NI/jeVUxZK
         b67RVHAGUD/GYZiAknfoqzHg2NkeKjgyHSiGsHRNpe9JOHsJkZBZ00U8nS2cinEyxU7S
         N7+huOyTqsc7TBMzOAiuWjqWeuGWcrC7LNR6/RnU5/fb5c0eMEijbqn0ZKV/WmUahDuG
         GALUpSJ0VHEW1mgW1dXqKbaYByKviUsxq4EoUmefUy1fjn4qqXO+aO2eWtNLx8ZDnz+2
         qtMA==
X-Gm-Message-State: APjAAAWgLOP5hQpP3lBNmnm7aBV2QsMIpaLfiDWwZfIHOzZT61dcQXJo
        BOX5TTIlzXU1Ee4WgR5Sae9v5g==
X-Google-Smtp-Source: APXvYqzDMuORRfaJT68JEBTRTG1lWRYGgATP795TJZ2KXH3TNeSmXRYq3cFVQH1OjTDUF8q8NYoLWQ==
X-Received: by 2002:a05:6000:14b:: with SMTP id r11mr2584070wrx.58.1569587777681;
        Fri, 27 Sep 2019 05:36:17 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id d9sm4077030wrc.44.2019.09.27.05.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 05:36:16 -0700 (PDT)
Date:   Fri, 27 Sep 2019 13:36:13 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jessica Yu <jeyu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Will Deacon <will.deacon@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] module: avoid code duplication in
 include/linux/export.h
Message-ID: <20190927123613.GD259443@google.com>
References: <20190927093603.9140-1-yamada.masahiro@socionext.com>
 <20190927093603.9140-5-yamada.masahiro@socionext.com>
 <f2e28d6b-77c5-5fe2-0bc4-b24955de9954@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f2e28d6b-77c5-5fe2-0bc4-b24955de9954@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 01:07:33PM +0200, Rasmus Villemoes wrote:
>On 27/09/2019 11.36, Masahiro Yamada wrote:
>> include/linux/export.h has lots of code duplication between
>> EXPORT_SYMBOL and EXPORT_SYMBOL_NS.
>>
>> To improve the maintainability and readability, unify the
>> implementation.
>>
>> When the symbol has no namespace, pass the empty string "" to
>> the 'ns' parameter.
>>
>> The drawback of this change is, it grows the code size.
>> When the symbol has no namespace, sym->namespace was previously
>> NULL, but it is now am empty string "". So, it increases 1 byte
>> for every no namespace EXPORT_SYMBOL.
>>
>> A typical kernel configuration has 10K exported symbols, so it
>> increases 10KB in rough estimation.
>>
>> I did not come up with a good idea to refactor it without increasing
>> the code size.
>
>Can't we put the "aMS" flags on the __ksymtab_strings section? That
>would make the empty strings free, and would also deduplicate the
>USB_STORAGE string. And while almost per definition we don't have exact
>duplicates among the names of exported symbols, we might have both a foo
>and __foo, so that could save even more.

I was not aware of this possibility and I was a bit bothered that I was
not able to deduplicate the namespace strings in the PREL case. So, at
least I tried to avoid having the redundant empty strings in it. If this
approach solves the deduplication problem _and_ reduces the complexity
of the code, I am very much for it. I will only be able to look into
this next week.

>I don't know if we have it already, but we'd need each arch to tell us
>what symbol to use for @ in @progbits (e.g. % for arm). It seems most
>are fine with @, so maybe a generic version could be
>
>#ifndef ARCH_SECTION_TYPE_CHAR
>#define ARCH_SECTION_TYPE_CHAR "@"
>#endif
>
>and then it would be
>section("__ksymtab_strings,\"aMS\","ARCH_SECTION_TYPE_CHAR"progbits,1")
>
>But I don't know if any tooling relies on the strings not being
>deduplicated.

Matthias
Cheers,

>Rasmus

Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F63CC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 11:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BBD207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 11:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="MEkjkBrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfI0LHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 07:07:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42525 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfI0LHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 07:07:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id y23so2059368lje.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 04:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3oGUOoJ5SW+DTMVPL3UUtjpNbyCkNbodWu3m4weaNuM=;
        b=MEkjkBrs2zp8UeloIli/4sMbZayjf5Iv+cPRCAAQKAc5OCQGFgu1WIwzwRoI2QZZZT
         lqXy7UZOvzGC+5hY7w/kuAO8LPexJQa5xRGo999UZs385hUUFNeDw/1+q6Am+ap03NTJ
         V7y9eLlvBUF2F+8iySWyNEJm64qOw8aWp6w/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3oGUOoJ5SW+DTMVPL3UUtjpNbyCkNbodWu3m4weaNuM=;
        b=Ez79PeX3hF9W/uiGy64zYzqsR23fyBK+hlV2xrAN5+UHRS9bdN3GVqS+/FyrvwrK1h
         imVHpC/7QGkLdtlxcM+CAZOUHZQFmmNaRk/jMCPNP+ZNYqbGaiIl6AD9T0z7M2kbR38w
         WxTM4iwxxgVTFFFv2KGv0sBFAn6nnrTTnL02yuKzv+D7B3iAzpN6VfUaMheqEcZsAnfk
         dYpnaBJrFtDBWo6cNJXBtf2A5ocIuHaeHNOixPe+mY4AqO0khNhCjDteyluNazwAsLbq
         kAX72x+j7+VdUF0NLKIYogvJJFpZb9PvBvUFiqVohipHU2x9BnUldKKQtM2w/0j+qpyM
         6aZQ==
X-Gm-Message-State: APjAAAW0wvyYwCoxwur6ajWJBcRQZoMRNJjONTWXtnFE1FqZf9kPYnsi
        3GBPkHv+VKfOvwRfSTg31CA+0jdlXclXMN/K
X-Google-Smtp-Source: APXvYqzumX9yp7awSisKK8bAze5UQnBkJTvkFtZqLB+nth2FTQgsa5+zv9JRLgENlXBrYrid92+DHw==
X-Received: by 2002:a2e:9584:: with SMTP id w4mr2509460ljh.145.1569582456181;
        Fri, 27 Sep 2019 04:07:36 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m21sm415265lfh.39.2019.09.27.04.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 04:07:35 -0700 (PDT)
Subject: Re: [PATCH 4/7] module: avoid code duplication in
 include/linux/export.h
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jessica Yu <jeyu@kernel.org>
Cc:     Matthias Maennich <maennich@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Will Deacon <will.deacon@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
References: <20190927093603.9140-1-yamada.masahiro@socionext.com>
 <20190927093603.9140-5-yamada.masahiro@socionext.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f2e28d6b-77c5-5fe2-0bc4-b24955de9954@rasmusvillemoes.dk>
Date:   Fri, 27 Sep 2019 13:07:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190927093603.9140-5-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2019 11.36, Masahiro Yamada wrote:
> include/linux/export.h has lots of code duplication between
> EXPORT_SYMBOL and EXPORT_SYMBOL_NS.
> 
> To improve the maintainability and readability, unify the
> implementation.
> 
> When the symbol has no namespace, pass the empty string "" to
> the 'ns' parameter.
> 
> The drawback of this change is, it grows the code size.
> When the symbol has no namespace, sym->namespace was previously
> NULL, but it is now am empty string "". So, it increases 1 byte
> for every no namespace EXPORT_SYMBOL.
> 
> A typical kernel configuration has 10K exported symbols, so it
> increases 10KB in rough estimation.
> 
> I did not come up with a good idea to refactor it without increasing
> the code size.

Can't we put the "aMS" flags on the __ksymtab_strings section? That
would make the empty strings free, and would also deduplicate the
USB_STORAGE string. And while almost per definition we don't have exact
duplicates among the names of exported symbols, we might have both a foo
and __foo, so that could save even more.

I don't know if we have it already, but we'd need each arch to tell us
what symbol to use for @ in @progbits (e.g. % for arm). It seems most
are fine with @, so maybe a generic version could be

#ifndef ARCH_SECTION_TYPE_CHAR
#define ARCH_SECTION_TYPE_CHAR "@"
#endif

and then it would be
section("__ksymtab_strings,\"aMS\","ARCH_SECTION_TYPE_CHAR"progbits,1")

But I don't know if any tooling relies on the strings not being
deduplicated.

Rasmus

Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B41CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D686120862
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572376773;
	bh=yMFBENXBzPYHJDxwTp9VyBRameOLEOvTCdOceGJIy8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NPmdpQoIpQ5NvgY7pxbTw1aPHBWPjugB7CrimIeSRRYXTYCPezDWSLUTiP33kNsMa
	 f/K12KRDqooO581XLhAMzcZOtLMhPXALj/2mrBC+4OAjg4WZ8T/tjsnszE6g8GCb58
	 vf3xWFcoLAWqR2Hy8kbChVECDvu/oTtEGHFGNn28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbfJ2TTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 15:19:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfJ2TTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 15:19:32 -0400
Received: from linux-8ccs (unknown [92.117.159.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7090220659;
        Tue, 29 Oct 2019 19:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572376771;
        bh=yMFBENXBzPYHJDxwTp9VyBRameOLEOvTCdOceGJIy8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T/l34ni9ZBUJCqv9+ALck3bG73n6eZygSioJ5tSqUXR2QBr6j7VbsJOULaHjNZ0iZ
         WM6omtRNjDPj5HR9dRpiI1/6XvTJcA7tBrMveGr0m9Ua8PxtjjlyY56z8JrHBQTkUS
         Vgz+4h+3Q2TyYE0b2i3nHJXRBjJjQONQ9inI2+vU=
Date:   Tue, 29 Oct 2019 20:19:25 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Will Deacon <will.deacon@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] module: avoid code duplication in
 include/linux/export.h
Message-ID: <20191029191925.GA19316@linux-8ccs>
References: <20190927093603.9140-1-yamada.masahiro@socionext.com>
 <20190927093603.9140-5-yamada.masahiro@socionext.com>
 <f2e28d6b-77c5-5fe2-0bc4-b24955de9954@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f2e28d6b-77c5-5fe2-0bc4-b24955de9954@rasmusvillemoes.dk>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Rasmus Villemoes [27/09/19 13:07 +0200]:
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
>
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

FWIW, I've just tinkered with this, and unfortunately the strings
don't get deduplicated for kernel modules :-(

Apparently ld does not do the deduplication for SHF_MERGE|SHF_STRINGS
sections for relocatable files (ld -r), which kernel modules are. See:

    https://sourceware.org/ml/binutils/2009-07/msg00291.html

But, the strings do get deduplicated for vmlinux. Not sure if we can
find a workaround for modules or if the benefit is significant enough
if it only for vmlinux.

Thanks,

Jessica


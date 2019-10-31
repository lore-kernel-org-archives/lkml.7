Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60F3CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600992086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572521170;
	bh=zERjF8p0lWRuszeLtdQc9aGX1SESfNhug1H09sXRuFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=njGbgVVCDdjbcTO/r07oP0ysMN2YiTF0Xq5rjkSwIWU+29r2WNubOwOq2xQsTX74g
	 Zr1n2hJuTbQqCRtunhTn7lgw0+aa44UNN85NLfIQw3ODvsVoryIxUCHUfqaewe/GMN
	 SBZ5UHlfOftg9JFSELsqmh0eUCak7ZaFj34qwOu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfJaL0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:26:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbfJaL0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:26:08 -0400
Received: from linux-8ccs (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CD0920650;
        Thu, 31 Oct 2019 11:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572521168;
        bh=zERjF8p0lWRuszeLtdQc9aGX1SESfNhug1H09sXRuFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AZFQwrT/Isqos+k1o3Ul933IlxVPdKI9DU2OgpcbeOJjCTNPuiaAYRUuqPk2KTO66
         Ip8i8ATLPKNSHHkWQ3YvV9LxchKndifq4MmpNYtgxwxyNINYkDhvEXKyl5L6xAUZop
         aX933PzqC5AvWe15vP/A54mhOyNPFQugtFGqbCR4=
Date:   Thu, 31 Oct 2019 12:26:03 +0100
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
Message-ID: <20191031112602.GD2177@linux-8ccs>
References: <20190927093603.9140-1-yamada.masahiro@socionext.com>
 <20190927093603.9140-5-yamada.masahiro@socionext.com>
 <f2e28d6b-77c5-5fe2-0bc4-b24955de9954@rasmusvillemoes.dk>
 <20191029191925.GA19316@linux-8ccs>
 <a2e6bdc2-3d35-a3dc-13ef-1ce32f77ef17@rasmusvillemoes.dk>
 <20191031101306.GA2177@linux-8ccs>
 <8eb4f2fd-f34f-606d-8e7d-4b6b6fb86edc@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8eb4f2fd-f34f-606d-8e7d-4b6b6fb86edc@rasmusvillemoes.dk>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Rasmus Villemoes [31/10/19 12:03 +0100]:
>On 31/10/2019 11.13, Jessica Yu wrote:
>> +++ Rasmus Villemoes [29/10/19 22:11 +0100]:
>>> On 29/10/2019 20.19, Jessica Yu wrote:
>
>>>> Apparently ld does not do the deduplication for SHF_MERGE|SHF_STRINGS
>>>> sections for relocatable files (ld -r), which kernel modules are. See:
>>>>
>>>>    https://sourceware.org/ml/binutils/2009-07/msg00291.html
>>>
>>> I know <https://patches-gcc.linaro.org/patch/5858/> :)
>>
>> That is exactly what we need! :)
>>
>>>> But, the strings do get deduplicated for vmlinux. Not sure if we can
>>>> find a workaround for modules or if the benefit is significant enough
>>>> if it only for vmlinux.
>>>
>>> I think it's definitely worth if, even if it "only" benefits vmlinux for
>>> now. And I still hope to revisit the --force-section-merge some day, but
>>> it's very far down my priority list.
>>
>> Yeah, I think it's worth having too.
>>
>> If you don't have any extra cycles at the moment, and it's far down
>> your priority list, do you mind if I take a look and maybe try to push
>> that patch of yours upstream again?
>
>Knock yourself out :) IIRC, it did actually work for the powerpc I was
>targeting, but I don't remember if that was just "readelf/objdump
>inspection of the ELF files looks reasonable" or if I actually tried
>loading the modules. I've pushed the patch to
>https://github.com/Villemoes/binutils-gdb/commit/107b9302858fc5fc1a1690f4a36e1f80808ab421
>so you don't have to copy-paste from a browser.

Thanks a bunch!

>I don't know how successful I'd
>> be, but now since it's especially relevant for namespaces, it's
>> definitely worth looking at again.
>
>Yeah, but even ignoring namespaces, it would be nice to have format
>strings etc. deduplicated. Please keep me cc'ed on any progress you make.

Thanks, I'll keep you posted if I manage to get somewhere with it :)


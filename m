Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8774CC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 22:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5913621670
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 22:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OGjChnSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbfIDWx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 18:53:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbfIDWx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 18:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VOCDgRJjNCLo+qT7jheJoN/yK4TwqXLq7YSM/I7lAwM=; b=OGjChnSQgBUdP9C+KoRTk06hO
        LL5vFvOBJqtJ/BsOqKP89pdZefSyvXIlZCuz+5sUuxu8k80BHvVB80bb/yVSw+S5EB99/f3LjUN4n
        3yM/unZPI5oUiSmvIb35mTEmqHyq96vTbTysc78rUKETBQkEYZmAQxwdZxhCVcDGiChX6Q89Q/gBc
        y236e/UUSpbFGr46hF5VsfIeWhHX+NziI46++9JriY1d9p+c9YXSe63FgbYth1yFgLBbHMdQlndSZ
        tlsc+skxcU3u4IWS1rYtJDPDvp7QExB753nYQnJ4I8eJKxTYgeMr1wsSQFogsHQx3yPxkKUrlqGFz
        j5RdzYcRQ==;
Received: from [2601:1c0:6200:6e8::e2a8]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5e9M-0008GX-Tb; Wed, 04 Sep 2019 22:53:18 +0000
Subject: Re: [PATCH 1/1] x86/purgatory: Change compiler flags to avoid
 relocation errors.
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Vaibhav Rustagi <vaibhavrustagi@google.com>,
        russ.anderson@hpe.com, dimitri.sivanich@hpe.com,
        mike.travis@hpe.com, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
References: <20190904214505.GA15093@swahl-linux>
 <CAKwvOdnX3qVq1wGovViyGJSnySKzCATU4SU_ASsL-9XfDZ8+Eg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5cdbd4bf-245c-1baf-97c0-e7723bad89bd@infradead.org>
Date:   Wed, 4 Sep 2019 15:53:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdnX3qVq1wGovViyGJSnySKzCATU4SU_ASsL-9XfDZ8+Eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/19 3:18 PM, Nick Desaulniers wrote:
> + (folks recommended by ./scripts/get_maintainer.pl <patchfile>)
> (See also, step 7:
> https://nickdesaulniers.github.io/blog/2017/05/16/submitting-your-first-patch-to-the-linux-kernel-and-responding-to-feedback/)
> 
> On Wed, Sep 4, 2019 at 2:45 PM Steve Wahl <steve.wahl@hpe.com> wrote:
>>
>> The last change to this Makefile caused relocation errors when loading
> 
> It's good to add a fixes tag like below when a patch fixes a
> regression, so that stable backports the fix as far back as the
> regression:
> Fixes: b059f801a937 ("x86/purgatory: Use CFLAGS_REMOVE rather than
> reset KBUILD_CFLAGS")

but don't split the Fixes: line (I did that once :).

from submitting-patches.rst:

If your patch fixes a bug in a specific commit, e.g. you found an issue using
``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
the SHA-1 ID, and the one line summary.  Do not split the tag across multiple
lines, tags are exempt from the "wrap at 75 columns" rule in order to simplify
parsing scripts.


thnx.
-- 
~Randy

Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA46C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7651C21473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554251383;
	bh=+cU9jzsfCAr4L9VaapHgF4ASVQkWLvM7R7qwcgxhKrI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=oPKnqhGCqzSt9mT064N19tZD2WXUYpjn42yyfX+czceLUElXvxgV24hXWMAHLK9tP
	 mcQUijZSjFl2KYGug6uv+Lg0Z53VFhVH1R4/WFjGbBRHlHP5DcbL3QjVlk3FoIECDD
	 U+EvfXJ93b4KEov0UXLMShoLVromBWArqZX0Vr6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfDCA3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 20:29:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfDCA3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 20:29:41 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFAC92084A;
        Wed,  3 Apr 2019 00:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554251380;
        bh=+cU9jzsfCAr4L9VaapHgF4ASVQkWLvM7R7qwcgxhKrI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P316Fa3PreqRgvdGG9qMpLzx9Q5kbU5HQMY3EsmNYWo6/Bm0ghTx/ywwHd5y4KvTJ
         mxHZ90yiNC1+9tqnBKC6yu/vfkJxLCWrJ85FZ9RVnF6dRSh63OwnIiXNuEG8jAbqQl
         Z/JKAXPljWdBZ4+/LpwFjhykFOtYdNZlKEnLvNII=
Subject: Re: [PATCH v3 0/7] lib/string: Add strscpy_pad() function
To:     "Tobin C. Harding" <me@tobin.cc>, Kees Cook <keescook@chromium.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jann Horn <jannh@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, shuah <shuah@kernel.org>
References: <20190306214226.14598-1-tobin@kernel.org>
 <CAGXu5jJeFOBBiofjG6_rqbf+_0fbKC46pzyfoACWt+NBg-bXtg@mail.gmail.com>
 <20190403002527.GB29296@eros.localdomain>
From:   shuah <shuah@kernel.org>
Message-ID: <5c780987-e8d4-a1cf-2ea6-a16087e4491d@kernel.org>
Date:   Tue, 2 Apr 2019 18:29:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190403002527.GB29296@eros.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/19 6:25 PM, Tobin C. Harding wrote:
> On Tue, Apr 02, 2019 at 02:37:57PM -0700, Kees Cook wrote:
>> On Wed, Mar 6, 2019 at 1:43 PM Tobin C. Harding <tobin@kernel.org> wrote:
>>> This set makes an attempt at adding a framework to kselftest for writing
>>> kernel test modules.  It also adds a script for use in creating script
>>> test runners for kselftest.  My macro-foo is not great, all criticism
>>> and suggestions very much appreciated.  The design is based on test
>>> modules lib/test_printf.c, lib/test_bitmap.c, lib/test_xarray.c.
>>
>> Hi Shuah,
>>
>> The bulk of this series is in the kselftests. Would you be willing to
>> carry this series?
>>
>> I think it might be able to use a v4 just to clean up the
>> script-finding logic, but I might be entirely missing something about
>> the best way to do it.
> 
> v4 to come once I grok the bash stuff you suggested in 'PATCH v3.1'.
> 

Yes I can take care of these. Will wait for v4

thanks,
-- Shuah

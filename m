Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9362EC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BD1214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554732541;
	bh=Dk0wePsmzGllGLI1Tfcx9rPsXy1gIkozkBirqlGseWI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=owUzzK4cYmnzqo6yHs1WgwZ1S+OOr8RmVriUS2FR4BQyUlfZdKlC3vbTN7eLSqLIj
	 KwsfdPDWWPZ5oX2sbrJPWcqs5k+OSmzmWaFpZDEr5xZPTjHFmGobN5cpPWRt4cqGUK
	 747iV+Kc6S4tmfZNPyYtj0su5JOBWDrzWvLPrQeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfDHOJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:09:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfDHOI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:08:59 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07A7D20883;
        Mon,  8 Apr 2019 14:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554732538;
        bh=Dk0wePsmzGllGLI1Tfcx9rPsXy1gIkozkBirqlGseWI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Tv32B8r2m+6I5xTkRHUX3FvYOtI0iAgHan3EAuI0NjqImBbNIl1HuxL1+RpM52zQI
         fK+sSEziXWpnLWa6DdnVGzkoNMS+zJFLg5rxj0r4VhrANl5AWsCjNg2BKXBzaqA4Oi
         OVVNfig/rbcrhgHzIeAVqsakJIldJFpa3dSb5gH8=
Subject: Re: [PATCH v4 0/6] lib/string: Add strscpy_pad() function
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
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
        kernel-hardening@lists.openwall.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190405015859.32755-1-tobin@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <3d1bc44f-313b-5a58-3492-b706d9510d34@kernel.org>
Date:   Mon, 8 Apr 2019 08:08:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405015859.32755-1-tobin@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/19 7:58 PM, Tobin C. Harding wrote:
> Hi Shua,
> 
> Here is the set with cleanup as suggested by Kees on v3.
> 
> Configured, built, and tested all modules loaded by
> tools/testing/selftests/lib/*.sh
> 
>>From previous cover letters ...
> 
> While doing the testing for strscpy_pad() it was noticed that there is
> duplication in how test modules are being fed to kselftest and also in
> the test modules themselves.
> 
> This set makes an attempt at adding a framework to kselftest for writing
> kernel test modules.  It also adds a script for use in creating script
> test runners for kselftest.  My macro-foo is not great, all criticism
> and suggestions very much appreciated.  The design is based on test
> modules lib/test_printf.c, lib/test_bitmap.c, lib/test_xarray.c.
> 
> Changes since last version:
> 
>   - Remove dependency on Bash (thanks Kees)
>   - Use oneliner to implement kselftest test runners (thanks Kees)
>   - Squash patch that adds kselftest script creator script with patch
>     that uses it.
>   - Fix typos (thanks Randy)
>   - Add Kees' Acked-by tags to all patches
> 
> thanks,
> Tobin.
> 
> 

Hi Tobin,

Thanks for this restructuring work and adding the framework. Thanks Kees
for the reviews.

The patch is series in now in linux-kselftest next for 5.2

thanks,
-- Shuah

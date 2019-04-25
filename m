Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88717C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0886D20684
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556211970;
	bh=oHb2oF583EyukPTDTrKCm/nGCt/ywD3s7w9ZGDYNauY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=yvr3hoKswX1Ojfbad8rc5RjlPBubYfn2fV9b3An9I/4sENijE2fGJaZhdJ0PBYfyg
	 Zb8BbSRAvsjBkwI/Fvv2TXUAaxj1jDojbmG7Ptu5SMbrBs8v7wi/mRccgeZtUZXxx7
	 IeqKrq1zWjh90NSco/afzKMX3PYrCJwIIRLjZQ+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfDYRGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:06:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfDYRGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:06:07 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EC5B206BF;
        Thu, 25 Apr 2019 17:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556211967;
        bh=oHb2oF583EyukPTDTrKCm/nGCt/ywD3s7w9ZGDYNauY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=V9G8hNc//EBYFKZcNrvXAA2HO2ZxlQJGba4/Gt7Yml163eW8NFX+oz25Gc8rT6BbI
         fEZbD1YobDxpblXwPeiv3UH2tBUtBk+4P9ME1Jic+1XD7yInk6HRBqn4555vBiNoJ1
         KId691gJ5poi7tL6vmJVOMa99UmVwXw/jKmG1Ogw=
Subject: Re: [PATCH v2 7/8] selftests: Remove KSFT_TAP_LEVEL
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        Serge Hallyn <serge@hallyn.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, shuah <shuah@kernel.org>
References: <20190424231237.14776-1-keescook@chromium.org>
 <20190424231237.14776-8-keescook@chromium.org>
 <1ca5ee52-ab07-9142-2e45-44df1e94276e@kernel.org>
 <CAGXu5j+F1iSu5GDG_FCykABXkH_gXcF=zjwwyev1vTDCXRLoVg@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <1134c85b-ec66-33e6-f0a9-6c9f575bdad0@kernel.org>
Date:   Thu, 25 Apr 2019 11:06:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+F1iSu5GDG_FCykABXkH_gXcF=zjwwyev1vTDCXRLoVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/19 10:56 AM, Kees Cook wrote:
> On Thu, Apr 25, 2019 at 9:36 AM shuah <shuah@kernel.org> wrote:
>>
>> On 4/24/19 5:12 PM, Kees Cook wrote:
>>> Since sub-testing can now be detected by indentation level, this removes
>>> KSFT_TAP_LEVEL so that subtests report their TAP header for later parsing.
>>
>> Does this take into ksft_print_header() getenv logic to avoid printing
>> TAP headers from tests when they fork? e.g timers tests do that a lot.
> 
> I didn't change the ksft_print_header() code, in case you want it back
> in the future. But nothing sets that variable any more in my series:
> 

Right. I want to see the impact of not setting this. I added this for
two reasons, one is to prevent nesting which goes away with your
refactor. I know there is another reason which I can't recall.


> $ git grep KSFT_TAP_LEVEL
> tools/testing/selftests/kselftest.h:    if (!(getenv("KSFT_TAP_LEVEL")))
> 
> I don't see the timers tests using print_header() at all, actually...
> 
> $ cd tools/testing/kselftest/timers
> $ git grep print_header | wc -l
> 0
> 

I don't see it in there either. I must be thinking about another test.

btw I like the changes. I just want to make sure it gets some road
testing first. :)

thanks,
-- Shuah




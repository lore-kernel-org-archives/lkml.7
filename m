Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10487C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129942077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556224782;
	bh=/28ppytH3HP+D/aqKJqUpHxLpqH0aIkrA1BELlrObfw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=WBUr4aHuLl20X9k3vp3+Af+AGUJwlxVL1V0l+CzZyM5N3/uDCgTQ90KCIcKD1xVmt
	 OZIwKs0NhTP6aeCM8SDcpr9Jo4vieUCcUK1Vsl2y3suebmDnfJUrUfKyd0Sb1IBh0n
	 bbhRZO976I6+EEjDRRqtcMCKus2I3VdiUTPxT0T4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387872AbfDYUjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:39:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387630AbfDYUjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:39:40 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAA1E20717;
        Thu, 25 Apr 2019 20:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556224779;
        bh=/28ppytH3HP+D/aqKJqUpHxLpqH0aIkrA1BELlrObfw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YWjuyCgtlmQHRBC0Mb2C03tvRm1SQJ6mkzi1VStf7up2hEVJefmSO1xOTcfgtp7L2
         v4Jh/zeSh1bAn3+bBodT3cQ22g9t+oM865AofFM/tRvdQA7wz2IOGvHbjYLAgs9ub0
         LZ9cV4bgt9TDdegQgm4hbnrGo3Lp+8B9phVhgzbg=
Subject: Re: [PATCH v2 0/8] selftests: Move test output to diagnostic lines
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
 <a3ca267e-8e1e-65da-77c8-c7010a39354b@kernel.org>
 <CAGXu5jJChvx-_E8RMTi3ioUZGuQGViy6gcAMpmvYZzms=zc6dQ@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <1afe0a17-c539-6ef2-ecff-f4ade4a865e7@kernel.org>
Date:   Thu, 25 Apr 2019 14:39:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJChvx-_E8RMTi3ioUZGuQGViy6gcAMpmvYZzms=zc6dQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/19 11:05 AM, Kees Cook wrote:
> On Thu, Apr 25, 2019 at 9:52 AM shuah <shuah@kernel.org> wrote:
>>
>> On 4/24/19 5:12 PM,  wrote:
>>> This refactors the selftest Makefiles to extract the test running logic
>>> to be reused between "run_tests" and "emit_tests", while also fixing
>>> up the test output to be TAP version 13 compliant:
>>> - added "plan" line
>>> - fixed result line syntax
>>> - moved all test output to be "# "-prefixed as TAP "diagnostic" lines
>>>
>>> The prefixing code includes a fallback mode for limited execution
>>> environments.
>>>
>>> Additionally, the plan lines are fixed for all callers of kselftest.h.
>>>
>>> -Kees
>>>
>>
>> Kees,
>>
>> Just about to apply these to a topic branch to do testing and ran into
>> checkpatch errors:
>>
>>
>> WARNING: line over 80 characters - a few
> 
> I only saw one, which is on a string which kernel coding style says to
> leave unsplit:
> 
> WARNING: line over 80 characters
> #55: FILE: tools/testing/selftests/kselftest/runner.sh:19:
> +               echo "$TEST_HDR_MSG: Warning: file $TEST is not
> executable, correct this."
> 
>> WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead
>> #141: FILE: tools/testing/selftests/kselftest/runner.sh:2:
> 
> WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead
> #37: FILE: tools/testing/selftests/kselftest/runner.sh:2:
>   # SPDX-License-Identifier: GPL-2.0
> 
> This is a shell script. It can't be on line 1:
> 
> $ head -n3 tools/testing/selftests/kselftest/runner.sh
> #!/bin/sh
> # SPDX-License-Identifier: GPL-2.0
> #
> 
> That looks like a bug in checkpatch not resetting the expected line or
> something.
> 
>> Can fix them and resend - SPDX one is my main concern.
> 
> These appear to be false positives; I don't think I need to fix them?
> Let me know what you think.
> 
>> The plan is to apply these to linux-kselftest ksft-tap-refactor topic
>> first. I don't want to rush these until we do some testing.
> 
> Absolutely. :)
> 
> Thanks!
> 

Kees,

Pushed all 8 patches to 
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
ksft-tap-refactor topic branch

I will have time to test tomorrow.

thanks,
-- Shuah



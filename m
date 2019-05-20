Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A6BC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD569214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558373236;
	bh=klOK/EtVgyp3Xf/41izntoB7oQuyIDNJE07ElPF4vAQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=XyE+664vQgnJUY54x7s6Woq054Za7TTWDdMtjTNgoqC5LMMf+Qdx3OfuKNaHE8Ies
	 jwMoodOUTA7BmZn40sj/fpA54l+SrgnwZ8CnphkdbSzjFbLMFmephLpIVfRtMgrqhU
	 +luY+7ysbX2QejPzTM0XaYHRQXdNKCp9kaIj++Ug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390880AbfETR1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:27:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfETR1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:27:15 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E61E208C3;
        Mon, 20 May 2019 17:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558373233;
        bh=klOK/EtVgyp3Xf/41izntoB7oQuyIDNJE07ElPF4vAQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Bw64yPx068n9jAhonyNopcFQcxxwvZfIsx9S2YqoXQswQ39SlGM+TwT5dwEQlE74r
         GZqew+vrCDTGQ5EtnGmbd0Vu+dVRuM3nNLl8jZMOlAGfOhLLIJL1J/lzbAcZNZDK+c
         JAj/hzxxBW6nR780Iaov27IqLORXfu277UV5q1/s=
Subject: Re: [PATCH 0/5] firmware: Add support for loading compressed files
To:     Takashi Iwai <tiwai@suse.de>, Kees Cook <keescook@chromium.org>,
        shuah <shuah@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20190520092647.8622-1-tiwai@suse.de>
 <20190520093929.GB15326@kroah.com> <s5hwoil5gwm.wl-tiwai@suse.de>
 <s5h7ealb1d3.wl-tiwai@suse.de> <s5ho93xqenb.wl-tiwai@suse.de>
From:   shuah <shuah@kernel.org>
Message-ID: <5a3a0649-ece0-c3e3-3ebb-9d8d19d9499f@kernel.org>
Date:   Mon, 20 May 2019 11:26:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <s5ho93xqenb.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/19 10:22 AM, Takashi Iwai wrote:
> On Mon, 20 May 2019 17:18:48 +0200,
> Takashi Iwai wrote:
>>
>> On Mon, 20 May 2019 16:39:37 +0200,
>> Takashi Iwai wrote:
>>>
>>> On Mon, 20 May 2019 11:39:29 +0200,
>>> Greg Kroah-Hartman wrote:
>>>>
>>>> On Mon, May 20, 2019 at 11:26:42AM +0200, Takashi Iwai wrote:
>>>>> Hi,
>>>>>
>>>>> this is a patch set to add the support for loading compressed firmware
>>>>> files.
>>>>>
>>>>> The primary motivation is to reduce the storage size; e.g. currently
>>>>> the amount of /lib/firmware on my machine counts up to 419MB, and this
>>>>> can be reduced to 130MB file compression.  No bad deal.
>>>>>
>>>>> The feature adds only fallback to the compressed file, so it should
>>>>> work as it was as long as the normal firmware file is present.  The
>>>>> f/w loader decompresses the content, so that there is no change needed
>>>>> in the caller side.
>>>>>
>>>>> Currently only XZ format is supported.  A caveat is that the kernel XZ
>>>>> helper code supports only CRC32 (or none) integrity check type, so
>>>>> you'll have to compress the files via xz -C crc32 option.
>>>>>
>>>>> The patch set begins with a few other improvements and refactoring,
>>>>> followed by the compression support.
>>>>>
>>>>> In addition to this, dracut needs a small fix to deal with the *.xz
>>>>> files.
>>>>>
>>>>> Also, the latest patchset is found in topic/fw-decompress branch of my
>>>>> sound.git tree:
>>>>>    git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>>>>
>>>> After a quick review, these all look good to me, nice job.
>>>>
>>>> One recommendation, can we add support for testing this to the
>>>> tools/testing/selftests/firmware/ tests?  And you did run those
>>>> regression tests to verify that you didn't get any of the config options
>>>> messed up, right? :)
>>>
>>> Now I've been testing the firmware selftest, and this turned out to be
>>> surprisingly difficult on my system.  By some reason, the test always
>>> fails at the point triggering the request (line 58 of
>>> fw_filesystem.sh):
>>>
>>>    if ! echo -n "$NAME" >"$DIR"/trigger_request ; then
>>> 	....
>>>
>>> Judging from the strace output, this echo writes only the first byte
>>> of $NAME.  Then kernfs write op is invoked and it deals this one byte
>>> input as if a whole argument were passed, leading to an error.
>>>
>>> My temporary workaround was to replace the all "echo" call with
>>> "/usr/bin/echo".
>>>
>>> Then it hits a similar write error at the places like:
>>>
>>> 	echo 1 > $DIR/config_sync_direct
>>>
>>> This could be worked around by adding -n option to echo.
>>>
>>> Finally, I noticed that the user-fallback doesn't work on my system
>>> any longer and the test stopped.  This is expected, so it implies that
>>> all direct loading tests passed.
>>>
>>> FWIW, my system is openSUSE Leap 15.1.  Does anyone experience a
>>> similar problem?
>>
>> This seems to be a regression on 5.2-rc1.
>> The tests on 4.20 worked fine.  5.1 worked, but gave the error at
>> fallback test instead of skipping.  This is likely another regression,
>> but irrelevant with the major issue as above.
>>
>> Now bisecting...
> 
> Still in bisection, but it's timeout, I'll have to leave now...
> 
> FWIW, the regression seems to have been introduced around the latest
> kselftest merge.
> The commit 4c7b63a32d54 is bad, and the commit 9cbda1bddb4c good.
> 
> Shuah, could you check it?
> 
> 

Kees,

Could this be related to your selftest Makefile test run output
refactoring work?

I did a quick test on 5.2 after my first kselftest update without
the refactor work - firmware test worked.

I am thinking this is related to

eff3ee303d0d
selftests: Extract single-test shell logic from lib.mk

bash vs. sh difference in "echo" command behavior is the cause
is my best guess. Will you be able to take a look at this?

sudo make -C tools/testing/selftests/firmware/ run_tests

will show the difference.

thanks,
-- Shuah

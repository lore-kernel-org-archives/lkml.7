Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAEAC43140
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 02:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC39B2173E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 02:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567823617;
	bh=BwjNmug7VeOX+mmJrtk2ttRDMPf6uUoGERmIXwKE2hI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=sXlMhkwuyyOPu1in8PLDXdjSTP6thMqmLfJeZRDw6yoGtaYajLoT4N7Lb3Z/DVn4i
	 lhgo3moYsyVTGwVsUtrqOj7mppcCXzMoHBlzOlkFhLlXY95jIa/8PFEm5fLn26rvBQ
	 nWPj5k0we/Mibjj6kSH4q8MRzcpaumWCiPcdqHpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393789AbfIGCdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 22:33:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbfIGCdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 22:33:35 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9886020854;
        Sat,  7 Sep 2019 02:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567823615;
        bh=BwjNmug7VeOX+mmJrtk2ttRDMPf6uUoGERmIXwKE2hI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bEDreOAlktrm6KaQ3jHTr3cLhHR6sdnvq6DGfurJdIcNNcdKYlIlfsNrpeLzmzSM5
         /MKKVaMraiBq/1KZt/QHC+HRrcJybobfGugCdSx/zAJbq45JWrIxrah455BUd8rik9
         GbAh4hPQ8AyU9tXic1d5T3KTruMk/z3tr7QgkHB4=
Subject: Re: [PATCH] kunit: Fix '--build_dir' option
To:     Brendan Higgins <brendanhiggins@google.com>,
        SeongJae Park <sj38.park@gmail.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        shuah <shuah@kernel.org>
References: <CAEjAshr=JqVpF651eSZYFhwVAMNZ29LWcfrH07K_M9GU=hPnvg@mail.gmail.com>
 <1567786314-12330-1-git-send-email-sj38.park@gmail.com>
 <CAFd5g44=8TV4VciMkcD2DHR+UsnpwyEFbw2Xucwo7-as6Py_4g@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <1bc1c5da-2810-60d3-4e76-8d0b73fdd521@kernel.org>
Date:   Fri, 6 Sep 2019 20:33:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g44=8TV4VciMkcD2DHR+UsnpwyEFbw2Xucwo7-as6Py_4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/19 7:16 PM, Brendan Higgins wrote:
> On Fri, Sep 6, 2019 at 9:12 AM SeongJae Park <sj38.park@gmail.com> wrote:
>>
>> Running kunit with '--build_dir' option gives following error message:
>>
>> ```
>> $ ./tools/testing/kunit/kunit.py run --build_dir ../linux.out.kunit/
>> [00:57:24] Building KUnit Kernel ...
>> [00:57:29] Starting KUnit Kernel ...
>> Traceback (most recent call last):
>>    File "./tools/testing/kunit/kunit.py", line 136, in <module>
>>      main(sys.argv[1:])
>>    File "./tools/testing/kunit/kunit.py", line 129, in main
>>      result = run_tests(linux, request)
>>    File "./tools/testing/kunit/kunit.py", line 68, in run_tests
>>      test_result = kunit_parser.parse_run_tests(kunit_output)
>>    File "/home/sjpark/linux/tools/testing/kunit/kunit_parser.py", line
>> 283, in parse_run_tests
>>      test_result =
>> parse_test_result(list(isolate_kunit_output(kernel_output)))
>>    File "/home/sjpark/linux/tools/testing/kunit/kunit_parser.py", line
>> 54, in isolate_kunit_output
>>      for line in kernel_output:
>>    File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line
>> 145, in run_kernel
>>      process = self._ops.linux_bin(args, timeout, build_dir)
>>    File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line
>> 69, in linux_bin
>>      stderr=subprocess.PIPE)
>>    File "/usr/lib/python3.5/subprocess.py", line 947, in __init__
>>      restore_signals, start_new_session)
>>    File "/usr/lib/python3.5/subprocess.py", line 1551, in _execute_child
>>      raise child_exception_type(errno_num, err_msg)
>> FileNotFoundError: [Errno 2] No such file or directory: './linux'
>> ```
>>
>> This error occurs because the '--build_dir' option value is not passed
>> to the 'run_kernel()' function.  Consequently, the function assumes
>> the kernel image that built for the tests, which is under the
>> '--build_dir' directory, is in kernel source directory and finally raises
>> the 'FileNotFoundError'.
>>
>> This commit fixes the problem by properly passing the '--build_dir'
>> option value to the 'run_kernel()'.
>>
>> Signed-off-by: SeongJae Park <sj38.park@gmail.com>
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Tested-by: Brendan Higgins <brendanhiggins@google.com>
> 
> Thanks!
> 

Thanks Brendan! I will apply the patch for 5.4-rc1.

SeongJae Park! In the future, please send tag versions. This should
have been [PATCH v2].

thanks,
-- Shuah

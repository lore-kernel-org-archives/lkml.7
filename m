Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147C0FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D275621835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571242136;
	bh=9HUO2lax7sfD2EWpxENWqLGsW4KjQ1zm0YRnYrvnQpM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Z7Jettqf1l4zLQaj1WiW5CzXcRSWO5PbDev9D9A65HOiYl0h7O0QPr1NSyoPmq+nK
	 Fy3vJvfSdfP+hzWokG2K9JK6YVrqo3ToHcKZYl7ykwG40Gj+FJ0bRbRpjyebCwF2vd
	 TFJhl58DAC2pJSFVoa8EcwUyj/i3TqG/dDDTQXT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393290AbfJPQIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:08:54 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40596 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391855AbfJPQIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:08:54 -0400
Received: by mail-io1-f65.google.com with SMTP id h144so54456998iof.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 09:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7o+rx92W0ToJU9u88b9aB62ABBJy9XXuVj3/E7onAsY=;
        b=HQuQvH6Wq07whdBGB9eF+PH3glxNhY/Id8J4vqQEnmrH8VJD06f4l44evP5quRS1sH
         MDcbIj+gaNLoZx73b2yz7mBv4ELOmfsAOam5HfS/b4Cuw8L1HnrA6kMq2hDdg7RMo+nC
         2SXY1oq45j6bqDt2T6S13dlLS2jM8C2vUmfVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7o+rx92W0ToJU9u88b9aB62ABBJy9XXuVj3/E7onAsY=;
        b=LEXuZ1XfKZdQodoWvnKVTE7fRiaqCOl9Orey+LaEnfCDzz3UCJpMsQrLbXk/5btY5Z
         qlQs+rf40fQ3pAGarOendWlBYFhZP2dkIWjO9pWOTw9fpW/4Oxy28ueuEFt1R1gAGyAo
         IbAjr3WfIgGr4A9judsyprNTDPfsS3wwNqvI0/t47u4eV1QU/S1qGheQqJjkw3niTru0
         OcN55N3OzRV0xNAnzNgJEf7TF3qy8CqC5Nczrs12+D8gF6C9fRJD0K0Rvae6QZlG4sl6
         dFYE9nb16lkiYkqAWne4dDwGyYZJHL2nd6XjaD8RtDXLq93oo/iSat4YFkW3dCSsSsX0
         PvxA==
X-Gm-Message-State: APjAAAWbV2zii0q/abCWSh1EAq/3HfiMZn9UA7IUKEu8JOHIxaJArgfX
        0tgMc4X+X5eTj/pCqxFBOITtRA==
X-Google-Smtp-Source: APXvYqwduWfC0eVNL88B7feWJXQ3795I/xaTG6v7wRzqgSzx2YiABSO9j7oIy30NHFSRFjAa20IcVg==
X-Received: by 2002:a5e:8d0f:: with SMTP id m15mr2825492ioj.47.1571242132786;
        Wed, 16 Oct 2019 09:08:52 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w68sm5204769ili.59.2019.10.16.09.08.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 09:08:52 -0700 (PDT)
Subject: Re: [PATCH v2] selftests: Add kselftest-all and kselftest-install
 targets
To:     Michael Ellerman <mpe@ellerman.id.au>,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        shuah@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20190926224014.28910-1-skhan@linuxfoundation.org>
 <87sgnttpoq.fsf@mpe.ellerman.id.au>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <adcfcda4-c36e-c222-4964-f83b5f3d0097@linuxfoundation.org>
Date:   Wed, 16 Oct 2019 10:08:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87sgnttpoq.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/19 8:00 PM, Michael Ellerman wrote:
> Hi Shuah,
> 
> I know this has been merged already, so this is just FYI and in case it
> helps anyone else who's tracking down build failures.
> 

Thanks for letting me know. I have been sending updates about
breakages. Will send an update with this info.

> Sorry I didn't reply before you merged it, I was on leave.
> 
> Shuah Khan <skhan@linuxfoundation.org> writes:
>> Add kselftest-all target to build tests from the top level
>> Makefile. This is to simplify kselftest use-cases for CI and
>> distributions where build and test systems are different.
>>
>> Current kselftest target builds and runs tests on a development
>> system which is a developer use-case.
>>
>> Add kselftest-install target to install tests from the top level
>> Makefile. This is to simplify kselftest use-cases for CI and
>> distributions where build and test systems are different.
>>
>> This change addresses requests from developers and testers to add
>> support for installing kselftest from the main Makefile.
>>
>> In addition, make the install directory the same when install is
>> run using "make kselftest-install" or by running kselftest_install.sh.
>> Also fix the INSTALL_PATH variable conflict between main Makefile and
>> selftests Makefile.
> ...
>> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
>> index c3feccb99ff5..bad18145ed1a 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -171,9 +171,12 @@ run_pstore_crash:
>>   # 1. output_dir=kernel_src
>>   # 2. a separate output directory is specified using O= KBUILD_OUTPUT
>>   # 3. a separate output directory is specified using KBUILD_OUTPUT
>> +# Avoid conflict with INSTALL_PATH set by the main Makefile
>>   #
>> -INSTALL_PATH ?= $(BUILD)/install
>> -INSTALL_PATH := $(abspath $(INSTALL_PATH))
>> +KSFT_INSTALL_PATH ?= $(BUILD)/kselftest_install
> 
> This change broke all my CI, because the tests no longer install in the
> place it's expecting them :/
> 

Sorry about that.

> I can fix it by explicitly specifying the install path in my CI scripts.
> 
>> +KSFT_INSTALL_PATH := $(abspath $(KSFT_INSTALL_PATH))
>> +# Avoid changing the rest of the logic here and lib.mk.
>> +INSTALL_PATH := $(KSFT_INSTALL_PATH)
>


I searched all the selftests Makefiles for it and convinced myself that,
the above would take care of it for these cases. I searched powerpc
Makefiles so this doesn't break it. Didn't think about the CI.

android/Makefile:	mkdir -p $(INSTALL_PATH)
android/Makefile:	install -t $(INSTALL_PATH) $(TEST_PROGS) 
$(TEST_PROGS_EXTENDED) $(TEST_FILES)
android/Makefile:		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$SUBDIR 
INSTALL_PATH=$(INSTALL_PATH)/$$SUBDIR install; \
futex/Makefile:	mkdir -p $(INSTALL_PATH)
futex/Makefile:	install -t $(INSTALL_PATH) $(TEST_PROGS) 
$(TEST_PROGS_EXTENDED) $(TEST_FILES)
futex/Makefile:		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$SUBDIR 
INSTALL_PATH=$(INSTALL_PATH)/$$SUBDIR install; \
sparc64/Makefile:	mkdir -p $(INSTALL_PATH)
sparc64/Makefile:	install -t $(INSTALL_PATH) $(TEST_PROGS) 
$(TEST_PROGS_EXTENDED) $(TEST_FILES)
sparc64/Makefile:		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$SUBDIR 
INSTALL_PATH=$(INSTALL_PATH)/$$SUBDIR install; \


> But because the over-rideable variable changed from INSTALL_PATH to
> KSFT_INSTALL_PATH I will need to export both of them in order for my CI
> to work with old and new kernels.

My mistake. I overlooked that this could be overridden and could
be in used in CI scripts.

> 
> So to emulate the old behaviour for old & new kernels you need to do:
> 
> # export KSFT_INSTALL_PATH=install
> # export INSTALL_PATH=install

Can we avoid exporting both if we updated INSTALL_PATH with 
KSFT_INSTALL_PATH in all the Makefiles instead of my shortcut?
Would that make it easier for you?

> # make -C tools/testing/selftests install
> 
> 

I am looking to simplify the use-case and ran into the INSTALL_PATH
variable conflict between main Makefile and selftests Makefile.

I think this should have been KSFT_INSTALL_PATH to begin with.

thanks,
-- Shuah


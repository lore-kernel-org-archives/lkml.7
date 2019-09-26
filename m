Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD1CC352A9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE2120640
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569535900;
	bh=0fHa0oO26e5qJeyB6MqjpwhDutjr9dv8tT+wwm5sUtU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=IyHMD/pOLrxUv0jqTBxjH+LP3P6U6HXQTBbfD2tyXjy+GfmlCZJaOOoru1o7/9WbN
	 H3OflFOd5qjp9AmO4tFano+lZg4amLro6w2bHSnUWkXKUHWrELUZWaZ/jATPxobvS0
	 ba6iGz8NTQFEskopMBCKCx8JQmgF9N4QgmCE/Wkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbfIZWLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 18:11:40 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35344 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfIZWLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 18:11:39 -0400
Received: by mail-io1-f67.google.com with SMTP id q10so10810315iop.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 15:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e5GWt3lztsgnfc3sldD8RB9/EhbtgxcMAZ8pv6IBv0o=;
        b=DNPR0aGdrz0Z8MxoYfs7keH6LEZ15NGlhg7uvwGt/utwm1UUTEfsyN4gUyHMfg37WS
         NFX+lvIQClaCK9QlECR98ZRoQp9yYwjccp/1ZmtZFBlQhRUY0eEkOBXYudCmgsjE3CMT
         UPWq9nbhTGUrx7AcnsfCUxCnNo8ucyLXg6Ivo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e5GWt3lztsgnfc3sldD8RB9/EhbtgxcMAZ8pv6IBv0o=;
        b=gcFrvmowoPQEy66m9w29oAshknjmqZyRe9AovqM9JFjDrNE7sH6Nx3ih+/Zcj178oQ
         RimaEVuuQgS+RwA7d+SJsF2NrCX+hgJGtAUnWoqyHrpkS5voHjTDDqR3DsPYSlRqyIUg
         jjezHxEezyWBQRM7in0juxF/E3t6hAajNKofKr8OHcPBv6XZNbHUFII5YeRQIYo7enPV
         z19dGAgRqfTbrj+OQzQUdgz/Blh0X94wRBgq6wmf+mSW8LLpcNus8MoSNv07GQr5vq1W
         uXqHQXf5Sq/3PeSZU6Qz1p1t1gGJy33JJV/bU/vJq2gBOVCak3HwdWHzZOskYiQZat5u
         23Bw==
X-Gm-Message-State: APjAAAWFLnNzvjYrQZTg/EUsT73mmas2vt5Z1F0RHywSiQcfNwOzP3nY
        Y0VyujtEQgNfX4UHUtABjDpk6jAJcXY=
X-Google-Smtp-Source: APXvYqzEIS99foCZIJEt/mjEPQI28ZkWb2KVeBSzeuCd5zi5J2t81jLUt+IwTIWsCPnNn1bbmfgnQg==
X-Received: by 2002:a92:c00d:: with SMTP id q13mr1102096ild.169.1569535898607;
        Thu, 26 Sep 2019 15:11:38 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a17sm320403ilf.22.2019.09.26.15.11.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 15:11:37 -0700 (PDT)
Subject: Re: [PATCH 2/2] selftests: Add kselftest_install target to main
 Makefile
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        "Cc: Shuah Khan" <shuah@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <cover.1569452305.git.skhan@linuxfoundation.org>
 <b3c50f4c726df521039f57295b53349227f629d9.1569452305.git.skhan@linuxfoundation.org>
 <CAK7LNATCFF9ERTwtPnnbMLGv++NJ_5zXxB0=NWHdSGrYADj3ug@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <43a7962e-4fae-78e4-1db2-b75c7ff802b1@linuxfoundation.org>
Date:   Thu, 26 Sep 2019 16:11:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNATCFF9ERTwtPnnbMLGv++NJ_5zXxB0=NWHdSGrYADj3ug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/19 9:24 PM, Masahiro Yamada wrote:
> Hi Shuah,
> 
> 
> 
> On Thu, Sep 26, 2019 at 8:05 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> Add kselftest_install target to install tests from the top level
>> Makefile. This is to simplify kselftest use-cases for CI and
>> distributions where build and test systems are different.
>>
>> This change addresses requests from developers and testers to add
>> support for installing kselftest from the main Makefile.
>>
>> In addition, make the install directory the same when install is
>> run using "make kselftest_install" or by running kselftest_install.sh.
>> Also fix the INSTALL_PATH variable conflict between main Makefile.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> So, if these two patches were applied, we would see the following:
> 
> 
> PHONY += kselftest_build
> kselftest_build:
>          $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests all
> 
> PHONY += kselftest
> kselftest:
>          $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
> 
> PHONY += kselftest_install
> kselftest_install:
>          $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests install
> 
> PHONY += kselftest-clean
> kselftest-clean:
>          $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests clean
> 
> 
> I do not want to see this endless crap addition just for
> changing the working directory to $(srctree)/tools/testing/selftests
> 
> 
> 
> Why don't you use pattern rule?
> Those will be reduced into the two rules.
> 

I just didn't think about simplifying it. Thanks for
being direct.

> 
> 
> PHONY += kselftest
> kselftest:
>          $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
> 
> kselftest-%: FORCE
>          $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*
> 
> 
> 
> This also avoids your inconsistency about
> "kselftest-" vs "kselftest_".
> 
> 
> Given the existing "kselftest-clean" and "kselftest-merge",
> "kselftest_build" and "kselftest_install"
> (using an underscore instead of n hyphen)
> would add needless confusion.
> 
> 

Done. Sending v2 with two patches collapsed into one.

thanks,
-- Shuah

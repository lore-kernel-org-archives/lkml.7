Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B042DC4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81493205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569270567;
	bh=6ogr/48fjYcay9vMCfPPLvP9aTyRWy3rsP7FX3pRdWA=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=B75uFoAfJQBNLdqAjWTAKmFlfOTO2xR8mIAVsr6mPP11J77Nus9c2bf2Mxm3biUeo
	 yN0nX0/rF0z97NqoKup7Pk3F5T4SMDI2v9dEOrQ5PbygYUavj6RkIVBUgUTx0rLx+2
	 7k08KXA3L0SSw7mrYJ1rG9/Kd+kbxdh3M26h2liI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502617AbfIWU30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 16:29:26 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34047 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfIWU30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 16:29:26 -0400
Received: by mail-io1-f66.google.com with SMTP id q1so36855835ion.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 13:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dvIwrEHo3XVBscwBga+E/4rR8hn4WyaWuLrNeRVb0wE=;
        b=ZMhIhfVMdxnCLLyLQB2v98nxgcjinY/NResoC9iqgWUfooRpQW1nbUwHE96zxsePXH
         l3rEKQZYUXzCxanIwE5tuN6puoumVuYVgbNgS5Tt8rwfRXP9ajRVZaQF/i25XPt0hWR2
         v/MRC5BAxTXMV0oxftl3S9t1AySFhNcZL0XZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dvIwrEHo3XVBscwBga+E/4rR8hn4WyaWuLrNeRVb0wE=;
        b=kOU917r9ZA9cFromykthCDCqx1lfnZrsoBgPmYWazP3qxd1cCoq1RwpYXYsxv8/bOY
         xjqZ9yJpXk1AI4o6K/DwEt0A24uKFMZOExzRVbQg/9SfdDYhac0vADCTvKreSnd5jVIG
         3sXHNTwOiABKbMy/a1R/nyEwErDHoXV8DiF3WWOKMPaFb30GSojN2eAP+KqwX+KYcO28
         Zkxw2kX70yIgwvnGPVTym2tUiN7hFmg+wf4dq0WdpIfRTYPJfvPDDFbB73S0IfAKdEB5
         va2LaCJdMnAiEJKvT6N5fY3ogTigZ7dzYiEKptXo74fsJiJpayTv7hrFlj78TBG/VzU3
         yQiw==
X-Gm-Message-State: APjAAAW2ybTw3K7JU4Ru/AMbfMuxWPjBUAMKP3yXLCIL71fvH3Gpsqdx
        H0vypgFYTcX0KA1HLME08Lk3nQ==
X-Google-Smtp-Source: APXvYqzTEkrazddggyqMZ8imGJAbPuGKQKs/RDmi0jIUwnS+DiX8lI9KQi3LPALztbXhBjtOOR5s9w==
X-Received: by 2002:a6b:6514:: with SMTP id z20mr1401383iob.50.1569270565407;
        Mon, 23 Sep 2019 13:29:25 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z10sm2267650iog.41.2019.09.23.13.29.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 13:29:24 -0700 (PDT)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc1
To:     Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <be8059f4-8e8f-cd18-0978-a9c861f6396b@linuxfoundation.org>
 <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
 <CAKRRn-edxk9Du70A27V=d3Na73fh=fVvGEVsQRGROrQm05YRrA@mail.gmail.com>
 <CAFd5g45ROPm-1SD5cD772gqESaP3D8RbBhSiJXZzbaA+2hFdHA@mail.gmail.com>
 <CAHk-=wgMuNLBhJR_nFHrpViHbz2ErQ-fJV6B9o0+wym+Wk+r0w@mail.gmail.com>
 <20190922112555.GB122003@gmail.com> <20190922115247.GA2679387@kroah.com>
 <0ab5da69-e4f2-8990-20f9-354461235581@linuxfoundation.org>
 <20190923194322.GA55255@gmail.com>
 <32d0e94d-bf9a-01e9-2548-1fc976c7f17b@infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f4c21702-f7b5-e6f9-b31d-8fc9e4d1c67d@linuxfoundation.org>
Date:   Mon, 23 Sep 2019 14:29:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <32d0e94d-bf9a-01e9-2548-1fc976c7f17b@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/19 1:52 PM, Randy Dunlap wrote:
> On 9/23/19 12:43 PM, Ingo Molnar wrote:
>>
>> * Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>>> I am exploring the possibility to move selftests to a better location
>>> or add a git alias so it can be found easily. With the addition of
>>> KUnit and future work that is planned to connect kselftest and KUnit,
>>> it would make sense have selftests to be in a location that is better
>>> suited than where it currently resides.
>>>
>>> I have been getting feedback from some developers that they would like
>>> to see selftests more visible and easier to find.
>>>
>>> There are some dependencies (unintended, shouldn't exist) between some
>>> tests and content under tools that might pose some logistical problems,
>>> in addition to the churn of backporting.
>>>
>>> I haven't explored "git alias" yet though. Since this topic of moving
>>> came up, I would liek to get feedback on selftests location in general
>>> and where would be a good place for it.
>>
>> I'm not sure about the Git alias thing - but I do agree that
>> tools/testing/selftests is a pretty obscure location given the importance
>> of kernel unit tests - and I think it could be moved one level higher, to
>> tools/selftests? The "selftest" name already implies the "test" aspect
>> after all.
> 
Right. Obscure location given the importance is the problem.

> 
> Without trying to use too much paint, I would move testing/ to a top-level
> dir, outside of tools/, and leave selftest/ under testing/.
> 

Right. What you suggesting is very similar to and more complete than
what I have been thinking about and proposed at the KS kselftest track.


i.e move tools/testing/selftests to kselftest at the root level. I like
your idea of moving tools/testing up to root and keep selftests under
it.

If we are good with this kind of change, I would like to get this done
sooner than later. There is some back-porting churn to worry about.

thanks,
-- Shuah

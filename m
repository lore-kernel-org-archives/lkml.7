Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D97EC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DE1214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L3fOvOhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390150AbfETQuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 12:50:10 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53458 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388598AbfETQuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 12:50:09 -0400
Received: by mail-it1-f194.google.com with SMTP id m141so115484ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 09:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CIN3xDslN+TH7id+BCtq6Zq78dD5JN+LMcvwIfXWjL4=;
        b=L3fOvOhTsO43dKwz0TIqNGbaGlmiIMVZC88HR45s5yDDy5j1aKnThdkZt8TkKCIPsK
         3nJf0MnYtRxx7ZUi5ycvvVNh90bJ/GXckVM7RvjVFjd6klG49ZrMqDe9jG8YAKKDgQOz
         gpGoYUHt5YMtyCplDIiEIUngA/gQ/t4+25l4NzzcxoFKOTEfduBkUIlz09s5oCPN7lqP
         jvQYZONWPm5OsTftRy9QjwoRAa+qjr/gkuwRyok9Lj+qBH1NzHHZAj/TjNtQsNSG42cE
         Qb1QZhfFLGbaZ3eM19FyaWFDQ+qsu3LmN3l6FwmsuMrnCHdiJIyQXhiNfMts1Y/6hiSN
         uvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CIN3xDslN+TH7id+BCtq6Zq78dD5JN+LMcvwIfXWjL4=;
        b=PjxSkdhABRvHQSg7aEOna4BDvrMtlqDZmADkx0fPbpwu23O7sL7eFQ7hRu9ppxdW6n
         Pxaw6PsyPnt1x5Io6SJPwajz+x94UtkTpcny68W/gzXtS8KPHviEDo9fF/KpNXJQLlHU
         MkTNI0uct7bBNFReY3cZF/8fOUivAEuTwXSam0dUXgtjivLBrnMar1nVgkzEB9jPtH5X
         WnroYGesFWTv/bpyz5SjvHy9l4QEseCweDJP85q5htc0b2OUVxt6/QLDkZEbYEMXAl0a
         +OCwOvwrND5fb28gAnYyusy07tdVYEPEeevUVZAhnF8QZBjMjoSBMnxCHEk3DWui/Hxo
         st2g==
X-Gm-Message-State: APjAAAVUbeBiHJAkCdtOMvUQLMFdBdKS6aHS9MjZHMkxUax+IZBa0O8w
        pHetFiw6YHfPxjMby/8Ouar9sbcTMlE=
X-Google-Smtp-Source: APXvYqwabxu9tAElG3MkV6DEr23OCHQPyKNHB3avN48hflvKACb+6aFsL0h5orned8rcpIa9WWo3yQ==
X-Received: by 2002:a02:228f:: with SMTP id o137mr49098856jao.39.1558371008557;
        Mon, 20 May 2019 09:50:08 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id m189sm22566itm.21.2019.05.20.09.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 09:50:07 -0700 (PDT)
Subject: Re: [PATCH 09/18] soc: qcom: ipa: GSI transactions
To:     Evan Green <evgreen@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        Ben Chan <benchan@google.com>,
        Eric Caruso <ejcaruso@google.com>, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190512012508.10608-1-elder@linaro.org>
 <20190512012508.10608-10-elder@linaro.org>
 <CAK8P3a0eYWN6mMwft5OSu8wQQo=kWh5safGFFNkDCELZJyiMmQ@mail.gmail.com>
 <14a040b6-8187-3fbc-754d-2e267d587858@linaro.org>
 <CAK8P3a37bPRZTHZcrg8KrYRLAhCr9pk8v4yuo_wSyUONs2OysQ@mail.gmail.com>
 <4a34d381-d31d-ea49-d6d3-3c4f632958e3@linaro.org>
 <dcd648f2-5305-04dd-8997-be87a9961fd9@linaro.org>
 <CAK8P3a0FfSvTF8kkQ8pyKFNX9-fSXvtEyMBYTjtM+VOPxMPkWg@mail.gmail.com>
 <d3d4670f-eb8b-7dcf-f91a-1ec1d4d96f67@linaro.org>
 <CAK8P3a12+3a-p2pNuQrJu01dOJJuCoQ4ttt=Y0g97wTtBmQO5w@mail.gmail.com>
 <8040fa0e-8446-1ec0-cf75-ac1c17331da5@linaro.org>
 <CAE=gft4ZkO+cGMNEt05+Xw=pEoR7gzJ4jBRB9wA0gQ7V=Pag6g@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <fa83020a-248c-9686-5a90-81923fe843bb@linaro.org>
Date:   Mon, 20 May 2019 11:50:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAE=gft4ZkO+cGMNEt05+Xw=pEoR7gzJ4jBRB9wA0gQ7V=Pag6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/19 11:34 AM, Evan Green wrote:
> On Mon, May 20, 2019 at 7:44 AM Alex Elder <elder@linaro.org> wrote:
>>
>> On 5/20/19 9:43 AM, Arnd Bergmann wrote:
>>> I have no idea how two 8-bit assignments could do that,
>>> it sounds like a serious gcc bug, unless you mean two
>>> 8-byte assignments, which would be within the range
>>> of expected behavior. If it's actually 8-bit stores, please
>>> open a bug against gcc with a minimized test case.
>>
>> Sorry, it's 8 *byte* assignments, not 8 bit.    -Alex
> 
> Is it important to the hardware that you're writing all 128 bits of

No, it is not important in the ways you are describing.

We're just geeking out over how to get optimal performance.
A single 128-bit write is nicer than two 64-bit writes,
or more smaller writes.

The hardware won't touch the TRE until the doorbell gets
rung telling it that it is permitted to do so.  The doorbell
is an I/O write, which implies a memory barrier, so the entire
TRE will be up-to-date in memory regardless of whether we
write it 128 bits or 8 bits at a time.

					-Alex

> this in an atomic manner? My understanding is that while you may get
> different behaviors using various combinations of
> volatile/aligned/packed, this is way deep in the compiler's "free to
> do whatever I want" territory. If the hardware's going to misbehave if
> you don't get an atomic 128-bit write, then I don't think this has
> been nailed down enough, since I think Clang or even a different
> version of GCC is within its right to split the writes up differently.
> 
> Is filling out the TRE touching memory that the hardware is also
> watching at the same time? Usually when the hardware cares about the
> contents of a struct, there's a particular (smaller) field that can be
> written out atomically. I remember USB having these structs that
> needed to be filled out, but the hardware wouldn't actually slurp them
> up until the smaller "token" part was non-zero. If the hardware is
> scanning this struct, it might be safer to do it in two steps: 1)
> flush out the filled out struct except for the field with the "go" bit
> (which you'd have zeroed), then 2) set the field containing the "go"
> bit.
> 


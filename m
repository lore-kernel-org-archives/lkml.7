Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3E5C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565AA20869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MQkK6jcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391582AbfKHL7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:59:42 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38246 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390668AbfKHLoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:44:08 -0500
Received: by mail-ed1-f66.google.com with SMTP id s10so4771302edi.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 03:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=g/++kKVU7OFaHGAtlltoncuD16PbRuMbUQv6ZhSLLII=;
        b=MQkK6jcPMk41V1f5zCzkH34OdDS4xlL7bw4LRqs5P3rbwFw8fnCjM3JmTDWj318k6e
         FREhlTnJtMiseRK9li/i2KKex9+IDrAKyUH49jSGemHMZiWeInZS/lQMgOAn2dwsFhcM
         6pyp1VxOrHReOPQT1pX26fYiRvsrjw7YtCK6JVZZYU+MpyJLWDqAdDmMOXEbxkMRHK5z
         AQUBoWqPwGjInz7Mm2JBDo2MgBqzrdh6ffacLGDm0iN4TYJ2lY+F5o0KAEuQM0fpt9/v
         2vyB0bXT+enHL6P3Up8bnfzV0dfbKDBtUQNSUWUmKO7kM6o8CHiZWLVmSKHp2yxDU6HK
         RCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g/++kKVU7OFaHGAtlltoncuD16PbRuMbUQv6ZhSLLII=;
        b=O9xluM1jACFIOTw4YDtykZs6OWiPBoFeMzYOZKu0YYJwcFmA4tDOMSXmSr8yn3UT5N
         CQ7JfY+NkR3uGtmZ/FjPuTIcLBBMw2Ugkk8tz0mBMNGsUipFUtZvQFgyP8xP/bYUJf3A
         G8r+b/qOeQZQxTLU3fPT1eJ/dUEGPNclERRYQCEsdLaRYM0KQab3ADZKTu3TcVtpXVxA
         iMRa4IWdQ+r55AQpPIg/DRXjyqMaPfMnw8l1D8LzBXNoKwhZIJyLXpl6oVHkBsCTzARq
         MzOnkhUR25pDeFOpeaHRGM43UMTFC9lVpcUs5xuw2fmVj4fkAakMEhpN2nKaeyQL02TK
         sJ/Q==
X-Gm-Message-State: APjAAAXBRVB+2k/n+f3m5NEM5YVW6o4Ap4TVqFEbVrbKtD4beEYeLkHU
        GIFRCmBzMYGlp3FZSz9TmDBqjw==
X-Google-Smtp-Source: APXvYqy+5wkvN8ghdz9sfdp3QIcwFKW0lcB/xb+gSdB1lui68o9slbwHKbtDEd8IikQ88ubpRW95zw==
X-Received: by 2002:a17:906:278a:: with SMTP id j10mr8262538ejc.125.1573213446765;
        Fri, 08 Nov 2019 03:44:06 -0800 (PST)
Received: from [192.168.27.135] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id d11sm123025edq.39.2019.11.08.03.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 03:44:06 -0800 (PST)
Subject: Re: [GIT PULL] interconnect changes for 5.5
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <5123bf54-5d62-fc5c-8838-17bc34487d83@linaro.org>
 <20191107142111.GB109902@kroah.com>
 <0cb5a6a6-399f-99e3-dc41-50114eea4025@linaro.org>
 <20191108103917.GB683302@kroah.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <77e2922b-162c-5554-57f5-85ba278371fe@linaro.org>
Date:   Fri, 8 Nov 2019 13:44:05 +0200
MIME-Version: 1.0
In-Reply-To: <20191108103917.GB683302@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8.11.19 г. 12:39 ч., Greg Kroah-Hartman wrote:
> On Thu, Nov 07, 2019 at 05:42:13PM +0200, Georgi Djakov wrote:
>> Hi Greg,
>>
>> On 11/7/19 16:21, Greg Kroah-Hartman wrote:
>>> On Thu, Nov 07, 2019 at 02:46:53PM +0200, Georgi Djakov wrote:
>>>> Hi Greg,
>>>>
>>>> This is a pull request with interconnect patches for the 5.5 merge window.
>>>> All patches have been for a while in linux-next without reported issues. The
>>>> details are in the signed tag. Please consider pulling into char-misc-next.
>>>
>>> I don't know about
>>> 0003-interconnect-Disallow-interconnect-core-to-be-built-.patch here.
>>> Shouldn't you just fix up the dependancies of subsystems that rely on
>>> this?  We are moving more and more to kernels that "just work" with
>>> everything as modules, even on arm64 systems.  So forbiding the
>>> interconnect code from being able to be built as a module does not feel
>>> good to me at all.
>>
>> Thank you for commenting on this! The initial idea was to keep everything as
>> modular as possible. The reasons behind this change is that other core
>> frameworks like cpufreq (and possibly others) want to call the interconnect
>> APIs. Some of these frameworks are built-in only and it would be easier to
>> handle dependencies if interconnect core built-in too. Now each user that
>> can be built-in has to specify in Kconfig that it depends on INTERCONNECT ||
>> !INTERCONNECT.
> 
> That's fine, when those subsystems start to use those apis, that
> dependency needs to be added.  Nothing new here, and you forcing it to
> either be "on or off" isn't going to change that.  Let's do it correctly
> please.

Alright! That matches with what we do today. Thanks for the guidance!

BR,
Georgi

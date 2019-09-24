Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2141C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 20:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A425B207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 20:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569355522;
	bh=nB3ANp+/569VNYtSayN5jMF7IHRxY+m3iP1QD1TGWw8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=YIrjNM9y1cqSk93xrog55zsHWkBKrTncmySK4Ttd6syPvlVXnuEgcCW1aup1Ij0Ih
	 ypNVNDLBxijZaZiJlMzbmc2OtYc5BeXjC7IEbFZqeY6y7TNmqppvhOYoDk+uzZC3gB
	 L8OF0F9nRciuoSTd1h1xtrQ9hBxi2MEh3IDPja2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407372AbfIXUFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 16:05:22 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36309 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbfIXUFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 16:05:21 -0400
Received: by mail-io1-f68.google.com with SMTP id b136so7611732iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 13:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tzqNMqA07jBcBpcqIcid0j0G7N4xLkFUhmGjg7IIOuU=;
        b=DCyKK193tOOwAbtGLptlJdOOKYY/0pAfa4quNNXrWUvG3TJ7wXw/pThGwGpG+9QiwN
         FazKM7SpbmIueD8YLUzNgzzgixAWUC4leRTPUG/z7IwX9zqjQydBTyOUnRi/xqLq7O0X
         vwnBLD/ePKlVhAXYcazuiJhoHAT+eKbgJPEi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tzqNMqA07jBcBpcqIcid0j0G7N4xLkFUhmGjg7IIOuU=;
        b=qpNOAqa5tUkZ54vmn+BQHq+t7KOzXIL8IfIwrv/OHPtPxETIsHezbEft5z+LB49mhf
         Cf3N2Xe5u7YntLDeESVD82zdABwRn5kQKSDVNOH0YOhEj0fRNRh01yHzpFppJjJO9twP
         zUmqWQQdZkomndcCefVWHnxfMasRtgxr1fwzlSo+TkOMw36sAqh4ayQddYFlkk4RsNeq
         XD7ZIEOrcQS/5k6YkF6LjR0lA1Gc9VMGvHm8jlqUmStBRirW0KXQ1fODHDXt6ycJgYyV
         btloEosTrStwBFhavm+QFQ/6+YQlzNGVb3ipGBw4oSwv4ynn2paQMuFa8S5EBSuWgsvH
         fnCA==
X-Gm-Message-State: APjAAAWzf5xdCO7nyk16PbACwfj6QaJiztYs+gYxoWo5WzX8jAGg3Dvz
        M+OXHv+U6plQFiooZIz0KAVP9w==
X-Google-Smtp-Source: APXvYqxALuZ+2sOPVcl1PCpmgHoIsSghK1bXD0k9qNItmHh8nea4aKSF+aMNcivHLWvltHMCZ47cgQ==
X-Received: by 2002:a5d:89da:: with SMTP id a26mr4311422iot.61.1569355520865;
        Tue, 24 Sep 2019 13:05:20 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k66sm4656319iof.25.2019.09.24.13.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 13:05:20 -0700 (PDT)
Subject: Re: [PATCH] selftests: proc: Fix _GNU_SOURCE redefined build warns
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     shuah@kernel.org, akpm@linux-foundation.org,
        sabyasachi.linux@gmail.com, jrdr.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20190924181910.23588-1-skhan@linuxfoundation.org>
 <20190924181910.23588-2-skhan@linuxfoundation.org>
 <20190924195253.GA2633@avx2>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f6c20b9b-4984-f865-3698-70b61bcd4be0@linuxfoundation.org>
Date:   Tue, 24 Sep 2019 14:05:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924195253.GA2633@avx2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/19 1:52 PM, Alexey Dobriyan wrote:
> On Tue, Sep 24, 2019 at 12:19:10PM -0600, Shuah Khan wrote:
>> Fix the following _GNU_SOURCE redefined build warns:
>>
>> proc-loadavg-001.c:17: warning: "_GNU_SOURCE" redefined
>> proc-self-syscall.c:16: warning: "_GNU_SOURCE" redefined
>> proc-uptime-002.c:18: warning: "_GNU_SOURCE" redefined
> 
>> +#ifndef _GNU_SOURCE
>>   #define _GNU_SOURCE
>> +#endif
> 
> Why are you doing this.
> 
> There are 140 redefinitions of _GNU_SOURCE
> 


Is there something wrong with getting rid of this warning?

thanks,
-- Shuah

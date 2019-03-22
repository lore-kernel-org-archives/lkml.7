Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41119C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1D0218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="glUXnsMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfCVN0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:26:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38451 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbfCVN0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:26:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id a188so2167487wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 06:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YUR9BD0OknTRpwxa7omTX6fkLtmusBY0KjBttpuweLE=;
        b=glUXnsMKii9bEJsd3AnwfOBOqdIXHFOFx5dExl4Mk+I2W8ZppOED1boqhtXR8A0CRn
         SoMGbV53PbG4AfKmZQ/ImldKle2BsZWz2EZqTINPFGxIcZuywL4OFB3dvwOydi/BDzPW
         15d3R6uet+l+z+Y4HvYk/tGbWqOcD3HbzfZXsPGY4F89aFOfMPd62DB4G/c96TGx0BDQ
         XJYUL526glwi4kGRbGAmYiqnm85yTbXk9sYr0RoM3KeTdZ8CWRdW2d+C5sM981IZy2bg
         qFBQQUO/jFNxpIvKH01+B+F5NTwVTkJ+mRNul5oWXhWMzkCSQVaQhArQSY+AFGFmBWgu
         iZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YUR9BD0OknTRpwxa7omTX6fkLtmusBY0KjBttpuweLE=;
        b=o3/x3lJrjZDFEOOX6KR7gbOwBxmhxBDe3v7ymab/j6CU+wTcKTuGvPnLtwUi/Jj0+X
         bWdWwLUwo6VmYjKWiI5rqXbmxsYf18TUisMrJH24ipRW5ZQQcykOCmQEihBfiHlGw9FJ
         7ZHQkjDXM4VN9I2dVFf22xm+2nsOm1FKMa/3C43P4St5wjS/NpKEUWLqyw4cQN6ipQzi
         cT570i7Zalff0EXL+5j6lYHWsYjJMyaEZB1c0y7I6zkEmutq84jEzLDREzsRo7MOI11D
         Fn7KsiO/6MT7Ra1ey0GzPbhjsuudX84TziDRJJVb4PCa65XaWNixELbQFJIDDrjPD4le
         hlVw==
X-Gm-Message-State: APjAAAUlxqSy4fy2oA79sZ+D1TxYrAKIjm+FGAlXldQR6hgVISpuaeKC
        MA127gT4EQMjZGTiEUDK4arGkg==
X-Google-Smtp-Source: APXvYqwi0WvccLBM3J2CJUBQR+V2TOQ3nUIFcN6vLmKaJGFAyjNJoPKgU/Rke4qOFsxwyFYLGQX8JA==
X-Received: by 2002:a1c:ef08:: with SMTP id n8mr1936534wmh.85.1553261168923;
        Fri, 22 Mar 2019 06:26:08 -0700 (PDT)
Received: from [192.168.0.41] (205.94.129.77.rev.sfr.net. [77.129.94.205])
        by smtp.googlemail.com with ESMTPSA id b16sm7143988wrq.41.2019.03.22.06.26.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 06:26:08 -0700 (PDT)
Subject: Re: [PATCH 1/2] cpuidle : auto-promotion for cpuidle states
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20190322072942.8038-1-huntbag@linux.vnet.ibm.com>
 <20190322072942.8038-2-huntbag@linux.vnet.ibm.com>
 <CAJZ5v0gY-theHng=bQQpw-33jHGe++iEigEM5j6Ls7vEuewuSQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <cfb0076f-0b56-f12c-a736-469a3d11ab83@linaro.org>
Date:   Fri, 22 Mar 2019 14:26:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gY-theHng=bQQpw-33jHGe++iEigEM5j6Ls7vEuewuSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2019 10:45, Rafael J. Wysocki wrote:
> On Fri, Mar 22, 2019 at 8:31 AM Abhishek Goel
> <huntbag@linux.vnet.ibm.com> wrote:
>>
>> Currently, the cpuidle governors (menu /ladder) determine what idle state
>> an idling CPU should enter into based on heuristics that depend on the
>> idle history on that CPU. Given that no predictive heuristic is perfect,
>> there are cases where the governor predicts a shallow idle state, hoping
>> that the CPU will be busy soon. However, if no new workload is scheduled
>> on that CPU in the near future, the CPU will end up in the shallow state.
>>
>> In case of POWER, this is problematic, when the predicted state in the
>> aforementioned scenario is a lite stop state, as such lite states will
>> inhibit SMT folding, thereby depriving the other threads in the core from
>> using the core resources.
>>
>> To address this, such lite states need to be autopromoted. The cpuidle-
>> core can queue timer to correspond with the residency value of the next
>> available state. Thus leading to auto-promotion to a deeper idle state as
>> soon as possible.
> 
> Isn't the tick stopping avoidance sufficient for that?

I was about to ask the same :)




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


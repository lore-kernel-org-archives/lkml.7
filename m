Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBC0C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFD720891
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDcc3xxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfDYPnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:43:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46853 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfDYPnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:43:18 -0400
Received: by mail-lj1-f194.google.com with SMTP id h21so26960ljk.13;
        Thu, 25 Apr 2019 08:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZusI12UTBXqKsG9kJjiBteoBKQIenFbcyx0Ahu02Vbc=;
        b=mDcc3xxVfCIT/xnSV+fRmfK47jBSfi67FO4DyPH8TGg1H5+X6iIjioPcIhkAWHKfxU
         dDnqHyIvqaxlFCBc3gBx0ZEXisDggWHFsFzDNQt2kEiYzKoXC9JnFWQ51+aN5iFkgSj8
         zfRxYtyHGqZLmeZtnhkLRpZ/y77yU5GUINkQJNhzCDBY7PvSwsKon1niAun04Unsbg63
         vVC2tzXBiHZFfQsxP8p6wRo8rFBZGZNvJK3OruM0xhY/b4jG6HmFJMeMW/tN7m91QTOL
         JeDiO/ESTRDFx+3KKMgHrTUtiP1brH55fwQSniKNINXEA+w+l4eZDWNY7IhB6qtwwQM4
         03SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZusI12UTBXqKsG9kJjiBteoBKQIenFbcyx0Ahu02Vbc=;
        b=qHkwyhx7+0TQ+CNIVt+b9rv6wN2m4IoR8EsXlkQF3QHo0L2Wp2SZwhT6z0Alw1D92M
         JXe2SWUO/7IEOS78uCJEBRgZsqEKK1EDMczZO9Fax1iv7F/19/63VqlcuxLWQFWB0W9v
         nhNiOqwKym6jvbL27uHCz4A4AZVyxox4NYqQhpGI+DQ3wTuciFp8txf9gPNsUb/C5Qln
         vs+eTaulW+9AkavXFFrzEKNl4zNo+70GSp0vRm5OIGWeeXJe516G1WCWe8aUCZm3LNmj
         +7iU/DGhjrqDskzuD963r+YdvTc7CEBEDMR3+KTmfREfDs33mrXWDJxEmV9D1tlSCyO7
         bUEw==
X-Gm-Message-State: APjAAAVS4yAFcrCb46Jl1faqGgB1g/yUecFBS7MfXj8HTtVw4YpiUJhM
        fERWuaT+aiHxXmNMQ17rly9r5gbk
X-Google-Smtp-Source: APXvYqwjK7vp4gdZYj3p3aqoqlnWqs6W6u33VKIHTOqUHrHn7YdTac2XzMpnwyg+K6RWKVJ4+mVw+w==
X-Received: by 2002:a2e:a0c4:: with SMTP id f4mr3906701ljm.100.1556206995982;
        Thu, 25 Apr 2019 08:43:15 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id d2sm1926245ljl.69.2019.04.25.08.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 08:43:14 -0700 (PDT)
Subject: Re: [PATCH v1 0/2] clk: Tegra124 PLLM fixes
To:     Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190411214835.19947-1-digetx@gmail.com>
 <46c12545-0e9e-93bf-2ccc-4577f4eb223e@gmail.com>
 <20190424083625.GQ12975@pdeschrijver-desktop.Nvidia.com>
 <d020b512-59be-51bd-39c1-4827e57b020c@gmail.com>
 <155620524950.15276.14252541417126056267@swboyd.mtv.corp.google.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <692c6b3f-9f46-0b0a-63a7-029ec7a7409d@gmail.com>
Date:   Thu, 25 Apr 2019 18:43:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155620524950.15276.14252541417126056267@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.04.2019 18:14, Stephen Boyd пишет:
> Quoting Dmitry Osipenko (2019-04-25 06:50:39)
>> 24.04.2019 11:36, Peter De Schrijver пишет:
>>> On Fri, Apr 19, 2019 at 02:50:10PM +0300, Dmitry Osipenko wrote:
>>>> 12.04.2019 0:48, Dmitry Osipenko пишет:
>>>>
>>>> The patches in this series are trivial and fixing the longstanding bug on Tegra124. Could you please take a look and and ACK the series if it looks good to you?
>>>
>>> Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>                                                              
>>
>> Thank you, Peter.
>>
>>
>> Stephen, is yours maintainer-tool able to pick up the "Acked-By" for the whole series or do I need to resend the series with a proper "Acked-by" tag added to every patch? Please let me know.
> 
> The maintainer-tool is me, but I don't require you to resend to collect
> acks or other tags. I can do it and I'll do it today.
> 

Thank you very much!

Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AD9C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E8F2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yy4gZZjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfENTN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 15:13:27 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33238 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfENTN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 15:13:26 -0400
Received: by mail-lf1-f68.google.com with SMTP id x132so83305lfd.0;
        Tue, 14 May 2019 12:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BbR9Yrok2+r2iuSrKXyCdVxdVyCF4DRzoDzjudqSfhs=;
        b=Yy4gZZjwjJJL96M9LqthkzzzWTHN4Io+F8xLcItoTr4/Um5vZiAIr6E+glB340PTT8
         L9b9U1YC4gEvcYbJcs/i62APNBZP5dKdvn7H4Q6Ot7lxn3hMrKFT34ycFROM8Bjm4ZKN
         evgIPQY8PEeaLZM7e/mRLTzIgCekVbWlGDvvuUE8s9DU5xxPgkmw8wyoy4t2hPJ0lTYp
         wr+ao2gipTZ4NbA8lAb697F8YzfWzUkQCoGMVETA9+y4VqSg93KjdEvlDhHthF3O5yE2
         AtDfflLbwtdR15cQf7By5X/YImbk42qKmkI8bnlCiyhmhkn7PhGdnotDqxd/UmhRe67U
         VCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BbR9Yrok2+r2iuSrKXyCdVxdVyCF4DRzoDzjudqSfhs=;
        b=X8AVmdCRqwS0S6pY34braDtgK0rL+mQ63OSGjFSmRn9gg6pghxAPMwmGdcB12O5v0c
         /AgTpNtO8z63uv8+khJzUjwNhqpVOVHjQQC4Lkr0Z6HlwadkfMF5BaAQQx/UHjCiOScz
         ufLEMzt44vvVJD41v22Rjcctl9JtVV1El0QXCoOR+U6IXwrYjm0djFdgy8JwonogJFE8
         S+Z14AgLbKzjmb/boSU/VkLbJEgwwGvJuGRPl65TwQmsHf1BCTBL45uUlJRzRu3f6p1J
         4ilFRzrtf9X16FViF3lqJ2z1Ph0KO4PhFaLzZHh0P4JNvY8qTCOINIacGazpEEV3NFQN
         00WA==
X-Gm-Message-State: APjAAAX1jARxCYxkecP4rXbytPLl9tzXTGINvpyHvyxwJIAaDOrHj/TZ
        dRx7p6oFmqLT2+q2825oMMyblGIm
X-Google-Smtp-Source: APXvYqwjGA+6FKnifsb5grJr693AVLfaeSckMZG5ZsXPoEQ/sbIwaQj3WiG1KpI+c0W8Zge5/da5tw==
X-Received: by 2002:ac2:5986:: with SMTP id w6mr18939816lfn.147.1557861204485;
        Tue, 14 May 2019 12:13:24 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id b15sm3843192ljj.1.2019.05.14.12.13.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 12:13:23 -0700 (PDT)
Subject: Re: [RFC PATCH v1 5/6] soc/tegra: regulators: Add regulators coupler
 for Tegra20
To:     Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190414175939.12368-1-digetx@gmail.com>
 <20190414175939.12368-6-digetx@gmail.com>
 <20190508075706.GW14916@sirena.org.uk>
 <9756d8ca-0778-5185-5b6b-3168d63819ec@gmail.com>
 <20190512090627.GO21483@sirena.org.uk>
 <586b4f29-1937-2d7b-3944-c29311502878@gmail.com>
 <20190513173816.GG5168@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b7bd37d4-471a-4c31-f561-8d4eb89519a4@gmail.com>
Date:   Tue, 14 May 2019 22:12:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513173816.GG5168@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

13.05.2019 20:38, Mark Brown пишет:
> On Sun, May 12, 2019 at 08:42:39PM +0300, Dmitry Osipenko wrote:
>> 12.05.2019 12:06, Mark Brown пишет:
> 
>>> This seems like it should be easy enough to describe - we just need
>>> minimum and maximum spreads between pairs of rails.
> 
>> Yes, but the proper CORE/RTC minimum voltages shall be maintained until
>> all drivers will get support for the voltage management, which likely to
>> take a lot of time to get upstreamed. So I'd want to get at least some
>> basics working for the start, later on it should be possible to consider
>> generalization of the regulators coupling. Mark, are you okay with
>> having the custom regulators coupler as an interim solution?
> 
> Let me think about it.  Interim solutions have this habit of hanging
> around and the bit with needing to get all the drivers loaded is very
> much an open and substantial question...  :/  Definitely not something
> I'd close the door on at this point though.
> 

This one has a good chance to stick around for a substantial time.

Realistically I see two variants right now:

  1) get at least some basics to work (regulators coupling, CPUFreq
voltage managing) and then continue step-by-step

  2) give up on it all in upstream because likely that an immediate
complete solution will take just too much time and effort for a one
person to cope (I have other things to do as well)

Mark, I'm glad that you're not strongly opposed. Will prepare  v2.

If anyone else has something to say, please don't shy.

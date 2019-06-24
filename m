Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B2FC48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BE720673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtpiU+Fh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfFXCXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 22:23:48 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42314 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfFXCXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:23:48 -0400
Received: by mail-lf1-f67.google.com with SMTP id x144so1352346lfa.9;
        Sun, 23 Jun 2019 19:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d28rLR61bEHhlQ7ZaLjzEo7EXN7nV6mp2jaVnBr+SN0=;
        b=dtpiU+FhTbBG/G6KcA6mRKle96BQiDowlKrQlytPeYq0TT2INWyknc3s88Qlnsvb6C
         qZMQoyaeR1uGZ2huPAD9HXUZxCCvu7NnVNzJnoAAm5gtnjNhXsgkBvMEgSOPFZitlBuN
         sDOVlZsDUEcyADii7AN8TuK/0LPV0eO6xPBd2A5OYqHVCrxORe5qj3isIfpbs/9f2Iqa
         M1d8IQI5tyMdemNR4fpgW5a6aZ4a8x7VIZx/MGCVTy85AbVGU/5xxKxKKiAa0/XD+ec1
         AXY1VqqDyzqrYpReyNpBGMHTonTOmlJh/CtzdGe1gSF6DHbBMenqdOxtQouzXW3zF4Yx
         E55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d28rLR61bEHhlQ7ZaLjzEo7EXN7nV6mp2jaVnBr+SN0=;
        b=qCXxS6xLLjq0OGs+4us3TCRwPHx2sG0wGTN5gYiVhCbG10ihizGAD+UQw8mrncmmiU
         pzpnKzDC4Y70gvVOL+Ptcg/dkZzq4DtXPu1U79RJd1tuU+UEdEOhRirG6zlVBSBs3aOF
         4hz2kBLJjUwyHmD4Uuv90iN/IKdBPGRCuzuesM1KlIZn0wuuX+ycziKN1Jdg0gpZyMWm
         rIVgJQQu9kHx7EW1D+BZxmBwehb26eQX+IgSixhZ9Hf6NYeX69JAPYWfwMtawfy3cv5F
         x/JrjcC/4t1Hvx231LH1MbBvOlStjE/FdbXRWe4xdwtQJJvHndsehlfFVoRhVwDs2eVK
         sgdw==
X-Gm-Message-State: APjAAAWlEg4xW0wtXjcmIEy7+r+JQKvv8SILyKwOMAeT2h0JTYFosH2g
        cnIfozC1za4PiHaPQYJJYLD3rwK/
X-Google-Smtp-Source: APXvYqzp3xpYo/+S38IaUxFUeLxZtX8vTSKdXatdtXKY5E2EaxW4mweXcaiOqhyE/kedLKYFq9656w==
X-Received: by 2002:ac2:4d1c:: with SMTP id r28mr35207146lfi.159.1561336545448;
        Sun, 23 Jun 2019 17:35:45 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id y12sm1513359lfy.36.2019.06.23.17.35.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 17:35:44 -0700 (PDT)
Subject: Re: [PATCH v4 00/16] NVIDIA Tegra devfreq improvements and Tegra20/30
 support
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CGME20190501234148epcas5p1cc9a8dafa9ee6d8d046d1292b8270727@epcas5p1.samsung.com>
 <20190501233815.32643-1-digetx@gmail.com>
 <60ef6e47-e61b-3a92-e90d-90debedfcfc4@samsung.com>
 <fa061a65-f108-6c5e-1f87-950a9a8caafc@gmail.com>
 <0fb50eb1-a173-1756-6889-2526a10ac707@gmail.com>
 <683b343a-e64f-8345-ac44-10f5c00521bd@samsung.com>
 <5c2a7c32-a98c-3930-14ae-beb0241908d0@gmail.com>
 <389cc71d-8f0b-fa39-1325-433d27c75dc8@gmail.com>
 <31fc1430-5a3b-cccb-06bb-7b46081edb68@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5d5cba1f-1625-7496-3599-7bdc6042b5ca@gmail.com>
Date:   Mon, 24 Jun 2019 03:35:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <31fc1430-5a3b-cccb-06bb-7b46081edb68@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.06.2019 2:50, Chanwoo Choi пишет:
> Hi Dmitry,
> 
> On 19. 6. 24. 오전 2:17, Dmitry Osipenko wrote:
>> 05.06.2019 2:09, Dmitry Osipenko пишет:
>>> 04.06.2019 3:49, Chanwoo Choi пишет:
>>>> On 19. 6. 4. 오전 1:52, Dmitry Osipenko wrote:
>>>>> 03.05.2019 3:52, Dmitry Osipenko пишет:
>>>>>> 03.05.2019 3:31, Chanwoo Choi пишет:
>>>>>>> Hi Dmitry,
>>>>>>>
>>>>>>> On 19. 5. 2. 오전 8:37, Dmitry Osipenko wrote:
>>>>>>>> Changelog:
>>>>>>>>
>>>>>>>> v4: Addressed all review comments that were made by Chanwoo Choi to v3:
>>>>>>>>
>>>>>>>>     - changed the driver removal order to match the probe exactly
>>>>>>>>     - added clarifying comment for 1/8 ratio to the Tegra20 driver
>>>>>>>>
>>>>>>>>     Chanwoo, please also note that the clk patch that should fix
>>>>>>>>     compilation problem that was reported the kbuild-test-robot is already
>>>>>>>>     applied and available in the recent linux-next.
>>>>>>>
>>>>>>> I knew that Stephen picked up your path about clock.
>>>>>>
>>>>>> Hi Chanwoo,
>>>>>>
>>>>>> Okay, good. Thank you very much for reviewing this series! I assume it's
>>>>>> too late now for v5.2, but it should be good to go for v5.3.
>>>>>>
>>>>>
>>>>> Hello Chanwoo,
>>>>>
>>>>> Will be nice to see the patches in the linux-next before they'll hit mainline. We have tested that
>>>>> everything works fine on a selective devices, but won't hurt to get some extra testing beforehand.
>>>>> AFAIK, at least NVIDIA people are regularly testing -next on theirs dev boards. Please note that
>>>>> this not very important, so don't bother if there is some hurdle with pushing to the tracking branch
>>>>> for now. Also please let me know if you're expecting to see some ACK's on the patches, I'm sure
>>>>> we'll be able to work out that with Thierry and Jon if necessary.
>>>>>
>>>>>
>>>>
>>>> Hi Dmitry,
>>>> I think that it is enough for applying to mainline branch.
>>>> The devfreq.git is maintained by Myungjoo. He will be merged or
>>>> reviewed if there are th remained review point.
>>>
>>> Thank you very much!
>>>
>>>>
>>>> Hi Myungjoo,
>>>> I reviewed the Dmitry's patches from v1 to v4 patches.
>>>> And then I tested them on my testing branch[1] for catching
>>>> the build warning and error. In result, it is clean.
>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing
>>>>
>>>> Please review or apply these patches for v5.3.
>>>>
>>>
>>> Hello Myungjoo,
>>>
>>> I think this patchset should be completed now. Thierry has some extra
>>> comments to the patches, but seems nothing critical so far and all the
>>> concerns could be addressed in a follow-up series. Please let me know if
>>> you're fine with this, I can re-spin v5 as well if necessary.
>>>
>>
>> Hello Chanwoo,
>>
>> It looks like Myungjoo is inactive at the moment. Do you know if he'll
>> be back to the time of the merge window opening or you'll be curating
>> the pull request for 5.3 this time?
> 
> Myungoo works in the same place. I'll talk with him.
> 
>>
>> Secondly, I'll send a few more patches on top of this series, addressing
>> Thierry's comments and making more improvements. Please let me know if
>> this causes any problems and I should re-spin the whole series.
> 
> OK. I'll review them.

Thank you!


Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7100BC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 12:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C1D2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 12:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoijBk+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfF2Mi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 08:38:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41039 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfF2Mi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 08:38:26 -0400
Received: by mail-lf1-f68.google.com with SMTP id 136so5722119lfa.8;
        Sat, 29 Jun 2019 05:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PxB3Diftculh9VRXp9qOsj2Wfuu0tHg69Smbkbmpvq8=;
        b=MoijBk+rB6pc0O8vADSTYaf5vdNDqq1PKwA907cqdu6ACgVCscLMcBULehxqNnSGb+
         1+tOLBFscFsF7Oz/lekwrsnKfQK/SfWqQ/of3/2+KSP/uNXsujm9zfQgwpkC0sP9Epaj
         otgk8C9ffHOxbgKxzzrDsE+xXG1G/wThi0m1AZjWGZh+W6eYWabiUXuzfWJbNawI0E3p
         D92y6kh5himm1HQdCFpoB+2ddFwJ/viMZWtHlZqItX20ygAeTbjD6nxJpufnhUzX2nxw
         gLg6/4vcbI25DXgVIkLkiKpFW+2q4OwLAGQ3PcQ1tTyBeLNKw7K6iyceui/+aLIpkkDU
         Q8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PxB3Diftculh9VRXp9qOsj2Wfuu0tHg69Smbkbmpvq8=;
        b=DkGSVEGHCKxdQYEmlHXXUtXRC05yl6RIm8KPltNyMpyrm3vgXbAtOfprugo8qqNrzS
         4ynLVa4IbZkm+G/toGTnmv22cpC6mtrQOWOFcRdf+APHLjSYU0RPcBZtxg+UpnFhmw3m
         UYDvl/VYOoMVXCU9DZmfBXCGCDJzm1zifg9LezLmp/qOY6996GTlWxjhb6S5nluywbDH
         TUf6h0G1+CO6vHQH8kc9N2YeZoUDbNYL5TktJq+DgoEygXWue4hTCqXnsrpOGseMzDkg
         3Gw056xdJkK1fxcMInoP7AiXoXmG+pz4Wls2PqvFFgS7SBjepQuYpxs8SayZnmgoWeJ6
         SW0g==
X-Gm-Message-State: APjAAAWBUTDQ0SgAxtkQb4QCuWy5TFt3SQFL0foziN5ma4hb2rsORAjD
        LM1A+CLMmXPB/aJcMd4LjLZZH4NO
X-Google-Smtp-Source: APXvYqz78bHqqcP8bJJmKNHs8RZazuz7Fr9E/6nX+Zc1vmRRrK0GetZI1zCxC7fhwxsNCvqFZgQlLQ==
X-Received: by 2002:ac2:51ab:: with SMTP id f11mr2968217lfk.55.1561811903067;
        Sat, 29 Jun 2019 05:38:23 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id o74sm1294461lff.46.2019.06.29.05.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 05:38:22 -0700 (PDT)
Subject: Re: [PATCH V5 02/18] pinctrl: tegra: Add suspend and resume support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        linus.walleij@linaro.org, stefan@agner.ch, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        jckuo@nvidia.com, josephl@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        mperttunen@nvidia.com, spatra@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org
References: <1561687972-19319-1-git-send-email-skomatineni@nvidia.com>
 <1561687972-19319-3-git-send-email-skomatineni@nvidia.com>
 <0409f478-e425-4e7f-5fff-8c3a94f47ee8@gmail.com>
 <ca8199af-43db-c878-a93f-66c275acf864@gmail.com>
 <99403cb1-aaef-4dd4-68a0-67864ca7ce6c@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fbfb2167-d0b3-b66a-d1ba-378c877817ed@gmail.com>
Date:   Sat, 29 Jun 2019 15:38:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <99403cb1-aaef-4dd4-68a0-67864ca7ce6c@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

29.06.2019 2:00, Sowjanya Komatineni пишет:
> 
> On 6/28/19 5:05 AM, Dmitry Osipenko wrote:
>> 28.06.2019 14:56, Dmitry Osipenko пишет:
>>> 28.06.2019 5:12, Sowjanya Komatineni пишет:
>>>> This patch adds support for Tegra pinctrl driver suspend and resume.
>>>>
>>>> During suspend, context of all pinctrl registers are stored and
>>>> on resume they are all restored to have all the pinmux and pad
>>>> configuration for normal operation.
>>>>
>>>> Acked-by: Thierry Reding <treding@nvidia.com>
>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>> ---
>>>>   int tegra_pinctrl_probe(struct platform_device *pdev,
>>>>               const struct tegra_pinctrl_soc_data *soc_data);
>>>>   #endif
>>>> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra210.c
>>>> b/drivers/pinctrl/tegra/pinctrl-tegra210.c
>>>> index 0b56ad5c9c1c..edd3f4606cdb 100644
>>>> --- a/drivers/pinctrl/tegra/pinctrl-tegra210.c
>>>> +++ b/drivers/pinctrl/tegra/pinctrl-tegra210.c
>>>> @@ -1571,6 +1571,7 @@ static struct platform_driver tegra210_pinctrl_driver = {
>>>>       .driver = {
>>>>           .name = "tegra210-pinctrl",
>>>>           .of_match_table = tegra210_pinctrl_of_match,
>>>> +        .pm = &tegra_pinctrl_pm,
>>>>       },
>>>>       .probe = tegra210_pinctrl_probe,
>>>>   };
>>>>
>>> Could you please address my comments in the next revision if there will be one?
>>>
>> Also, what about adding ".pm' for other Tegras? I'm sure Jon could test them for you.
> 
> This series is for Tegra210 SC7 entry/exit along with clocks and pinctrl suspend
> resume needed for Tegra210 basic sc7 entry and exit.
> 
> This includes pinctrl, pmc changes, clock-tegra210 driver changes all w.r.t Tegra210
> platforms specific.
> 
> Suspend/resume support for other Tegras will be in separate patch series.

Okay, fair enough.

Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63669C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 22:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BEB21835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 22:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2LgDXRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfLGW4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 17:56:14 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36058 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfLGW4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 17:56:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id r19so11527671ljg.3;
        Sat, 07 Dec 2019 14:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZI1hlb9vVNSPXF5Vfa+R7+tmdxj9q/t0Z42RxCkIyA8=;
        b=U2LgDXRI1k/TPhJXMlVbsEsJxny/DOj/FGzHAJSpa29uO/4yOlNemizYR2RYZTh6CG
         +fLiTn1TmwrMIFCpaJxu9H9+Wx6BZdPqs/WWsj+fSxxIBgL9zwNXPd6M4j1dYyHPO5+i
         +OymBpsNfaOE5gyuIjwVxwLkxFEoUJs6hUgbOz1jXR/OufTza0MKJKPRUn+90bvd01c5
         /cm43HDTp4G4VrRpkXit6W8f5HZoAcz2+mKbW0ylDGgPlGdPezn5H8x0H7Quk0GSvycT
         wsVlNXk0wP3HJg2FUqArNLFWftss+bbbk6JgsOYN6tjvPDQt2BMGxR2z6luhtnBUfP8q
         flOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZI1hlb9vVNSPXF5Vfa+R7+tmdxj9q/t0Z42RxCkIyA8=;
        b=CVCQ8rd7hpXsRM8OJzLV7lntq2L31l36Hjx13jINuAbjzbd8uQRUkm+w6t7lgTjvHb
         THaLX3/h4GWeR2VMITQ9KH5aQG4D9wtnmHxydiNmsjtA0qTGVpwIJ90BriurZgbn1bM3
         zCzI9dpjAxVe1jZU5l0TIP/bv9Zb/VjLsA5Ff4NGHZ/k9ksOPZSdsc9fPx5tKGxEb/rB
         xM+lp5I2mjFEFUCeOL+pvxlte7UL7HpFuVppg7vIBYLa+Ou+y81eeSkm4EQhivGzHgZD
         xVYQlZNuUSyJG1h73gLbA6jgfNU3L8CRd6Y0vJwfQ4HVwTjPv0fMnhfS7holC8UPNiWH
         mCHw==
X-Gm-Message-State: APjAAAVI0oL3JPdEF7Ew32rvh7OTX3KoBa+LamNNTIfatnXfCyndWRYd
        eGs2s5ODBUFnpVIlZM4FH1ymHiN7
X-Google-Smtp-Source: APXvYqxjCDu585IB+DUfK2wFvNbftHX6b/0kgnUHJsmXv70jbyd0QlKq/oaGO2yYZArOzJYdkd+eEg==
X-Received: by 2002:a2e:3216:: with SMTP id y22mr12204248ljy.95.1575759370979;
        Sat, 07 Dec 2019 14:56:10 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id n5sm8449226ljh.86.2019.12.07.14.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 14:56:10 -0800 (PST)
Subject: Re: [PATCH v8 00/19] Consolidate and improve NVIDIA Tegra CPUIDLE
 driver(s)
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191203004116.11771-1-digetx@gmail.com>
 <20191207193128.GB19924@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d13eaf7b-7a85-2b7d-ac41-ebc89f8e8b82@gmail.com>
Date:   Sun, 8 Dec 2019 01:56:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191207193128.GB19924@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.12.2019 22:31, Michał Mirosław пишет:
> On Tue, Dec 03, 2019 at 03:40:57AM +0300, Dmitry Osipenko wrote:
>> Hello,
>>
>> This series does the following:
>>
>>   1. Unifies Tegra20/30/114 drivers into a single driver and moves it out
>>      into common drivers/cpuidle/ directory.
>>
>>   2. Enables CPU cluster power-down idling state on Tegra30.
>>
>> In the end there is a quite nice clean up of the Tegra CPUIDLE drivers
>> and of the Tegra's arch code in general. Please review, thanks!
>>
>> Changelog:
>>
>> v8: - Rebased on recent linux-next, now making use of
>>       cpuidle_driver_state_disabled(). [...]
> 
> Dear Dmitry
> 
> This rebase was not complete, at least in patch 14 direct access to
> .disabled field (now removed in Linus' master) are left. The fixups
> needed are below (only compile-tested for now).

Hello Michał,

CPUIDLE core got changed after this series was sent out, I'll rebase it
one more time. Thank you for the attention.

[snip]

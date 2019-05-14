Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C371CC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AF421473
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8xs//Up"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfENSar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 14:30:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37352 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfENSar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:30:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id h19so172155ljj.4;
        Tue, 14 May 2019 11:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EapbBImn7I+/owIGCCoZMA8xARMudBKelPedvhh+T0w=;
        b=g8xs//UpQ1Q8Scvyoyixf5Mzv3wzHeM1TX75i/V8BbFxI+7dVXn5RZsEdWKW3h3wkR
         pxgCiKUHmbkG3n41FZbbVe7J9TBJbwyv3JLRHkIUp22Jsk6p5xxCSQd/Bh1pQqCsxfki
         DzYfQD+rPM6BytD1sbNYJIp1UkGCw4kNcEzcSZYclch6BmgNuj/2kHacAdmWVRlZHoT5
         5iGgP3QWOmZ/3FoeLwrfuZ/TESfYQ2DjZHtXJztqR42Dg9RpznW3Tl1F9JjjApKNxATd
         HOape8rhaCOE+0wXixSXmvKdZF/2ERBzoUnX/xSiz+l/oLKeR9HhLAfXYWWuxJ0sr7S7
         UGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EapbBImn7I+/owIGCCoZMA8xARMudBKelPedvhh+T0w=;
        b=cUhbnpYm0fT6aV/AyJkUIrX+eZQ9AcwKLVRT6k3AZLHnctQ5s8Ljn562RPvxKKLkq1
         EwVNlm+hZyhFOU7lv5BzugVoouXH7yzpgM7uoS1109RUBXsguzlwpZpac1QfkqCWKowp
         zz9ICkXJ8O9AdB9aEs3BRNKdF+8JsIUH+fPka1gutnHYW+EfJL7k2KMHVIEnmueFdIi+
         5HoShFQKQ83lx19ckJzY95Rc9zCw3Dm08fFLTc5kcUFRqhQtkfs3dD9dfOkOBG3lruIE
         o3wnufIoouAMKyhvnj7Z5Sv4XeXQj/dFcSGf0zpHZBs0kTcLW8FZTDQivfIsDnxEL4mB
         12mQ==
X-Gm-Message-State: APjAAAXwnntrPU2ZMqm8r9/vnMQrTkCCJeGzmPykeG7wyq81Z+TZU8sD
        Fx/yTUKusN304UWrMiMfokl4KRV9
X-Google-Smtp-Source: APXvYqwLvJck93JW05fM6HY3C3TUPBQmER3GljRPzmCs4nsw11FSIBQUuEcbyhjeGddnf6tkDlvtCA==
X-Received: by 2002:a2e:8849:: with SMTP id z9mr1832510ljj.164.1557858644707;
        Tue, 14 May 2019 11:30:44 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id s26sm3639022ljj.52.2019.05.14.11.30.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:30:43 -0700 (PDT)
Subject: Re: [RFC PATCH v1 6/6] soc/tegra: regulators: Add regulators coupler
 for Tegra30
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190414175939.12368-1-digetx@gmail.com>
 <20190414175939.12368-7-digetx@gmail.com>
 <20190508075848.GX14916@sirena.org.uk>
 <af6de446-ab45-1745-30e5-426c6b34421f@gmail.com>
 <20190512090446.GN21483@sirena.org.uk>
 <3988cfb6-55fe-48c4-5365-ac79871f7fd2@gmail.com>
 <20190513174000.GH5168@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9e13bbd1-ff28-1570-b1a6-0cc6337b8f6c@gmail.com>
Date:   Tue, 14 May 2019 21:30:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513174000.GH5168@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

13.05.2019 20:40, Mark Brown пишет:
> On Sun, May 12, 2019 at 09:29:54PM +0300, Dmitry Osipenko wrote:
>> 12.05.2019 12:04, Mark Brown пишет:
>>> On Wed, May 08, 2019 at 04:27:42PM +0300, Dmitry Osipenko wrote:
> 
>>> Those seem like they should be doable in generic code, though the fact
>>> that the constraint is variable makes it annoying to specify - otherwise
>>> it'd just be a minimum and maximum spread.  I'm not really coming up
>>> with any great ideas right now, it's getting into OPP type territory but
>>> it sounds like there's more flexibility for ramping the core voltage so
>>> you'd end up with silly numbers of OPPs.
> 
>> The OPP shouldn't have to do anything in regards to the regulators
>> coupling. The whole idea of the regulators coupling is to make device
>> drivers to not churn with the coupling. The coupling in this case is
>> specific to SoC and not to a particular board.
> 
> The thing with OPPs is that they specify a whole table of values that
> work together including regulator settings, the result being that you
> have many fewer options but don't need to think about constraints.

I'm afraid this is just a way of abusing the OPP's. I actually already
had variant of the CPUFreq driver where it was managing all of the
coupled regulators and gave up on it because it's just not very
practical and adds a lot of unnecessary churning into the code. Note
that it's just the CPUFreq driver, there are quite a lot of other (CORE)
drivers as well and there are a lot of voltage combinations because OPP
entries are also specific to a range of hardware versions.

>> I think the current approach with the customized regulators coupler is
>> the best solution for the time being. We may consider something more
>> generic if there will be other users with a similar coupling
>> requirements, otherwise it's quite difficult to judge what is "generic".
>> Do you agree?
> 
> Some of the constraints (like having drivers loaded) are kind of fun...
> 

AFAIK, there is no good solution in upstream kernel for that problem
yet. Maybe it will be possible to reset hardware into a some more
predictable state early during kernel's boot for the start, will see.

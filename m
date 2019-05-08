Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D4EC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B919820675
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t4C1I55+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfEHODl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 10:03:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38625 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfEHODk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 10:03:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id u21so8458345lja.5;
        Wed, 08 May 2019 07:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n2M5rYUjwakjvvg7nYPCE88Q86Q6otV4ovZgwMe0OQk=;
        b=t4C1I55+cV8bMREZ9s+0h41c1bK1cEZcJXJ2zk5Kn8/XXnvST9t8rBDo/twhkdMuGa
         4krkzW9mqFw2yclz4R3M5gQnnxc4D26PUjjy8NK4CLlIoi9LUM2GqNffjdLQGHkg7L7K
         jPoKgWPGjnU4xXBBtu5dJ6wqX8eWTdG4ydvXQPbBZtLAKKSTQgHbotUyps0eq5cLZz8d
         ZoozhIoJss7vog1a3r7Uvq49ImBQpe0NJz7swMKDw8cPx7fnICdYGsx8v1aiUD0jM9OY
         BLoh3+09dwR8U5yMMtWrpXBCFEk5K9Ezq67EUmOCJ5h4Hcs5Eulay2WPlUWf+q2UwOE5
         sx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n2M5rYUjwakjvvg7nYPCE88Q86Q6otV4ovZgwMe0OQk=;
        b=Fmhge8vl/SmfDBpD/Kp1aO9ooOMyYL5reDfvpMRPkiXkMuPzR5qOV2ugWGTKLYw3Z8
         pZmfUwn7kMlhld6bYH1YpIJLK3PrUwl9x5NdxUX5CL61U4inZFpXtqSUQVgGgWOaolLB
         6ewUuwKXUqQui4maSRyNr6NiIspoG6aiZH7Jadu/5xE8GAqcpiYvoGhlgIAuVGZmzj0s
         TgO38GxCHLW3fyjP5K63uWvLXjMXGd3gFgYmfvlu2VdnBprThlByB0ELsEWQvPOqGlAt
         MshwFzxwRtSxh9sIi5NanegLESnFQSJzBwsEnevnZ1RPGnM/u13CzFr7h/aBWeRbEB5i
         FYoA==
X-Gm-Message-State: APjAAAVoCFqrcpvtEqqQzC8Go64PDRjDxrGam6vCPuRSE99AvD83dVug
        bg/6idgWIrPP5Bzhe8UK2kSh/FHy
X-Google-Smtp-Source: APXvYqzFJVh+263fj0gdAEqUcQlE5eYt/Gr3nboxtN0U7PO1uemxLUUYMdU7QV8jRwyb4EISVIvdiw==
X-Received: by 2002:a2e:84ce:: with SMTP id q14mr21677855ljh.80.1557324218478;
        Wed, 08 May 2019 07:03:38 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id t4sm3949404lff.42.2019.05.08.07.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 07:03:37 -0700 (PDT)
Subject: Re: [RFC PATCH v1 0/6] Introduce machine-specific regulators coupling
 API
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190414175939.12368-1-digetx@gmail.com>
 <46665d2d-aeda-4b63-1d0e-1599214e7bae@gmail.com>
 <20190508080513.GY14916@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fbdce9b8-46b6-97b3-6ca6-b9cba50c7e41@gmail.com>
Date:   Wed, 8 May 2019 17:03:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508080513.GY14916@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.05.2019 11:05, Mark Brown пишет:
> On Sun, May 05, 2019 at 05:57:42PM +0300, Dmitry Osipenko wrote:
> 
>> after bootloader. Currently, in this patchset, we are not allowing CORE
>> voltage to go lower than the level left after bootloader and once all
>> the relevant drivers will get support for the voltage management, we
>> should be able to unhold the lower CORE voltages around late_init().
> 
> That's going to break as soon as someone like a distro builds drivers as
> modules, you can't rely on things getting done at any particular point
> in initialization or indeed on any given set of drivers being available
> in the particular kernel that the user chooses to run - if they decide
> not to build drivers for devices that they don't use on their particular
> system that should work.

Yes, this is not really well-thought yet. Although I guess it should be
fine to assume that all the relevant hardware units are blocked by the
CLK framework that disables the orphaned clocks (by default).

Probably we'll have to better define what drivers are system-critical
for the platform, making sure that they are always included in the
kernel build and complied as built-in. But I also guess there could be
other (better) variants as well.

For now I'm primarily focused on getting the CPU voltage scaling to
work. The CORE minimum voltage is kept limited for now to the
boot-level. I'm assuming that the boot-stage voltages are at reasonable
levels for all boards because otherwise likely that there is a trouble
already (constraint violations).

> Overall this feels like an abstraction failure and you've not really
> said what the constraints you're trying to implement here are so it's
> hard to tell if that's the case or not.
> 

I described the coupling voltage constraints in the replies to the
relevant patches.

The CORE regulator supplies multiple peripherals in the SoC, each
peripheral has it's own demand for a minimum CORE voltage depending on a
clock rate and hardware version.

Tegra20 has the RTC (real-time-clock domain) regulator being coupled in
addition to the CORE. It doesn't supply any peripherals in the SoC that
have specific demands for minimum RTC voltage.

Please let me know if there is a need to explain anything else in a more
detail.

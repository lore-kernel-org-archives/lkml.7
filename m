Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6AFC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 14:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14638206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 14:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPU/YG0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfEEO5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 10:57:48 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35635 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfEEO5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 10:57:47 -0400
Received: by mail-lf1-f67.google.com with SMTP id j20so7429555lfh.2;
        Sun, 05 May 2019 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kbP3QlGhgZkK5sQY+JUtbK1m8upDYNc5EHzX1iAQU+g=;
        b=KPU/YG0NDQgNmpQxcAAZeXrjtwijkoCzlR4xnQxxzI6EspjWFswLPB0KUaLxOtBQPK
         CU0g5a1GTjnjGyC1PSoqn3/2uDFr4dHbFybmT2Sv0nVk3JZCBakSjdwJs9cxivAKh6fc
         AjfPzQqEJRg5dykK0rrNgFPJyrWYfPc5Ecy5N5Gp7T8P5+HbDeKi2gLmsknYVYnBNymA
         uWA+lKhI+bdtwPeIPaSMRSV8DN6Gy9VzeZMs/k7Sq4yYBx54lz8/ybwgtU6nfsA/7dUS
         VvmLqhOVNsTDz0ibbU7JWzQ7ur4puFNk4Vtpk44s8uvaCpRFNeWNWln+3IBy0AYnjHLN
         09jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kbP3QlGhgZkK5sQY+JUtbK1m8upDYNc5EHzX1iAQU+g=;
        b=pRnJl+7O22TA2IWIwp9ZXvX/2XUyWrIAaCIOkLP35i7JlctKMJW3dNcGTRIXMjRVjP
         5QyjfJSuIm5emPJcti/Xd3pd+/A34ggrJ3HYBQdErJgP7ntc0CTaZ/YWYmmbShvBgNGU
         CQ/MFYlMyCP7JzLHtIgCla1VxmqP7TdTN7NHAF7zzllb17DDmdy8ttXK1LZbztMU51ji
         K8/6mGF4XDTOIrtR5LIP0MIBG1P0G2tF4T32RqEKSs/esHlHGHmHG+ttSGFfPnDdfZIW
         kqNM0I7TzkQVEap00aJTuuXL/Qihiuum/H1fh1Pm8pxlrPkeWknl3cMyVcB+1hf+7xNX
         1x7g==
X-Gm-Message-State: APjAAAWWNJQ3k6GZAZvMtAVgjSzC+nmnoGmQAKzB1mKG5yv9V413CQ9l
        /VU7DbF0Lc1hCnkN8JGuXFGao6vu
X-Google-Smtp-Source: APXvYqwLY0sMcTqhNWrKYU1OADNxLLfwI/+Bm2aPJ16S8IgUnpWa7F8yDwcv07xXp60K3i2PsFa4lw==
X-Received: by 2002:ac2:457a:: with SMTP id k26mr7482317lfm.161.1557068265478;
        Sun, 05 May 2019 07:57:45 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id b28sm1567855lfc.7.2019.05.05.07.57.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 07:57:44 -0700 (PDT)
Subject: Re: [RFC PATCH v1 0/6] Introduce machine-specific regulators coupling
 API
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190414175939.12368-1-digetx@gmail.com>
Message-ID: <46665d2d-aeda-4b63-1d0e-1599214e7bae@gmail.com>
Date:   Sun, 5 May 2019 17:57:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190414175939.12368-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

14.04.2019 20:59, Dmitry Osipenko пишет:
> Hello,
> 
> I was looking into how to properly implement regulators coupling for
> NVIDIA Tegra SoC's and ended up with this patchset that introduces
> machine-specific regulators coupling. Upstream kernel now has support
> for a simple variants of regulators coupling in a form of limiting
> maximum voltage spreading between two regulators, but that's not enough
> for the case of Tegra SoC's. It's a bit difficult to support universally
> all possible coupling restrictions in a form of device-tree description,
> so here comes the machine-specific coupling API which allow platforms
> to customize coupling algorithms.

Hello people,

I want to point out that the CPUFreq patches are currently blocked
because of the missing support for a regulators coupling on Tegra and we
want to switch to a proper-generic OPP voltage/freq API.

The other thing that I also forgot to mention that we will need a way to
keep on hold CORE voltage changes until all relevant peripheral drivers
are loaded and claimed the required voltage level. That is needed
because some of the critical peripherals are left in a running state
after bootloader. Currently, in this patchset, we are not allowing CORE
voltage to go lower than the level left after bootloader and once all
the relevant drivers will get support for the voltage management, we
should be able to unhold the lower CORE voltages around late_init().

Will be great if you could take a look at this series and tell your
opinion on the approach, I'll be happy to put more effort into it all if
will be needed. There is now a bit more advanced version of the series
that adds more error-checking and makes use of max-spread and max-step
values from the regular constraints (i.e. values defined in device-tree)
instead of hardcoding them in the code.

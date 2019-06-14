Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38420C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BC72183F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIj2dn3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfFNQvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:51:36 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44235 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfFNQvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:51:35 -0400
Received: by mail-lf1-f67.google.com with SMTP id r15so2176648lfm.11;
        Fri, 14 Jun 2019 09:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=La0om+Dm2f2QFp3CrekJBlv0rebzycLNY6Yi9piJU5o=;
        b=XIj2dn3MekBc7CEwjalh574vqRmrX+0g+5gz5K2IAnjYDYIHOO5nhpQcEj2SwDzTIS
         FfD58vd4ah4wj8Pr3cSIddxPdG1wKT4vaafRN4hy7DLbFBR3VSMGxofTfE8Tf2nRpsP4
         3PzFKbF8xmpfgZdLpZ08Ie66e+PkE0y0s3keXCND9LJX73qoyDkQ7YEE5gkqfWX252Xc
         8OTMsa3jcKP4/l/xawElS2mVoCrRHMAFO777paf1VjG+Li7PkNiJ4lZumf4fIX83g95L
         cAEiSiDXrPYafCNqy4rRmEUzc7PJTnJJBg25e7eOuPu/ddmrxWU54JtX+FMSFxkbLeWg
         AU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=La0om+Dm2f2QFp3CrekJBlv0rebzycLNY6Yi9piJU5o=;
        b=GlE1bsAC+GozkA9z2z3Ve0uTV02k0reKm51cQj42FhUcl1KQ4/CPAFyzpAaDSmHkBr
         vJiVrmv00XgcB3GGBxx33oEZR4cri4xyFwEDpv9wW0lajyjQkz5C1WrucwOYdNLhICcD
         5+aahJM/9fT0beLEZnoxvH4COjJUpF/bvbYU19w53t40qLmf2g4i6heHb0+JITmi7cCX
         do+C2eNqxJwfidb39WNo2jfkohn7ROquCHxvMuKFwGX6t1lp9LjfgKBg/AJ4YwYMufje
         baf24zjnkwne2GxOTWonBJT0vTw3YBbguVp+9iIUnoDf6VxGxIQFry//5eqtyEJFkxrC
         vlIA==
X-Gm-Message-State: APjAAAUF8LJUX3uGwnZWpCSTjiZmEZ8RuOg5PmGGDk+M0oxO9kBoi/QM
        UFn5hxVxZXoKsYQq+Iu+m6r/uDkH
X-Google-Smtp-Source: APXvYqxTap64O3rowcREbfhX3IoZGv0kxTYgz7zM69D7MW1NwadlRCFNuj+ZZnORA9/9Kkt+QlIJUA==
X-Received: by 2002:a19:4017:: with SMTP id n23mr52512076lfa.112.1560531093330;
        Fri, 14 Jun 2019 09:51:33 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id m24sm546452lfl.41.2019.06.14.09.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 09:51:32 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] clocksource/drivers/tegra: Restore base address
 before cleanup
To:     Jon Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190610164400.11830-1-digetx@gmail.com>
 <20190610164400.11830-7-digetx@gmail.com>
 <b2eeb477-2e08-eaf5-6355-4a05cec5a9b7@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <dbc69b48-f83c-7af7-4a49-7cd2ee9937ab@gmail.com>
Date:   Fri, 14 Jun 2019 19:51:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b2eeb477-2e08-eaf5-6355-4a05cec5a9b7@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

14.06.2019 18:48, Jon Hunter пишет:
> 
> On 10/06/2019 17:44, Dmitry Osipenko wrote:
>> We're adjusting the timer's base for each per-CPU timer to point to the
>> actual start of the timer since device-tree defines a compound registers
>> range that includes all of the timers. In this case the original base
>> need to be restore before calling iounmap to unmap the proper address.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/clocksource/timer-tegra.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
>> index 2a428fdf702f..7be91db98bd7 100644
>> --- a/drivers/clocksource/timer-tegra.c
>> +++ b/drivers/clocksource/timer-tegra.c
>> @@ -345,6 +345,8 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20,
>>  			irq_dispose_mapping(cpu_to->clkevt.irq);
>>  		}
>>  	}
>> +
>> +	to->of_base.base = timer_reg_base;
>>  out:
>>  	timer_of_cleanup(to);
> 
> So what you are saying is that because we don't know which CPU executes
> the tegra_init_timer() function, then it is necessary to restore the
> base. IOW if it is not CPU0, then the base will be updated and hence,
> need to be restored. Correct?

We know what the CPU is, it is always CPU0. What we don't know is what TIMER is
assigned for CPU0. On Tegra210 it is TIMER10, for other Tegra's it is TIMER0.

Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E328FC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59FD268E3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3jjqccK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfEaMev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 08:34:51 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32892 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfEaMev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 08:34:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id w1so9494755ljw.0;
        Fri, 31 May 2019 05:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JnKJvYjWnAfIQMAZ3ua6/Ve8Idf2nuUWaSok1fIrNQg=;
        b=A3jjqccKZY6ExYHU98ojOPPa9LiHrTmJDR+FI0yBCgD6k88Vmyp5GcQ2+pxdj4i+d6
         UY3Od83j4+K5P6Cam0UEcv9kwFGAQQz/i7MmPp1M6Kuypml9arPJu5YXtAx0VFAgpdJn
         V+vwUmn0uWvsTfm6I4PiYUc3cZPHscerFF7EGjoW5q+I7chULkoZSM1NP4kFQnpnL1Ev
         +fdahtBqWeJ4wkIRzUQmwElyUBJhR/u13nfCJjyUjZn4dJo0WUBDnHdjBccwWtgJextR
         hbsTXRP74tGPJTTI0QWYNOFuWVIsqjwdUWjJZbqPFinctwMB+M1H6zMUXeN9XW0arrj0
         0MUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JnKJvYjWnAfIQMAZ3ua6/Ve8Idf2nuUWaSok1fIrNQg=;
        b=lktj7EaGvLmptJ4bu2f9TA5SEfNo//nA+cBpzmmcEI5XaBifxHkaI8M0H4OmjKpgrG
         c6icwdWrEMnH3OeMnp9czHBR2NrIYpHUi1/FAOHTJfBEqdpxYgj7HXdEiWH72YVus3MB
         ASzKgx7KRmkXVhiz9+k5h5jbHtMnQgZr7uvrlp3FfR3tzrm+UtJaKuRcep5CAMJr8FuD
         tp/bEHo/4qFLSBFFfqsiPGHPJDTFCFe8bIEaLQRMlZGyY2uZ1pCNjnSHGPBcH5st0KQ3
         eXIpFrzhInkKHgozKDJWZVwq4Ltg5HFZ+xWOX/C90ae9QevMZyDvMB7oZhdSPE9LGGSG
         gPdA==
X-Gm-Message-State: APjAAAWqRDwTTqSTbiMkBZa9adMTU+aaojjKONOMoRRxE/byb1Ga/DuW
        oK/PvyvhiTGVsJZciKIYe+0=
X-Google-Smtp-Source: APXvYqyZwtWEbtwhfGO8+ej0+HL5axWX1XPswIZFhMJgq+6Q3G5z1b2fDLNeR1BR7ZZXdiCua1/6Rw==
X-Received: by 2002:a2e:834f:: with SMTP id l15mr2013911ljh.56.1559306089241;
        Fri, 31 May 2019 05:34:49 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.35.141])
        by smtp.googlemail.com with ESMTPSA id n7sm1137011ljc.69.2019.05.31.05.34.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 05:34:48 -0700 (PDT)
Subject: Re: [PATCH v3 0/8] NVIDIA Tegra clocksource driver improvements
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Chauvet <kwizart@gmail.com>
References: <20190524153253.28564-1-digetx@gmail.com>
 <20190531082634.GA6070@pdeschrijver-desktop.Nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c686aae8-3be0-805e-265b-a7f16f2a6c02@gmail.com>
Date:   Fri, 31 May 2019 15:33:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531082634.GA6070@pdeschrijver-desktop.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31.05.2019 11:26, Peter De Schrijver пишет:
> On Fri, May 24, 2019 at 06:32:45PM +0300, Dmitry Osipenko wrote:
>> Hello,
>>
>> This series primarily unifies the driver code across all Tegra SoC
>> generations. In a result the clocksources are allocated per-CPU on
>> older Tegra's and have a higher rating than the arch-timer, the newer
>> Tegra210 is getting support for microsecond clocksource and the driver's
>> code is getting much cleaner. Note that arch-timer usage is discouraged on
>> all Tegra's due to the time jitter caused by the CPU frequency scaling.
> 
> I think the limitations are more as follows:
> 
> Chip	timer		suffers cpu dvfs jitter		can wakeup from cc7
> T20	us-timer	No				Yes
> T20	twd timer	Yes				No?
> T30	us-timer	No				Yes
> T30	twd timer	Yes				No?
> T114	us-timer	No				Yes
> T114	arch timer	No				Yes
> T124	us-timer	No				Yes
> T124	arch timer	No				Yes
> T210	us-timer	No				Yes
> T210	arch timer	No				No
> T210	clk_m timer	No				Yes
> 
> right?

Doesn't arch timer run off the CPU clock? If yes (that's what I
assumed), then it should be affected by the DVFS. Otherwise I'll lower
the clocksource's rating for T114/124/132.

TWD can't wake CPU from the power-down state, so it's a solid "No" for
TWD in the "can wakeup from cc7" column.

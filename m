Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8513C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847E7206EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uVXtAH3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfKNMK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 07:10:56 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46887 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfKNMK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:10:56 -0500
Received: by mail-lj1-f194.google.com with SMTP id e9so6380202ljp.13;
        Thu, 14 Nov 2019 04:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V3iPFvICh2PC2SW0ECmSzJKHcRSxlwVfa49H/g84OtY=;
        b=uVXtAH3lunBk6jzYEqb9f5bw4ymgYlFBH2qESmvE3ahqQE2sdkjHrv27Q9cv5iWO5/
         tAPmEDR740oZIesch020/2cMFkf5KqNXCh7f/4iUrgw10v6XLhW5mZ0op2VpteY8opBz
         qOl8OeiFhSeJJm899MFuC4xw+58yg6Z6saRX9xJqvD576mk9RhoQFbI0rnny+dfgX5a2
         ezxnXc7/yEFq5JQ6xkXG7GQSRZlT+K56j5C4a63OwgwF+PsyxV3+NexKkVoxnWvmM276
         4Ye8mIqcERvDPo7yG2lB/zTwpulEdV/M8fYJiRZdt0QRuS3uQSPQUBxoiKoN15Z2SLRi
         NXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V3iPFvICh2PC2SW0ECmSzJKHcRSxlwVfa49H/g84OtY=;
        b=OcBojmWh1umP8pktS7WdtAV6RpaTGOVBdRETOqiABYeiz5Eb4SUZgea5ngpdmhdrju
         95oO49lHU5CNdHwVIB6uC/xou/s+Mg26XzskTVPNRFY3sMqM5xh7tg82Q5gpEa0MzV9D
         adWhDvBsL8s3woT7Tx6Yf+nksvihfaWH4JIGCdFrEQAiQFbRXDM+BJFgRisiRreN3b5A
         OVAzmo4IQ7KiYjskYlZJo8Q99pn3licGNVOnsXWK9DYJIxxYXLlmmsSuq9W5vhr14ilK
         8cXuAaB0qs8ugY1/1e1c4vfZ6Lo2BIhxk8BW0/XK55/fSyCrGfJHVQDKl9PV/zygdwoB
         XSNw==
X-Gm-Message-State: APjAAAVprNJbAXNg2FbFo2PMV365O2qVh6Lz+YYL79SYobJGMveNv0nR
        o1GcX/Wrztgzum3h11paw9JTRKAv
X-Google-Smtp-Source: APXvYqyTvdy7St9nn1yvucJ1vFfx67G9OJX8e4xasDAfZlZ3RolkSoOA5s487+Raq3OYVxpd+EHEVQ==
X-Received: by 2002:a2e:b5d0:: with SMTP id g16mr6541534ljn.88.1573733453562;
        Thu, 14 Nov 2019 04:10:53 -0800 (PST)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id t13sm2067030ljo.70.2019.11.14.04.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 04:10:52 -0800 (PST)
Subject: Re: [PATCH v2] clk: tegra: divider: Check UART's divider enable-bit
 state on rate's recalculation
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191030004813.9187-1-digetx@gmail.com>
 <20191113230303.726AE206E3@mail.kernel.org>
 <02df00b3-5e23-441f-b2d5-b84fdb411e98@gmail.com>
 <20191114115656.GC5690@aiwendil>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ec7062cf-a246-8b95-dca7-34e2b957d691@gmail.com>
Date:   Thu, 14 Nov 2019 15:10:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191114115656.GC5690@aiwendil>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

14.11.2019 14:56, Thierry Reding пишет:
> On Thu, Nov 14, 2019 at 02:29:51PM +0300, Dmitry Osipenko wrote:
>> 14.11.2019 02:03, Stephen Boyd пишет:
>>> Quoting Dmitry Osipenko (2019-10-29 17:48:13)
>>>> UART clock is divided using divisor values from DLM/DLL registers when
>>>> enable-bit is unset in clk register and clk's divider configuration isn't
>>>> taken onto account in this case. This doesn't cause any problems, but
>>>> let's add a check for the divider's enable-bit state, for consistency.
>>>>
>>>> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>
>>> Is this going to be picked up or should I just apply atop the tegra PR?
>>
>> Looks like this patch missed the Tegra's PR by accident.
>>
>> Stephen, I assume it will be easier if you could apply this patch atop.
>> The patch doesn't have any dependencies on any other patches, so it's
>> fine to apply it separately. Thanks in advance!
>>
>> Thierry, please let us know if you have any objections.
> 
> It's not so much that I missed to pick this up. It's just that it didn't
> make it in time. This was posted just a couple of days before v5.4-rc6
> and I had already finalized the branches at that point. Given that this
> doesn't fix any actual issues it didn't seem worth to force it in at
> that point.
> 
> That said, I don't have any objections if Stephen wants to pick this up
> on top of the pull requests.

Thanks!

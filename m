Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8A6C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088A520409
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZrCysa7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfLPNlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:41:18 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33428 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbfLPNlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:41:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so7330887wrq.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 05:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CyxWhxmr43Rw57Br2YlZyS8fg23uDDYjv1gKLcIX0Gg=;
        b=jZrCysa7xhNAVELwLj7HTQW3rjdnBPXr0xDrPFVzCKdm7g+BtQcAQ00QqLlq4K6SYn
         K4ML1A335XdJFwGkBAvLIXMzmQrHGSbSLesuQ6yAfyzL+WTBH5WKOX0GRQt90k4l3RI4
         lVegjx2icdy3s/hFtVUnafWjQ9ooldhllaRim5cQXSm6CDtYxuGhypimZJx37H3MG2gg
         DC/w/gbHefgLoYvuNYbq4kFOwtja+jGfJwG/GQKmmUmk9YULMnLCtHCfymkLpDnTv73X
         GMDB4I+URSl5twrq0vIX6D6d/DKlqCK4DVD0MA+fIeCKudX0jg/54IW0cF5JKHiDoRct
         O1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CyxWhxmr43Rw57Br2YlZyS8fg23uDDYjv1gKLcIX0Gg=;
        b=sm/BjpdSxnwK4gepP6hUh/4Ux4dDgdOn849DMUxAogHayvkyNRsZgBCPLLgPqriAK7
         TuwDVyzAkkkwTnJlRL72/2wXizUIHmmVRpUreVPdiaReDNDGrb+Y2mK1ziwFIMAG/ksR
         U5wwzG0kMOkv9qdPOsVCHjAXwo6jp8DDh6DpxtxTxIGuhInBN34PX1qZivJdTFE+mvVk
         odTK+gNT46pridCzXjN9lFaL0ElNtbYSttQbCoLLh+xnf0Tuxmr7KxyN6vm54JhgFy+i
         0nV33ZBDw3x+x3sQ3ybysVfOCTdZh5w5PPIs82Mc9XE9tzL5Hw7abu1YAr0gppy7tGyz
         AYJA==
X-Gm-Message-State: APjAAAV2TNJin48IdE9BodNgUJy81bpKVTO51ujlRqxf5iAlmdCdGXCf
        uuakvWp6BvU0HSSyqn0QuNH9HsUaCA4=
X-Google-Smtp-Source: APXvYqwjni0nm6nIPcsccCY1hCZaURKwpDGZl8+tg6HvU3CBTlkbhSCaKoIWjsLrdv+5wynLESfxPg==
X-Received: by 2002:a05:6000:1288:: with SMTP id f8mr30201689wrx.66.1576503674890;
        Mon, 16 Dec 2019 05:41:14 -0800 (PST)
Received: from [192.168.43.165] ([37.173.129.140])
        by smtp.googlemail.com with ESMTPSA id e16sm21369575wrs.73.2019.12.16.05.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 05:41:14 -0800 (PST)
Subject: Re: [PATCH] clocksource/drivers: Fix error handling in
 ttc_setup_clocksource
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Navid Emamdoost <emamd001@umn.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
References: <2a6cdb63-397b-280a-7379-740e8f43ddf6@xilinx.com>
 <20191023044737.2824-1-navid.emamdoost@gmail.com>
 <CAEkB2ETvi=Zryh+3UnSddrprnB+MzSObAbsms+6LHHLuiRwZjw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <26da3a6b-60f3-d09b-6eff-7a3db8234d64@linaro.org>
Date:   Mon, 16 Dec 2019 14:41:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAEkB2ETvi=Zryh+3UnSddrprnB+MzSObAbsms+6LHHLuiRwZjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Navid,

On 14/12/2019 23:54, Navid Emamdoost wrote:
> Would you review this patch, please?

please fix the version number, send without in-reply-to.

Do the same for the other patch:

clocksource/drivers: Fix memory leak in ttc_setup_clockevent

It is a bit confuse what patch is ok or not.

Thanks

  -- Daniel

> On Tue, Oct 22, 2019 at 11:47 PM Navid Emamdoost
> <navid.emamdoost@gmail.com> wrote:
>>
>> In the implementation of ttc_setup_clocksource() when
>> clk_notifier_register() fails the execution should go to error handling.
>> Additionally, to avoid memory leak the allocated memory for ttccs should
>> be released, too. So, goto error handling to release the memory and
>> return.
>>
>> Fixes: e932900a3279 ("arm: zynq: Use standard timer binding")
>> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
>> ---
>>  drivers/clocksource/timer-cadence-ttc.c | 20 +++++++++++---------
>>  1 file changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
>> index 88fe2e9ba9a3..035e16bc17d3 100644
>> --- a/drivers/clocksource/timer-cadence-ttc.c
>> +++ b/drivers/clocksource/timer-cadence-ttc.c
>> @@ -328,10 +328,8 @@ static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
>>         ttccs->ttc.clk = clk;
>>
>>         err = clk_prepare_enable(ttccs->ttc.clk);
>> -       if (err) {
>> -               kfree(ttccs);
>> -               return err;
>> -       }
>> +       if (err)
>> +               goto release_ttccs;
>>
>>         ttccs->ttc.freq = clk_get_rate(ttccs->ttc.clk);
>>
>> @@ -341,8 +339,10 @@ static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
>>
>>         err = clk_notifier_register(ttccs->ttc.clk,
>>                                     &ttccs->ttc.clk_rate_change_nb);
>> -       if (err)
>> +       if (err) {
>>                 pr_warn("Unable to register clock notifier.\n");
>> +               goto release_ttccs;
>> +       }
>>
>>         ttccs->ttc.base_addr = base;
>>         ttccs->cs.name = "ttc_clocksource";
>> @@ -363,16 +363,18 @@ static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
>>                      ttccs->ttc.base_addr + TTC_CNT_CNTRL_OFFSET);
>>
>>         err = clocksource_register_hz(&ttccs->cs, ttccs->ttc.freq / PRESCALE);
>> -       if (err) {
>> -               kfree(ttccs);
>> -               return err;
>> -       }
>> +       if (err)
>> +               goto release_ttccs;
>>
>>         ttc_sched_clock_val_reg = base + TTC_COUNT_VAL_OFFSET;
>>         sched_clock_register(ttc_sched_clock_read, timer_width,
>>                              ttccs->ttc.freq / PRESCALE);
>>
>>         return 0;
>> +
>> +release_ttccs:
>> +       kfree(ttccs);
>> +       return err;
>>  }
>>
>>  static int ttc_rate_change_clockevent_cb(struct notifier_block *nb,
>> --
>> 2.17.1
>>
> 
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


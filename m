Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F37AC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8C22073C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Wz/HrpXp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfLBS7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:59:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46473 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbfLBS7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:59:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so424579wrl.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 10:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=unQTULTp6sAiG48yHS2yhT/Mb1KShE6yCF9NxnRbumc=;
        b=Wz/HrpXpI9EidUbftYCVFgDYmqn47264Tr7ylFDuLsrDIpJf0hjv3lRQOwtjP3Yww8
         Z48ehC2r8dousMCklB+fs6PWssXD4/5k/f0aNSwcqnMZuuAwar68mwFVtGg09Bu6287E
         7m3b3kDb3hFcziNommbxQcoJM2bBxBCQgiVPtPkBGRQi7Lcq8MXtkZsshKu0m2au1iN4
         RnwzxyNoGetxVUzxEpc89778wB7lvisgV1vfKWOEBP3tD7w0K9SZg3IM2MDm19qPOKn+
         o5602GFlgDoV8PCOIjm1vUSqGLrJ+fAnPykRZkLc2LQvFtUpEnr2Zl6+xqWGn/X9PqeS
         AKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=unQTULTp6sAiG48yHS2yhT/Mb1KShE6yCF9NxnRbumc=;
        b=o6S/JMos+GrAv1wl+2wr7kYedS8ANFhE6QK4/bPtwPh4Vkbn1blSJHY0YKw4SrJB6T
         Lu8T5zNCqbpwrCXXeGUGDOftlVGzgspeOLGKe7unIN5rRzAFYqonXg9JBwIy/4Ay/FW2
         EppUvHeiarVRGqo+HNP6rOZnM3JUldl+l8irdRiWqi02HPjgNKh5Pjnrb7pjjfi+oVOc
         gHUie7hw8zhb71z0gDKXreSLsQgWPaCdu28ZSoQ9IbFLlutlHIkowhJZXsCSDuD/R+bC
         Y2nYqtsTWvAXlAdwQ6lGOkvwqp9pu/4aaRYAZ+Pr+BLKvuSMiik2f9UxhsbK+vsbDIkd
         On2A==
X-Gm-Message-State: APjAAAWD0xqHoQmdOARMl/MzJ0JyPVYGsQaFBkPhmz10OuZotjBSBEQ7
        GXo/P+5yZldux/LAjZaq/HqQ7w==
X-Google-Smtp-Source: APXvYqwF3V6A6/ZmoJopXwSQgsb+/y5UMG/e7168Qb4THtCwU66DB7QwmneInenq2eC7frlHkGWP2g==
X-Received: by 2002:adf:de86:: with SMTP id w6mr480167wrl.115.1575313166088;
        Mon, 02 Dec 2019 10:59:26 -0800 (PST)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id w22sm347094wmk.34.2019.12.02.10.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 10:59:25 -0800 (PST)
References: <20191129161658.344517-1-jbrunet@baylibre.com> <20191202181923.4D26D20717@mail.kernel.org>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: walk orphan list on clock provider registration
In-reply-to: <20191202181923.4D26D20717@mail.kernel.org>
Date:   Mon, 02 Dec 2019 19:59:22 +0100
Message-ID: <1j7e3eft9x.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 02 Dec 2019 at 19:19, Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Jerome Brunet (2019-11-29 08:16:58)
>> So far, we walked the orphan list every time a new clock was registered
>> in CCF. This was fine since the clocks were only referenced by name.
>> 
>> Now that the clock can be referenced through DT, it is not enough:
>> * Controller A register first a reference clocks from controller B
>>   through DT.
>> * Controller B register all its clocks then register the provider.
>> 
>> Each time controller B registers a new clock, the orphan list is walked
>> but it can't match since the provider is registered yet. When the
>> provider is finally registered, the orphan list is not walked unless
>> another clock is registered afterward.
>> 
>> This can lead to situation where some clocks remain orphaned even if
>> the parent is available.
>> 
>> Walking the orphan list on provider registration solves the problem.
>> 
>> Fixes: fc0c209c147f ("clk: Allow parents to be specified without string names")
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>
> Sounds right. Thanks for making the fix!
>
> I suspect there should be a reported-by tag though?

laboriously, yes

>
>>  drivers/clk/clk.c | 59 +++++++++++++++++++++++++++++------------------
>>  1 file changed, 37 insertions(+), 22 deletions(-)
>> 
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index ef4416721777..917ba37c3b9d 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -3249,6 +3249,34 @@ static inline void clk_debug_unregister(struct clk_core *core)
>>  }
>>  #endif
>>  
>> +static void __clk_core_reparent_orphan(void)
>
> Maybe drop the double underscore. clk_core prefix already means "private
> to this file".

I've done it this way just to keep coherent with __clk_core_init(),
which the code was extracted from

In the end, I don't mind so I'll drop it in the v2

>
>> +{
>> +       struct clk_core *orphan;
>> +       struct hlist_node *tmp2;
>> +
>> +       /*
>> +        * walk the list of orphan clocks and reparent any that newly finds a
>> +        * parent.
>> +        */
>> +       hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_node) {
>> +               struct clk_core *parent = __clk_init_parent(orphan);
>> +
>> +               /*
>> +                * We need to use __clk_set_parent_before() and _after() to
>> +                * to properly migrate any prepare/enable count of the orphan
>> +                * clock. This is important for CLK_IS_CRITICAL clocks, which
>> +                * are enabled during init but might not have a parent yet.
>> +                */
>> +               if (parent) {
>> +                       /* update the clk tree topology */
>> +                       __clk_set_parent_before(orphan, parent);
>> +                       __clk_set_parent_after(orphan, parent, NULL);
>> +                       __clk_recalc_accuracies(orphan);
>> +                       __clk_recalc_rates(orphan, 0);
>> +               }
>> +       }
>> +}
>> +
>>  /**
>>   * __clk_core_init - initialize the data structures in a struct clk_core
>>   * @core:      clk_core being initialized
>> @@ -3259,8 +3287,6 @@ static inline void clk_debug_unregister(struct clk_core *core)
>>  static int __clk_core_init(struct clk_core *core)
>>  {
>>         int ret;
>> -       struct clk_core *orphan;
>> -       struct hlist_node *tmp2;
>>         unsigned long rate;
>>  
>>         if (!core)
>> @@ -3416,27 +3442,8 @@ static int __clk_core_init(struct clk_core *core)
>>                 clk_enable_unlock(flags);
>>         }
>>  
>> -       /*
>> -        * walk the list of orphan clocks and reparent any that newly finds a
>> -        * parent.
>> -        */
>> -       hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_node) {
>> -               struct clk_core *parent = __clk_init_parent(orphan);
>> +       __clk_core_reparent_orphan();
>>  
>> -               /*
>> -                * We need to use __clk_set_parent_before() and _after() to
>> -                * to properly migrate any prepare/enable count of the orphan
>> -                * clock. This is important for CLK_IS_CRITICAL clocks, which
>> -                * are enabled during init but might not have a parent yet.
>> -                */
>> -               if (parent) {
>> -                       /* update the clk tree topology */
>> -                       __clk_set_parent_before(orphan, parent);
>> -                       __clk_set_parent_after(orphan, parent, NULL);
>> -                       __clk_recalc_accuracies(orphan);
>> -                       __clk_recalc_rates(orphan, 0);
>> -               }
>> -       }
>>  
>>         kref_init(&core->ref);
>>  out:
>> @@ -4288,6 +4295,10 @@ int of_clk_add_provider(struct device_node *np,
>>         mutex_unlock(&of_clk_mutex);
>>         pr_debug("Added clock from %pOF\n", np);
>>  
>> +       clk_prepare_lock();
>> +       __clk_core_reparent_orphan();
>> +       clk_prepare_unlock();
>> +
>
> Maybe make a locked version of this function and an unlocked version?
>
>>         ret = of_clk_set_defaults(np, true);
>>         if (ret < 0)
>>                 of_clk_del_provider(np);
>> @@ -4323,6 +4334,10 @@ int of_clk_add_hw_provider(struct device_node *np,
>>         mutex_unlock(&of_clk_mutex);
>>         pr_debug("Added clk_hw provider from %pOF\n", np);
>>  
>> +       clk_prepare_lock();
>> +       __clk_core_reparent_orphan();
>> +       clk_prepare_unlock();
>> +
>
> So we don't duplicate this twice.
>

Sure.

>>         ret = of_clk_set_defaults(np, true);
>>         if (ret < 0)

